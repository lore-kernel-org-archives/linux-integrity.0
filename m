Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752601AbdKMLxL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 06:53:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADBnkMB142275
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 06:53:11 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e7a8w9rv2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 06:53:10 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 13 Nov 2017 11:53:08 -0000
Subject: [PATCH] ima: support new "hash" and "dont_hash" policy actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Stefan Berger <stefanb@us.ibm.com>
Date: Mon, 13 Nov 2017 06:53:05 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510573985.3404.114.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The builtin ima_appraise_tcb policy, which is specified on the boot
command line, can be replaced with a custom policy, normally early in
the boot process.  Custom policies can be more restrictive in some ways,
like requiring file signatures, but can be less restrictive in other
ways, like not appraising mutable files.  With a less restrictive policy
in place, files in the builtin policy might not be hashed and labeled
with a security.ima hash.  On reboot, files which should be labeled in
the ima_appraise_tcb are not labeled, possibly preventing the system
from booting properly.

To resolve this problem, this patch extends the existing IMA policy
actions "measure", "dont_measure", "appraise", "dont_appraise", and
"audit" with "hash" and "dont_hash".  The new "hash" action will write
the file hash as security.ima, but without requiring the file to be
appraised as well.

For example, the builtin ima_appraise_tcb policy includes the rule,
"appraise fowner=0".  Adding the "hash fowner=0" rule to a custom
policy, will cause the needed file hashes to be calculated and written
as security.ima xattrs.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy  |  3 ++-
 security/integrity/ima/ima_api.c      |  2 +-
 security/integrity/ima/ima_appraise.c | 15 +++++++++------
 security/integrity/ima/ima_main.c     | 28 ++++++++++++++++++++--------
 security/integrity/ima/ima_policy.c   | 30 ++++++++++++++++++++++++++++--
 security/integrity/integrity.h        | 23 +++++++++++++----------
 6 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e76432b9954d..2028f2d093b2 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -17,7 +17,8 @@ Description:
 
 		rule format: action [condition ...]
 
