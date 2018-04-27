Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot0-f201.google.com ([74.125.82.201]:47809 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759018AbeD0TmA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Apr 2018 15:42:00 -0400
Received: by mail-ot0-f201.google.com with SMTP id w10-v6so1890311otj.14
        for <linux-integrity@vger.kernel.org>; Fri, 27 Apr 2018 12:41:59 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 Apr 2018 12:41:55 -0700
Message-Id: <20180427194155.41282-1-mjg59@google.com>
Subject: [PATCH V2] EVM: Allow runtime modification of the set of verified xattrs
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

Mimi, annotating the list_head __ro_after_init doesn't work - adding
entries after init will attempt to modify its ->prev pointer.

 Documentation/ABI/testing/evm       |  13 ++++
 security/integrity/evm/evm.h        |   7 +-
 security/integrity/evm/evm_crypto.c |  10 +--
 security/integrity/evm/evm_main.c   |  73 +++++++++++++++-----
 security/integrity/evm/evm_secfs.c  | 102 ++++++++++++++++++++++++++--
 5 files changed, 176 insertions(+), 29 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index d12cb2eae9ee..bfe529eb26b2 100644
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
+		to be added at runtime. Adding additional extended attributes
+		will result in any existing signatures generated without the
+		additional attributes becoming invalid, and any signatures
+		generated after additional attributes are added will only be
+		valid if the same additional attributes are configured on
+		system boot.
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 45c4a89c02ff..1257c3c24723 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -30,6 +30,11 @@
 #define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP_COMPLETE | \
 		       EVM_ALLOW_METADATA_WRITES)
 
+struct xattr_list {
+	struct list_head list;
+	char *name;
+};
+
 extern int evm_initialized;
 
 #define EVM_ATTR_FSUUID		0x0001
@@ -40,7 +45,7 @@ extern struct crypto_shash *hmac_tfm;
 extern struct crypto_shash *hash_tfm;
 
 /* List of EVM protected security xattrs */
-extern char *evm_config_xattrnames[];
+extern struct list_head evm_config_xattrnames;
 
 int evm_init_key(void);
 int evm_update_evmxattr(struct dentry *dentry,
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..caeea20670cc 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -192,8 +192,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				char type, char *digest)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct xattr_list *xattr;
 	struct shash_desc *desc;
-	char **xattrname;
 	size_t xattr_size = 0;
 	char *xattr_value = NULL;
 	int error;
@@ -208,14 +208,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		return PTR_ERR(desc);
 
 	error = -ENODATA;
-	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
+	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
 		bool is_ima = false;
 
-		if (strcmp(*xattrname, XATTR_NAME_IMA) == 0)
+		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
 			is_ima = true;
 
 		if ((req_xattr_name && req_xattr_value)
-		    && !strcmp(*xattrname, req_xattr_name)) {
+		    && !strcmp(xattr->name, req_xattr_name)) {
 			error = 0;
 			crypto_shash_update(desc, (const u8 *)req_xattr_value,
 					     req_xattr_value_len);
@@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				ima_present = true;
 			continue;
 		}
