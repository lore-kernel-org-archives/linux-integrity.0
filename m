Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f74.google.com ([209.85.214.74]:48442 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdI0WRJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:09 -0400
Received: by mail-it0-f74.google.com with SMTP id g18so14677itg.7
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:08 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:49 -0700
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
Message-Id: <20170927221653.11219-3-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Subject: [PATCH 2/6] EVM: Add infrastructure for making EVM fields optional
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The set of information used for EVM calculations is currently hardcoded
at kernel build time. Add infrastructure for allowing individual
components to be enabled or disabled, but keep the same default
behaviour for the moment.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm.h        | 22 +++++++++++++----
 security/integrity/evm/evm_crypto.c | 48 ++++++++++++++++++++++---------------
 security/integrity/evm/evm_main.c   | 45 +++++++++++++++++++++-------------
 3 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index f5f12727771a..1d8201b1fb8a 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -28,9 +28,23 @@ extern int evm_initialized;
 extern char *evm_hmac;
 extern char *evm_hash;
 
-#define EVM_ATTR_FSUUID		0x0001
+/* Extended attributes */
+#define EVM_SELINUX (1L << 0)
+#define EVM_SMACK (1L << 1)
+#define EVM_SMACKEXEC (1L << 2)
+#define EVM_SMACKTRANSMUTE (1L << 3)
+#define EVM_SMACKMMAP (1L << 4)
+#define EVM_IMA (1L << 5)
+#define EVM_CAPS (1L << 6)
+/* Other metadata */
+#define EVM_INODE (1L << 32)
+#define EVM_OWNERSHIP (1L << 33)
+#define EVM_MODE (1L << 34)
+#define EVM_FSUUID (1L << 35)
+/* Behavioural flags */
+#define EVM_HMAC_CONVERT (1L << 63)
 
-extern int evm_hmac_attrs;
+extern u64 evm_default_flags;
 
 extern struct crypto_shash *hmac_tfm;
 extern struct crypto_shash *hash_tfm;
@@ -45,10 +59,10 @@ int evm_update_evmxattr(struct dentry *dentry,
 			size_t req_xattr_value_len);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, u64 flags, char *digest);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, u64 flags, char *digest);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1d32cd20009a..9ce55ac6781e 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -138,7 +138,7 @@ static struct shash_desc *init_desc(char type)
  * protection.)
  */
 static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
-			  char *digest)
+			  u64 flags, char *digest)
 {
 	struct h_misc {
 		unsigned long ino;
@@ -149,8 +149,10 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	} hmac_misc;
 
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
-	hmac_misc.ino = inode->i_ino;
-	hmac_misc.generation = inode->i_generation;
+	if (flags & EVM_INODE) {
+		hmac_misc.ino = inode->i_ino;
+		hmac_misc.generation = inode->i_generation;
+	}
 	/* The hmac uid and gid must be encoded in the initial user
 	 * namespace (not the filesystems user namespace) as encoding
 	 * them in the filesystems user namespace allows an attack
@@ -159,11 +161,14 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	 * filesystem for real on next boot and trust it because
 	 * everything is signed.
 	 */
-	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
-	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
-	hmac_misc.mode = inode->i_mode;
+	if (flags & EVM_OWNERSHIP) {
+		hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
+		hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
+	}
+	if (flags & EVM_MODE)
+		hmac_misc.mode = inode->i_mode;
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
-	if (evm_hmac_attrs & EVM_ATTR_FSUUID)
+	if (flags & EVM_FSUUID)
 		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
 				    sizeof(inode->i_sb->s_uuid));
 	crypto_shash_final(desc, digest);
@@ -180,15 +185,16 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				const char *req_xattr_name,
 				const char *req_xattr_value,
 				size_t req_xattr_value_len,
-				char type, char *digest)
+				char type, u64 flags, char *digest)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct shash_desc *desc;
-	char **xattrname;
+	char *xattrname;
 	size_t xattr_size = 0;
 	char *xattr_value = NULL;
 	int error;
 	int size;
+	int i;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
@@ -198,15 +204,19 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		return PTR_ERR(desc);
 
 	error = -ENODATA;
