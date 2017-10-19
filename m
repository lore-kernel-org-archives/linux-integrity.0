Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:41551 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbdJSW5y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 18:57:54 -0400
Received: by mail-oi0-f74.google.com with SMTP id l5so9470531oib.0
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 15:57:53 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 Oct 2017 15:57:39 -0700
Message-Id: <20171019225739.4196-1-mjg59@google.com>
Subject: [PATCH] EVM: Allow userland to permit modification of EVM-protected xattrs
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

When EVM is enabled it forbids modification of extended attributes that
are protected by EVM unless there is already a valid EVM signature. If
any modification is made, the kernel will then generate a new EVM HMAC.
However, this does not map well on use cases which use only asymmetric
EVM signatures, as in this scenario the kernel is unable to generate new
signatures.

This patch extends the /sys/kernel/security/evm interface to allow
userland to request that modification of these xattrs be permitted. This
is only permitted if there is no symmetric key loaded. In this
configuration, modifying the extended attributes will increase the
i_version on the file in question, invalidating any existing validation
state. This allows packaging systems to write out new files, set the
relevant extended attributes and then move them into place.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/evm      | 33 +++++++++++++++++++++++----------
 security/integrity/evm/evm.h       |  4 +++-
 security/integrity/evm/evm_main.c  |  5 +++++
 security/integrity/evm/evm_secfs.c |  4 ++++
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
index d2782afb0d96..3de362fd1278 100644
--- a/Documentation/ABI/testing/evm
+++ b/Documentation/ABI/testing/evm
@@ -14,20 +14,33 @@ Description:
 		generated either locally or remotely using an
 		asymmetric key. These keys are loaded onto root's
 		keyring using keyctl, and EVM is then enabled by
-		echoing a value to <securityfs>/evm:
+		echoing a value to <securityfs>/evm made up of the
+		following bits:
 
-		1: enable HMAC validation and creation
-		2: enable digital signature validation
-		3: enable HMAC and digital signature validation and HMAC
-		   creation
+		Bit	  Effect
+		0	  Enable HMAC validation and creation
+		1	  Enable digital signature validation
+		2	  Permit modification of EVM-protected xattrs at
+			  runtime. Not supported if HMAC validation and
+			  creation is enabled.
+		31	  Disable further runtime modification of EVM policy
 
-		Further writes will be blocked if HMAC support is enabled or
-		if bit 32 is set:
+		For example:
 
-		echo 0x80000002 ><securityfs>/evm
+		echo 1 ><securityfs>/evm
 
-		will enable digital signature validation and block
-		further writes to <securityfs>/evm.
+		will enable HMAC validation and creation
+
+		echo 0x80000003 ><securityfs>/evm
+
+		will enable HMAC and digital signature validation and
+		HMAC creation and disable all further modification of policy.
+
+		echo 0x80000006 ><securityfs>/evm
+
+		will enable digital signature validation, permit
+		modification of EVM-protected extended attributes and
+		disable all further modification of policy
 
 		Until this is done, EVM can not create or validate the
 		'security.evm' xattr, but returns INTEGRITY_UNKNOWN.
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 946efffcc389..81ec6c74b178 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -23,9 +23,11 @@
 
 #define EVM_INIT_HMAC	0x0001
 #define EVM_INIT_X509	0x0002
+#define EVM_PERMIT_XATTR_WRITES	0x0004
 #define EVM_SETUP       0x80000000 /* userland has signaled key load */
 
-#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP)
+#define EVM_INIT_MASK (EVM_INIT_HMAC | EVM_INIT_X509 | EVM_SETUP | \
+		       EVM_PERMIT_XATTR_WRITES)
 
 extern int evm_initialized;
 extern char *evm_hmac;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f29ac3384b2a..1d895226af29 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -303,6 +303,11 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 			return 0;
 		goto out;
 	}
+
+	/* Policy permits modification of the protected xattrs */
+	if (evm_initialized & EVM_PERMIT_XATTR_WRITES)
+		return 0;
+
 	evm_status = evm_verify_current_integrity(dentry);
 	if (evm_status == INTEGRITY_NOXATTRS) {
 		struct integrity_iint_cache *iint;
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 319cf16d6603..0ce5134d3de5 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -81,6 +81,10 @@ static ssize_t evm_write_key(struct file *file, const char __user *buf,
 			return ret;
 		/* Forbid further writes after the symmetric key is loaded */
 		i |= EVM_SETUP;
+		/* Don't allow protected xattr modification if a
+		 * symmetric key is loaded
+		 */
+		i &= ~(EVM_PERMIT_XATTR_WRITES);
 	}
 
 	evm_initialized |= i;
-- 
2.15.0.rc0.271.g36b669edcc-goog
