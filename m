Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f201.google.com ([209.85.220.201]:53840 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbdKGPR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 10:17:56 -0500
Received: by mail-qk0-f201.google.com with SMTP id z12so9760815qkb.12
        for <linux-integrity@vger.kernel.org>; Tue, 07 Nov 2017 07:17:55 -0800 (PST)
MIME-Version: 1.0
Date: Tue,  7 Nov 2017 07:17:42 -0800
Message-Id: <20171107151742.25122-1-mjg59@google.com>
Subject: [PATCH V6] EVM: Add support for portable signature format
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The EVM signature includes the inode number and (optionally) the
filesystem UUID, making it impractical to ship EVM signatures in
packages. This patch adds a new portable format intended to allow
distributions to include EVM signatures. It is identical to the existing
format but hardcodes the inode and generation numbers to 0 and does not
include the filesystem UUID even if the kernel is configured to do so.

Removing the inode means that the metadata and signature from one file
could be copied to another file without invalidating it. This is avoided
by ensuring that an IMA xattr is present during EVM validation.

Portable signatures are intended to be immutable - ie, they will never
be transformed into HMACs.

Based on earlier work by Dmitry Kasatkin and Mikhail Kurinnoi.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
---

Sigh. Get rid of an unused variable declaration.

 include/linux/integrity.h             |  1 +
 security/integrity/evm/evm.h          |  2 +-
 security/integrity/evm/evm_crypto.c   | 75 ++++++++++++++++++++++++++++++-----
 security/integrity/evm/evm_main.c     | 27 ++++++++-----
 security/integrity/ima/ima_appraise.c |  4 +-
 security/integrity/integrity.h        |  2 +
 6 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index c2d6082a1a4c..858d3f4a2241 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -14,6 +14,7 @@
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
+	INTEGRITY_PASS_IMMUTABLE,
 	INTEGRITY_FAIL,
 	INTEGRITY_NOLABEL,
 	INTEGRITY_NOXATTRS,
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index f5f12727771a..2ff02459fcfd 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -48,7 +48,7 @@ int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  size_t req_xattr_value_len, char *digest);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, char type, char *digest);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 1d32cd20009a..e526f0f5aaaf 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -138,7 +138,7 @@ static struct shash_desc *init_desc(char type)
  * protection.)
  */
 static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
-			  char *digest)
+			  char type, char *digest)
 {
 	struct h_misc {
 		unsigned long ino;
@@ -149,8 +149,13 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	} hmac_misc;
 
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
-	hmac_misc.ino = inode->i_ino;
-	hmac_misc.generation = inode->i_generation;
+	/* Don't include the inode or generation number in portable
+	 * signatures
+	 */
+	if (type != EVM_XATTR_PORTABLE_DIGSIG) {
+		hmac_misc.ino = inode->i_ino;
+		hmac_misc.generation = inode->i_generation;
+	}
 	/* The hmac uid and gid must be encoded in the initial user
 	 * namespace (not the filesystems user namespace) as encoding
 	 * them in the filesystems user namespace allows an attack
@@ -163,7 +168,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
-	if (evm_hmac_attrs & EVM_ATTR_FSUUID)
+	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
+	    type != EVM_XATTR_PORTABLE_DIGSIG)
 		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
 				    sizeof(inode->i_sb->s_uuid));
 	crypto_shash_final(desc, digest);
@@ -189,6 +195,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	char *xattr_value = NULL;
 	int error;
 	int size;
+	bool ima_present = false;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
@@ -199,11 +206,18 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 	error = -ENODATA;
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
+		bool is_ima = false;
+
+		if (strcmp(*xattrname, XATTR_NAME_IMA) == 0)
+			is_ima = true;
+
 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(*xattrname, req_xattr_name)) {
 			error = 0;
 			crypto_shash_update(desc, (const u8 *)req_xattr_value,
 					     req_xattr_value_len);
+			if (is_ima)
+				ima_present = true;
 			continue;
 		}
 		size = vfs_getxattr_alloc(dentry, *xattrname,
@@ -218,9 +232,14 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		error = 0;
 		xattr_size = size;
 		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		if (is_ima)
+			ima_present = true;
 	}
-	hmac_add_misc(desc, inode, digest);
+	hmac_add_misc(desc, inode, type, digest);
 
+	/* Portable EVM signatures must include an IMA hash */
+	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
+		return -EPERM;
 out:
 	kfree(xattr_value);
 	kfree(desc);
@@ -232,17 +251,45 @@ int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  char *digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				req_xattr_value_len, EVM_XATTR_HMAC, digest);
+			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char *digest)
+		  char type, char *digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				req_xattr_value_len, IMA_XATTR_DIGEST, digest);
+				     req_xattr_value_len, type, digest);
+}
+
+static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
+{
+	const struct evm_ima_xattr_data *xattr_data = NULL;
+	struct integrity_iint_cache *iint;
+	int rc = 0;
+
+	iint = integrity_iint_find(inode);
+	if (iint && (iint->flags & EVM_IMMUTABLE_DIGSIG))
+		return 1;
+
+	/* Do this the hard way */
+	rc = vfs_getxattr_alloc(dentry, XATTR_NAME_EVM, (char **)&xattr_data, 0,
+				GFP_NOFS);
+	if (rc <= 0) {
+		if (rc == -ENODATA)
+			return 0;
+		return rc;
+	}
+	if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG)
+		rc = 1;
+	else
+		rc = 0;
+
+	kfree(xattr_data);
+	return rc;
 }
 
