Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED7C64EB4
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 03:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C98021473
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 03:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C98021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeLCDfc (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:35:32 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54284 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeLCDfc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 22:35:32 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DE1C572CC6C;
        Mon,  3 Dec 2018 06:35:25 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id A3ECC4A4AE7;
        Mon,  3 Dec 2018 06:35:25 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 2/7] ima-evm-utils: Define hash and sig buffer sizes and add asserts
Date:   Mon,  3 Dec 2018 06:35:20 +0300
Message-Id: <20181203033525.20431-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181203033525.20431-1-vt@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To prevent hash and sig buffers size mismatch, define their maximum
sizes and add sanity checking asserts.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- New patch.
Changes since v2:
- Add single comment line to sign_evm.

 src/evmctl.c    | 35 ++++++++++++++++++++++-------------
 src/imaevm.h    |  3 +++
 src/libimaevm.c |  4 +++-
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index f8035da..f019a67 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -505,15 +505,17 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 static int sign_evm(const char *file, const char *key)
 {
-	unsigned char hash[64];
-	unsigned char sig[1024];
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
+	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
+	assert(len < sizeof(sig));
 	if (len <= 1)
 		return len;
 
@@ -543,7 +545,7 @@ static int sign_evm(const char *file, const char *key)
 
 static int hash_ima(const char *file)
 {
-	unsigned char hash[66]; /* MAX hash size + 2 */
+	unsigned char hash[MAX_DIGEST_SIZE + 2]; /* +2 byte xattr header */
 	int len, err, offset;
 	int algo = get_hash_algo(params.hash_algo);
 
@@ -557,6 +559,7 @@ static int hash_ima(const char *file)
 	}
 
 	len = ima_calc_hash(file, hash + offset);
+	assert(len + offset <= sizeof(hash));
 	if (len <= 1)
 		return len;
 
@@ -581,15 +584,17 @@ static int hash_ima(const char *file)
 
 static int sign_ima(const char *file, const char *key)
 {
-	unsigned char hash[64];
-	unsigned char sig[1024];
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
 	len = ima_calc_hash(file, hash);
+	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
+	assert(len < sizeof(sig));
 	if (len <= 1)
 		return len;
 
@@ -695,8 +700,8 @@ static int cmd_sign_hash(struct command *cmd)
 	int hashlen = 0;
 	size_t line_len;
 	ssize_t len;
-	unsigned char hash[64];
-	unsigned char sig[1024] = "\x03";
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
 	int siglen;
 
 	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
@@ -711,9 +716,11 @@ static int cmd_sign_hash(struct command *cmd)
 		token = strpbrk(line, ", \t");
 		hashlen = token ? token - line : strlen(line);
 
-		hex2bin(hash, line, hashlen);
+		assert(hashlen / 2 <= sizeof(hash));
+		hex2bin(hash, line, hashlen / 2);
 		siglen = sign_hash(params.hash_algo, hash, hashlen/2,
 				 key, NULL, sig + 1);
+		assert(siglen < sizeof(sig));
 		if (siglen <= 1)
 			return siglen;
 
@@ -761,8 +768,8 @@ static int cmd_sign_evm(struct command *cmd)
 
 static int verify_evm(const char *file)
 {
-	unsigned char hash[64];
-	unsigned char sig[1024];
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int mdlen;
 	int len;
 
@@ -804,12 +811,13 @@ static int cmd_verify_evm(struct command *cmd)
 
 static int verify_ima(const char *file)
 {
-	unsigned char sig[1024];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len;
 
 	if (sigfile) {
 		void *tmp = file2bin(file, "sig", &len);
 
+		assert(len <= sizeof(sig));
 		memcpy(sig, tmp, len);
 		free(tmp);
 	} else {
@@ -1138,8 +1146,8 @@ out:
 
 static int hmac_evm(const char *file, const char *key)
 {
-	unsigned char hash[64];
-	unsigned char sig[1024];
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
 	len = calc_evm_hmac(file, key, hash);
@@ -1149,6 +1157,7 @@ static int hmac_evm(const char *file, const char *key)
 
 	log_info("hmac: ");
 	log_dump(hash, len);
+	assert(len < sizeof(sig));
 	memcpy(sig + 1, hash, len);
 
 	if (xattr) {
diff --git a/src/imaevm.h b/src/imaevm.h
index 1bafaad..2ebe7e7 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -75,6 +75,9 @@
 #define	DATA_SIZE	4096
 #define SHA1_HASH_LEN   20
 
+#define MAX_DIGEST_SIZE		64
+#define MAX_SIGNATURE_SIZE	1024
+
 #define __packed __attribute__((packed))
 
 enum evm_ima_xattr_type {
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6fa0ed4..80b61a2 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -49,6 +49,7 @@
 #include <dirent.h>
 #include <string.h>
 #include <stdio.h>
+#include <assert.h>
 
 #include <openssl/pem.h>
 #include <openssl/evp.h>
@@ -590,7 +591,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 			 unsigned char *digest, int digestlen)
 {
-	unsigned char hash[64];
+	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
 
 	if (sig[0] != 0x03) {
@@ -614,6 +615,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	    return verify_hash(file, digest, digestlen, sig + 1, siglen - 1);
 
 	hashlen = ima_calc_hash(file, hash);
+	assert(hashlen <= sizeof(hash));
 	if (hashlen <= 1)
 		return hashlen;
 
-- 
2.11.0

