Return-Path: <SRS0=Yr3x=37=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E1C35242
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 03:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E2C20661
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 03:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgBKDZA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:25:00 -0500
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:54147 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727530AbgBKDZA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 22:25:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EC675180295A3;
        Tue, 11 Feb 2020 03:24:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soda35_48698b41ae525
X-Filterd-Recvd-Size: 3906
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Feb 2020 03:24:57 +0000 (UTC)
Message-ID: <9ed05e364f7eb7ccdeed7c580b3aded8fd8697f7.camel@perches.com>
Subject: Re: [PATCH v2 2/3] IMA: Add log statements for failure conditions.
From:   Joe Perches <joe@perches.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Feb 2020 19:23:42 -0800
In-Reply-To: <20200211024755.5579-2-tusharsu@linux.microsoft.com>
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
         <20200211024755.5579-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 18:47 -0800, Tushar Sugandhi wrote:
> process_buffer_measurement() and ima_alloc_key_entry()
> functions do not have log messages for failure conditions.

trivia:

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
[]
> @@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
>  		ima_free_template_entry(entry);
>  
>  out:
> +	if (ret < 0)
> +		pr_err("Process buffer measurement failed, result: %d\n", ret);

perhaps use %s, __func__

		pr_err("%s: failed, result: %d\n", __func__, ret);
 
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
[]
> @@ -90,6 +90,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>  
>  out:
>  	if (rc) {
> +		pr_err("Key entry allocation failed, result: %d\n", rc);
>  		ima_free_key_entry(entry);
>  		entry = NULL;
>  	}

Likely the pr_err is unnecessary here as kmalloc, kstrdup
and kmemdup all emit a dump_stack() on allocation failure.

Perhaps instead:

o Remove unnecessary indentation in ima_free_key_entry by
  returning early on NULL argument
o Remove unnecessary rc, tests and label in ima_alloc_key_entry
---
 security/integrity/ima/ima_queue_keys.c | 37 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index c87c722..ba449f 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -58,42 +58,35 @@ void ima_init_key_queue(void)
 
 static void ima_free_key_entry(struct ima_key_entry *entry)
 {
-	if (entry) {
-		kfree(entry->payload);
-		kfree(entry->keyring_name);
-		kfree(entry);
-	}
+	if (!entry)
+		return;
+
+	kfree(entry->payload);
+	kfree(entry->keyring_name);
+	kfree(entry);
 }
 
 static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 						 const void *payload,
 						 size_t payload_len)
 {
-	int rc = 0;
 	struct ima_key_entry *entry;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (entry) {
-		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
-		entry->keyring_name = kstrdup(keyring->description,
-					      GFP_KERNEL);
-		entry->payload_len = payload_len;
-	}
-
-	if ((entry == NULL) || (entry->payload == NULL) ||
-	    (entry->keyring_name == NULL)) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!entry)
+		return NULL;
 
-	INIT_LIST_HEAD(&entry->list);
+	entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
+	entry->payload_len = payload_len;
+	entry->keyring_name = kstrdup(keyring->description, GFP_KERNEL);
 
-out:
-	if (rc) {
+	if (!entry->payload || !entry->keyring_name) {
 		ima_free_key_entry(entry);
-		entry = NULL;
+		return NULL;
 	}
 
+	INIT_LIST_HEAD(&entry->list);
+
 	return entry;
 }
 