+
 /*
  * Calculate the hmac and update security.evm xattr
  *
@@ -255,6 +302,16 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	struct evm_ima_xattr_data xattr_data;
 	int rc = 0;
 
+	/*
+	 * Don't permit any transformation of the EVM xattr if the signature
+	 * is of an immutable type
+	 */
+	rc = evm_is_immutable(dentry, inode);
+	if (rc < 0)
+		return rc;
+	if (rc)
+		return -EPERM;
+
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
 			   xattr_value_len, xattr_data.digest);
 	if (rc == 0) {
@@ -280,7 +337,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 	}
 
 	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
-	hmac_add_misc(desc, inode, hmac_val);
+	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
 	kfree(desc);
 	return 0;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 063d38aef64e..485f235234ab 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -120,7 +120,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	int rc, xattr_len;
 
-	if (iint && iint->evm_status == INTEGRITY_PASS)
+	if (iint && (iint->evm_status == INTEGRITY_PASS ||
+		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -161,22 +162,26 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			rc = -EINVAL;
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
+	case EVM_XATTR_PORTABLE_DIGSIG:
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				xattr_value_len, calc.digest);
+				   xattr_value_len, xattr_data->type,
+				   calc.digest);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
 					calc.digest, sizeof(calc.digest));
 		if (!rc) {
-			/* Replace RSA with HMAC if not mounted readonly and
-			 * not immutable
-			 */
-			if (!IS_RDONLY(d_backing_inode(dentry)) &&
-			    !IS_IMMUTABLE(d_backing_inode(dentry)))
+			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
+				if (iint)
+					iint->flags |= EVM_IMMUTABLE_DIGSIG;
+				evm_status = INTEGRITY_PASS_IMMUTABLE;
+			} else if (!IS_RDONLY(d_backing_inode(dentry)) &&
+				   !IS_IMMUTABLE(d_backing_inode(dentry))) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
+			}
 		}
 		break;
 	default:
@@ -277,7 +282,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
  * affect security.evm.  An interesting side affect of writing posix xattr
  * acls is their modifying of the i_mode, which is included in security.evm.
  * For posix xattr acls only, permit security.evm, even if it currently
- * doesn't exist, to be updated.
+ * doesn't exist, to be updated unless the EVM signature is immutable.
  */
 static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 			     const void *xattr_value, size_t xattr_value_len)
@@ -345,7 +350,8 @@ int evm_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
 		if (!xattr_value_len)
 			return -EINVAL;
-		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG)
+		if (xattr_data->type != EVM_IMA_XATTR_DIGSIG &&
+		    xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG)
 			return -EPERM;
 	}
 	return evm_protect_xattr(dentry, xattr_name, xattr_value,
@@ -422,6 +428,9 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
  * @dentry: pointer to the affected dentry
+ *
+ * Permit update of file attributes when files have a valid EVM signature,
+ * except in the case of them having an immutable portable signature.
  */
 int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 809ba70fbbbf..8336c70dc6bc 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -229,7 +229,9 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) && (status != INTEGRITY_UNKNOWN)) {
+	if ((status != INTEGRITY_PASS) &&
+	    (status != INTEGRITY_PASS_IMMUTABLE) &&
+	    (status != INTEGRITY_UNKNOWN)) {
 		if ((status == INTEGRITY_NOLABEL)
 		    || (status == INTEGRITY_NOXATTRS))
 			cause = "missing-HMAC";
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a53e7e4ab06c..cbc7de33fac7 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -33,6 +33,7 @@
 #define IMA_DIGSIG_REQUIRED	0x02000000
 #define IMA_PERMIT_DIRECTIO	0x04000000
 #define IMA_NEW_FILE		0x08000000
+#define EVM_IMMUTABLE_DIGSIG	0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_APPRAISE_SUBMASK)
@@ -58,6 +59,7 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_HMAC,
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
+	EVM_XATTR_PORTABLE_DIGSIG,
 	IMA_XATTR_LAST
 };
 
-- 
2.15.0.403.gc27cc4dac6-goog
