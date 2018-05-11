Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51242 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeEKSjS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 14:39:18 -0400
Received: by mail-ua0-f202.google.com with SMTP id 70-v6so4644324uav.18
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 11:39:18 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 11 May 2018 11:39:12 -0700
Message-Id: <20180511183912.11636-1-mjg59@google.com>
Subject: [PATCH V2] evm: Allow non-SHA1 digital signatures
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

SHA1 is reasonable in HMAC constructs, but it's desirable to be able to
use stronger hashes in digital signatures. Modify the EVM crypto code so
the hash type is imported from the digital signature and passed down to
the hash calculation code, and return the digest size to higher layers
for validation.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---

Reworked to take Mimi and Thiago's comments into account - this
simplifies evm_calc_hmac_or_hash, but makes evm_update_evmxattr a little
more complicated as a result.

 security/integrity/evm/evm.h        |  5 ++-
 security/integrity/evm/evm_crypto.c | 57 +++++++++++++++++------------
 security/integrity/evm/evm_main.c   | 29 +++++++++++----
 3 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 45c4a89c02ff..84ffae97e8a9 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -49,10 +49,11 @@ int evm_update_evmxattr(struct dentry *dentry,
 			size_t req_xattr_value_len);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, struct ima_digest_data *data);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char type, char *digest);
+		  size_t req_xattr_value_len, char type,
+		  struct ima_digest_data *data);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..427a2229cca8 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -21,6 +21,7 @@
 #include <linux/evm.h>
 #include <keys/encrypted-type.h>
 #include <crypto/hash.h>
+#include <crypto/hash_info.h>
 #include "evm.h"
 
 #define EVMKEY "evm-key"
@@ -28,8 +29,7 @@
 static unsigned char evmkey[MAX_KEY_SIZE];
 static int evmkey_len = MAX_KEY_SIZE;
 
-struct crypto_shash *hmac_tfm;
-struct crypto_shash *hash_tfm;
+static struct crypto_shash *evm_tfm[HASH_ALGO__LAST];
 
 static DEFINE_MUTEX(mutex);
 
@@ -37,9 +37,6 @@ static DEFINE_MUTEX(mutex);
 
 static unsigned long evm_set_key_flags;
 
-static char * const evm_hmac = "hmac(sha1)";
-static char * const evm_hash = "sha1";
-
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
  * @key: pointer to a buffer with the key data
@@ -74,10 +71,10 @@ int evm_set_key(void *key, size_t keylen)
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
 
@@ -86,13 +83,11 @@ static struct shash_desc *init_desc(char type)
 			pr_err_once("HMAC key is not set\n");
 			return ERR_PTR(-ENOKEY);
 		}
-		tfm = &hmac_tfm;
-		algo = evm_hmac;
-	} else {
-		tfm = &hash_tfm;
-		algo = evm_hash;
 	}
 
+	tfm = &evm_tfm[hash_algo];
+	algo = hash_algo_name[hash_algo];
+
 	if (*tfm == NULL) {
 		mutex_lock(&mutex);
 		if (*tfm)
@@ -186,10 +181,10 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
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
+				 uint8_t type, struct ima_digest_data *data)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct shash_desc *desc;
@@ -203,10 +198,17 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	desc = init_desc(type);
+	desc = init_desc(type, data->algo);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	/*
+	 * HMACs are always SHA1, but signatures may be of varying sizes -
+	 * make sure the caller knows how long the returned data is
+	 */
+	if (type != EVM_XATTR_HMAC)
+		data->length = crypto_shash_digestsize(desc->tfm);
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
+		  struct ima_digest_data *data)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
+		    req_xattr_value_len, EVM_XATTR_HMAC, data);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char type, char *digest)
+		  char type, struct ima_digest_data *data)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				     req_xattr_value_len, type, digest);
+		      req_xattr_value_len, type, data);
 }
 
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
@@ -303,6 +305,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct evm_ima_xattr_data xattr_data;
+	struct ima_digest_data *data;
 	int rc = 0;
 
 	/*
@@ -315,10 +318,16 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	if (rc)
 		return -EPERM;
 
+	data = kmalloc(sizeof(*data) + SHA1_DIGEST_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->algo = HASH_ALGO_SHA1;
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			   xattr_value_len, xattr_data.digest);
+			   xattr_value_len, data);
 	if (rc == 0) {
 		xattr_data.type = EVM_XATTR_HMAC;
+		memcpy(&xattr_data.digest, data->digest, SHA1_DIGEST_SIZE);
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
 					   &xattr_data,
 					   sizeof(xattr_data), 0);
@@ -333,7 +342,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 {
 	struct shash_desc *desc;
 
-	desc = init_desc(EVM_XATTR_HMAC);
+	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
 		pr_info("init_desc failed\n");
 		return PTR_ERR(desc);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9ea9c19a545c..20aaa54c473a 100644
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
+	struct ima_digest_data *digest = NULL;
 	struct inode *inode;
 	int rc, xattr_len;
 
@@ -155,29 +157,41 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* check value type */
 	switch (xattr_data->type) {
 	case EVM_XATTR_HMAC:
+		digest = kmalloc(sizeof(*digest) + SHA1_DIGEST_SIZE,
+				 GFP_KERNEL);
+		if (!digest) {
+			rc = -ENOMEM;
+			break;
+		}
 		if (xattr_len != sizeof(struct evm_ima_xattr_data)) {
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
+
+		digest->algo = HASH_ALGO_SHA1;
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-				   xattr_value_len, calc.digest);
+				   xattr_value_len, digest);
 		if (rc)
 			break;
-		rc = crypto_memneq(xattr_data->digest, calc.digest,
-			    sizeof(calc.digest));
+		rc = crypto_memneq(xattr_data->digest, digest,
+				   SHA1_DIGEST_SIZE);
 		if (rc)
 			rc = -EINVAL;
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
 	case EVM_XATTR_PORTABLE_DIGSIG:
+		digest = kmalloc(sizeof(*digest) + IMA_MAX_DIGEST_SIZE,
+				 GFP_KERNEL);
+		hdr = (struct signature_v2_hdr *)xattr_data;
+
+		digest->algo = hdr->hash_algo;
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				   xattr_value_len, xattr_data->type,
-				   calc.digest);
+				   xattr_value_len, xattr_data->type, digest);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
-					calc.digest, sizeof(calc.digest));
+					digest->digest, digest->length);
 		if (!rc) {
 			inode = d_backing_inode(dentry);
 
@@ -203,6 +217,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		evm_status = (rc == -ENODATA) ?
 				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
 out:
+	kfree(digest);
 	if (iint)
 		iint->evm_status = evm_status;
 	kfree(xattr_data);
-- 
2.17.0.441.gb46fe60e1d-goog
