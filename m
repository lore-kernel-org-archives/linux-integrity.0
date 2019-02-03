Return-Path: <SRS0=duCA=QK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF0C169C4
	for <linux-integrity@archiver.kernel.org>; Sun,  3 Feb 2019 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D7B2083B
	for <linux-integrity@archiver.kernel.org>; Sun,  3 Feb 2019 17:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfBCRrS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:47:18 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:38416 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfBCRrS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 Feb 2019 12:47:18 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A3F9E72CC72;
        Sun,  3 Feb 2019 20:47:14 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7DF504A4A14;
        Sun,  3 Feb 2019 20:47:14 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2] ima-evm-utils: rework openssl init
Date:   Sun,  3 Feb 2019 20:47:12 +0300
Message-Id: <20190203174712.892-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove deprecated call to OpenSSL_add_all_algorithms().
Allow to disable openssl config loading via configure
`--disable-openssl-conf' option.
Finish engine initialization properly by calling ENGINE_set_default(),
as suggested by James Bottomley.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
- v1 is "ima-evm-utils: remove redundant call to OpenSSL_add_all_algorithms"
- everything is changed as suggested in mailing list, not just
  redundant OpenSSL_add_all_algorithms() call is removed.

 configure.ac    | 6 ++++++
 src/evmctl.c    | 1 +
 src/libimaevm.c | 8 ++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 60f3684..ff8ac29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,6 +39,12 @@ AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
 	    [KERNEL_HEADERS="$withval"],
 	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])
 
+AC_ARG_ENABLE([openssl_conf],
+	      [AS_HELP_STRING([--disable-openssl-conf], [disable loading of openssl config by libimaevm])],
+	      if test "$enable_openssl_conf" = "no"; then
+		AC_DEFINE(DISABLE_OPENSSL_CONF, 1, [Define to disable loading of openssl config by libimaevm.])
+	      fi)
+
 #debug support - yes for a while
 PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
 if test $pkg_cv_enable_debug = yes; then
diff --git a/src/evmctl.c b/src/evmctl.c
index 2e4d551..fa074c4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1904,6 +1904,7 @@ int main(int argc, char *argv[])
 				ENGINE_free(eng);
 				eng = NULL;
 			}
+			ENGINE_set_default(eng, ENGINE_METHOD_ALL);
 			break;
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 799eeec..db27c6f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -976,7 +976,11 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 
 static void libinit()
 {
-	OpenSSL_add_all_algorithms();
-	OPENSSL_add_all_algorithms_conf();
+	OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS |
+			    OPENSSL_INIT_ADD_ALL_DIGESTS |
+#ifndef DISABLE_OPENSSL_CONF
+			    OPENSSL_INIT_LOAD_CONFIG |
+#endif
+			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
 	ERR_load_crypto_strings();
 }
-- 
2.11.0

