Return-Path: <SRS0=dZkj=QN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71251C282C2
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Feb 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A1F2175B
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Feb 2019 13:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBFNK6 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:10:58 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55818 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfBFNK6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Feb 2019 08:10:58 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E57BF72CC53;
        Wed,  6 Feb 2019 16:07:00 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id BB5E44A4A14;
        Wed,  6 Feb 2019 16:07:00 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v2] ima-evm-utils: convert sign v2 from RSA to EVP_PKEY API
Date:   Wed,  6 Feb 2019 16:06:53 +0300
Message-Id: <20190206130653.5503-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
This enables more signatures to work out of the box.

Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
is doing proper PKCS1 padding automatically (tested to be compatible
with previous version, except for MD4). This also fixes bug with MD4
which produced wrong signature because of absence of the appropriate
RSA_ASN1_template.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- More key neutral code in calc_keyid_v1().
- Fix uninitialized sigsize for EVP_PKEY_sign().
- Fix memory leaks for openssl types.

 src/evmctl.c    |  29 +++---
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 277 +++++++++++++++++++++++++++-----------------------------
 3 files changed, 152 insertions(+), 158 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 55781fb..99f7e06 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 static int sign_evm(const char *file, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
-	unsigned char sig[MAX_SIGNATURE_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
@@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
 		return len;
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
+	assert(len < MAX_SIGNATURE_SIZE);
 	if (len <= 1)
 		return len;
 
@@ -891,7 +891,6 @@ static int cmd_import(struct command *cmd)
 	int id, len, err = 0;
 	char name[20];
 	uint8_t keyid[8];
-	RSA *key;
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
@@ -925,18 +924,26 @@ static int cmd_import(struct command *cmd)
 		}
 	}
 
-	key = read_pub_key(inkey, params.x509);
-	if (!key)
-		return 1;
-
 	if (params.x509) {
+		EVP_PKEY *pkey = read_pub_pkey(inkey, params.x509);
+
+		if (!pkey)
+			return 1;
 		pub = file2bin(inkey, NULL, &len);
-		if (!pub)
-			goto out;
-		calc_keyid_v2((uint32_t *)keyid, name, key);
+		if (!pub) {
+			EVP_PKEY_free(pkey);
+			return 1;
+		}
+		calc_keyid_v2((uint32_t *)keyid, name, pkey);
+		EVP_PKEY_free(pkey);
 	} else {
+		RSA *key = read_pub_key(inkey, params.x509);
+
+		if (!key)
+			return 1;
 		len = key2bin(key, pub);
 		calc_keyid_v1(keyid, name, pub, len);
+		RSA_free(key);
 	}
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
@@ -951,8 +958,6 @@ static int cmd_import(struct command *cmd)
 	}
 	if (params.x509)
 		free(pub);
-out:
-	RSA_free(key);
 	return err;
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index 795966a..577c93f 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -208,7 +208,6 @@ struct RSA_ASN1_template {
 #define	NUM_PCRS 20
 #define DEFAULT_PCR 10
 
-extern const struct RSA_ASN1_template RSA_ASN1_templates[PKEY_HASH__LAST];
 extern struct libevm_params params;
 
 void do_dump(FILE *fp, const void *ptr, int len, bool cr);
@@ -217,9 +216,10 @@ int get_filesize(const char *filename);
 int ima_calc_hash(const char *file, uint8_t *hash);
 int get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
+EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key);
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key);
 int key2bin(RSA *key, unsigned char *pub);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index dccb74c..a259003 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -76,63 +76,6 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
 };
 
