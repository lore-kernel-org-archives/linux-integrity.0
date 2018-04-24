Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57511 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbeDXOa6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Apr 2018 10:30:58 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] ima: Unify logging
Date: Tue, 24 Apr 2018 16:30:38 +0200
Message-Id: <20180424143038.16703-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Define pr_fmt everywhere.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima_fs.c           | 7 +++++--
 security/integrity/ima/ima_kexec.c        | 2 ++
 security/integrity/ima/ima_template_lib.c | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fa540c0469da..aae558926ac0 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -15,6 +15,9 @@
  *	implemenents security file system for reporting
  *	current measurement list and IMA statistics
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -336,7 +339,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	if (data[0] == '/') {
 		result = ima_read_policy(data);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
-		pr_err("IMA: signed policy file (specified as an absolute pathname) required\n");
+		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", "signed policy required",
 				    1, 0);
@@ -417,7 +420,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 		valid_policy = 0;
 	}
 
-	pr_info("IMA: policy update %s\n", cause);
+	pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 			    "policy_update", cause, !valid_policy, 0);
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e473eee913cb..db0de585f6c0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,6 +15,8 @@
 #include <linux/kexec.h>
 #include "ima.h"
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #ifdef CONFIG_IMA_KEXEC
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 5afaa53decc5..43752002c222 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -13,6 +13,8 @@
  *      Library of supported template fields.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "ima_template_lib.h"
 
 static bool ima_template_hash_algo_allowed(u8 algo)
-- 
2.12.3
