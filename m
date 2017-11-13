Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752408AbdKMLnl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 06:43:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADBekUd115006
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 06:43:41 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e7a8w9cgw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 06:43:40 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 13 Nov 2017 11:43:39 -0000
Subject: [RFC PATCH v2] fw_lockdown: new micro LSM module to prevent loading
 unsigned firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Mon, 13 Nov 2017 06:43:34 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510573414.3404.109.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If the kernel is locked down and IMA-appraisal is not enabled, prevent
loading of unsigned firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
Changelog v2:
- Invert kernel_is_locked_down() test (Luis Rodriquez)
- Increase LSM name maximum size (15 bytes + null) (Casey)

Changelog v1:
- Lots of minor changes Kconfig, Makefile, fw_lsm.c for such a small patch

 security/Kconfig              |  1 +
 security/Makefile             |  2 ++
 security/fw_lockdown/Kconfig  |  6 +++++
 security/fw_lockdown/Makefile |  3 +++
 security/fw_lockdown/fw_lsm.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 security/security.c           |  2 +-
 6 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 security/fw_lockdown/Kconfig
 create mode 100644 security/fw_lockdown/Makefile
 create mode 100644 security/fw_lockdown/fw_lsm.c

diff --git a/security/Kconfig b/security/Kconfig
index a4fa8b826039..6e7e5888f823 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -243,6 +243,7 @@ source security/tomoyo/Kconfig
 source security/apparmor/Kconfig
 source security/loadpin/Kconfig
 source security/yama/Kconfig
+source security/fw_lockdown/Kconfig
 
 source security/integrity/Kconfig
 
diff --git a/security/Makefile b/security/Makefile
index 8c4a43e3d4e0..58852dee5e22 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -9,6 +9,7 @@ subdir-$(CONFIG_SECURITY_TOMOYO)        += tomoyo
 subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
+subdir-$(CONFIG_SECURITY_FW_LOCKDOWN)	+= fw_lockdown
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -24,6 +25,7 @@ obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/
 obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
+obj-$(CONFIG_SECURITY_FW_LOCKDOWN)	+= fw_lockdown/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/fw_lockdown/Kconfig b/security/fw_lockdown/Kconfig
new file mode 100644
index 000000000000..d6aef6ce8fee
--- /dev/null
+++ b/security/fw_lockdown/Kconfig
@@ -0,0 +1,6 @@
+config SECURITY_FW_LOCKDOWN
+	bool "Prevent loading unsigned firmware"
+	depends on LOCK_DOWN_KERNEL
+	default y
+	help
+	  Prevent loading unsigned firmware in lockdown mode,
diff --git a/security/fw_lockdown/Makefile b/security/fw_lockdown/Makefile
new file mode 100644
index 000000000000..3a16757fd35d
--- /dev/null
+++ b/security/fw_lockdown/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SECURITY_FW_LOCKDOWN) += fw_lockdown.o
+
+fw_lockdown-y := fw_lsm.o
diff --git a/security/fw_lockdown/fw_lsm.c b/security/fw_lockdown/fw_lsm.c
new file mode 100644
index 000000000000..9a5472bc733f
--- /dev/null
+++ b/security/fw_lockdown/fw_lsm.c
@@ -0,0 +1,51 @@
+/*
+ * fw_lockdown security module
+ *
+ * Copyright (C) 2017 IBM Corporation
+ *
+ * Authors:
+ * Mimi Zohar <zohar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "fw_lockdown: " fmt
+
+#include <linux/module.h>
+#include <linux/ima.h>
+#include <linux/lsm_hooks.h>
+
+/**
+ * fw_lockdown_read_file - prevent loading of unsigned firmware
+ * @file: pointer to firmware
+ * @read_id: caller identifier
+ *
+ * Prevent loading of unsigned firmware in lockdown mode.
+ */
+static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
+{
+	if (id == READING_FIRMWARE) {
+		if (!is_ima_appraise_enabled() &&
+		    kernel_is_locked_down("Loading of unsigned firmware"))
+			return -EACCES;
+	}
+	return 0;
+}
+
+static struct security_hook_list fw_lockdown_hooks[] = {
+	LSM_HOOK_INIT(kernel_read_file, fw_lockdown_read_file)
+};
+
+static int __init init_fw_lockdown(void)
+{
+	security_add_hooks(fw_lockdown_hooks, ARRAY_SIZE(fw_lockdown_hooks),
+			   "fw_lockdown");
+	pr_info("initialized\n");
+	return 0;
+}
+
+late_initcall(init_fw_lockdown);
+MODULE_LICENSE("GPL");
diff --git a/security/security.c b/security/security.c
index 4bf0f571b4ef..61a0c95ec687 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,7 +32,7 @@
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
+#define SECURITY_NAME_MAX	15
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
-- 
2.7.4