-/*
- * Hash algorithm OIDs plus ASN.1 DER wrappings [RFC4880 sec 5.2.2].
- */
-static const uint8_t RSA_digest_info_MD5[] = {
-	0x30, 0x20, 0x30, 0x0C, 0x06, 0x08,
-	0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x02, 0x05, /* OID */
-	0x05, 0x00, 0x04, 0x10
-};
-
-static const uint8_t RSA_digest_info_SHA1[] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
-	0x2B, 0x0E, 0x03, 0x02, 0x1A,
-	0x05, 0x00, 0x04, 0x14
-};
-
-static const uint8_t RSA_digest_info_RIPE_MD_160[] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
-	0x2B, 0x24, 0x03, 0x02, 0x01,
-	0x05, 0x00, 0x04, 0x14
-};
-
-static const uint8_t RSA_digest_info_SHA224[] = {
-	0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x04,
-	0x05, 0x00, 0x04, 0x1C
-};
-
-static const uint8_t RSA_digest_info_SHA256[] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
-	0x05, 0x00, 0x04, 0x20
-};
-
-static const uint8_t RSA_digest_info_SHA384[] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02,
-	0x05, 0x00, 0x04, 0x30
-};
-
-static const uint8_t RSA_digest_info_SHA512[] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03,
-	0x05, 0x00, 0x04, 0x40
-};
-
-const struct RSA_ASN1_template RSA_ASN1_templates[PKEY_HASH__LAST] = {
-#define _(X) { RSA_digest_info_##X, sizeof(RSA_digest_info_##X) }
-	[PKEY_HASH_MD5]		= _(MD5),
-	[PKEY_HASH_SHA1]	= _(SHA1),
-	[PKEY_HASH_RIPE_MD_160]	= _(RIPE_MD_160),
-	[PKEY_HASH_SHA256]	= _(SHA256),
-	[PKEY_HASH_SHA384]	= _(SHA384),
-	[PKEY_HASH_SHA512]	= _(SHA512),
-	[PKEY_HASH_SHA224]	= _(SHA224),
-#undef _
-};
-
 struct libevm_params params = {
 	.verbose = LOG_INFO - 1,
 	.x509 = 1,
@@ -159,8 +102,12 @@ void dump(const void *ptr, int len)
 
 const char *get_hash_algo_by_id(int algo)
 {
-	if (algo < PKEY_HASH__LAST)
-	    return pkey_hash_algo[algo];
+	if (algo < PKEY_HASH__LAST) {
+		const char *name = pkey_hash_algo[algo];
+		const char *last = strrchr(name, ',');
+
+	    return last ? last + 1 : name;
+	}
 	if (algo < HASH_ALGO__LAST)
 	    return hash_algo_name[algo];
 
@@ -378,10 +325,9 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	return mdlen;
 }
 
-RSA *read_pub_key(const char *keyfile, int x509)
+EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
-	RSA *key = NULL;
 	X509 *crt = NULL;
 	EVP_PKEY *pkey = NULL;
 
@@ -398,24 +344,36 @@ RSA *read_pub_key(const char *keyfile, int x509)
 			goto out;
 		}
 		pkey = X509_extract_key(crt);
+		X509_free(crt);
 		if (!pkey) {
 			log_err("X509_extract_key() failed\n");
 			goto out;
 		}
-		key = EVP_PKEY_get1_RSA(pkey);
 	} else {
-		key = PEM_read_RSA_PUBKEY(fp, NULL, NULL, NULL);
+		pkey = PEM_read_PUBKEY(fp, NULL, NULL, NULL);
+		if (!pkey)
+			log_err("PEM_read_PUBKEY() failed\n");
 	}
 
-	if (!key)
-		log_err("PEM_read_RSA_PUBKEY() failed\n");
-
 out:
-	if (pkey)
-		EVP_PKEY_free(pkey);
-	if (crt)
-		X509_free(crt);
 	fclose(fp);
+	return pkey;
+}
+
+RSA *read_pub_key(const char *keyfile, int x509)
+{
+	EVP_PKEY *pkey;
+	RSA *key;
+
+	pkey = read_pub_pkey(keyfile, x509);
+	if (!pkey)
+		return NULL;
+	key = EVP_PKEY_get1_RSA(pkey);
+	EVP_PKEY_free(pkey);
+	if (!key) {
+		log_err("read_pub_key: unsupported key type\n");
+		return NULL;
+	}
 	return key;
 }
 
