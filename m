Return-Path: <SRS0=r+VA=OH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A69C43441
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Nov 2018 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FCA2081C
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Nov 2018 20:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FCA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeK2HKD (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:10:03 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51560 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeK2HKD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Nov 2018 02:10:03 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0883B72CC59;
        Wed, 28 Nov 2018 23:07:13 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id D8B684A4A29;
        Wed, 28 Nov 2018 23:07:12 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH v2 7/7] ima-evm-utils: Try to load digest by its alias
Date:   Wed, 28 Nov 2018 23:06:10 +0300
Message-Id: <20181128200610.21214-7-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181128200610.21214-1-vt@altlinux.org>
References: <20181128200610.21214-1-vt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For compatibility with older OpenSSL try to load digest by its alias if
load by its proper name is failed.

This is configured in pkey_hash_algo by mentioning loadable alias first in the
comma separated list of algo names.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- New patch.

 src/imaevm.h    |  1 +
 src/libimaevm.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index c81bf21..795966a 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -75,6 +75,7 @@
 #define	DATA_SIZE	4096
 #define SHA1_HASH_LEN   20
 
+#define MAX_DIGEST_NAME		32
 #define MAX_DIGEST_SIZE		64
 #define MAX_SIGNATURE_SIZE	1024
 
diff --git a/src/libimaevm.c b/src/libimaevm.c
index cb4721b..7501303 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -41,6 +41,7 @@
 /* should we use logger instead for library? */
 #define USE_FPRINTF
 
+#define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/stat.h>
@@ -56,6 +57,7 @@
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
+#include <openssl/engine.h>
 #include <openssl/err.h>
 
 #include "imaevm.h"
@@ -70,8 +72,8 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
-	[PKEY_HASH_STREEBOG_256] = "streebog256",
-	[PKEY_HASH_STREEBOG_512] = "streebog512",
+	[PKEY_HASH_STREEBOG_256] = "md_gost12_256,streebog256",
+	[PKEY_HASH_STREEBOG_512] = "md_gost12_512,streebog512",
 };
 
 /*
@@ -284,6 +286,35 @@ static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
 	return !EVP_DigestUpdate(ctx, &dev, sizeof(dev));
 }
 
+/* Call EVP_get_digestbyname with provided name and with alias,
+ * which is first name in the comma separated list of names
+ * in pkey_hash_algo.
+ */
+static const EVP_MD *get_digestbyname(const char *name)
+{
+	const EVP_MD *md;
+
+	md = EVP_get_digestbyname(params.hash_algo);
+	if (!md) {
+		char alias[MAX_DIGEST_NAME];
+		int len;
+		int algo_id;
+		const char *algo_alias;
+
+		/* try to get algo by its alias */
+		algo_id = get_hash_algo(params.hash_algo);
+		algo_alias = get_hash_algo_by_id(algo_id);
+		len = strchrnul(algo_alias, ',') - algo_alias;
+		if (len < sizeof(alias)) {
+			memcpy(alias, algo_alias, len);
+			alias[len] = '\0';
+			if (strcmp(params.hash_algo, alias))
+				md = EVP_get_digestbyname(alias);
+		}
+	}
+	return md;
+}
+
 int ima_calc_hash(const char *file, uint8_t *hash)
 {
 	const EVP_MD *md;
@@ -305,7 +336,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		return err;
 	}
 
-	md = EVP_get_digestbyname(params.hash_algo);
+	md = get_digestbyname(params.hash_algo);
 	if (!md) {
 		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
 		return 1;
@@ -561,6 +592,22 @@ static int algocmp(const char *a, const char *b)
 	return *a || *b;
 }
 
+static int strmatch(const char *needle, const char *haystack)
+{
+	int len = strlen(needle);
+	const char *p = haystack;
+	const char *t;
+
+	for (t = strchrnul(p, ','); *p; p = t, t = strchrnul(p, ',')) {
+		if (t - p == len &&
+		    !strncmp(needle, p, len))
+			return 0;
+		if (!*t++)
+			break;
+	}
+	return 1;
+}
+
 int get_hash_algo(const char *algo)
 {
 	int i;
@@ -568,7 +615,7 @@ int get_hash_algo(const char *algo)
 	/* first iterate over builtin algorithms */
 	for (i = 0; i < PKEY_HASH__LAST; i++)
 		if (pkey_hash_algo[i] &&
-		    !strcmp(algo, pkey_hash_algo[i]))
+		    !strmatch(algo, pkey_hash_algo[i]))
 			return i;
 
 	/* iterate over algorithms provided by kernel-headers */
-- 
2.11.0

