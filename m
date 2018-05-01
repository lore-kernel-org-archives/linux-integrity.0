Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f74.google.com ([209.85.214.74]:57206 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755898AbeEARvf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 13:51:35 -0400
Received: by mail-it0-f74.google.com with SMTP id 6-v6so10903297itl.6
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 10:51:35 -0700 (PDT)
MIME-Version: 1.0
Date: Tue,  1 May 2018 10:51:24 -0700
In-Reply-To: <20180501175124.192587-1-mjg59@google.com>
Message-Id: <20180501175124.192587-2-mjg59@google.com>
References: <20180501175124.192587-1-mjg59@google.com>
Subject: [PATCH V3 2/2] EVM: Allow runtime modification of the set of verified xattrs
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
 Documentation/ABI/testing/evm      |  13 ++++
 security/integrity/evm/evm_secfs.c | 102 +++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 6 deletions(-)

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
