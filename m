Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752716AbdLGTFK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 14:05:10 -0500
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: dmitry.kasatkin@gmail.com, zohar@linux.vnet.ibm.com,
        jarkko.sakkinen@linux.intel.com
Cc: linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: migrate to the new openssl 1.1 api
Date: Thu,  7 Dec 2017 17:05:08 -0200
Message-Id: <20171207190508.28292-1-brdeoliv@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch adds and changes the points needed to support the new OpenSSL
1.1 API, considering the older one, OpenSSL 1.0.z, will be dropped by
the major distros in following releases.

Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
---
 src/evmctl.c    | 39 +++++++++++++++++++++++++--------------
 src/libimaevm.c | 38 +++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c54efbb..7d9be32 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -314,7 +314,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	struct stat st;
 	int err;
 	uint32_t generation = 0;
-	EVP_MD_CTX ctx;
+	EVP_MD_CTX *ctx;
 	unsigned int mdlen;
 	char **xattrname;
 	char xattr_value[1024];
@@ -366,9 +366,14 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		return -1;
 	}
 
-	err = EVP_DigestInit(&ctx, EVP_sha1());
+	ctx = EVP_MD_CTX_new();
+	if (!ctx) {
+		log_err("EVP_MD_CTX_new() failed\n");
+		return 1;
+	}
+	err = EVP_DigestInit_ex(ctx, EVP_sha1(), NULL);
 	if (!err) {
-		log_err("EVP_DigestInit() failed\n");
+		log_err("EVP_DigestInit_ex() failed\n");
 		return 1;
 	}
 
@@ -398,7 +403,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
 		log_info("name: %s, size: %d\n", *xattrname, err);
 		log_debug_dump(xattr_value, err);
-		err = EVP_DigestUpdate(&ctx, xattr_value, err);
+		err = EVP_DigestUpdate(ctx, xattr_value, err);
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
 			return 1;
@@ -446,7 +451,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	log_debug("hmac_misc (%d): ", hmac_size);
 	log_debug_dump(&hmac_misc, hmac_size);
 
-	err = EVP_DigestUpdate(&ctx, &hmac_misc, hmac_size);
+	err = EVP_DigestUpdate(ctx, &hmac_misc, hmac_size);
 	if (!err) {
 		log_err("EVP_DigestUpdate() failed\n");
 		return 1;
@@ -457,18 +462,19 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		if (err)
 			return -1;
 
-		err = EVP_DigestUpdate(&ctx, (const unsigned char *)uuid, sizeof(uuid));
+		err = EVP_DigestUpdate(ctx, (const unsigned char *)uuid, sizeof(uuid));
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
 			return 1;
 		}
 	}
 
-	err = EVP_DigestFinal(&ctx, hash, &mdlen);
+	err = EVP_DigestFinal_ex(ctx, hash, &mdlen);
 	if (!err) {
 		log_err("EVP_DigestFinal() failed\n");
 		return 1;
 	}
+	EVP_MD_CTX_free(ctx);
 
 	return mdlen;
 }
@@ -908,7 +914,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	struct stat st;
 	int err = -1;
 	uint32_t generation = 0;
-	HMAC_CTX ctx;
+	HMAC_CTX *ctx;
 	unsigned int mdlen;
 	char **xattrname;
 	unsigned char xattr_value[1024];
@@ -965,10 +971,15 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		goto out;
 	}
 
-	err = !HMAC_Init(&ctx, evmkey, sizeof(evmkey), EVP_sha1());
+	ctx = HMAC_CTX_new();
+	if (!ctx) {
+		log_err("HMAC_MD_CTX_new() failed\n");
+		goto out;
+	}
+	err = !HMAC_Init_ex(ctx, evmkey, sizeof(evmkey), EVP_sha1(), NULL);
 	if (err) {
 		log_err("HMAC_Init() failed\n");
-		goto out;
+		goto out_ctx_cleanup;
 	}
 
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
@@ -984,7 +995,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
 		log_info("name: %s, size: %d\n", *xattrname, err);
 		log_debug_dump(xattr_value, err);