@@ -464,11 +422,11 @@ struct public_key_entry {
 	struct public_key_entry *next;
 	uint32_t keyid;
 	char name[9];
-	RSA *key;
+	EVP_PKEY *key;
 };
 static struct public_key_entry *public_keys = NULL;
 
-static RSA *find_keyid(uint32_t keyid)
+static EVP_PKEY *find_keyid(uint32_t keyid)
 {
 	struct public_key_entry *entry;
 
@@ -501,7 +459,7 @@ void init_public_keys(const char *keyfiles)
 			break;
 		}
 
-		entry->key = read_pub_key(keyfile, 1);
+		entry->key = read_pub_pkey(keyfile, 1);
 		if (!entry->key) {
 			free(entry);
 			continue;
@@ -518,11 +476,11 @@ void init_public_keys(const char *keyfiles)
 int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		   unsigned char *sig, int siglen, const char *keyfile)
 {
-	int err, len;
-	unsigned char out[1024];
-	RSA *key;
+	int err;
+	EVP_PKEY *pkey;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx;
+	const EVP_MD *md;
 
 	if (params.verbose > LOG_INFO) {
 		log_info("hash: ");
@@ -530,45 +488,39 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 
 	if (public_keys) {
-		key = find_keyid(hdr->keyid);
-		if (!key) {
+		pkey = find_keyid(hdr->keyid);
+		if (!pkey) {
 			log_err("%s: unknown keyid: %x\n", file,
 				__be32_to_cpup(&hdr->keyid));
 			return -1;
 		}
 	} else {
-		key = read_pub_key(keyfile, 1);
-		if (!key)
+		pkey = read_pub_pkey(keyfile, 1);
+		if (!pkey)
 			return 1;
 	}
 
-
-	err = RSA_public_decrypt(siglen - sizeof(*hdr), sig + sizeof(*hdr),
-				 out, key, RSA_PKCS1_PADDING);
-	if (err < 0) {
-		log_err("%s: RSA_public_decrypt() failed: %d\n", file, err);
-		return 1;
-	}
-
-	len = err;
-
-	asn1 = &RSA_ASN1_templates[hdr->hash_algo];
-
-	if (len < asn1->size || memcmp(out, asn1->data, asn1->size)) {
-		log_err("%s: verification failed: %d (asn1 mismatch)\n",
-			file, err);
-		return -1;
-	}
-
-	len -= asn1->size;
-
-	if (len != size || memcmp(out + asn1->size, hash, len)) {
-		log_err("%s: verification failed: %d (digest mismatch)\n",
-			file, err);
-		return -1;
-	}
-
-	return 0;
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	if (!EVP_PKEY_verify_init(ctx))
+		goto err;
+	if (!(md = get_digestbyname(params.hash_algo)))
+		goto err;
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	err = EVP_PKEY_verify(ctx, sig + sizeof(*hdr),
+			      siglen - sizeof(*hdr), hash, size);
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+
+	return err != 1;
+err:
+#ifdef USE_FPRINTF
+	ERR_print_errors_fp(stderr);
+#endif
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+	return -1;
 }
 
 /* compare algo names case insensitively and ignoring separators */
@@ -775,16 +727,25 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 		log_info("keyid-v1: %s\n", str);
 }
 
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key)
 {
+	X509_PUBKEY *pk = NULL;
 	uint8_t sha1[SHA_DIGEST_LENGTH];
-	unsigned char *pkey = NULL;
+	const unsigned char *pkey = NULL;
 	int len;
 
-	len = i2d_RSAPublicKey(key, &pkey);
-
+	/* This is more general than i2d_PublicKey() */
+	if (!X509_PUBKEY_set(&pk, key) ||
+	    !X509_PUBKEY_get0_param(NULL, &pkey, &len, NULL, pk) ||
+	    len <= 0) {
+#ifdef USE_FPRINTF
+		ERR_print_errors_fp(stderr);
+#endif
+		/* Produce invalid key in case of error. */
+		*keyid = 0;
+		return;
+	}
 	SHA1(pkey, len, sha1);
-
 	/* sha1[12 - 19] is exactly keyid from gpg file */
 	memcpy(keyid, sha1 + 16, 4);
 	log_debug("keyid: ");
@@ -794,13 +755,13 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	if (params.verbose > LOG_INFO)
 		log_info("keyid: %s\n", str);
 
-	free(pkey);
+	X509_PUBKEY_free(pk);
 }
 
