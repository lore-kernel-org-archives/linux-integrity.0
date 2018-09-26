Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727435AbeIZSiD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Sep 2018 14:38:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QCOh56113377
        for <linux-integrity@vger.kernel.org>; Wed, 26 Sep 2018 08:25:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr9huhtdm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Sep 2018 08:25:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 13:25:15 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v4 1/6] x86/ima: define arch_ima_get_secureboot
Date: Wed, 26 Sep 2018 17:52:05 +0530
In-Reply-To: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
Message-Id: <20180926122210.14642-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Distros are concerned about totally disabling the kexec_load syscall.
As a compromise, the kexec_load syscall will only be disabled when
CONFIG_KEXEC_VERIFY_SIG is configured and the system is booted with
secureboot enabled.

This patch defines the new arch specific function called
arch_ima_get_secureboot() to retrieve the secureboot state of the system.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Suggested-by: Seth Forshee <seth.forshee@canonical.com>
---
 arch/x86/kernel/Makefile   |  2 ++
 arch/x86/kernel/ima_arch.c | 17 +++++++++++++++++
 include/linux/ima.h        |  9 +++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/x86/kernel/ima_arch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..f32406e51424 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,3 +149,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
+
+obj-$(CONFIG_IMA)			+= ima_arch.o
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
new file mode 100644
index 000000000000..bb5a88d2b271
--- /dev/null
+++ b/arch/x86/kernel/ima_arch.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/ima.h>
+
+extern struct boot_params boot_params;
+
+bool arch_ima_get_secureboot(void)
+{
+	if (efi_enabled(EFI_BOOT) &&
+		(boot_params.secure_boot == efi_secureboot_mode_enabled))
+		return true;
+	else
+		return false;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 84806b54b50a..4852255aa4f4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,15 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
+#ifdef CONFIG_X86
+extern bool arch_ima_get_secureboot(void);
+#else
+static inline bool arch_ima_get_secureboot(void)
+{
+	return false;
+}
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
-- 
2.13.6
