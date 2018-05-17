Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f201.google.com ([209.85.216.201]:50154 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeEQWPX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 May 2018 18:15:23 -0400
Received: by mail-qt0-f201.google.com with SMTP id m15-v6so5065667qti.16
        for <linux-integrity@vger.kernel.org>; Thu, 17 May 2018 15:15:23 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 17 May 2018 15:09:38 -0700
In-Reply-To: <1526508736.3306.6.camel@linux.vnet.ibm.com>
Message-Id: <20180517220938.102953-1-mjg59@google.com>
References: <1526508736.3306.6.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] evm: Allow non-SHA1 digital signatures
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Oh bother - I think I see what's wrong. Does this version work better?
I'm afraid I only tested against signatures rather than HMACs, and I was
generating a raw SHA1 rather than an HMAC :(

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 45c4a89c02ff..a8289fbf2f0c 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -42,6 +42,11 @@ extern struct crypto_shash *hash_tfm;
 /* List of EVM protected security xattrs */
 extern char *evm_config_xattrnames[];
 
+struct evm_digest {
+	struct ima_digest_data hdr;
+	char digest[IMA_MAX_DIGEST_SIZE];
+} __packed;
+
 int evm_init_key(void);
 int evm_update_evmxattr(struct dentry *dentry,
 			const char *req_xattr_name,
@@ -49,10 +54,11 @@ int evm_update_evmxattr(struct dentry *dentry,
 			size_t req_xattr_value_len);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, struct evm_digest *data);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char type, char *digest);
+		  size_t req_xattr_value_len, char type,
+		  struct evm_digest *data);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..eb87d40c62a5 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -21,6 +21,7 @@
 #include <linux/evm.h>
 #include <keys/encrypted-type.h>
 #include <crypto/hash.h>
+#include <crypto/hash_info.h>
 #include "evm.h"
 
 #define EVMKEY "evm-key"
@@ -29,7 +30,7 @@ static unsigned char evmkey[MAX_KEY_SIZE];
 static int evmkey_len = MAX_KEY_SIZE;
 
 struct crypto_shash *hmac_tfm;
-struct crypto_shash *hash_tfm;
+static struct crypto_shash *evm_tfm[HASH_ALGO__LAST];
 
 static DEFINE_MUTEX(mutex);
 
@@ -38,7 +39,6 @@ static DEFINE_MUTEX(mutex);
 static unsigned long evm_set_key_flags;
 
 static char * const evm_hmac = "hmac(sha1)";
-static char * const evm_hash = "sha1";
 
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
@@ -74,10 +74,10 @@ int evm_set_key(void *key, size_t keylen)
 }
 EXPORT_SYMBOL_GPL(evm_set_key);
 
-static struct shash_desc *init_desc(char type)
+static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 {
 	long rc;
-	char *algo;
+	const char *algo;
 	struct crypto_shash **tfm;
 	struct shash_desc *desc;
 
@@ -89,8 +89,8 @@ static struct shash_desc *init_desc(char type)
 		tfm = &hmac_tfm;
 		algo = evm_hmac;
 	} else {
-		tfm = &hash_tfm;
-		algo = evm_hash;
+		tfm = &evm_tfm[hash_algo];
+		algo = hash_algo_name[hash_algo];
 	}
 
 	if (*tfm == NULL) {
@@ -186,10 +186,10 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
  * each xattr, but attempt to re-use the previously allocated memory.
  */
 static int evm_calc_hmac_or_hash(struct dentry *dentry,
-				const char *req_xattr_name,
-				const char *req_xattr_value,
-				size_t req_xattr_value_len,
-				char type, char *digest)
+				 const char *req_xattr_name,
+				 const char *req_xattr_value,
+				 size_t req_xattr_value_len,
+				 uint8_t type, struct evm_digest *data)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct shash_desc *desc;
@@ -203,10 +203,12 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	desc = init_desc(type);
+	desc = init_desc(type, data->hdr.algo);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	data->hdr.length = crypto_shash_digestsize(desc->tfm);
+
 	error = -ENODATA;
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
 		bool is_ima = false;
@@ -238,7 +240,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 	}
-	hmac_add_misc(desc, inode, type, digest);
+	hmac_add_misc(desc, inode, type, data->digest);
 
 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
@@ -251,18 +253,18 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char *digest)
+		  struct evm_digest *data)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
+				    req_xattr_value_len, EVM_XATTR_HMAC, data);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char type, char *digest)
+		  char type, struct evm_digest *data)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				     req_xattr_value_len, type, digest);
+				     req_xattr_value_len, type, data);
 }
 
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
@@ -302,7 +304,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct evm_ima_xattr_data xattr_data;
+	struct evm_digest data;
 	int rc = 0;
 
 	/*
@@ -315,13 +317,14 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	if (rc)
 		return -EPERM;
 
+	data.hdr.algo = HASH_ALGO_SHA1;
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			   xattr_value_len, xattr_data.digest);
+			   xattr_value_len, &data);
 	if (rc == 0) {
-		xattr_data.type = EVM_XATTR_HMAC;
+		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
-					   &xattr_data,
-					   sizeof(xattr_data), 0);
+					   &data.hdr.xattr.data[1],
+					   SHA1_DIGEST_SIZE + 1, 0);
 	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
 		rc = __vfs_removexattr(dentry, XATTR_NAME_EVM);
 	}
@@ -333,7 +336,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 {
 	struct shash_desc *desc;
 
-	desc = init_desc(EVM_XATTR_HMAC);
+	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
 		pr_info("init_desc failed\n");
 		return PTR_ERR(desc);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9ea9c19a545c..88ea9c1962d6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -25,6 +25,7 @@
 #include <linux/magic.h>
 
 #include <crypto/hash.h>
+#include <crypto/hash_info.h>
 #include <crypto/algapi.h>
 #include "evm.h"
 
@@ -122,8 +123,9 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     struct integrity_iint_cache *iint)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
-	struct evm_ima_xattr_data calc;
+	struct signature_v2_hdr *hdr;
 	enum integrity_status evm_status = INTEGRITY_PASS;
+	struct evm_digest digest;
 	struct inode *inode;
 	int rc, xattr_len;
 
@@ -159,25 +161,28 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
+
+		digest.hdr.algo = HASH_ALGO_SHA1;
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-				   xattr_value_len, calc.digest);
+				   xattr_value_len, &digest);
 		if (rc)
 			break;
-		rc = crypto_memneq(xattr_data->digest, calc.digest,
-			    sizeof(calc.digest));
+		rc = crypto_memneq(xattr_data->digest, digest.digest,
+				   SHA1_DIGEST_SIZE);
 		if (rc)
 			rc = -EINVAL;
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
 	case EVM_XATTR_PORTABLE_DIGSIG:
+		hdr = (struct signature_v2_hdr *)xattr_data;
+		digest.hdr.algo = hdr->hash_algo;
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				   xattr_value_len, xattr_data->type,
-				   calc.digest);
+				   xattr_value_len, xattr_data->type, &digest);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
-					calc.digest, sizeof(calc.digest));
+					digest.digest, digest.hdr.length);
 		if (!rc) {
 			inode = d_backing_inode(dentry);
 
-- 
2.17.0.441.gb46fe60e1d-goog
