Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:57240 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbdI0WRG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:06 -0400
Received: by mail-oi0-f74.google.com with SMTP id z73so8746110oia.15
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:06 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:48 -0700
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
Message-Id: <20170927221653.11219-2-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Subject: [PATCH 1/6] IMA: Allow EVM validation on appraisal even without a
 symmetric key
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

A reasonable configuration is to use IMA to appraise a subset of files
(based on user, security label or other features supported by IMA) but
to also want to use EVM to validate not only the state of the IMA hash
but also additional metadata on the file. Right now this is only
possible if a symmetric key has been loaded, which may not be desirable
in all cases (eg, one where EVM digital signatures are shipped to end
systems rather than EVM HMACs being generated locally). Add an
additional "require_evm" keyword to the IMA policy language in order to
permit the local admin to indicate that they wish EVM validation to
occur even if no symmetric key has been loaded.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/ima_policy  |  3 ++-
 include/linux/evm.h                   |  6 ++++--
 security/integrity/evm/evm_main.c     |  6 ++++--
 security/integrity/ima/ima_appraise.c | 11 ++++++++++-
 security/integrity/ima/ima_policy.c   | 12 +++++++++++-
 security/integrity/integrity.h        |  3 ++-
 6 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 5dc9eed035fb..ea2703c847f6 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -23,7 +23,8 @@ Description:
 				[euid=] [fowner=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=]] [permit_directio]
+			option:	[[appraise_type=] [permit_directio]
+			         [require_evm]]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 35ed9a8a403a..7661f3085942 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -19,7 +19,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
 					     void *xattr_value,
 					     size_t xattr_value_len,
-					     struct integrity_iint_cache *iint);
+					     struct integrity_iint_cache *iint,
+					     bool force);
 extern int evm_inode_setattr(struct dentry *dentry, struct iattr *attr);
 extern void evm_inode_post_setattr(struct dentry *dentry, int ia_valid);
 extern int evm_inode_setxattr(struct dentry *dentry, const char *name,
@@ -54,7 +55,8 @@ static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
 						    const char *xattr_name,
 						    void *xattr_value,
 						    size_t xattr_value_len,
-					struct integrity_iint_cache *iint)
+					      struct integrity_iint_cache *iint,
+						    bool force)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 063d38aef64e..44e4f4fda965 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -223,6 +223,7 @@ static int evm_protected_xattr(const char *req_xattr_name)
  * @xattr_name: requested xattr
  * @xattr_value: requested xattr value
  * @xattr_value_len: requested xattr value length
+ * @force: force verification even if no EVM symmetric key is loaded
  *
  * Calculate the HMAC for the given dentry and verify it against the stored
  * security.evm xattr. For performance, use the xattr value and length
@@ -236,9 +237,10 @@ static int evm_protected_xattr(const char *req_xattr_name)
 enum integrity_status evm_verifyxattr(struct dentry *dentry,
 				      const char *xattr_name,
 				      void *xattr_value, size_t xattr_value_len,
-				      struct integrity_iint_cache *iint)
+				      struct integrity_iint_cache *iint,
+				      bool force)
 {
-	if (!evm_initialized || !evm_protected_xattr(xattr_name))
+	if ((!evm_initialized || !evm_protected_xattr(xattr_name)) && !force)
 		return INTEGRITY_UNKNOWN;
 
 	if (!iint) {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index edb82e722a0d..9df1148f17cc 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -217,6 +217,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len, hash_start = 0;
+	bool evm_force = false;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return INTEGRITY_UNKNOWN;
@@ -236,7 +237,15 @@ int ima_appraise_measurement(enum ima_hooks func,
 		goto out;
 	}
 
-	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
+	/*
+	 * Check if policy specifies that we should perform EVM
+	 * validation even in the absence of an EVM symmetric key
+	 */
+	if (iint->flags & IMA_EVM_REQUIRED)
+		evm_force = true;
+
+	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint,
+				 evm_force);
 	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
 		if ((status == INTEGRITY_NOLABEL)
 		    || (status == INTEGRITY_NOXATTRS))
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a6e14c532627..db4a0c968e00 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -531,7 +531,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_require_evm,
 };
 
 static match_table_t policy_tokens = {
@@ -562,6 +562,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_require_evm, "require_evm"},
 	{Opt_err, NULL}
 };
 
@@ -876,6 +877,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else
 				entry->flags |= IMA_PCR;
 
+			break;
+		case Opt_require_evm:
+			if (entry->action != APPRAISE) {
+				result = -EINVAL;
+				break;
+			}
+			entry->flags |= IMA_EVM_REQUIRED;
 			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
@@ -1142,6 +1150,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 			}
 		}
 	}
+	if (entry->flags & IMA_EVM_REQUIRED)
+		seq_puts(m, "require_evm ");
 	if (entry->flags & IMA_DIGSIG_REQUIRED)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 45ba0e4501d6..2fa0d7bc55fb 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -28,11 +28,12 @@
 
 /* iint cache flags */
 #define IMA_ACTION_FLAGS	0xff000000
-#define IMA_ACTION_RULE_FLAGS	0x06000000
+#define IMA_ACTION_RULE_FLAGS	0x16000000
 #define IMA_DIGSIG		0x01000000
 #define IMA_DIGSIG_REQUIRED	0x02000000
 #define IMA_PERMIT_DIRECTIO	0x04000000
 #define IMA_NEW_FILE		0x08000000
+#define IMA_EVM_REQUIRED	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_APPRAISE_SUBMASK)
-- 
2.14.2.822.g60be5d43e6-goog
