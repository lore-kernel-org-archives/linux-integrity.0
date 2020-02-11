Return-Path: <SRS0=Yr3x=37=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E61C3F68F
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 02:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7D2082F
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 02:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OVMZvnwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBKCsI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:48:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgBKCsH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 21:48:07 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F6BD20B9C02;
        Mon, 10 Feb 2020 18:48:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F6BD20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581389287;
        bh=ta2+cPR+SWW5mggrKQmNME5B7299QZqk4q419Roxmxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVMZvnwjzElk5Wr6POy145pylvqcbHDDrhGk62NDUF/22/eNnpDwjzHEt4KbjQiTM
         wECK9nh8RM4cDy7WIO7MtHw+0uKUjp8Y9eBYn17GH3Wi9Elo1pbeKn+ZIa+8yPp+1L
         8VKdWwIfqX7xq+sQAyZdONGMDqQfvqZ8fkhl9LyU=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] IMA: Add log statements for failure conditions.
Date:   Mon, 10 Feb 2020 18:47:54 -0800
Message-Id: <20200211024755.5579-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() and ima_alloc_key_entry()
functions do not have log messages for failure conditions.

This change adds log statements in the above functions. 

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c       | 3 +++
 security/integrity/ima/ima_queue_keys.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..ee01ee34eec8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
 		ima_free_template_entry(entry);
 
 out:
+	if (ret < 0)
+		pr_err("Process buffer measurement failed, result: %d\n", ret);
+
 	return;
 }
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index c87c72299191..6a9ee52649c4 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -90,6 +90,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
 
 out:
 	if (rc) {
+		pr_err("Key entry allocation failed, result: %d\n", rc);
 		ima_free_key_entry(entry);
 		entry = NULL;
 	}
-- 
2.17.1

