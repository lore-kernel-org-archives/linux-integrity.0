Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.161.202]:39731 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENWMd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 18:12:33 -0400
Received: by mail-yw0-f202.google.com with SMTP id j11-v6so5831863ywi.6
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 15:12:33 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 14 May 2018 15:07:30 -0700
Message-Id: <20180514220730.99811-1-mjg59@google.com>
Subject: [PATCH V3] evm: Allow non-SHA1 digital signatures
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
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

Added a new struct type equivalent to ima_digest_data but with the
digest field actually populated in order to make it practical to
allocate on the stack, and reworked stuff to use that.

 security/integrity/evm/evm.h              |  5 +-
 security/integrity/evm/evm_crypto.c       | 59 ++++++++++++-----------
 security/integrity/evm/evm_main.c         | 20 +++++---
 security/integrity/ima/ima_api.c          | 14 +++---
 security/integrity/ima/ima_appraise.c     | 20 ++++----
 security/integrity/ima/ima_crypto.c       | 28 +++++------
 security/integrity/ima/ima_init.c         |  4 +-
 security/integrity/ima/ima_template_lib.c | 12 ++---
 security/integrity/integrity.h            | 11 ++++-
 9 files changed, 96 insertions(+), 77 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 45c4a89c02ff..4b199c61007e 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -49,10 +49,11 @@ int evm_update_evmxattr(struct dentry *dentry,
 			size_t req_xattr_value_len);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, struct ima_xattr *data);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char type, char *digest);
+		  size_t req_xattr_value_len, char type,
+		  struct ima_xattr *data);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..84c3c5aa8307 100644
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
+				 uint8_t type, struct ima_xattr *data)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct shash_desc *desc;
@@ -203,10 +198,17 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	desc = init_desc(type);
+	desc = init_desc(type, data->header.algo);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	/*
+	 * HMACs are always SHA1, but signatures may be of varying sizes -
+	 * make sure the caller knows how long the returned data is
+	 */
+	if (type != EVM_XATTR_HMAC)
+		data->header.length = crypto_shash_digestsize(desc->tfm);
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
+		  struct ima_xattr *data)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
+		    req_xattr_value_len, EVM_XATTR_HMAC, data);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char type, char *digest)
+		  char type, struct ima_xattr *data)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				     req_xattr_value_len, type, digest);
+		      req_xattr_value_len, type, data);
 }
 
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
@@ -302,7 +304,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct evm_ima_xattr_data xattr_data;
+	struct ima_xattr data;
 	int rc = 0;
 
 	/*
@@ -315,13 +317,14 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	if (rc)
 		return -EPERM;
 
+	data.header.algo = HASH_ALGO_SHA1;
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			   xattr_value_len, xattr_data.digest);
+			   xattr_value_len, &data);
 	if (rc == 0) {
-		xattr_data.type = EVM_XATTR_HMAC;
+		data.header.xattr.sha1.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
-					   &xattr_data,
-					   sizeof(xattr_data), 0);
+					   &data.header.xattr.data[1],
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
index 9ea9c19a545c..f8553158b033 100644
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
+	struct ima_xattr digest;
 	struct inode *inode;
 	int rc, xattr_len;
 
@@ -159,25 +161,29 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
+
+		digest.header.algo = HASH_ALGO_SHA1;
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-				   xattr_value_len, calc.digest);
+				   xattr_value_len, &digest);
 		if (rc)
 			break;
-		rc = crypto_memneq(xattr_data->digest, calc.digest,
-			    sizeof(calc.digest));
+		rc = crypto_memneq(xattr_data->digest, &digest.digest,
+				   SHA1_DIGEST_SIZE);
 		if (rc)
 			rc = -EINVAL;
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
 	case EVM_XATTR_PORTABLE_DIGSIG:
+		hdr = (struct signature_v2_hdr *)xattr_data;
+
+		digest.header.algo = hdr->hash_algo;
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				   xattr_value_len, xattr_data->type,
-				   calc.digest);
+				   xattr_value_len, xattr_data->type, &digest);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
-					calc.digest, sizeof(calc.digest));
+					digest.digest, digest.header.length);
 		if (!rc) {
 			inode = d_backing_inode(dentry);
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bf88236b7a0b..1e6a6a4c75ec 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -103,7 +103,7 @@ int ima_store_template(struct ima_template_entry *entry,
 		int num_fields = entry->template_desc->num_fields;
 
 		/* this function uses default algo */
