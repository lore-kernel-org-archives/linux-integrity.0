Return-Path: <SRS0=j0Ek=UW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A124C43613
	for <linux-integrity@archiver.kernel.org>; Sun, 23 Jun 2019 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9A820663
	for <linux-integrity@archiver.kernel.org>; Sun, 23 Jun 2019 09:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFWJBV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 23 Jun 2019 05:01:21 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41898 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfFWJBV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:01:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9481072CC6C;
        Sun, 23 Jun 2019 12:01:18 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 71E8A4A4AEA;
        Sun, 23 Jun 2019 12:01:18 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 10/11] ima-evm-utils: Pass status codes from sign and hash functions to the callers
Date:   Sun, 23 Jun 2019 12:00:26 +0300
Message-Id: <20190623090027.11852-11-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190623090027.11852-1-vt@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move sign_hash()/ima_calc_hash()/calc_evm_hmac()/calc_evm_hash() status
checking before assert()'ing of their return values, so it can be passed
to the upper level callers. Especially useful for showing errors.

Fixes: 1d9c279279 ("Define hash and sig buffer sizes and add asserts")
Fixes: 9643544701 ("Fix hash buffer overflow in verify_evm and hmac_evm")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 354d731..4e0a831 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -514,14 +514,14 @@ static int sign_evm(const char *file, const char *key)
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
-	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len <= sizeof(hash));
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
 	if (len <= 1)
 		return len;
+	assert(len < sizeof(sig));
 
 	/* add header */
 	len++;
@@ -563,9 +563,9 @@ static int hash_ima(const char *file)
 	}
 
 	len = ima_calc_hash(file, hash + offset);
-	assert(len + offset <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len + offset <= sizeof(hash));
 
 	len += offset;
 
@@ -593,14 +593,14 @@ static int sign_ima(const char *file, const char *key)
 	int len, err;
 
 	len = ima_calc_hash(file, hash);
-	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len <= sizeof(hash));
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
 	if (len <= 1)
 		return len;
+	assert(len < sizeof(sig));
 
 	/* add header */
 	len++;
@@ -724,9 +724,9 @@ static int cmd_sign_hash(struct command *cmd)
 		hex2bin(hash, line, hashlen / 2);
 		siglen = sign_hash(params.hash_algo, hash, hashlen/2,
 				 key, NULL, sig + 1);
-		assert(siglen < sizeof(sig));
 		if (siglen <= 1)
 			return siglen;
+		assert(siglen < sizeof(sig));
 
 		fwrite(line, len, 1, stdout);
 		fprintf(stdout, " ");
@@ -778,9 +778,9 @@ static int verify_evm(const char *file)
 	int len;
 
 	mdlen = calc_evm_hash(file, hash);
-	assert(mdlen <= sizeof(hash));
 	if (mdlen <= 1)
 		return mdlen;
+	assert(mdlen <= sizeof(hash));
 
 	len = lgetxattr(file, xattr_evm, sig, sizeof(sig));
 	if (len < 0) {
@@ -1160,9 +1160,9 @@ static int hmac_evm(const char *file, const char *key)
 	int len, err;
 
 	len = calc_evm_hmac(file, key, hash);
-	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len <= sizeof(hash));
 
 	log_info("hmac: ");
 	log_dump(hash, len);
-- 
2.11.0