-		size = vfs_getxattr_alloc(dentry, *xattrname,
+		size = vfs_getxattr_alloc(dentry, xattr->name,
 					  &xattr_value, xattr_size, GFP_NOFS);
 		if (size == -ENOMEM) {
 			error = -ENOMEM;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9ea9c19a545c..86b1632d6b5b 100644
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
@@ -57,6 +57,8 @@ char *evm_config_xattrnames[] = {
 	NULL
 };
 
+LIST_HEAD(evm_config_xattrnames);
+
 static int evm_fixmode;
 static int __init evm_set_fixmode(char *str)
 {
@@ -66,12 +68,30 @@ static int __init evm_set_fixmode(char *str)
 }
 __setup("evm=", evm_set_fixmode);
 
-static void __init evm_init_config(void)
+static int __init evm_init_config(void)
 {
+	struct xattr_list *tmp;
+	char **xattrname;
+
+	for (xattrname = evm_config_default_xattrnames; *xattrname != NULL;
+	     xattrname++) {
+		tmp = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		tmp->name = kstrdup(*xattrname, GFP_KERNEL);
+		if (!tmp->name) {
+			kfree(tmp);
+			return -ENOMEM;
+		}
+		list_add_tail(&tmp->list, &evm_config_xattrnames);
+	}
+
 #ifdef CONFIG_EVM_ATTR_FSUUID
 	evm_hmac_attrs |= EVM_ATTR_FSUUID;
 #endif
 	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
+
+	return 0;
 }
 
 static bool evm_key_loaded(void)
@@ -82,15 +102,15 @@ static bool evm_key_loaded(void)
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	char **xattr;
+	struct xattr_list *xattr;
 	int error;
 	int count = 0;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++) {
-		error = __vfs_getxattr(dentry, inode, *xattr, NULL, 0);
+	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
 		if (error < 0) {
 			if (error == -ENODATA)
 				continue;
@@ -211,24 +231,25 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 
 static int evm_protected_xattr(const char *req_xattr_name)
 {
-	char **xattrname;
 	int namelen;
 	int found = 0;
+	struct xattr_list *xattr;
 
 	namelen = strlen(req_xattr_name);
-	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
-		if ((strlen(*xattrname) == namelen)
-		    && (strncmp(req_xattr_name, *xattrname, namelen) == 0)) {
+	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
+		if ((strlen(xattr->name) == namelen)
+		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
 			found = 1;
 			break;
 		}
 		if (strncmp(req_xattr_name,
-			    *xattrname + XATTR_SECURITY_PREFIX_LEN,
+			    xattr->name + XATTR_SECURITY_PREFIX_LEN,
 			    strlen(req_xattr_name)) == 0) {
 			found = 1;
 			break;
 		}
 	}
+
 	return found;
 }
 
@@ -544,20 +565,37 @@ void __init evm_load_x509(void)
 static int __init init_evm(void)
 {
 	int error;
+	struct list_head *pos, *q;
+	struct xattr_list *xattr;
 
-	evm_init_config();
+	error = evm_init_config();
+	if (error)
+		goto error;
 
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
 	if (error)
-		return error;
+		goto error;
 
 	error = evm_init_secfs();
 	if (error < 0) {
 		pr_info("Error registering secfs\n");
-		return error;
+		goto error;
 	}
 
-	return 0;
+error:
+	if (error != 0) {
+		if (!list_empty(&evm_config_xattrnames)) {
+			list_for_each_safe(pos, q, &evm_config_xattrnames) {
+				xattr = list_entry(pos, struct xattr_list,
+						   list);
+				list_del(pos);
+				kfree(xattr->name);
+				kfree(xattr);
+			}
+		}
+	}
+
+	return error;
 }
 
 /*
@@ -565,10 +603,11 @@ static int __init init_evm(void)
  */
 static int __init evm_display_config(void)
 {
-	char **xattrname;
+	struct xattr_list *xattr;
+
+	list_for_each_entry(xattr, &evm_config_xattrnames, list)
+		pr_info("%s\n", xattr->name);
 
-	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++)
-		pr_info("%s\n", *xattrname);
 	return 0;
 }
 
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index feba03bbedae..3b371125d439 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -20,6 +20,7 @@
 #include "evm.h"
 
 static struct dentry *evm_init_tpm;
+static struct dentry *evm_xattrs;
 
 /**
  * evm_read_key - read() for <securityfs>/evm
@@ -107,13 +108,102 @@ static const struct file_operations evm_key_ops = {
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
 {
-	int error = 0;
+	char *temp;
+	int offset = 0;
+	ssize_t rc, size = 0;
+	struct xattr_list *xattr;
+
+	if (*ppos != 0)
+		return 0;
 
-	evm_init_tpm = securityfs_create_file("evm", S_IRUSR | S_IRGRP,
-					      NULL, NULL, &evm_key_ops);
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
+	int len;
+	struct xattr_list *xattr;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
+	if (!xattr)
+		return -ENOMEM;
+
+	xattr->name = memdup_user_nul(buf, count);
+	if (!xattr->name) {
+		kfree(xattr);
+		return -ENOMEM;
+	}
+
+	/* Remove any trailing newline */
+	len = strlen(xattr->name);
+	if (xattr->name[len-1] == '\n')
+		xattr->name[len-1] = '\0';
+
+	list_add_tail(&xattr->list, &evm_config_xattrnames);
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
+	evm_init_tpm = securityfs_create_file("evm", 0440, NULL, NULL,
+					      &evm_key_ops);
 	if (!evm_init_tpm || IS_ERR(evm_init_tpm))
-		error = -EFAULT;
-	return error;
+		return -EFAULT;
+
+	evm_xattrs = securityfs_create_file("evm_xattrs", 0440, NULL, NULL,
+					    &evm_xattr_ops);
+	if (!evm_xattrs || IS_ERR(evm_xattrs)) {
+		securityfs_remove(evm_init_tpm);
+		return -EFAULT;
+	}
+
+	return 0;
 }
-- 
2.17.0.441.gb46fe60e1d-goog
