Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f202.google.com ([209.85.213.202]:47224 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeEIU2T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 16:28:19 -0400
Received: by mail-yb0-f202.google.com with SMTP id l7-v6so23962754ybk.14
        for <linux-integrity@vger.kernel.org>; Wed, 09 May 2018 13:28:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed,  9 May 2018 13:28:11 -0700
In-Reply-To: <20180509202811.29875-1-mjg59@google.com>
Message-Id: <20180509202811.29875-2-mjg59@google.com>
References: <20180509202811.29875-1-mjg59@google.com>
Subject: [PATCH V4 2/2] EVM: Allow runtime modification of the set of verified xattrs
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Sites may wish to provide additional metadata alongside files in order
to make more fine-grained security decisions[1]. The security of this is
enhanced if this metadata is protected, something that EVM makes
possible. However, the kernel cannot know about the set of extended
attributes that local admins may wish to protect, and hardcoding this
policy in the kernel makes it difficult to change over time and less
convenient for distributions to enable.

This patch adds a new /sys/kernel/security/evm_xattrs node, which can be
read to obtain the current set of EVM-protected extended attributes or
written to in order to add new entries. Extending this list will not
change the validity of any existing signatures provided that the file
in question does not have any of the additional extended attributes -
missing xattrs are skipped when calculating the EVM hash.

[1] For instance, a package manager could install information about the
package uploader in an additional extended attribute. Local LSM policy
could then be associated with that extended attribute in order to
restrict the privileges available to packages from less trusted
uploaders.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---

 Updated to add support for locking down the list, and also to forbid adding
 the same xattr twice.

 Documentation/ABI/testing/evm       |  13 +++
 security/integrity/evm/Kconfig      |  11 ++
 security/integrity/evm/evm_crypto.c |   2 +-
 security/integrity/evm/evm_main.c   |   6 +-
 security/integrity/evm/evm_secfs.c  | 153 ++++++++++++++++++++++++++--
 5 files changed, 175 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index d12cb2eae9ee..fa31df7fd30b 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -57,3 +57,16 @@ Description:
 		dracut (via 97masterkey and 98integrity) and systemd (via
 		core/ima-setup) have support for loading keys at boot
 		time.
+
+What:		security/evm_xattrs
+Date:		April 2018
+Contact:	Matthew Garrett <mjg59@google.com>
+Description:
+		Shows the set of extended attributes used to calculate or
+		validate the EVM signature, and allows additional attributes
+		to be added at runtime. Any signatures generated after
+		additional attributes are added (and on files posessing those
+		additional attributes) will only be valid if the same
+		additional attributes are configured on system boot. Writing
+		a single period (.) will lock the xattr list from any further
+		modification.
diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
index e825e0ae78e7..54adb3f9ad1d 100644
--- a/security/integrity/evm/Kconfig
+++ b/security/integrity/evm/Kconfig
@@ -42,6 +42,17 @@ config EVM_EXTRA_SMACK_XATTRS
 	  additional info to the calculation, requires existing EVM
 	  labeled file systems to be relabeled.
 
+config EVM_ADD_XATTRS
+	bool "Add additional EVM extended attributes at runtime"
+	depends on EVM
+	default n
+	help
+	  Allow userland to provide additional xattrs for HMAC calculation.
+
+	  When this option is enabled, root can add additional xattrs to the
+	  list used by EVM by writing them into
+	  /sys/kernel/security/evm_xattrs.
+
 config EVM_LOAD_X509
 	bool "Load an X509 certificate onto the '.evm' trusted keyring"
 	depends on EVM && INTEGRITY_TRUSTED_KEYRING
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index caeea20670cc..494da5fcc092 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -208,7 +208,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		return PTR_ERR(desc);
 
 	error = -ENODATA;
-	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
 		bool is_ima = false;
 
 		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index dd2415c55982..f049af2cc037 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -35,7 +35,7 @@ static const char * const integrity_status_msg[] = {
 };
 int evm_hmac_attrs;
 
-static struct xattr_list evm_config_default_xattrnames[] __ro_after_init = {
+static struct xattr_list evm_config_default_xattrnames[] = {
 #ifdef CONFIG_SECURITY_SELINUX
 	{.name = XATTR_NAME_SELINUX},
 #endif
@@ -98,7 +98,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
 		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
 		if (error < 0) {
 			if (error == -ENODATA)
@@ -225,7 +225,7 @@ static int evm_protected_xattr(const char *req_xattr_name)
 	struct xattr_list *xattr;
 
 	namelen = strlen(req_xattr_name);
-	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
 		if ((strlen(xattr->name) == namelen)
 		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
 			found = 1;
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index feba03bbedae..8dc11c0ac8a0 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -17,10 +17,17 @@
 
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include "evm.h"
 
 static struct dentry *evm_init_tpm;
 
+#ifdef CONFIG_EVM_ADD_XATTRS
+static struct dentry *evm_xattrs;
+static DEFINE_MUTEX(xattr_list_mutex);
+static int evm_xattrs_locked;
+#endif
+
 /**
  * evm_read_key - read() for <securityfs>/evm
  *
@@ -107,13 +114,147 @@ static const struct file_operations evm_key_ops = {
 	.write		= evm_write_key,
 };
 
-int __init evm_init_secfs(void)
+#ifdef CONFIG_EVM_ADD_XATTRS
+/**
+ * evm_read_xattrs - read() for <securityfs>/evm_xattrs
+ *
+ * @filp: file pointer, not actually used
+ * @buf: where to put the result
+ * @count: maximum to send along
+ * @ppos: where to start
+ *
+ * Returns number of bytes read or error code, as appropriate
+ */
+static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	char *temp;
+	int offset = 0;
+	ssize_t rc, size = 0;
+	struct xattr_list *xattr;
+
+	if (*ppos != 0)
+		return 0;
+
+	rc = mutex_lock_interruptible(&xattr_list_mutex);
+	if (rc)
+		return -ERESTARTSYS;
+
+	list_for_each_entry(xattr, &evm_config_xattrnames, list)
+		size += strlen(xattr->name) + 1;
+
+	temp = kmalloc(size + 1, GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+		sprintf(temp + offset, "%s\n", xattr->name);
+		offset += strlen(xattr->name) + 1;
+	}
+
+	mutex_unlock(&xattr_list_mutex);
+	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+
+	return rc;
+}
+
+/**
+ * evm_write_xattrs - write() for <securityfs>/evm_xattrs
+ * @file: file pointer, not actually used
+ * @buf: where to get the data from
+ * @count: bytes sent
+ * @ppos: where to start
+ *
+ * Returns number of bytes written or error code, as appropriate
+ */
+static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	int len, err;
+	struct xattr_list *xattr, *tmp;
+
+	if (!capable(CAP_SYS_ADMIN) || evm_xattrs_locked)
+		return -EPERM;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	if (count > XATTR_NAME_MAX)
+		return -E2BIG;
+
+	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
+	if (!xattr)
+		return -ENOMEM;
+
+	xattr->name = memdup_user_nul(buf, count);
+	if (IS_ERR(xattr->name)) {
+		err = PTR_ERR(xattr->name);
+		kfree(xattr);
+		return err;
+	}
+
+	/* Remove any trailing newline */
+	len = strlen(xattr->name);
+	if (xattr->name[len-1] == '\n')
+		xattr->name[len-1] = '\0';
+
+	if (strcmp(xattr->name, ".") == 0) {
+		evm_xattrs_locked = 1;
+		err = count;
+		goto out;
+	}
+
+	/* Guard against races in evm_read_xattrs */
+	mutex_lock(&xattr_list_mutex);
+	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
+		if (strcmp(xattr->name, tmp->name) == 0) {
+			err = -EEXIST;
+			mutex_unlock(&xattr_list_mutex);
+			goto out;
+		}
+	}
+	list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
+	mutex_unlock(&xattr_list_mutex);
+
+	return count;
+out:
+	kfree(xattr->name);
+	kfree(xattr);
+	return err;
+}
+
+static const struct file_operations evm_xattr_ops = {
+	.read		= evm_read_xattrs,
+	.write		= evm_write_xattrs,
+};
+
+static int evm_init_xattrs(void)
+{
+	evm_xattrs = securityfs_create_file("evm_xattrs", 0440, NULL, NULL,
+					    &evm_xattr_ops);
+	if (!evm_xattrs || IS_ERR(evm_xattrs))
+		return -EFAULT;
+
+	return 0;
+}
+#else
+static int evm_init_xattrs(void)
 {
-	int error = 0;
+	return 0;
+}
+#endif
 
-	evm_init_tpm = securityfs_create_file("evm", S_IRUSR | S_IRGRP,
-					      NULL, NULL, &evm_key_ops);
+int __init evm_init_secfs(void)
+{
+	evm_init_tpm = securityfs_create_file("evm", 0440, NULL, NULL,
+					      &evm_key_ops);
 	if (!evm_init_tpm || IS_ERR(evm_init_tpm))
-		error = -EFAULT;
-	return error;
+		return -EFAULT;
+
+	if (evm_init_xattrs()) {
+		securityfs_remove(evm_init_tpm);
+		return -EFAULT;
+	}
+
+	return 0;
 }
-- 
2.17.0.441.gb46fe60e1d-goog