-static RSA *read_priv_key(const char *keyfile, const char *keypass)
+static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-	RSA *key;
+	EVP_PKEY *key;
 
 	fp = fopen(keyfile, "r");
 	if (!fp) {
@@ -808,18 +769,40 @@ static RSA *read_priv_key(const char *keyfile, const char *keypass)
 		return NULL;
 	}
 	ERR_load_crypto_strings();
-	key = PEM_read_RSAPrivateKey(fp, NULL, NULL, (void *)keypass);
+	key = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
 	if (!key) {
 		char str[256];
 
-		ERR_error_string(ERR_get_error(), str);
-		log_err("PEM_read_RSAPrivateKey() failed: %s\n", str);
+		ERR_error_string(ERR_peek_error(), str);
+		log_err("PEM_read_PrivateKey() failed: %s\n", str);
+#ifdef USE_FPRINTF
+		ERR_print_errors_fp(stderr);
+#else
+		ERR_clear_error();
+#endif
 	}
 
 	fclose(fp);
 	return key;
 }
 
+static RSA *read_priv_key(const char *keyfile, const char *keypass)
+{
+	EVP_PKEY *pkey;
+	RSA *key;
+
+	pkey = read_priv_pkey(keyfile, keypass);
+	if (!pkey)
+		return NULL;
+	key = EVP_PKEY_get1_RSA(pkey);
+	EVP_PKEY_free(pkey);
+	if (!key) {
+		log_err("sign_hash_v1: unsupported key type\n");
+		return NULL;
+	}
+	return key;
+}
+
 static int get_hash_algo_v1(const char *algo)
 {
 
@@ -911,14 +894,16 @@ out:
 	return len;
 }
 
+/* @sig is assumed to be of MAX_SIGNATURE_SIZE size */
 int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const char *keyfile, unsigned char *sig)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
-	RSA *key;
+	EVP_PKEY *pkey;
 	char name[20];
-	unsigned char *buf;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx = NULL;
+	const EVP_MD *md;
+	size_t sigsize;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -943,8 +928,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, params.keypass);
-	if (!key)
+	pkey = read_priv_pkey(keyfile, params.keypass);
+	if (!pkey)
 		return -1;
 
 	hdr = (struct signature_v2_hdr *)sig;
@@ -952,32 +937,36 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	hdr->hash_algo = get_hash_algo(algo);
 
-	calc_keyid_v2(&hdr->keyid, name, key);
-
-	asn1 = &RSA_ASN1_templates[hdr->hash_algo];
-
-	buf = malloc(size + asn1->size);
-	if (!buf)
-		goto out;
-
-	memcpy(buf, asn1->data, asn1->size);
-	memcpy(buf + asn1->size, hash, size);
-	len = RSA_private_encrypt(size + asn1->size, buf, hdr->sig,
-				  key, RSA_PKCS1_PADDING);
-	if (len < 0) {
-		log_err("RSA_private_encrypt() failed: %d\n", len);
-		goto out;
-	}
+	calc_keyid_v2(&hdr->keyid, name, pkey);
+
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	if (!EVP_PKEY_sign_init(ctx))
+		goto err;
+	if (!(md = get_digestbyname(params.hash_algo)))
+		goto err;
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr);
+	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+		goto err;
+	len = (int)sigsize;
 
 	/* we add bit length of the signature to make it gnupg compatible */
 	hdr->sig_size = __cpu_to_be16(len);
 	len += sizeof(*hdr);
 	log_info("evm/ima signature: %d bytes\n", len);
-out:
-	if (buf)
-		free(buf);
-	RSA_free(key);
+
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
 	return len;
+err:
+#ifdef USE_FPRINTF
+	ERR_print_errors_fp(stderr);
+#endif
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+	return -1;
 }
 
 
-- 
2.11.0

