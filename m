Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yw0-f201.google.com ([209.85.161.201]:48062 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeDQW4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Apr 2018 18:56:11 -0400
Received: by mail-yw0-f201.google.com with SMTP id i204so13455907ywb.14
        for <linux-integrity@vger.kernel.org>; Tue, 17 Apr 2018 15:56:11 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Apr 2018 15:56:00 -0700
Message-Id: <20180417225601.6965-1-mjg59@google.com>
Subject: [USER] [PATCH 1/2] Remove hardcoding of SHA1 in EVM signatures
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

EVM signatures are always being generated with SHA1 even if the -a
argument has been provided to evmctl. Fix this so the provided hash
algorithm is used instead.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 src/evmctl.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 2ffee78..43d261f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -313,6 +313,7 @@ err:
 
 static int calc_evm_hash(const char *file, unsigned char *hash)
 {
+        const EVP_MD *md;
 	struct stat st;
 	int err;
 	uint32_t generation = 0;
@@ -374,7 +375,13 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		return -1;
 	}
 
-	err = EVP_DigestInit(pctx, EVP_sha1());
+	md = EVP_get_digestbyname(params.hash_algo);
+	if (!md) {
+		log_err("EVP_get_digestbyname() failed\n");
+		return 1;
+	}
+
+	err = EVP_DigestInit(pctx, md);
 	if (!err) {
 		log_err("EVP_DigestInit() failed\n");
 		return 1;
@@ -498,7 +505,7 @@ static int sign_evm(const char *file, const char *key)
 	if (len <= 1)
 		return len;
 
-	len = sign_hash("sha1", hash, len, key, NULL, sig + 1);
+	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
 	if (len <= 1)
 		return len;
 
@@ -967,6 +974,7 @@ static int cmd_setxattr_ima(struct command *cmd)
 
 static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
 {
+        const EVP_MD *md;
 	struct stat st;
 	int err = -1;
 	uint32_t generation = 0;
@@ -1033,7 +1041,13 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		goto out;
 	}
 
-	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), EVP_sha1(), NULL);
+	md = EVP_get_digestbyname(params.hash_algo);
+	if (!md) {
+		log_err("EVP_get_digestbyname() failed\n");
+		goto out;
+	}
+
+	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
 	if (err) {
 		log_err("HMAC_Init() failed\n");
 		goto out;
-- 
2.17.0.484.g0c8726318c-goog
