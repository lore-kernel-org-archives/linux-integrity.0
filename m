Return-Path: <SRS0=KXTF=7R=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D79EC433E0
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Jun 2020 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C49206E6
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Jun 2020 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PykBJqC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgFDQcs (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:32:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42596 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQcs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 12:32:48 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B42CB20B7185;
        Thu,  4 Jun 2020 09:32:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B42CB20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591288367;
        bh=HSE+hmGxuCSoZdoQKdpxxvMKb/F1FAb7gfSJdIw8nJw=;
        h=From:To:Cc:Subject:Date:From;
        b=PykBJqC3/hrZtyBrGfy1EsHeBOraUlEDJ0Q/0jAvxU1higWxhzg87HS6DT0j/i9sH
         +l8uSI5aZH3LZMF8RqRNGKyJJvP/ndOb4OtxdpgyDAioH6E9vHvi7ecTvrjL4D2xsl
         44Fatr8JRYL994Zcq4NQcOGIWFCbKPY3wGJGdG64=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     tusharsu@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Add log statements for failure conditions
Date:   Thu,  4 Jun 2020 09:32:43 -0700
Message-Id: <20200604163243.2575-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The final log statement in process_buffer_measurement() for failure
condition is at debug level. This does not log the message unless
the system log level is raised which would significantly increase
the messages in the system log. Change this log message to error level,
and add eventname and ima_hooks enum to the message for better triaging
failures in the function.

ima_alloc_key_entry() does not log a message for failure condition.
Add an error message for failure condition in this function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c       | 3 ++-
 security/integrity/ima/ima_queue_keys.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9d0abedeae77..3b371f31597b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -756,7 +756,8 @@ void process_buffer_measurement(const void *buf, int size,
 
 out:
 	if (ret < 0)
-		pr_devel("%s: failed, result: %d\n", __func__, ret);
+		pr_err("%s failed. eventname: %s, func: %d, result: %d\n",
+		       __func__, eventname, func, ret);
 
 	return;
 }
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index cb3e3f501593..e51d0eb08d8a 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -88,6 +88,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 
 out:
 	if (rc) {
+		pr_err("%s failed. keyring: %s, result: %d\n",
+		       __func__, keyring->description, rc);
 		ima_free_key_entry(entry);
 		entry = NULL;
 	}
-- 
2.27.0

