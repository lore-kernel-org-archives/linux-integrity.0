Return-Path: <SRS0=ex1J=OF=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89742C04EB8
	for <linux-integrity@archiver.kernel.org>; Mon, 26 Nov 2018 04:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A95F20855
	for <linux-integrity@archiver.kernel.org>; Mon, 26 Nov 2018 04:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A95F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeKZPdC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:33:02 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52166 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZPdC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Nov 2018 10:33:02 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 88EDC72CC6C;
        Mon, 26 Nov 2018 07:40:07 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 0941E4A4A29;
        Mon, 26 Nov 2018 07:40:07 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 2/3] ima-evm-utils: Add --xattr-user option for testing
Date:   Mon, 26 Nov 2018 07:39:52 +0300
Message-Id: <20181126043953.1126-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181126043953.1126-1-vt@altlinux.org>
References: <20181126043953.1126-1-vt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keep ima/evm attributes in user namespace instead of security namespace.
Would be useful for testing purposes without having root privileges,
easier to understand, and because --sigfile does not work for evm
signatures.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    | 32 ++++++++++++++++++++------------
 src/libimaevm.c |  2 +-
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 94d7ab1..032ea9d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -145,6 +145,9 @@ static int find(const char *path, int dts, find_cb_t func);
 struct command cmds[];
 static void print_usage(struct command *cmd);
 
+static const char *xattr_ima = "security.ima";
+static const char *xattr_evm = "security.evm";
+
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
 	FILE *fp;
@@ -531,7 +534,7 @@ static int sign_evm(const char *file, const char *key)
 		dump(sig, len);
 
 	if (xattr) {
-		err = lsetxattr(file, "security.evm", sig, len, 0);
+		err = lsetxattr(file, xattr_evm, sig, len, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
 			return err;
@@ -569,7 +572,7 @@ static int hash_ima(const char *file)
 		dump(hash, len);
 
 	if (xattr) {
-		err = lsetxattr(file, "security.ima", hash, len, 0);
+		err = lsetxattr(file, xattr_ima, hash, len, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
 			return err;
@@ -604,7 +607,7 @@ static int sign_ima(const char *file, const char *key)
 		bin2file(file, "sig", sig, len);
 
 	if (xattr) {
-		err = lsetxattr(file, "security.ima", sig, len, 0);
+		err = lsetxattr(file, xattr_ima, sig, len, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
 			return err;
@@ -771,14 +774,14 @@ static int verify_evm(const char *file)
 	if (mdlen <= 1)
 		return mdlen;
 
-	len = lgetxattr(file, "security.evm", sig, sizeof(sig));
+	len = lgetxattr(file, xattr_evm, sig, sizeof(sig));
 	if (len < 0) {
 		log_err("getxattr failed: %s\n", file);
 		return len;
 	}
 
 	if (sig[0] != 0x03) {
-		log_err("security.evm has no signature\n");
+		log_err("%s has no signature\n", xattr_evm);
 		return -1;
 	}
 
@@ -813,7 +816,7 @@ static int verify_ima(const char *file)
 		memcpy(sig, tmp, len);
 		free(tmp);
 	} else {
-		len = lgetxattr(file, "security.ima", sig, sizeof(sig));
+		len = lgetxattr(file, xattr_ima, sig, sizeof(sig));
 		if (len < 0) {
 			log_err("getxattr failed: %s\n", file);
 			return len;
@@ -956,7 +959,7 @@ static int setxattr_ima(const char *file, char *sig_file)
 	if (!sig)
 		return 0;
 
-	err = lsetxattr(file, "security.ima", sig, len, 0);
+	err = lsetxattr(file, xattr_ima, sig, len, 0);
 	if (err < 0)
 		log_err("setxattr failed: %s\n", file);
 	free(sig);
@@ -1152,7 +1155,7 @@ static int hmac_evm(const char *file, const char *key)
 
 	if (xattr) {
 		sig[0] = EVM_XATTR_HMAC;
-		err = lsetxattr(file, "security.evm", sig, len + 1, 0);
+		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
 			return err;
@@ -1208,9 +1211,9 @@ static int ima_fix(const char *path)
 		}
 		for (; size > 0; len++, size -= len, list += len) {
 			len = strlen(list);
-			if (!strcmp(list, "security.ima"))
+			if (!strcmp(list, xattr_ima))
 				ima = 1;
-			else if (!strcmp(list, "security.evm"))
+			else if (!strcmp(list, xattr_evm))
 				evm = 1;
 		}
 		if (ima && evm)
@@ -1287,8 +1290,8 @@ static int cmd_ima_fix(struct command *cmd)
 static int ima_clear(const char *path)
 {
 	log_info("%s\n", path);
-	lremovexattr(path, "security.ima");
-	lremovexattr(path, "security.evm");
+	lremovexattr(path, xattr_ima);
+	lremovexattr(path, xattr_evm);
 
 	return 0;
 }
@@ -1718,6 +1721,7 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"list", 0, 0, 138},
+	{"xattr-user", 0, 0, 140},
 	{}
 
 };
@@ -1869,6 +1873,10 @@ int main(int argc, char *argv[])
 		case 138:
 			measurement_list = 1;
 			break;
+		case 140: /* --xattr-user */
+			xattr_ima = "user.ima";
+			xattr_evm = "user.evm";
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6fa0ed4..714f1ac 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -594,7 +594,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	int hashlen, sig_hash_algo;
 
 	if (sig[0] != 0x03) {
-		log_err("security.ima has no signature\n");
+		log_err("xattr ima has no signature\n");
 		return -1;
 	}
 
-- 
2.11.0

