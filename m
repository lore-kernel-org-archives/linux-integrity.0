Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965659AbeE2SCZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 14:02:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4THsZgu025219
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:24 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j993ryw69-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:23 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 19:02:20 +0100
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 3/8] ima: based on policy require signed kexec kernel images
Date: Tue, 29 May 2018 14:01:55 -0400
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1527616920-5415-4-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The original kexec_load syscall can not verify file signatures, nor can
the kexec image be measured.  Based on policy, deny the kexec_load
syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>

Changelog v3:
- use switch/case
---
 include/linux/ima.h                 |  7 +++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 27 +++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c |  2 ++
 security/security.c                 |  7 ++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..84806b54b50a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 struct linux_binprm;
 
@@ -19,6 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
@@ -49,6 +51,11 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
+static inline int ima_load_data(enum kernel_load_data_id id)
+{
+	return 0;
+}
+
 static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..78c15264b17b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -232,6 +232,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
+#define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 83f84928ad76..a565d46084c2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -499,6 +499,33 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				   MAY_READ, func, 0);
 }
 
+/**
+ * ima_load_data - appraise decision based on policy
+ * @id: kernel load data caller identifier
+ *
+ * Callers of this LSM hook can not measure, appraise, or audit the
+ * data provided by userspace.  Enforce policy rules requring a file
+ * signature (eg. kexec'ed kernel image).
+ *
+ * For permission return 0, otherwise return -EACCES.
+ */
+int ima_load_data(enum kernel_load_data_id id)
+{
+	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
+		return 0;
+
+	switch (id) {
+	case LOADING_KEXEC_IMAGE:
+		if (ima_appraise & IMA_APPRAISE_KEXEC) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bbc18eb07eb..c27f6993b07a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_FIRMWARE;
 	else if (func == POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
+	else if (func == KEXEC_KERNEL_CHECK)
+		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
 
diff --git a/security/security.c b/security/security.c
index c2de2f134854..4927e7cc7d96 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1058,7 +1058,12 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
 int security_kernel_load_data(enum kernel_load_data_id id)
 {
-	return call_int_hook(kernel_load_data, 0, id);
+	int ret;
+
+	ret = call_int_hook(kernel_load_data, 0, id);
+	if (ret)
+		return ret;
+	return ima_load_data(id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.7.5
