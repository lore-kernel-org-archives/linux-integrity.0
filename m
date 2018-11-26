Return-Path: <SRS0=ex1J=OF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C5C43441
	for <linux-integrity@archiver.kernel.org>; Mon, 26 Nov 2018 04:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF672086B
	for <linux-integrity@archiver.kernel.org>; Mon, 26 Nov 2018 04:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF672086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeKZPdG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:33:06 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52244 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZPdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Nov 2018 10:33:06 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2941872CC61;
        Mon, 26 Nov 2018 07:40:12 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id F00534A4AE9;
        Mon, 26 Nov 2018 07:40:11 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 3/3] ima-evm-utils: Allow to use Streebog hash function
Date:   Mon, 26 Nov 2018 07:39:53 +0300
Message-Id: <20181126043953.1126-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181126043953.1126-1-vt@altlinux.org>
References: <20181126043953.1126-1-vt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are two methods of using GOST algorithms in OpenSSL: via config
extension and via --engine option. Both require gost-engine to be
installed.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    | 27 ++++++++++++++++++++++++---
 src/imaevm.h    | 13 +++++++++++++
 src/libimaevm.c | 15 +++++++++++----
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 032ea9d..5b4d8d9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -62,6 +62,7 @@
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
+#include <openssl/engine.h>
 
 #ifndef XATTR_APPAARMOR_SUFFIX
 #define XATTR_APPARMOR_SUFFIX "apparmor"
@@ -388,7 +389,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname() failed\n");
+		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		return 1;
 	}
 
@@ -1056,7 +1057,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname() failed\n");
+		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		goto out;
 	}
 
@@ -1643,7 +1644,7 @@ static void usage(void)
 
 	printf(
 		"\n"
-		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512\n"
+		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
 		"  -s, --imasig       make IMA signature\n"
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
@@ -1669,6 +1670,7 @@ static void usage(void)
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --list         measurement list verification\n"
+		"      --engine e     preload OpenSSL engine e\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
@@ -1721,6 +1723,7 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"list", 0, 0, 138},
+	{"engine", 1, 0, 139},
 	{"xattr-user", 0, 0, 140},
 	{}
 
@@ -1763,6 +1766,7 @@ static char *get_password(void)
 int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
+	ENGINE *eng = NULL;
 
 	g_argv = argv;
 	g_argc = argc;
@@ -1873,6 +1877,16 @@ int main(int argc, char *argv[])
 		case 138:
 			measurement_list = 1;
 			break;
+		case 139: /* --engine e */
+			eng = ENGINE_by_id(optarg);
+			if (!eng)
+				log_err("engine %s isn't available\n", optarg);
+			else if (!ENGINE_init(eng)) {
+				log_err("engine %s init failed\n", optarg);
+				ENGINE_free(eng);
+				eng = NULL;
+			}
+			break;
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
 			xattr_evm = "user.evm";
@@ -1903,6 +1917,13 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (eng) {
+		ENGINE_finish(eng);
+		ENGINE_free(eng);
+#if OPENSSL_API_COMPAT < 0x10100000L
+		ENGINE_cleanup();
+#endif
+	}
 	ERR_free_strings();
 	EVP_cleanup();
 	BIO_free(NULL);
diff --git a/src/imaevm.h b/src/imaevm.h
index 1bafaad..1a5ebbe 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -149,6 +149,7 @@ struct signature_hdr {
 	char mpi[0];
 } __packed;
 
+/* reflect enum hash_algo from include/uapi/linux/hash_info.h */
 enum pkey_hash_algo {
 	PKEY_HASH_MD4,
 	PKEY_HASH_MD5,
@@ -158,6 +159,18 @@ enum pkey_hash_algo {
 	PKEY_HASH_SHA384,
 	PKEY_HASH_SHA512,
 	PKEY_HASH_SHA224,
+	PKEY_HASH_RIPE_MD_128,
+	PKEY_HASH_RIPE_MD_256,
+	PKEY_HASH_RIPE_MD_320,
+	PKEY_HASH_WP_256,
+	PKEY_HASH_WP_384,
+	PKEY_HASH_WP_512,
+	PKEY_HASH_TGR_128,
+	PKEY_HASH_TGR_160,
+	PKEY_HASH_TGR_192,
+	PKEY_HASH_SM3_256,
+	PKEY_HASH_STREEBOG_256,
+	PKEY_HASH_STREEBOG_512,
 	PKEY_HASH__LAST
 };
 
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 714f1ac..8f74660 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -50,6 +50,7 @@
 #include <string.h>
 #include <stdio.h>
 
+#include <openssl/crypto.h>
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
@@ -66,6 +67,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
+	[PKEY_HASH_STREEBOG_256] = "streebog256",
+	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
 
 /*
@@ -290,7 +293,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname() failed\n");
+		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		return 1;
 	}
 
@@ -508,14 +511,16 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	asn1 = &RSA_ASN1_templates[hdr->hash_algo];
 
 	if (len < asn1->size || memcmp(out, asn1->data, asn1->size)) {
-		log_err("%s: verification failed: %d\n", file, err);
+		log_err("%s: verification failed: %d (asn1 mismatch)\n",
+			file, err);
 		return -1;
 	}
 
 	len -= asn1->size;
 
 	if (len != size || memcmp(out + asn1->size, hash, len)) {
-		log_err("%s: verification failed: %d\n", file, err);
+		log_err("%s: verification failed: %d (digest mismatch)\n",
+			file, err);
 		return -1;
 	}
 
@@ -527,7 +532,8 @@ int get_hash_algo(const char *algo)
 	int i;
 
 	for (i = 0; i < PKEY_HASH__LAST; i++)
-		if (!strcmp(algo, pkey_hash_algo[i]))
+		if (pkey_hash_algo[i] &&
+		    !strcmp(algo, pkey_hash_algo[i]))
 			return i;
 
 	return PKEY_HASH_SHA1;
@@ -899,5 +905,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 static void libinit()
 {
 	OpenSSL_add_all_algorithms();
+	OPENSSL_add_all_algorithms_conf();
 	ERR_load_crypto_strings();
 }
-- 
2.11.0

