Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f202.google.com ([209.85.220.202]:41115 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeDTUeP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Apr 2018 16:34:15 -0400
Received: by mail-qk0-f202.google.com with SMTP id z128so6350580qka.8
        for <linux-integrity@vger.kernel.org>; Fri, 20 Apr 2018 13:34:14 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 13:34:08 -0700
Message-Id: <20180420203408.50769-1-mjg59@google.com>
Subject: [PATCH] evm: Allow non-SHA1 digital signatures
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
 security/integrity/evm/evm.h        |  5 ++--
 security/integrity/evm/evm_crypto.c | 40 ++++++++++++++++++++---------
 security/integrity/evm/evm_main.c   | 24 ++++++++++++-----
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 45c4a89c02ff..ae1674d86e4c 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -49,10 +49,11 @@ int evm_update_evmxattr(struct dentry *dentry,
 			size_t req_xattr_value_len);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char *digest);
+		  size_t req_xattr_value_len, char **digest);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, char type, char *digest);
+		  size_t req_xattr_value_len, char type, uint8_t hash_algo,
+		  char **digest, int *digestlen);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a46fba322340..a3e30e34bcf5 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -21,6 +21,7 @@
 #include <linux/evm.h>
 #include <keys/encrypted-type.h>
 #include <crypto/hash.h>
+#include <crypto/hash_info.h>
 #include "evm.h"
 
 #define EVMKEY "evm-key"
@@ -74,10 +75,10 @@ int evm_set_key(void *key, size_t keylen)
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
 
@@ -90,7 +91,7 @@ static struct shash_desc *init_desc(char type)
 		algo = evm_hmac;
 	} else {
 		tfm = &hash_tfm;
-		algo = evm_hash;
+		algo = hash_algo_name[hash_algo];
 	}
 
 	if (*tfm == NULL) {
@@ -189,7 +190,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				const char *req_xattr_name,
 				const char *req_xattr_value,
 				size_t req_xattr_value_len,
-				char type, char *digest)
+				uint8_t type, uint8_t hash_algo,
+				char **digest, int *digestlen)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	struct shash_desc *desc;
@@ -203,10 +205,24 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	desc = init_desc(type);
+	desc = init_desc(type, hash_algo);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	/*
+	 * HMACs are always SHA1, but signatures may be of varying sizes, so
+	 * allocate a buffer for the non-HMAC case and return the size to
+	 * the caller
+	 */
+	if (type != EVM_XATTR_HMAC) {
+		*digestlen = crypto_shash_digestsize(desc->tfm);
+		*digest = kmalloc(*digestlen, GFP_KERNEL);
+		if (!*digest) {
+			error = -ENOMEM;
+			goto out;
+		}
+	}
+
 	error = -ENODATA;
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
 		bool is_ima = false;
@@ -238,7 +254,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 	}
-	hmac_add_misc(desc, inode, type, digest);
+	hmac_add_misc(desc, inode, type, *digest);
 
 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
@@ -251,18 +267,18 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char *digest)
+		  char **digest)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-			       req_xattr_value_len, EVM_XATTR_HMAC, digest);
+		    req_xattr_value_len, EVM_XATTR_HMAC, 0x02, digest, NULL);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char type, char *digest)
+		  char type, uint8_t hash_algo, char **digest, int *digestlen)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				     req_xattr_value_len, type, digest);
+		      req_xattr_value_len, type, hash_algo, digest, digestlen);
 }
 
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
@@ -316,7 +332,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 		return -EPERM;
 
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			   xattr_value_len, xattr_data.digest);
+			   xattr_value_len, (char **)&xattr_data.digest);
 	if (rc == 0) {
 		xattr_data.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
@@ -333,7 +349,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 {
 	struct shash_desc *desc;
 
-	desc = init_desc(EVM_XATTR_HMAC);
+	desc = init_desc(EVM_XATTR_HMAC, 0x02);
 	if (IS_ERR(desc)) {
 		pr_info("init_desc failed\n");
 		return PTR_ERR(desc);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9ea9c19a545c..3d952e69852f 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -28,6 +28,8 @@
 #include <crypto/algapi.h>
 #include "evm.h"
 
+#define HMAC_LEN 20
+
 int evm_initialized;
 
 static const char * const integrity_status_msg[] = {
@@ -122,10 +124,11 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     struct integrity_iint_cache *iint)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
-	struct evm_ima_xattr_data calc;
+	struct signature_v2_hdr *hdr;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	struct inode *inode;
-	int rc, xattr_len;
+	int rc, xattr_len, digest_len;
+	char *digest = NULL;
 
 	if (iint && (iint->evm_status == INTEGRITY_PASS ||
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
@@ -155,29 +158,35 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* check value type */
 	switch (xattr_data->type) {
 	case EVM_XATTR_HMAC:
+		digest = kmalloc(HMAC_LEN, GFP_KERNEL);
+		if (!digest) {
+			rc = -ENOMEM;
+			break;
+		}
 		if (xattr_len != sizeof(struct evm_ima_xattr_data)) {
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-				   xattr_value_len, calc.digest);
+				   xattr_value_len, &digest);
 		if (rc)
 			break;
-		rc = crypto_memneq(xattr_data->digest, calc.digest,
-			    sizeof(calc.digest));
+		rc = crypto_memneq(xattr_data->digest, digest, HMAC_LEN);
 		if (rc)
 			rc = -EINVAL;
 		break;
 	case EVM_IMA_XATTR_DIGSIG:
 	case EVM_XATTR_PORTABLE_DIGSIG:
+		hdr = (struct signature_v2_hdr *)xattr_value;
+
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
 				   xattr_value_len, xattr_data->type,
-				   calc.digest);
+				   hdr->hash_algo, &digest, &digest_len);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
-					calc.digest, sizeof(calc.digest));
+					digest, digest_len);
 		if (!rc) {
 			inode = d_backing_inode(dentry);
 
@@ -203,6 +212,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		evm_status = (rc == -ENODATA) ?
 				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
 out:
+	kfree(digest);
 	if (iint)
 		iint->evm_status = evm_status;
 	kfree(xattr_data);
-- 
2.17.0.484.g0c8726318c-goog