-		action: measure | dont_measure | appraise | dont_appraise | audit
+		action: measure | dont_measure | appraise | dont_appraise |
+			audit | hash | dont_hash
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
 				[euid=] [fowner=]]
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7e8db0ea4c0..877f446fdca2 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -174,7 +174,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  */
 int ima_get_action(struct inode *inode, int mask, enum ima_hooks func, int *pcr)
 {
-	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE;
+	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 9a54c77fb457..2843099b7e1f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -46,14 +46,14 @@ bool is_ima_appraise_enabled(void)
 /*
  * ima_must_appraise - set appraise flag
  *
- * Return 1 to appraise
+ * Return 1 to appraise or hash
  */
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
 	if (!ima_appraise)
 		return 0;
 
-	return ima_match_policy(inode, func, mask, IMA_APPRAISE, NULL);
+	return ima_match_policy(inode, func, mask, IMA_APPRAISE | IMA_HASH, NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
@@ -343,22 +343,25 @@ void ima_inode_post_setattr(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
-	int must_appraise;
+	int action;
 
 	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
 	iint = integrity_iint_find(inode);
 	if (iint) {
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
+				 IMA_HASH | IMA_HASHED |
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
 				 IMA_ACTION_RULE_FLAGS);
-		if (must_appraise)
+		if (action & IMA_APPRAISE)
 			iint->flags |= IMA_APPRAISE;
+		if (action & IMA_HASH)
+			iint->flags |= IMA_HASH;
 	}
-	if (!must_appraise)
+	if (!action)
 		__vfs_removexattr(dentry, XATTR_NAME_IMA);
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 770654694efc..ca86f4a61cf8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -126,15 +126,17 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		return;
 
 	inode_lock(inode);
-	if (atomic_read(&inode->i_writecount) == 1) {
-		if ((iint->version != inode->i_version) ||
-		    (iint->flags & IMA_NEW_FILE)) {
-			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
-			iint->measured_pcrs = 0;
-			if (iint->flags & IMA_APPRAISE)
-				ima_update_xattr(iint, file);
-		}
+	if (atomic_read(&inode->i_writecount) != 1)
+		goto out;
+
+	if ((iint->version != inode->i_version) ||
+	    (iint->flags & IMA_NEW_FILE)) {
+		iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
+		iint->measured_pcrs = 0;
+		if (iint->flags & IMA_APPRAISE || iint->flags & IMA_HASH)
+			ima_update_xattr(iint, file);
 	}
+out:
 	inode_unlock(inode);
 }
 
@@ -223,6 +225,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
 		action ^= IMA_MEASURE;
 
+	/* HASH just sets the digital signature flag, nothing else */
+	if ((action & IMA_HASH) && !(iint->flags & IMA_DIGSIG)) {
+		xattr_len = ima_read_xattr(file->f_path.dentry, &xattr_value);
+		if ((xattr_value && xattr_len > 2) &&
+		    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
+			iint->flags |= IMA_DIGSIG;
+		iint->flags |= IMA_HASHED;
+		action ^= IMA_HASH;
+	}
+
 	/* Nothing to do, just return existing appraised status */
 	if (!action) {
 		if (must_appraise)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ee4613fa5840..93dcf1bf92a8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -40,6 +40,8 @@
 #define APPRAISE	0x0004	/* same as IMA_APPRAISE */
 #define DONT_APPRAISE	0x0008
 #define AUDIT		0x0040
+#define HASH		0x0100
+#define DONT_HASH	0x0200
 
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (FIELD_SIZEOF(struct integrity_iint_cache, measured_pcrs) * 8))
@@ -380,8 +382,10 @@ int ima_match_policy(struct inode *inode, enum ima_hooks func, int mask,
 		action |= entry->flags & IMA_ACTION_FLAGS;
 
 		action |= entry->action & IMA_DO_MASK;
-		if (entry->action & IMA_APPRAISE)
+		if (entry->action & IMA_APPRAISE) {
 			action |= get_subaction(entry, func);
+			action ^= IMA_HASH;
+		}
 
 		if (entry->action & IMA_DO_MASK)
 			actmask &= ~(entry->action | entry->action << 1);
@@ -521,7 +525,7 @@ enum {
 	Opt_err = -1,
 	Opt_measure = 1, Opt_dont_measure,
 	Opt_appraise, Opt_dont_appraise,
-	Opt_audit,
+	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
 	Opt_func, Opt_mask, Opt_fsmagic,
@@ -538,6 +542,8 @@ static match_table_t policy_tokens = {
 	{Opt_appraise, "appraise"},
 	{Opt_dont_appraise, "dont_appraise"},
 	{Opt_audit, "audit"},
+	{Opt_hash, "hash"},
+	{Opt_dont_hash, "dont_hash"},
 	{Opt_obj_user, "obj_user=%s"},
 	{Opt_obj_role, "obj_role=%s"},
 	{Opt_obj_type, "obj_type=%s"},
@@ -671,6 +677,22 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->action = AUDIT;
 			break;
+		case Opt_hash:
+			ima_log_string(ab, "action", "hash");
+
+			if (entry->action != UNKNOWN)
+				result = -EINVAL;
+
+			entry->action = HASH;
+			break;
+		case Opt_dont_hash:
+			ima_log_string(ab, "action", "dont_hash");
+
+			if (entry->action != UNKNOWN)
+				result = -EINVAL;
+
+			entry->action = DONT_HASH;
+			break;
 		case Opt_func:
 			ima_log_string(ab, "func", args[0].from);
 
@@ -1040,6 +1062,10 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, pt(Opt_dont_appraise));
 	if (entry->action & AUDIT)
 		seq_puts(m, pt(Opt_audit));
+	if (entry->action & HASH)
+		seq_puts(m, pt(Opt_hash));
+	if (entry->action & DONT_HASH)
+		seq_puts(m, pt(Opt_dont_hash));
 
 	seq_puts(m, " ");
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e324bf98c856..144f6fc54635 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -25,6 +25,8 @@
 #define IMA_COLLECTED		0x00000020
 #define IMA_AUDIT		0x00000040
 #define IMA_AUDITED		0x00000080
+#define IMA_HASH		0x00000100
+#define IMA_HASHED		0x00000200
 
 /* iint cache flags */
 #define IMA_ACTION_FLAGS	0xff000000
@@ -36,19 +38,20 @@
 #define EVM_IMMUTABLE_DIGSIG	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
-				 IMA_APPRAISE_SUBMASK)
+				 IMA_HASH | IMA_APPRAISE_SUBMASK)
 #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
-				 IMA_COLLECTED | IMA_APPRAISED_SUBMASK)
+				 IMA_HASHED | IMA_COLLECTED | \
+				 IMA_APPRAISED_SUBMASK)
 
 /* iint subaction appraise cache flags */
-#define IMA_FILE_APPRAISE	0x00000100
-#define IMA_FILE_APPRAISED	0x00000200
-#define IMA_MMAP_APPRAISE	0x00000400
-#define IMA_MMAP_APPRAISED	0x00000800
-#define IMA_BPRM_APPRAISE	0x00001000
-#define IMA_BPRM_APPRAISED	0x00002000
-#define IMA_READ_APPRAISE	0x00004000
-#define IMA_READ_APPRAISED	0x00008000
+#define IMA_FILE_APPRAISE	0x00001000
+#define IMA_FILE_APPRAISED	0x00002000
+#define IMA_MMAP_APPRAISE	0x00004000
+#define IMA_MMAP_APPRAISED	0x00008000
+#define IMA_BPRM_APPRAISE	0x00010000
+#define IMA_BPRM_APPRAISED	0x00020000
+#define IMA_READ_APPRAISE	0x00040000
+#define IMA_READ_APPRAISED	0x00080000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
-- 
2.7.4
