Return-Path: <SRS0=zpiu=QT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00051C169C4
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 00:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDE52084E
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Feb 2019 00:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfBLAOM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:14:12 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50880 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfBLAOM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 19:14:12 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EAEDA72CC64;
        Tue, 12 Feb 2019 03:14:09 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id C10BA4A4AE7;
        Tue, 12 Feb 2019 03:14:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: simplify digest alias handling
Date:   Tue, 12 Feb 2019 03:14:00 +0300
Message-Id: <20190212001400.11107-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

- Make digest name search work just with simple strcmp() and two arrays.
- Make newer name "streebogX" alias of older and backward compatible name
  "md_gost12_X".
- Remove get_digestbyname() which was doing two hash name resolving
  attempts, reverting to use plain EVP_get_digestbyname(). This will
  force the user to specify the proper hash name depending on what
  OpenSSL provides, allowing to specify older hash name in older
  OpenSSL. (This may be improved later, for example, by resolving
  hash name to a numerical id and the id to a proper hash name. Or
  we could resolve a hash name to the OpenSSL hash NID and resolve
  the NID to a internal hash name. In this case we don't need to keep
  hash alias names at all.)
---
 src/libimaevm.c | 89 +++++++++------------------------------------------------
 1 file changed, 13 insertions(+), 76 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index d9ffa13..ed77211 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -63,7 +63,7 @@
 #include "imaevm.h"
 #include "hash_info.h"
 
-const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
+const char *pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_MD4]		= "md4",
 	[PKEY_HASH_MD5]		= "md5",
 	[PKEY_HASH_SHA1]	= "sha1",
@@ -72,8 +72,13 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
-	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
-	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
+	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
+	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
+};
+
+const char *pkey_hash_algo_alias[PKEY_HASH__LAST] = {
+	[PKEY_HASH_STREEBOG_256] = "streebog256",
+	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
 
 /*
@@ -161,8 +166,6 @@ const char *get_hash_algo_by_id(int algo)
 {
 	if (algo < PKEY_HASH__LAST)
 	    return pkey_hash_algo[algo];
-	if (algo < HASH_ALGO__LAST)
-	    return hash_algo_name[algo];
 
 	log_err("digest %d not found\n", algo);
 	return "unknown";
@@ -286,35 +289,6 @@ static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
 	return !EVP_DigestUpdate(ctx, &dev, sizeof(dev));
 }
 
-/* Call EVP_get_digestbyname with provided name and with alias,
- * which is first name in the comma separated list of names
- * in pkey_hash_algo.
- */
-static const EVP_MD *get_digestbyname(const char *name)
-{
-	const EVP_MD *md;
-
-	md = EVP_get_digestbyname(params.hash_algo);
-	if (!md) {
-		char alias[MAX_DIGEST_NAME];
-		int len;
-		int algo_id;
-		const char *algo_alias;
-
-		/* try to get algo by its alias */
-		algo_id = get_hash_algo(params.hash_algo);
-		algo_alias = get_hash_algo_by_id(algo_id);
-		len = strchrnul(algo_alias, ',') - algo_alias;
-		if (len < sizeof(alias)) {
-			memcpy(alias, algo_alias, len);
-			alias[len] = '\0';
-			if (strcmp(params.hash_algo, alias))
-				md = EVP_get_digestbyname(alias);
-		}
-	}
-	return md;
-}
-
 int ima_calc_hash(const char *file, uint8_t *hash)
 {
 	const EVP_MD *md;
@@ -336,7 +310,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		return err;
 	}
 
-	md = get_digestbyname(params.hash_algo);
+	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
 		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		return 1;
@@ -572,42 +546,6 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	return 0;
 }
 
-/* compare algo names case insensitively and ignoring separators */
-static int algocmp(const char *a, const char *b)
-{
-	while (*a && *b) {
-		int cha, chb;
-
-		cha = tolower((unsigned char)*a++);
-		if (!isalnum(cha))
-			continue;
-		chb = tolower((unsigned char)*b++);
-		if (!isalnum(chb)) {
-			a--;
-			continue;
-		}
-		if (cha != chb)
-			return -1;
-	}
-	return *a || *b;
-}
-
-static int strmatch(const char *needle, const char *haystack)
-{
-	int len = strlen(needle);
-	const char *p = haystack;
-	const char *t;
-
-	for (t = strchrnul(p, ','); *p; p = t, t = strchrnul(p, ',')) {
-		if (t - p == len &&
-		    !strncmp(needle, p, len))
-			return 0;
-		if (!*t++)
-			break;
-	}
-	return 1;
-}
-
 int get_hash_algo(const char *algo)
 {
 	int i;
@@ -615,15 +553,14 @@ int get_hash_algo(const char *algo)
 	/* first iterate over builtin algorithms */
 	for (i = 0; i < PKEY_HASH__LAST; i++)
 		if (pkey_hash_algo[i] &&
-		    !strmatch(algo, pkey_hash_algo[i]))
+		    !strcmp(algo, pkey_hash_algo[i]))
 			return i;
 
 	/* iterate over algorithms provided by kernel-headers */
-	for (i = 0; i < HASH_ALGO__LAST; i++) {
-		if (hash_algo_name[i] &&
-		    !algocmp(algo, hash_algo_name[i]))
+	for (i = 0; i < PKEY_HASH__LAST; i++)
+		if (pkey_hash_algo_alias[i] &&
+		    !strcmp(algo, pkey_hash_algo_alias[i]))
 			return i;
-	}
 
 	log_info("digest %s not found, fall back to sha1\n", algo);
 	return PKEY_HASH_SHA1;
-- 
2.11.0

