Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f201.google.com ([209.85.223.201]:41163 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeDMWw1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Apr 2018 18:52:27 -0400
Received: by mail-io0-f201.google.com with SMTP id s11so8742183ioa.8
        for <linux-integrity@vger.kernel.org>; Fri, 13 Apr 2018 15:52:27 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 13 Apr 2018 15:52:20 -0700
Message-Id: <20180413225220.20130-1-mjg59@google.com>
Subject: [PATCH] EVM: Allow runtime modification of the set of verified xattrs
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
written to in order to add new entries. Once EVM is enabled (by writing
to /sys/kernel/security/evm), further writes are blocked. This should
make no difference to security considerations around EVM - even if an
attacker is able to get additional extended attributes added to this
list, it will simply result in existing signatures failing to validate.

[1] For instance, a package manager could install information about the
package uploader in an additional extended attribute. Local LSM policy
could then be associated with that extended attribute in order to
restrict the privileges available to packages from less trusted
uploaders.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/evm      |  16 +++++
 security/integrity/evm/evm.h       |   3 +-
 security/integrity/evm/evm_main.c  |   4 +-
 security/integrity/evm/evm_secfs.c | 111 +++++++++++++++++++++++++++--
 4 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index d12cb2eae9ee..5f60c263462c 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -57,3 +57,19 @@ Description:
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
+		to be added at runtime. Adding additional extended attributes
+		will result in any existing signatures generated without the
+		additional attributes becoming invalid, and any signatures
+		generated after additional attributes are added will only be
+		valid if the same additional attributes are configured on
+		system boot.
+
+		This list cannot be modified after EVM has been enabled at
+		runtime.
\ No newline at end of file
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 45c4a89c02ff..b134358860d2 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -40,7 +40,8 @@ extern struct crypto_shash *hmac_tfm;
 extern struct crypto_shash *hash_tfm;
 
 /* List of EVM protected security xattrs */
-extern char *evm_config_xattrnames[];
+extern char **evm_config_xattrnames;
+extern char **evm_config_extra_xattrnames;
 
 int evm_init_key(void);
 int evm_update_evmxattr(struct dentry *dentry,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9ea9c19a545c..debc8f836a9c 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -35,7 +35,7 @@ static const char * const integrity_status_msg[] = {
 };
 int evm_hmac_attrs;
 
-char *evm_config_xattrnames[] = {
+char *evm_config_default_xattrnames[] = {
 #ifdef CONFIG_SECURITY_SELINUX
 	XATTR_NAME_SELINUX,
 #endif
@@ -56,6 +56,8 @@ char *evm_config_xattrnames[] = {
 	XATTR_NAME_CAPS,
 	NULL
 };
+char **evm_config_xattrnames = evm_config_default_xattrnames;
+char **evm_config_extra_xattrnames;
 
 static int evm_fixmode;
 static int __init evm_set_fixmode(char *str)
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index feba03bbedae..2db800076728 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -20,6 +20,7 @@
 #include "evm.h"
 
 static struct dentry *evm_init_tpm;
+static struct dentry *evm_xattrs;
 
 /**
  * evm_read_key - read() for <securityfs>/evm
@@ -107,13 +108,115 @@ static const struct file_operations evm_key_ops = {
 	.write		= evm_write_key,
 };
 
-int __init evm_init_secfs(void)
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
+	char **xattr;
+	int offset = 0;
+	ssize_t rc, size = 0;
+
+	if (*ppos != 0)
+		return 0;
+
+	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++)
+		size += strlen(*xattr) + 1;
+
+	temp = kmalloc(size + 1, GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++) {
+		sprintf(temp + offset, "%s\n", *xattr);
+		offset += strlen(*xattr) + 1;
+	}
+
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
 {
-	int error = 0;
+	bool populate = false;
+	int len, entries = 0;
+	char **xattr, **temp;
+
+	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE))
+		return -EPERM;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++)
+		entries++;
+
+	if (!evm_config_extra_xattrnames)
+		populate = true;
+
+	temp = krealloc(evm_config_extra_xattrnames,
+			(entries + 2) * sizeof(char *),
+			GFP_KERNEL);
+
+	if (!temp)
+		return -ENOMEM;
 
+	evm_config_extra_xattrnames = temp;
+
+	if (populate) {
+		memcpy(evm_config_extra_xattrnames, evm_config_xattrnames,
+		       entries * sizeof(char *));
+		evm_config_xattrnames = evm_config_extra_xattrnames;
+	}
+
+	evm_config_extra_xattrnames[entries] = memdup_user_nul(buf, count);
+	evm_config_extra_xattrnames[entries + 1] = NULL;
+
+	/* Remove any trailing newline */
+	len = strlen(evm_config_extra_xattrnames[entries]);
+	if (evm_config_extra_xattrnames[entries][len-1] == '\n')
+		evm_config_extra_xattrnames[entries][len-1] = '\0';
+	return count;
+}
+
+static const struct file_operations evm_xattr_ops = {
+	.read		= evm_read_xattrs,
+	.write		= evm_write_xattrs,
+};
+
+int __init evm_init_secfs(void)
+{
 	evm_init_tpm = securityfs_create_file("evm", S_IRUSR | S_IRGRP,
 					      NULL, NULL, &evm_key_ops);
 	if (!evm_init_tpm || IS_ERR(evm_init_tpm))
-		error = -EFAULT;
-	return error;
+		return -EFAULT;
+
+	evm_xattrs = securityfs_create_file("evm_xattrs", S_IRUSR | S_IRGRP,
+					    NULL, NULL, &evm_xattr_ops);
+	if (!evm_xattrs || IS_ERR(evm_xattrs)) {
+		securityfs_remove(evm_init_tpm);
+		return -EFAULT;
+	}
+
+	return 0;
 }
-- 
2.17.0.484.g0c8726318c-goog
