Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEEC65BB0
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 03:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895B2147C
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 03:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A895B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeLCDfc (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:35:32 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54314 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeLCDfc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Dec 2018 22:35:32 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7958772CC73;
        Mon,  3 Dec 2018 06:35:26 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 332384A4A29;
        Mon,  3 Dec 2018 06:35:26 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 5/7] ima-evm-utils: Preload OpenSSL engine via '--engine' option
Date:   Mon,  3 Dec 2018 06:35:23 +0300
Message-Id: <20181203033525.20431-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181203033525.20431-1-vt@altlinux.org>
References: <20181203033525.20431-1-vt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Another method of using GOST algorithms (and cryptographic accelerators)
is via direct preloading of appropriate engine using '--engine' option.
For the gost-engine it should be '--engine gost'.

Usage example:

1. Install gost-engine appropriately. (No need to edit openssl.cnf).

2. Then GOST algorithms should work:

  # cp /dev/null a
  # evmctl -v ima_hash --engine gost -a streebog256 a
  hash: 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v1:
- Code split from prevously combined patch.
- More verbose OpenSSL error message.
Changes since v2:
- Update README.
- Add example engine name to the --help.
- Add usage example to description.

 README       |  1 +
 src/evmctl.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/README b/README
index 05cc2ff..3603ae8 100644
--- a/README
+++ b/README
@@ -58,6 +58,7 @@ OPTIONS
       --smack        use extra SMACK xattrs for EVM
       --m32          force EVM hmac/signature for 32 bit target system
       --m64          force EVM hmac/signature for 64 bit target system
+      --engine e     preload OpenSSL engine e (such as: gost)
   -v                 increase verbosity level
   -h, --help         display this help and exit
 
diff --git a/src/evmctl.c b/src/evmctl.c
index 1f6dad5..0459798 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -62,6 +62,7 @@
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
+#include <openssl/engine.h>
 
 #ifndef XATTR_APPAARMOR_SUFFIX
 #define XATTR_APPARMOR_SUFFIX "apparmor"
@@ -1680,6 +1681,7 @@ static void usage(void)
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --list         measurement list verification\n"
+		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
@@ -1732,6 +1734,7 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"list", 0, 0, 138},
+	{"engine", 1, 0, 139},
 	{"xattr-user", 0, 0, 140},
 	{}
 
@@ -1774,6 +1777,7 @@ static char *get_password(void)
 int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
+	ENGINE *eng = NULL;
 
 	g_argv = argv;
 	g_argc = argc;
@@ -1884,6 +1888,18 @@ int main(int argc, char *argv[])
 		case 138:
 			measurement_list = 1;
 			break;
+		case 139: /* --engine e */
+			eng = ENGINE_by_id(optarg);
+			if (!eng) {
+				log_err("engine %s isn't available\n", optarg);
+				ERR_print_errors_fp(stderr);
+			} else if (!ENGINE_init(eng)) {
+				log_err("engine %s init failed\n", optarg);
+				ERR_print_errors_fp(stderr);
+				ENGINE_free(eng);
+				eng = NULL;
+			}
+			break;
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
 			xattr_evm = "user.evm";
@@ -1914,6 +1930,13 @@ int main(int argc, char *argv[])
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
-- 
2.11.0