-		err = !HMAC_Update(&ctx, xattr_value, err);
+		err = !HMAC_Update(ctx, xattr_value, err);
 		if (err) {
 			log_err("HMAC_Update() failed\n");
 			goto out_ctx_cleanup;
@@ -1025,16 +1036,16 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	log_debug("hmac_misc (%d): ", hmac_size);
 	log_debug_dump(&hmac_misc, hmac_size);
 
-	err = !HMAC_Update(&ctx, (const unsigned char *)&hmac_misc, hmac_size);
+	err = !HMAC_Update(ctx, (const unsigned char *)&hmac_misc, hmac_size);
 	if (err) {
 		log_err("HMAC_Update() failed\n");
 		goto out_ctx_cleanup;
 	}
-	err = !HMAC_Final(&ctx, hash, &mdlen);
+	err = !HMAC_Final(ctx, hash, &mdlen);
 	if (err)
 		log_err("HMAC_Final() failed\n");
 out_ctx_cleanup:
-	HMAC_CTX_cleanup(&ctx);
+	HMAC_CTX_free(ctx);
 out:
 	free(key);
 	return err ?: mdlen;
diff --git a/src/libimaevm.c b/src/libimaevm.c
index eedffb4..f6339e5 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -271,7 +271,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 {
 	const EVP_MD *md;
 	struct stat st;
-	EVP_MD_CTX ctx;
+	EVP_MD_CTX *ctx;
 	unsigned int mdlen;
 	int err;
 
@@ -288,25 +288,30 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		return 1;
 	}
 
-	err = EVP_DigestInit(&ctx, md);
+	ctx = EVP_MD_CTX_new();
+	if (!ctx) {
+		log_err("EVP_MD_CTX_new() failed\n");
+		return 1;
+	}
+	err = EVP_DigestInit_ex(ctx, md, NULL);
 	if (!err) {
-		log_err("EVP_DigestInit() failed\n");
+		log_err("EVP_DigestInit_ex() failed\n");
 		return 1;
 	}
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFREG:
-		err = add_file_hash(file, &ctx);
+		err = add_file_hash(file, ctx);
 		break;
 	case S_IFDIR:
-		err = add_dir_hash(file, &ctx);
+		err = add_dir_hash(file, ctx);
 		break;
 	case S_IFLNK:
-		err = add_link_hash(file, &ctx);
+		err = add_link_hash(file, ctx);
 		break;
 	case S_IFIFO: case S_IFSOCK:
 	case S_IFCHR: case S_IFBLK:
-		err = add_dev_hash(&st, &ctx);
+		err = add_dev_hash(&st, ctx);
 		break;
 	default:
 		log_errno("Unsupported file type");
@@ -316,11 +321,12 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	if (err)
 		return err;
 
-	err = EVP_DigestFinal(&ctx, hash, &mdlen);
+	err = EVP_DigestFinal_ex(ctx, hash, &mdlen);
 	if (!err) {
-		log_err("EVP_DigestFinal() failed\n");
+		log_err("EVP_DigestFinal_ex() failed\n");
 		return 1;
 	}
+	EVP_MD_CTX_free(ctx);
 
 	return mdlen;
 }
@@ -549,6 +555,7 @@ int key2bin(RSA *key, unsigned char *pub)
 {
 	int len, b, offset = 0;
 	struct pubkey_hdr *pkh = (struct pubkey_hdr *)pub;
+	const BIGNUM *n, *e;
 
 	/* add key header */
 	pkh->version = 1;
@@ -558,18 +565,19 @@ int key2bin(RSA *key, unsigned char *pub)
 
 	offset += sizeof(*pkh);
 
-	len = BN_num_bytes(key->n);
-	b = BN_num_bits(key->n);
+	RSA_get0_key(key, &n, &e, NULL);
+	len = BN_num_bytes(n);
+	b = BN_num_bits(n);
 	pub[offset++] = b >> 8;
 	pub[offset++] = b & 0xff;
-	BN_bn2bin(key->n, &pub[offset]);
+	BN_bn2bin(n, &pub[offset]);
 	offset += len;
 
-	len = BN_num_bytes(key->e);
-	b = BN_num_bits(key->e);
+	len = BN_num_bytes(e);
+	b = BN_num_bits(e);
 	pub[offset++] = b >> 8;
 	pub[offset++] = b & 0xff;
-	BN_bn2bin(key->e, &pub[offset]);
+	BN_bn2bin(e, &pub[offset]);
 	offset += len;
 
 	return offset;
-- 
2.14.3
