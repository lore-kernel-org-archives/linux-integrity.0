Return-Path: <SRS0=kwZo=QE=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F884C282C8
	for <linux-integrity@archiver.kernel.org>; Mon, 28 Jan 2019 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCBD2082C
	for <linux-integrity@archiver.kernel.org>; Mon, 28 Jan 2019 17:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfA1RMC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:12:02 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33986 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbfA1RMB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jan 2019 12:12:01 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 66A6D72CC61;
        Mon, 28 Jan 2019 20:11:57 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 24D594A4A16;
        Mon, 28 Jan 2019 20:11:57 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH] ima-evm-utils: convert sign v2 from RSA to EVP_PKEY API
Date:   Mon, 28 Jan 2019 20:11:53 +0300
Message-Id: <20190128171154.24073-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
This enables more signatures to work out of the box.

Only in single instance GOST NIDs are checked to produce correct keyid.
Other than that code is quite generic.

Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
is doing proper PKCS1 padding automatically (tested to be compatible
with previous version, except for MD4). This also fixes bug with MD4
which produced wrong signature because of absence of the appropriate
RSA_ASN1_template.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    |  25 +++---
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 271 +++++++++++++++++++++++++++-----------------------------
 3 files changed, 146 insertions(+), 154 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0459798..2e4d551 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
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
index d9ffa13..bd99c60 100644
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
 
@@ -379,10 +326,9 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	return mdlen;
 }
 
-RSA *read_pub_key(const char *keyfile, int x509)
+EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
-	RSA *key = NULL;
 	X509 *crt = NULL;
 	EVP_PKEY *pkey = NULL;
 
@@ -403,20 +349,33 @@ RSA *read_pub_key(const char *keyfile, int x509)
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
 	if (crt)
 		X509_free(crt);
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
 
@@ -465,11 +424,11 @@ struct public_key_entry {
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
 
@@ -502,7 +461,7 @@ void init_public_keys(const char *keyfiles)
 			break;
 		}
 
-		entry->key = read_pub_key(keyfile, 1);
+		entry->key = read_pub_pkey(keyfile, 1);
 		if (!entry->key) {
 			free(entry);
 			continue;
@@ -519,11 +478,11 @@ void init_public_keys(const char *keyfiles)
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
@@ -531,45 +490,34 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
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
+
+	return err != 1;
+err:
+	ERR_print_errors_fp(stderr);
+	return -1;
 }
 
 /* compare algo names case insensitively and ignoring separators */
@@ -776,16 +724,32 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 		log_info("keyid-v1: %s\n", str);
 }
 
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key)
 {
+	X509_PUBKEY *pk = NULL;
 	uint8_t sha1[SHA_DIGEST_LENGTH];
-	unsigned char *pkey = NULL;
+	const unsigned char *pkey = NULL;
+	unsigned char *pp = NULL;
 	int len;
 
-	len = i2d_RSAPublicKey(key, &pkey);
-
-	SHA1(pkey, len, sha1);
+	switch (EVP_PKEY_id(key)) {
+	case NID_id_GostR3410_2012_256:
+	case NID_id_GostR3410_2012_512:
+		X509_PUBKEY_set(&pk, key);
+		X509_PUBKEY_get0_param(NULL, &pkey, &len, NULL, pk);
+		break;
+	default:
+		len = i2d_PublicKey(key, &pp);
+		pkey = pp;
+	}
 
+	if (len <= 0) {
+		ERR_print_errors_fp(stderr);
+		/* Produce invalid key in case of error. */
+		len = SHA_DIGEST_LENGTH;
+		memset(sha1, 0, len);
+	} else
+		SHA1(pkey, len, sha1);
 	/* sha1[12 - 19] is exactly keyid from gpg file */
 	memcpy(keyid, sha1 + 16, 4);
 	log_debug("keyid: ");
@@ -795,13 +759,14 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	if (params.verbose > LOG_INFO)
 		log_info("keyid: %s\n", str);
 
-	free(pkey);
+	X509_PUBKEY_free(pk);
+	free(pp);
 }
 
-static RSA *read_priv_key(const char *keyfile, const char *keypass)
+static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-	RSA *key;
+	EVP_PKEY *key;
 
 	fp = fopen(keyfile, "r");
 	if (!fp) {
@@ -809,18 +774,40 @@ static RSA *read_priv_key(const char *keyfile, const char *keypass)
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
 
@@ -916,10 +903,11 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
-	RSA *key;
+	EVP_PKEY *pkey;
 	char name[20];
-	unsigned char *buf;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx;
+	const EVP_MD *md;
+	size_t sigsize;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -944,8 +932,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, params.keypass);
-	if (!key)
+	pkey = read_priv_pkey(keyfile, params.keypass);
+	if (!pkey)
 		return -1;
 
 	hdr = (struct signature_v2_hdr *)sig;
@@ -953,32 +941,31 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
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
+	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+		goto err;
+	len = (int)sigsize;
+	EVP_PKEY_CTX_free(ctx);
 
 	/* we add bit length of the signature to make it gnupg compatible */
 	hdr->sig_size = __cpu_to_be16(len);
 	len += sizeof(*hdr);
 	log_info("evm/ima signature: %d bytes\n", len);
-out:
-	if (buf)
-		free(buf);
-	RSA_free(key);
+
+	EVP_PKEY_free(pkey);
 	return len;
+err:
+	ERR_print_errors_fp(stderr);
+	return -1;
 }
 
 
-- 
2.11.0