-		hash.hdr.algo = HASH_ALGO_SHA1;
+		hash.hdr.header.algo = HASH_ALGO_SHA1;
 		result = ima_calc_field_array_hash(&entry->template_data[0],
 						   entry->template_desc,
 						   num_fields, &hash.hdr);
@@ -113,7 +113,7 @@ int ima_store_template(struct ima_template_entry *entry,
 					    audit_cause, result, 0);
 			return result;
 		}
-		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
+		memcpy(entry->digest, hash.hdr.digest, hash.hdr.header.length);
 	}
 	entry->pcr = pcr;
 	result = ima_add_template_entry(entry, violation, op, inode, filename);
@@ -220,7 +220,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	 * measurement/appraisal/audit.
 	 */
 	i_version = inode_query_iversion(inode);
-	hash.hdr.algo = algo;
+	hash.hdr.header.algo = algo;
 
 	/* Initialize hash digest to 0's in case of failure */
 	memset(&hash.digest, 0, sizeof(hash.digest));
@@ -233,7 +233,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	if (result && result != -EBADF && result != -EINVAL)
 		goto out;
 
-	length = sizeof(hash.hdr) + hash.hdr.length;
+	length = sizeof(hash.hdr) + hash.hdr.header.length;
 	tmpbuf = krealloc(iint->ima_hash, length, GFP_NOFS);
 	if (!tmpbuf) {
 		result = -ENOMEM;
@@ -312,17 +312,17 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 {
 	struct audit_buffer *ab;
 	char *hash;
-	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
+	const char *algo_name = hash_algo_name[iint->ima_hash->header.algo];
 	int i;
 
 	if (iint->flags & IMA_AUDITED)
 		return;
 
-	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
+	hash = kzalloc((iint->ima_hash->header.length * 2) + 1, GFP_KERNEL);
 	if (!hash)
 		return;
 
-	for (i = 0; i < iint->ima_hash->length; i++)
+	for (i = 0; i < iint->ima_hash->header.length; i++)
 		hex_byte_pack(hash + (i * 2), iint->ima_hash->digest[i]);
 	hash[i * 2] = '\0';
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8bd7a0733e51..5404c391eb2c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -64,20 +64,20 @@ static int ima_fix_xattr(struct dentry *dentry,
 			 struct integrity_iint_cache *iint)
 {
 	int rc, offset;
-	u8 algo = iint->ima_hash->algo;
+	u8 algo = iint->ima_hash->header.algo;
 
 	if (algo <= HASH_ALGO_SHA1) {
 		offset = 1;
-		iint->ima_hash->xattr.sha1.type = IMA_XATTR_DIGEST;
+		iint->ima_hash->header.xattr.sha1.type = IMA_XATTR_DIGEST;
 	} else {
 		offset = 0;
-		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
-		iint->ima_hash->xattr.ng.algo = algo;
+		iint->ima_hash->header.xattr.ng.type = IMA_XATTR_DIGEST_NG;
+		iint->ima_hash->header.xattr.ng.algo = algo;
 	}
 	rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_IMA,
-				   &iint->ima_hash->xattr.data[offset],
-				   (sizeof(iint->ima_hash->xattr) - offset) +
-				   iint->ima_hash->length, 0);
+			      &iint->ima_hash->header.xattr.data[offset],
+			      (sizeof(iint->ima_hash->header.xattr) - offset) +
+			      iint->ima_hash->header.length, 0);
 	return rc;
 }
 
