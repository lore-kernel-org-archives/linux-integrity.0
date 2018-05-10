Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964827AbeEJPQY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 11:16:24 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] ima: Remove unused variable ima_initialized
Date: Thu, 10 May 2018 17:15:48 +0200
Message-Id: <20180510151548.7155-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima.h      | 1 -
 security/integrity/ima/ima_main.c | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 35fe91aa1fc9..354bb5716ce3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,7 +53,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 extern int ima_policy_flag;
 
 /* set during initialization */
-extern int ima_initialized;
 extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 74d0bd7e76d7..e771b736aa03 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -32,8 +32,6 @@
 
 #include "ima.h"
 
-int ima_initialized;
-
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
 #else
@@ -517,10 +515,9 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
-	if (!error) {
-		ima_initialized = 1;
+	if (!error)
 		ima_update_policy_flag();
-	}
+
 	return error;
 }
 
-- 
2.12.3
