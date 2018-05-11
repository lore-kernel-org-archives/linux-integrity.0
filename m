Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f201.google.com ([209.85.213.201]:43404 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEKXMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 19:12:44 -0400
Received: by mail-yb0-f201.google.com with SMTP id w78-v6so3985226ybe.10
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 16:12:43 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 11 May 2018 16:12:34 -0700
Message-Id: <20180511231236.5501-1-mjg59@google.com>
Subject: [PATCH V5 1/3] integrity: Add an integrity directory in securityfs
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

We want to add additional evm control nodes, and it'd be preferable not
to clutter up the securityfs root directory any further. Create a new
integrity directory, move the ima directory into it, create an evm
directory for the evm attribute and add compatibility symlinks.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm_secfs.c | 27 ++++++++++++++++++++++++---
 security/integrity/iint.c          | 18 ++++++++++++++++++
 security/integrity/ima/ima_fs.c    |  9 ++++++++-
 security/integrity/integrity.h     |  2 ++
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index feba03bbedae..e44380f0cb45 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -19,7 +19,9 @@
 #include <linux/module.h>
 #include "evm.h"
 
+static struct dentry *evm_dir;
 static struct dentry *evm_init_tpm;
+static struct dentry *evm_symlink;
 
 /**
  * evm_read_key - read() for <securityfs>/evm
@@ -111,9 +113,28 @@ int __init evm_init_secfs(void)
 {
 	int error = 0;
 
-	evm_init_tpm = securityfs_create_file("evm", S_IRUSR | S_IRGRP,
-					      NULL, NULL, &evm_key_ops);
-	if (!evm_init_tpm || IS_ERR(evm_init_tpm))
+	evm_dir = securityfs_create_dir("evm", integrity_dir);
+	if (!evm_dir || IS_ERR(evm_dir))
+		return -EFAULT;
+
+	evm_init_tpm = securityfs_create_file("evm", 0660,
+					      evm_dir, NULL, &evm_key_ops);
+	if (!evm_init_tpm || IS_ERR(evm_init_tpm)) {
+		error = -EFAULT;
+		goto out;
+	}
+
+	evm_symlink = securityfs_create_symlink("evm", NULL,
+						"integrity/evm/evm", NULL);
+	if (!evm_symlink || IS_ERR(evm_symlink)) {
 		error = -EFAULT;
+		goto out;
+	}
+
+	return 0;
+out:
+	securityfs_remove(evm_symlink);
+	securityfs_remove(evm_init_tpm);
+	securityfs_remove(evm_dir);
 	return error;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index f266e4b3b7d4..149faa81f6f0 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -21,12 +21,15 @@
 #include <linux/rbtree.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
 static DEFINE_RWLOCK(integrity_iint_lock);
 static struct kmem_cache *iint_cache __read_mostly;
 
+struct dentry *integrity_dir;
+
 /*
  * __integrity_iint_find - return the iint associated with an inode
  */
@@ -211,3 +214,18 @@ void __init integrity_load_keys(void)
 	ima_load_x509();
 	evm_load_x509();
 }
+
+static int __init integrity_fs_init(void)
+{
+	integrity_dir = securityfs_create_dir("integrity", NULL);
+	if (IS_ERR(integrity_dir)) {
+		pr_err("Unable to create integrity sysfs dir: %ld\n",
+		       PTR_ERR(integrity_dir));
+		integrity_dir = NULL;
+		return PTR_ERR(integrity_dir);
+	}
+
+	return 0;
+}
+
+late_initcall(integrity_fs_init)
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index fa540c0469da..5153d7faea13 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -356,6 +356,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 }
 
 static struct dentry *ima_dir;
+static struct dentry *ima_symlink;
 static struct dentry *binary_runtime_measurements;
 static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
@@ -448,10 +449,15 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int __init ima_fs_init(void)
 {
-	ima_dir = securityfs_create_dir("ima", NULL);
+	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return -1;
 
+	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
+						NULL);
+	if (IS_ERR(ima_symlink))
+		goto out;
+
 	binary_runtime_measurements =
 	    securityfs_create_file("binary_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
@@ -491,6 +497,7 @@ int __init ima_fs_init(void)
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
+	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 	securityfs_remove(ima_policy);
 	return -1;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5e58e02ba8dc..0bb372eed62a 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -143,6 +143,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_MODULE	2
 #define INTEGRITY_KEYRING_MAX		3
 
+extern struct dentry *integrity_dir;
+
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
-- 
2.17.0.441.gb46fe60e1d-goog