@@ -270,13 +270,13 @@ int ima_appraise_measurement(enum ima_hooks func,
 		}
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
+				iint->ima_hash->header.length)
 			/* xattr length may be longer. md5 hash in previous
 			   version occupied 20 bytes in xattr, instead of 16
 			 */
 			rc = memcmp(&xattr_value->digest[hash_start],
 				    iint->ima_hash->digest,
-				    iint->ima_hash->length);
+				    iint->ima_hash->header.length);
 		else
 			rc = -EINVAL;
 		if (rc) {
@@ -291,7 +291,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
 					     (const char *)xattr_value, rc,
 					     iint->ima_hash->digest,
-					     iint->ima_hash->length);
+					     iint->ima_hash->header.length);
 		if (rc == -EOPNOTSUPP) {
 			status = INTEGRITY_UNKNOWN;
 		} else if (rc) {
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4e085a17124f..26b6a5369bd7 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -216,7 +216,7 @@ static int ima_calc_file_hash_atfm(struct file *file,
 	struct crypto_wait wait;
 	size_t rbuf_size[2];
 
-	hash->length = crypto_ahash_digestsize(tfm);
+	hash->header.length = crypto_ahash_digestsize(tfm);
 
 	req = ahash_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
@@ -319,7 +319,7 @@ static int ima_calc_file_ahash(struct file *file, struct ima_digest_data *hash)
 	struct crypto_ahash *tfm;
 	int rc;
 
-	tfm = ima_alloc_atfm(hash->algo);
+	tfm = ima_alloc_atfm(hash->header.algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -342,7 +342,7 @@ static int ima_calc_file_hash_tfm(struct file *file,
 	shash->tfm = tfm;
 	shash->flags = 0;
 
-	hash->length = crypto_shash_digestsize(tfm);
+	hash->header.length = crypto_shash_digestsize(tfm);
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
@@ -392,7 +392,7 @@ static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
 	struct crypto_shash *tfm;
 	int rc;
 
-	tfm = ima_alloc_tfm(hash->algo);
+	tfm = ima_alloc_tfm(hash->header.algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -426,8 +426,8 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 	 * filesystems mounted with/without DAX option.
 	 */
 	if (file->f_flags & O_DIRECT) {
-		hash->length = hash_digest_size[ima_hash_algo];
-		hash->algo = ima_hash_algo;
+		hash->header.length = hash_digest_size[ima_hash_algo];
+		hash->header.algo = ima_hash_algo;
 		return -EINVAL;
 	}
 
@@ -457,7 +457,7 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 	shash->tfm = tfm;
 	shash->flags = 0;
 
-	hash->length = crypto_shash_digestsize(tfm);
+	hash->header.length = crypto_shash_digestsize(tfm);
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
@@ -499,7 +499,7 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	struct crypto_shash *tfm;
 	int rc;
 
-	tfm = ima_alloc_tfm(hash->algo);
+	tfm = ima_alloc_tfm(hash->header.algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -520,7 +520,7 @@ static int calc_buffer_ahash_atfm(const void *buf, loff_t len,
 	struct crypto_wait wait;
 	int rc, ahash_rc = 0;
 
-	hash->length = crypto_ahash_digestsize(tfm);
+	hash->header.length = crypto_ahash_digestsize(tfm);
 
 	req = ahash_request_alloc(tfm, GFP_KERNEL);
 	if (!req)
@@ -557,7 +557,7 @@ static int calc_buffer_ahash(const void *buf, loff_t len,
 	struct crypto_ahash *tfm;
 	int rc;
 
-	tfm = ima_alloc_atfm(hash->algo);
+	tfm = ima_alloc_atfm(hash->header.algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -579,7 +579,7 @@ static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 	shash->tfm = tfm;
 	shash->flags = 0;
 
-	hash->length = crypto_shash_digestsize(tfm);
+	hash->header.length = crypto_shash_digestsize(tfm);
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
@@ -605,7 +605,7 @@ static int calc_buffer_shash(const void *buf, loff_t len,
 	struct crypto_shash *tfm;
 	int rc;
 
-	tfm = ima_alloc_tfm(hash->algo);
+	tfm = ima_alloc_tfm(hash->header.algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -671,11 +671,11 @@ int __init ima_calc_boot_aggregate(struct ima_digest_data *hash)
 	struct crypto_shash *tfm;
 	int rc;
 
-	tfm = ima_alloc_tfm(hash->algo);
+	tfm = ima_alloc_tfm(hash->header.algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	hash->length = crypto_shash_digestsize(tfm);
+	hash->header.length = crypto_shash_digestsize(tfm);
 	rc = ima_calc_boot_aggregate_tfm(hash->digest, tfm);
 
 	ima_free_tfm(tfm);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..6f9bf49421e2 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -61,8 +61,8 @@ static int __init ima_add_boot_aggregate(void)
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 	iint->ima_hash = &hash.hdr;
-	iint->ima_hash->algo = HASH_ALGO_SHA1;
-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
+	iint->ima_hash->header.algo = HASH_ALGO_SHA1;
+	iint->ima_hash->header.length = SHA1_DIGEST_SIZE;
 
 	if (ima_used_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 5afaa53decc5..0afd4e59e84b 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -276,9 +276,9 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	if (event_data->violation)	/* recording a violation. */
 		goto out;
 
-	if (ima_template_hash_algo_allowed(event_data->iint->ima_hash->algo)) {
+	if (ima_template_hash_algo_allowed(event_data->iint->ima_hash->header.algo)) {
 		cur_digest = event_data->iint->ima_hash->digest;
-		cur_digestsize = event_data->iint->ima_hash->length;
+		cur_digestsize = event_data->iint->ima_hash->header.length;
 		goto out;
 	}
 
@@ -286,7 +286,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 		return -EINVAL;
 
 	inode = file_inode(event_data->file);
-	hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
+	hash.hdr.header.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
 	    ima_hash_algo : HASH_ALGO_SHA1;
 	result = ima_calc_file_hash(event_data->file, &hash.hdr);
 	if (result) {
@@ -296,7 +296,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 		return result;
 	}
 	cur_digest = hash.hdr.digest;
-	cur_digestsize = hash.hdr.length;
+	cur_digestsize = hash.hdr.header.length;
 out:
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
 					   HASH_ALGO__LAST, field_data);
@@ -315,9 +315,9 @@ int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 		goto out;
 
 	cur_digest = event_data->iint->ima_hash->digest;
-	cur_digestsize = event_data->iint->ima_hash->length;
+	cur_digestsize = event_data->iint->ima_hash->header.length;
 
-	hash_algo = event_data->iint->ima_hash->algo;
+	hash_algo = event_data->iint->ima_hash->header.algo;
 out:
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
 					   hash_algo, field_data);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5e58e02ba8dc..6884b5e1c8a4 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -83,7 +83,7 @@ struct evm_ima_xattr_data {
 
 #define IMA_MAX_DIGEST_SIZE	64
 
-struct ima_digest_data {
+struct ima_digest_header {
 	u8 algo;
 	u8 length;
 	union {
@@ -97,9 +97,18 @@ struct ima_digest_data {
 		} ng;
 		u8 data[2];
 	} xattr;
+} __packed;
+
+struct ima_digest_data {
+	struct ima_digest_header header;
 	u8 digest[0];
 } __packed;
 
+struct ima_xattr {
+	struct ima_digest_header header;
+	u8 digest[IMA_MAX_DIGEST_SIZE];
+} __packed;
+
 /*
  * signature format v2 - for using with asymmetric keys
  */
-- 
2.17.0.441.gb46fe60e1d-goog
