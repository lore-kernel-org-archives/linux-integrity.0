Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f73.google.com ([209.85.218.73]:55794 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757719AbdJKTMd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 15:12:33 -0400
Received: by mail-oi0-f73.google.com with SMTP id e123so1993204oig.14
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 12:12:33 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 11 Oct 2017 12:12:17 -0700
Message-Id: <20171011191218.5274-1-mjg59@google.com>
Subject: [PATCH V3 1/2] IMA: Add support for IMA validation after credentials
 are committed
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, james.l.morris@oracle.com,
        keescook@chromium.org, oleg@redhat.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

It may be desirable to perform appraisal after credentials are
committed, for instance in the case where validation is only required if
the binary has transitioned into a privileged security context. Add an
additional call into IMA in the committed_credentials security hook and
abort execution if it fails. This will only be called at
install_exec_creds() time, which means it will only be run on binary
interpreters rather than on the scripts or files handled by binfmt_misc.
The following patch will rectify this.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/ima_policy  |  2 +-
 arch/x86/ia32/ia32_aout.c             |  4 +++-
 fs/binfmt_aout.c                      |  4 +++-
 fs/binfmt_elf.c                       |  5 ++++-
 fs/binfmt_elf_fdpic.c                 |  5 ++++-
 fs/binfmt_flat.c                      |  4 +++-
 fs/exec.c                             |  8 ++++++--
 include/linux/binfmts.h               |  2 +-
 include/linux/ima.h                   |  6 ++++++
 include/linux/security.h              |  5 +++--
 security/integrity/iint.c             |  1 +
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      |  2 +-
 security/integrity/ima/ima_appraise.c |  8 ++++++++
 security/integrity/ima/ima_main.c     | 24 +++++++++++++++++++++++-
 security/integrity/ima/ima_policy.c   |  4 ++++
 security/integrity/integrity.h        |  9 +++++++--
 security/security.c                   |  3 ++-
 18 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e76432b9954d..5dc9eed035fb 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -25,7 +25,7 @@ Description:
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [permit_directio]
 
-		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
+		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 8e02b30cf08e..0dba3ed8459f 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -312,7 +312,9 @@ static int load_aout_binary(struct linux_binprm *bprm)
 	if (retval < 0)
 		return retval;
 
-	install_exec_creds(bprm);
+	retval = install_exec_creds(bprm);
+	if (retval)
+		return retval;
 
 	if (N_MAGIC(ex) == OMAGIC) {
 		unsigned long text_addr, map_size;
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index ce1824f47ba6..02c7c4320fc8 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -256,7 +256,9 @@ static int load_aout_binary(struct linux_binprm * bprm)
 	if (retval < 0)
 		return retval;
 
-	install_exec_creds(bprm);
+	retval = install_exec_creds(bprm);
+	if (retval)
+		return retval;
 
 	if (N_MAGIC(ex) == OMAGIC) {
 		unsigned long text_addr, map_size;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 73b01e474fdc..a6883a855a14 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -866,7 +866,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
-	install_exec_creds(bprm);
+
+	retval = install_exec_creds(bprm);
+	if (retval)
+		goto out_free_dentry;
 
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e70c039ac190..d89830095e19 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -433,7 +433,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	current->mm->start_stack = current->mm->start_brk + stack_size;
 #endif
 
-	install_exec_creds(bprm);
+	retval = install_exec_creds(bprm);
+	if (retval)
+		goto error;
+
 	if (create_elf_fdpic_tables(bprm, current->mm,
 				    &exec_params, &interp_params) < 0)
 		goto error;
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 475d083f8088..5f59c53ba97f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -948,7 +948,9 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	install_exec_creds(bprm);
+	retval = install_exec_creds(bprm);
+	if (retval)
+		return retval;
 
 	set_binfmt(&flat_format);
 
diff --git a/fs/exec.c b/fs/exec.c
index 5470d3c1892a..c7e9f84abd36 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1425,8 +1425,10 @@ EXPORT_SYMBOL(bprm_change_interp);
 /*
  * install the new credentials for this executable
  */
-void install_exec_creds(struct linux_binprm *bprm)
+int install_exec_creds(struct linux_binprm *bprm)
 {
+	int ret = 0;
+
 	security_bprm_committing_creds(bprm);
 
 	commit_creds(bprm->cred);
@@ -1445,8 +1447,10 @@ void install_exec_creds(struct linux_binprm *bprm)
 	 * ptrace_attach() from altering our determination of the task's
 	 * credentials; any time after this it may be unlocked.
 	 */
-	security_bprm_committed_creds(bprm);
+	ret = security_bprm_committed_creds(bprm);
 	mutex_unlock(&current->signal->cred_guard_mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL(install_exec_creds);
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 18d05b5491f3..725d5582589f 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -135,7 +135,7 @@ extern int bprm_change_interp(const char *interp, struct linux_binprm *bprm);
 extern int copy_strings_kernel(int argc, const char *const *argv,
 			       struct linux_binprm *bprm);
 extern int prepare_bprm_creds(struct linux_binprm *bprm);
-extern void install_exec_creds(struct linux_binprm *bprm);
+extern int install_exec_creds(struct linux_binprm *bprm);
 extern void set_binfmt(struct linux_binfmt *new);
 extern ssize_t read_code(struct file *, unsigned long, loff_t, size_t);
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..f9a64f94b0d3 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,6 +16,7 @@ struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
+extern int ima_creds_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
@@ -34,6 +35,11 @@ static inline int ima_bprm_check(struct linux_binprm *bprm)
 	return 0;
 }
 
+static inline int ima_creds_check(struct linux_binprm *bprm)
+{
+	return 0;
+}
+
 static inline int ima_file_check(struct file *file, int mask, int opened)
 {
 	return 0;
diff --git a/include/linux/security.h b/include/linux/security.h
index ce6265960d6c..ad970a4f19f6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -232,7 +232,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
-void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_bprm_committed_creds(struct linux_binprm *bprm);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
@@ -536,8 +536,9 @@ static inline void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
 }
 
-static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
+static inline int security_bprm_committed_creds(struct linux_binprm *bprm)
 {
+	return 0;
 }
 
 static inline int security_sb_alloc(struct super_block *sb)
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 6fc888ca468e..ad30094a58b4 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -78,6 +78,7 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
 	iint->ima_read_status = INTEGRITY_UNKNOWN;
+	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
 	kmem_cache_free(iint_cache, iint);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d52b487ad259..547ea832bb1b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -177,6 +177,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(FILE_CHECK)		\
 	hook(MMAP_CHECK)		\
 	hook(BPRM_CHECK)		\
+	hook(CREDS_CHECK)		\
 	hook(POST_SETATTR)		\
 	hook(MODULE_CHECK)		\
 	hook(FIRMWARE_CHECK)		\
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c2edba8de35e..0c19bb423570 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -165,7 +165,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
- *	func: FILE_CHECK | BPRM_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 809ba70fbbbf..edb82e722a0d 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -86,6 +86,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 		return iint->ima_mmap_status;
 	case BPRM_CHECK:
 		return iint->ima_bprm_status;
+	case CREDS_CHECK:
+		return iint->ima_creds_status;
 	case FILE_CHECK:
 	case POST_SETATTR:
 		return iint->ima_file_status;
@@ -106,6 +108,9 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->ima_bprm_status = status;
 		break;
+	case CREDS_CHECK:
+		iint->ima_creds_status = status;
+		break;
 	case FILE_CHECK:
 	case POST_SETATTR:
 		iint->ima_file_status = status;
@@ -127,6 +132,9 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
 	case BPRM_CHECK:
 		iint->flags |= (IMA_BPRM_APPRAISED | IMA_APPRAISED);
 		break;
+	case CREDS_CHECK:
+		iint->flags |= (IMA_CREDS_APPRAISED | IMA_APPRAISED);
+		break;
 	case FILE_CHECK:
 	case POST_SETATTR:
 		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..5be8307a1dd1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -14,7 +14,7 @@
  *
  * File: ima_main.c
  *	implements the IMA hooks: ima_bprm_check, ima_file_mmap,
- *	and ima_file_check.
+ *	ima_creds_check and ima_file_check.
  */
 #include <linux/module.h>
 #include <linux/file.h>
@@ -306,6 +306,28 @@ int ima_bprm_check(struct linux_binprm *bprm)
 				   BPRM_CHECK, 0);
 }
 
+/**
+ * ima_creds_check - based on policy, collect/store measurement.
+ * @bprm: contains the linux_binprm structure
+ *
+ * The OS protects against an executable file, already open for write,
+ * from being executed in deny_write_access() and an executable file,
+ * already open for execute, from being modified in get_write_access().
+ * So we can be certain that what we verify and measure here is actually
+ * what is being executed.
+ *
+ * This is identical to ima_bprm_check, except called after child credentials
+ * have been committed.
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+int ima_creds_check(struct linux_binprm *bprm)
+{
+	return process_measurement(bprm->file, NULL, 0, MAY_EXEC,
+				   CREDS_CHECK, 0);
+}
+
 /**
  * ima_path_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 95209a5f8595..a6e14c532627 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -339,6 +339,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 		return IMA_MMAP_APPRAISE;
 	case BPRM_CHECK:
 		return IMA_BPRM_APPRAISE;
+	case CREDS_CHECK:
+		return IMA_CREDS_APPRAISE;
 	case FILE_CHECK:
 	case POST_SETATTR:
 		return IMA_FILE_APPRAISE;
@@ -691,6 +693,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = MMAP_CHECK;
 			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
 				entry->func = BPRM_CHECK;
+			else if (strcmp(args[0].from, "CREDS_CHECK") == 0)
+				entry->func = CREDS_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_KERNEL_CHECK") ==
 				 0)
 				entry->func = KEXEC_KERNEL_CHECK;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0a721c110e92..5413eb25b440 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -48,10 +48,14 @@
 #define IMA_BPRM_APPRAISED	0x00002000
 #define IMA_READ_APPRAISE	0x00004000
 #define IMA_READ_APPRAISED	0x00008000
+#define IMA_CREDS_APPRAISE	0x00010000
+#define IMA_CREDS_APPRAISED	0x00020000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
-				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE)
+				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
+				 IMA_CREDS_APPRAISE)
 #define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
-				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED)
+				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
+				 IMA_CREDS_APPRAISED)
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
@@ -109,6 +113,7 @@ struct integrity_iint_cache {
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
 	enum integrity_status ima_read_status:4;
+	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
 };
diff --git a/security/security.c b/security/security.c
index 4bf0f571b4ef..c2c5017e3477 100644
--- a/security/security.c
+++ b/security/security.c
@@ -346,9 +346,10 @@ void security_bprm_committing_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committing_creds, bprm);
 }
 
-void security_bprm_committed_creds(struct linux_binprm *bprm)
+int security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committed_creds, bprm);
+	return ima_creds_check(bprm);
 }
 
 int security_sb_alloc(struct super_block *sb)
-- 
2.15.0.rc0.271.g36b669edcc-goog
