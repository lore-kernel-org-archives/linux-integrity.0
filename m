Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:45281 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbdI0WRL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:11 -0400
Received: by mail-oi0-f74.google.com with SMTP id r20so8685374oie.4
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:50 -0700
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
Message-Id: <20170927221653.11219-4-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Subject: [PATCH 3/6] EVM: Allow userland to override the default EVM attributes
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Local policy may wish to provide a different set of metadata to measure
when compared to the kernel defaults. Allow this to be overridden before
the EVM key is initialised, giving userland an opportunity to define it
but locking it down after EVM is enabled.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm_secfs.c | 74 +++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index c8dccd54d501..b6678f01ec39 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -20,6 +20,7 @@
 #include "evm.h"
 
 static struct dentry *evm_init_tpm;
+static struct dentry *evm_init_flags;
 
 /**
  * evm_read_key - read() for <securityfs>/evm
@@ -88,13 +89,78 @@ static const struct file_operations evm_key_ops = {
 	.write		= evm_write_key,
 };
 
-int __init evm_init_secfs(void)
+/**
+ * evm_read_flags - read() for <securityfs>/evm_flags
+ *
+ * @filp: file pointer, not actually used
+ * @buf: where to put the result
+ * @count: maximum to send along
+ * @ppos: where to start
+ *
+ * Returns number of bytes read or error code, as appropriate
+ */
+static ssize_t evm_read_flags(struct file *filp, char __user *buf,
+			      size_t count, loff_t *ppos)
 {
-	int error = 0;
+	char temp[19];
+	ssize_t rc;
+
+	if (*ppos != 0)
+		return 0;
+
+	sprintf(temp, "0x%llx", evm_default_flags);
+	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+
+	return rc;
+}
 
+/**
+ * evm_write_flags - write() for <securityfs>/evm_flags
+ * @file: file pointer, not actually used
+ * @buf: where to get the data from
+ * @count: bytes sent
+ * @ppos: where to start
+ *
+ * - sets the components that will be measured in the EVM hash
+ * Returns number of bytes written or error code, as appropriate
+ */
+static ssize_t evm_write_flags(struct file *file, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_INIT_HMAC))
+		return -EPERM;
+
+	if (evm_initialized & EVM_INIT_HMAC)
+		return -EINVAL;
+
+	err = kstrtoull_from_user(buf, count, 0, &evm_default_flags);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static const struct file_operations evm_flags_ops = {
+	.read		= evm_read_flags,
+	.write		= evm_write_flags,
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
+	evm_init_flags = securityfs_create_file("evm_flags", S_IRUSR | S_IRGRP,
+						NULL, NULL, &evm_flags_ops);
+
+	if (!evm_init_flags || IS_ERR(evm_init_flags)) {
+		securityfs_remove(evm_init_tpm);
+		return -EFAULT;
+	}
+
+	return 0;
 }
-- 
2.14.2.822.g60be5d43e6-goog
