Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF4C65BAE
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 03:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2F12145D
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 03:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2F12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeLCDfb (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:35:31 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54304 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeLCDfb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 22:35:31 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2DA8672CC72;
        Mon,  3 Dec 2018 06:35:26 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0FF284A4AE7;
        Mon,  3 Dec 2018 06:35:26 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 4/7] ima-evm-utils: Allow using Streebog hash function
Date:   Mon,  3 Dec 2018 06:35:22 +0300
Message-Id: <20181203033525.20431-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181203033525.20431-1-vt@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch will allow using GOST algorithms from OpenSSL's
gost-engine[1] via config extension (which is the usual way).

[1] https://github.com/gost-engine/engine

Full usage example:

1. Install the gost-engine package for your distro, this could be
libengine-gost-openssl1.1, openssl-gost-engine, or openssl-engines.

2. Edit openssl.cnf appropriately. Reference INSTALL.md of gost-engine
for the detailed instructions.

3. Then GOST algorithms should work:

  $ cp /dev/null a
  $ openssl dgst -streebog256 a
  md_gost12_256(a)= 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
  $ evmctl -v ima_hash -a streebog256 --xattr-user a
  hash: 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
  $ getfattr -d -m. -ehex a
  # file: a
  user.ima=0x04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- "--engine" option is removed into separate patch.
Changes since v2:
- Add usage example to description.

 src/evmctl.c    |  6 +++---
 src/imaevm.h    | 13 +++++++++++++
 src/libimaevm.c | 15 +++++++++++----
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index f4df027..1f6dad5 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -388,7 +388,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname() failed\n");
+		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		return 1;
 	}
 
@@ -1064,7 +1064,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname() failed\n");
+		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		goto out;
 	}
 
@@ -1653,7 +1653,7 @@ static void usage(void)
 
 	printf(
 		"\n"
-		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512\n"
+		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
 		"  -s, --imasig       make IMA signature\n"
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
diff --git a/src/imaevm.h b/src/imaevm.h
index 2ebe7e7..c81bf21 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -152,6 +152,7 @@ struct signature_hdr {
 	char mpi[0];
 } __packed;
 
+/* reflect enum hash_algo from include/uapi/linux/hash_info.h */
 enum pkey_hash_algo {
 	PKEY_HASH_MD4,
 	PKEY_HASH_MD5,
@@ -161,6 +162,18 @@ enum pkey_hash_algo {
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
index 34501ca..7b2b62c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -51,6 +51,7 @@
 #include <stdio.h>
 #include <assert.h>
 
+#include <openssl/crypto.h>
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
@@ -67,6 +68,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
+	[PKEY_HASH_STREEBOG_256] = "streebog256",
+	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
 
 /*
@@ -291,7 +294,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname() failed\n");
+		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		return 1;
 	}
 
@@ -509,14 +512,16 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
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
 
@@ -528,7 +533,8 @@ int get_hash_algo(const char *algo)
 	int i;
 
 	for (i = 0; i < PKEY_HASH__LAST; i++)
-		if (!strcmp(algo, pkey_hash_algo[i]))
+		if (pkey_hash_algo[i] &&
+		    !strcmp(algo, pkey_hash_algo[i]))
 			return i;
 
 	return PKEY_HASH_SHA1;
@@ -901,5 +907,6 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 static void libinit()
 {
 	OpenSSL_add_all_algorithms();
+	OPENSSL_add_all_algorithms_conf();
 	ERR_load_crypto_strings();
 }
-- 
2.11.0