-	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
+	for (i = 0; evm_config_xattrnames[i] != NULL; i++) {
+		if (!(flags & (1 << i)))
+			continue;
+
+		xattrname = evm_config_xattrnames[i];
 		if ((req_xattr_name && req_xattr_value)
-		    && !strcmp(*xattrname, req_xattr_name)) {
+		    && !strcmp(xattrname, req_xattr_name)) {
 			error = 0;
 			crypto_shash_update(desc, (const u8 *)req_xattr_value,
 					     req_xattr_value_len);
 			continue;
 		}
-		size = vfs_getxattr_alloc(dentry, *xattrname,
+		size = vfs_getxattr_alloc(dentry, xattrname,
 					  &xattr_value, xattr_size, GFP_NOFS);
 		if (size == -ENOMEM) {
 			error = -ENOMEM;
@@ -219,7 +229,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		xattr_size = size;
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
 	}
-	hmac_add_misc(desc, inode, digest);
+	hmac_add_misc(desc, inode, flags, digest);
 
 out:
 	kfree(xattr_value);
@@ -229,18 +239,18 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char *digest)
+		  u64 flags, char *digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				req_xattr_value_len, EVM_XATTR_HMAC, digest);
+			   req_xattr_value_len, EVM_XATTR_HMAC, flags, digest);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char *digest)
+		  u64 flags, char *digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				req_xattr_value_len, IMA_XATTR_DIGEST, digest);
+			 req_xattr_value_len, IMA_XATTR_DIGEST, flags, digest);
 }
 
 /*
@@ -256,7 +266,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	int rc = 0;
 
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			   xattr_value_len, xattr_data.digest);
+			xattr_value_len, evm_default_flags, xattr_data.digest);
 	if (rc == 0) {
 		xattr_data.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
@@ -280,7 +290,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 	}
 
 	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
-	hmac_add_misc(desc, inode, hmac_val);
+	hmac_add_misc(desc, inode, evm_default_flags, hmac_val);
 	kfree(desc);
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 44e4f4fda965..52b6fff91f8d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -35,23 +35,32 @@ static char *integrity_status_msg[] = {
 };
 char *evm_hmac = "hmac(sha1)";
 char *evm_hash = "sha1";
-int evm_hmac_attrs;
 
-char *evm_config_xattrnames[] = {
+u64 evm_default_flags =
 #ifdef CONFIG_SECURITY_SELINUX
-	XATTR_NAME_SELINUX,
+	EVM_SELINUX |
 #endif
 #ifdef CONFIG_SECURITY_SMACK
-	XATTR_NAME_SMACK,
+	EVM_SMACK |
 #ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
-	XATTR_NAME_SMACKEXEC,
-	XATTR_NAME_SMACKTRANSMUTE,
-	XATTR_NAME_SMACKMMAP,
+	EVM_SMACKEXEC |	EVM_SMACKTRANSMUTE | EVM_SMACKMMAP |
 #endif
 #endif
 #ifdef CONFIG_IMA_APPRAISE
-	XATTR_NAME_IMA,
+	EVM_IMA |
 #endif
+#ifdef CONFIG_EVM_ATTR_FSUUID
+	EVM_FSUUID |
+#endif
+	EVM_CAPS | EVM_INODE | EVM_OWNERSHIP | EVM_MODE;
+
+char *evm_config_xattrnames[] = {
+	XATTR_NAME_SELINUX,
+	XATTR_NAME_SMACK,
+	XATTR_NAME_SMACKEXEC,
+	XATTR_NAME_SMACKTRANSMUTE,
+	XATTR_NAME_SMACKMMAP,
+	XATTR_NAME_IMA,
 	XATTR_NAME_CAPS,
 	NULL
 };
@@ -67,24 +76,26 @@ __setup("evm=", evm_set_fixmode);
 
 static void __init evm_init_config(void)
 {
-#ifdef CONFIG_EVM_ATTR_FSUUID
-	evm_hmac_attrs |= EVM_ATTR_FSUUID;
-#endif
-	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
+	pr_info("HMAC attrs: 0x%llx\n", evm_default_flags);
 }
 
 static int evm_find_protected_xattrs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	char **xattr;
+	char *xattr;
 	int error;
 	int count = 0;
+	int i;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	for (xattr = evm_config_xattrnames; *xattr != NULL; xattr++) {
-		error = __vfs_getxattr(dentry, inode, *xattr, NULL, 0);
+	for (i = 0; evm_config_xattrnames[i] != NULL; i++) {
+		if (!(evm_default_flags & (1 << i)))
+			continue;
+
+		xattr = evm_config_xattrnames[i];
+		error = __vfs_getxattr(dentry, inode, xattr, NULL, 0);
 		if (error < 0) {
 			if (error == -ENODATA)
 				continue;
@@ -152,7 +163,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			goto out;
 		}
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-				   xattr_value_len, calc.digest);
+			      xattr_value_len, evm_default_flags, calc.digest);
 		if (rc)
 			break;
 		rc = crypto_memneq(xattr_data->digest, calc.digest,
@@ -162,7 +173,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				xattr_value_len, calc.digest);
+			      xattr_value_len, evm_default_flags, calc.digest);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
-- 
2.14.2.822.g60be5d43e6-goog
