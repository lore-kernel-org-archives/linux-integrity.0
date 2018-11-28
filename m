Return-Path: <SRS0=r+VA=OH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B598C43441
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Nov 2018 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F0C2081C
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Nov 2018 20:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F0C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeK2HJZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:09:25 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50878 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2HJZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Nov 2018 02:09:25 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 636A672CC59;
        Wed, 28 Nov 2018 23:06:33 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 24A734A4A29;
        Wed, 28 Nov 2018 23:06:33 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Mikhail Efremov <sem@altlinux.org>
Subject: [PATCH v2 1/7] ima-evm-utils: Fix hash buffer overflow in verify_evm and hmac_evm
Date:   Wed, 28 Nov 2018 23:06:04 +0300
Message-Id: <20181128200610.21214-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit ae1319eeabd6 ("Remove hardcoding of SHA1 in EVM signatures")
introduces overflow of 20 byte buffer on the stack while calculating
hash. Also, invalid hash length is passed to the underlying verification
function in verify_evm. This prevents any non-SHA1 hashes from being
properly validated using evmctl.

Cc: Mikhail Efremov <sem@altlinux.org>
Fixes: ae1319eeabd6 ("Remove hardcoding of SHA1 in EVM signatures")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- Fix similar issue in hmac_evm

 src/evmctl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1b46d58..f8035da 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -55,6 +55,7 @@
 #include <keyutils.h>
 #include <ctype.h>
 #include <termios.h>
+#include <assert.h>
 
 #include <openssl/sha.h>
 #include <openssl/pem.h>
@@ -760,13 +761,15 @@ static int cmd_sign_evm(struct command *cmd)
 
 static int verify_evm(const char *file)
 {
-	unsigned char hash[20];
+	unsigned char hash[64];
 	unsigned char sig[1024];
+	int mdlen;
 	int len;
 
-	len = calc_evm_hash(file, hash);
-	if (len <= 1)
-		return len;
+	mdlen = calc_evm_hash(file, hash);
+	assert(mdlen <= sizeof(hash));
+	if (mdlen <= 1)
+		return mdlen;
 
 	len = lgetxattr(file, "security.evm", sig, sizeof(sig));
 	if (len < 0) {
@@ -779,7 +782,7 @@ static int verify_evm(const char *file)
 		return -1;
 	}
 
-	return verify_hash(file, hash, sizeof(hash), sig + 1, len - 1);
+	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
 }
 
 static int cmd_verify_evm(struct command *cmd)
@@ -1135,11 +1138,12 @@ out:
 
 static int hmac_evm(const char *file, const char *key)
 {
-	unsigned char hash[20];
+	unsigned char hash[64];
 	unsigned char sig[1024];
 	int len, err;
 
 	len = calc_evm_hmac(file, key, hash);
+	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
 
-- 
2.11.0

