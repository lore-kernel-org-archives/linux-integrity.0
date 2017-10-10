Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f201.google.com ([209.85.216.201]:63027 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756166AbdJJW0Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2017 18:26:24 -0400
Received: by mail-qt0-f201.google.com with SMTP id z19so11628qtg.21
        for <linux-integrity@vger.kernel.org>; Tue, 10 Oct 2017 15:26:23 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Oct 2017 15:26:09 -0700
Message-Id: <20171010222609.5185-1-mjg59@google.com>
Subject: [PATCH] EVM: Allow userspace to signal an RSA key has been loaded
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

EVM will only perform validation once a key has been loaded. This key
may either be a symmetric trusted key (for HMAC validation and creation)
or the public half of an asymmetric key (for digital signature
validation). The /sys/kernel/security/evm interface allows userland to
signal that a symmetric key has been loaded, but does not allow userland
to signal that an asymmetric public key has been loaded.

This patch extends the interface to permit userspace to pass a bitmask
of loaded key types. It is a write-once interface in order to avoid a
compromised system from being able to load an additional key type later.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/evm      | 39 ++++++++++++++++++++++++--------------
 security/integrity/evm/evm.h       |  3 +++
 security/integrity/evm/evm_secfs.c | 27 ++++++++++++++------------
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index 8374d4557e5d..0463c3339bb1 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -7,17 +7,28 @@ Description:
 		HMAC-sha1 value across the extended attributes, storing the
 		value as the extended attribute 'security.evm'.
 
-		EVM depends on the Kernel Key Retention System to provide it
-		with a trusted/encrypted key for the HMAC-sha1 operation.
-		The key is loaded onto the root's keyring using keyctl.  Until
-		EVM receives notification that the key has been successfully
-		loaded onto the keyring (echo 1 > <securityfs>/evm), EVM
-		can not create or validate the 'security.evm' xattr, but
-		returns INTEGRITY_UNKNOWN.  Loading the key and signaling EVM
-		should be done as early as possible.  Normally this is done
-		in the initramfs, which has already been measured as part
-		of the trusted boot.  For more information on creating and
-		loading existing trusted/encrypted keys, refer to:
-		Documentation/keys-trusted-encrypted.txt.  (A sample dracut
-		patch, which loads the trusted/encrypted key and enables
-		EVM, is available from http://linux-ima.sourceforge.net/#EVM.)
+		EVM supports two classes of security.evm. The first is
+		an HMAC-sha1 generated locally with a
+		trusted/encrypted key stored in the Kernel Key
+		Retention System. The second is a digital signature
+		generated either locally or remotely using an
+		asymmetric key. These keys are loaded onto root's
+		keyring using keyctl, and EVM is then enabled by
+		echoing a value to <securityfs>/evm:
+
+		1: enable HMAC validation and creation
+		2: enable digital signature validation
+		3: enable HMAC and digital signature validation and HMAC
+		   creation
+
+		Until this is done, EVM can not create or validate the
+		'security.evm' xattr, but returns INTEGRITY_UNKNOWN.
+		Loading keys and signaling EVM should be done as early
+		as possible.  Normally this is done in the initramfs,
+		which has already been measured as part of the trusted
+		boot.  For more information on creating and loading
+		existing trusted/encrypted keys, refer to:
+		Documentation/keys-trusted-encrypted.txt.  (A sample
+		dracut patch, which loads the trusted/encrypted key
+		and enables EVM, is available from
+		http://linux-ima.sourceforge.net/#EVM.)
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 2ff02459fcfd..abbe8f4302ed 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -23,6 +23,9 @@
 
 #define EVM_INIT_HMAC	0x0001
 #define EVM_INIT_X509	0x0002
+#define EVM_SETUP       0x80000000 /* userland has signaled key load */
+
+#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509)
 
 extern int evm_initialized;
 extern char *evm_hmac;
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index c8dccd54d501..c7bc38a7ca94 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -40,7 +40,7 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
 	if (*ppos != 0)
 		return 0;
 
-	sprintf(temp, "%d", evm_initialized);
+	sprintf(temp, "%d", (evm_initialized & ~EVM_SETUP));
 	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
 
 	return rc;
@@ -61,24 +61,27 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
 static ssize_t evm_write_key(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	char temp[80];
-	int i;
+	int i, ret;
 
-	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_INIT_HMAC))
+	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP))
 		return -EPERM;
 
-	if (count >= sizeof(temp) || count == 0)
-		return -EINVAL;
-
-	if (copy_from_user(temp, buf, count) != 0)
-		return -EFAULT;
+	ret = kstrtoint_from_user(buf, count, 0, &i);
 
-	temp[count] = '\0';
+	if (ret)
+		return ret;
 
-	if ((sscanf(temp, "%d", &i) != 1) || (i != 1))
+	/* Reject invalid values */
+	if (!i || (i & ~EVM_INIT_MASK) != 0)
 		return -EINVAL;
 
-	evm_init_key();
+	if (i & EVM_INIT_HMAC) {
+		ret = evm_init_key();
+		if (ret != 0)
+			return ret;
+	}
+
+	evm_initialized |= (i|EVM_SETUP);
 
 	return count;
 }
-- 
2.14.2.920.gcf0c67979c-goog
