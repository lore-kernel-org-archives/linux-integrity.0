Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbeJJAwm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 20:52:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w99HTcDF053173
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 13:34:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n0wtw90ee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 13:34:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 9 Oct 2018 18:34:36 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, pjones@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, Eric Richter <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v6 5/5] x86/ima: define arch_get_ima_policy() for x86
Date: Tue,  9 Oct 2018 23:00:37 +0530
In-Reply-To: <20181009173037.32630-1-nayna@linux.vnet.ibm.com>
References: <20181009173037.32630-1-nayna@linux.vnet.ibm.com>
Message-Id: <20181009173037.32630-6-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Eric Richter <erichte@linux.ibm.com>

On x86, there are two methods of verifying a kexec'ed kernel image
signature being loaded via the kexec_file_load syscall - an architecture
specific implementaton or a IMA KEXEC_KERNEL_CHECK appraisal rule. Neither
of these methods verify the kexec'ed kernel image signature being loaded
via the kexec_load syscall.

Secure boot enabled systems require kexec images to be signed. Therefore,
this patch loads an IMA KEXEC_KERNEL_CHECK policy rule on secure boot
enabled systems not configured with CONFIG_KEXEC_VERIFY_SIG enabled.

When IMA_APPRAISE_BOOTPARAM is configured, different IMA appraise modes
(eg. fix, log) can be specified on the boot command line, allowing unsigned
or invalidly signed kernel images to be kexec'ed. This patch permits
enabling IMA_APPRAISE_BOOTPARAM or IMA_ARCH_POLICY, but not both.

Signed-off-by: Eric Richter <erichte@linux.ibm.com>
- Removed the policy KEXEC_ORIG_KERNEL_CHECK which was defined to
  disable the kexec_load syscall.
- arch_get_ima_policy() uses arch_ima_get_secureboot() to get secureboot
  state
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/ima_arch.c     | 16 ++++++++++++++++
 include/linux/ima.h            |  3 ++-
 security/integrity/ima/Kconfig | 10 +++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index bb5a88d2b271..6c248616ee57 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -15,3 +15,19 @@ bool arch_ima_get_secureboot(void)
 	else
 		return false;
 }
+
+/* secureboot arch rules */
+static const char * const sb_arch_rules[] = {
+#if !IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
+#endif /* CONFIG_KEXEC_VERIFY_SIG */
+	"measure func=KEXEC_KERNEL_CHECK",
+	NULL
+};
+
+const char * const *arch_get_ima_policy(void)
+{
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
+		return sb_arch_rules;
+	return NULL;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 350fa957f8a6..dca3a96db4cd 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -32,17 +32,18 @@ extern void ima_add_kexec_buffer(struct kimage *image);
 
 #ifdef CONFIG_X86
 extern bool arch_ima_get_secureboot(void);
+extern const char * const *arch_get_ima_policy(void);
 #else
 static inline bool arch_ima_get_secureboot(void)
 {
 	return false;
 }
-#endif
 
 static inline const char * const *arch_get_ima_policy(void)
 {
 	return NULL;
 }
+#endif
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 13b446328dda..a18f8c6d13b5 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -157,6 +157,14 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_ARCH_POLICY
+        bool "Enable loading an IMA architecture specific policy"
+        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+        default n
+        help
+          This option enables loading an IMA architecture specific policy
+          based on run time secure boot flags.
+
 config IMA_APPRAISE_BUILD_POLICY
 	bool "IMA build time configured policy rules"
 	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
@@ -217,7 +225,7 @@ config IMA_APPRAISE_REQUIRE_POLICY_SIGS
 
 config IMA_APPRAISE_BOOTPARAM
 	bool "ima_appraise boot parameter"
-	depends on IMA_APPRAISE
+	depends on IMA_APPRAISE && !IMA_ARCH_POLICY
 	default y
 	help
 	  This option enables the different "ima_appraise=" modes
-- 
2.13.6
