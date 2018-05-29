Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965868AbeE2SCj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 14:02:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4THsXJD072060
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:38 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9955yy8q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:38 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 19:02:32 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v4 8/8] module: replace the existing LSM hook in init_module
Date: Tue, 29 May 2018 14:02:00 -0400
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Both the init_module and finit_module syscalls call either directly
or indirectly the security_kernel_read_file LSM hook.  This patch
replaces the direct call in init_module with a call to the new
security_kernel_load_data hook and makes the corresponding changes in
SELinux and IMA.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/module.c                   |  2 +-
 security/integrity/ima/ima_main.c | 24 ++++++++++--------------
 security/selinux/hooks.c          | 26 ++++++++++++++++++++------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index ce8066b88178..b97c642b5b4d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_read_file(NULL, READING_MODULE);
+	err = security_kernel_load_data(LOADING_MODULE);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3dae605a1604..0ff1d8152f6e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -441,17 +441,6 @@ static int read_idmap[READING_MAX_ID] = {
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
-	bool sig_enforce = is_module_sig_enforced();
-
-	if (!file && read_id == READING_MODULE) {
-		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		}
-		return 0;	/* We rely on module signature checking */
-	}
-
 	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
@@ -490,9 +479,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
-		return 0;
-
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -521,6 +507,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id)
 {
+	bool sig_enforce;
+
 	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
 		return 0;
 
@@ -536,6 +524,14 @@ int ima_load_data(enum kernel_load_data_id id)
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case LOADING_MODULE:
+		sig_enforce = is_module_sig_enforced();
+
+		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
+			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 	default:
 		break;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 02ebd1585eaf..e02186470fc5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4018,12 +4018,6 @@ static int selinux_kernel_module_from_file(struct file *file)
 	u32 sid = current_sid();
 	int rc;
 
-	/* init_module */
-	if (file == NULL)
-		return avc_has_perm(&selinux_state,
-				    sid, sid, SECCLASS_SYSTEM,
-					SYSTEM__MODULE_LOAD, NULL);
-
 	/* finit_module */
 
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
 				SYSTEM__MODULE_LOAD, &ad);
 }
 
+static int selinux_kernel_load_data(enum kernel_load_data_id id)
+{
+	u32 sid;
+	int rc = 0;
+
+	switch (id) {
+	case LOADING_MODULE:
+		sid = current_sid();
+
+		/* init_module */
+		return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
+				    SYSTEM__MODULE_LOAD, NULL);
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 static int selinux_kernel_read_file(struct file *file,
 				    enum kernel_read_file_id id)
 {
@@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
 	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
-- 
2.7.5
