Return-Path: <SRS0=cYyd=R2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80085C43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 02:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AC221874
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 02:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfCWCQU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:16:20 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59024 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfCWCQU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 22:16:20 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 976F872CCAC;
        Sat, 23 Mar 2019 05:16:18 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 65E544A4A16;
        Sat, 23 Mar 2019 05:16:18 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3] ima-evm-utils: Rework openssl init
Date:   Sat, 23 Mar 2019 05:16:09 +0300
Message-Id: <20190323021609.20600-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove deprecated call to OpenSSL_add_all_algorithms().
Allow to disable openssl config loading by evmctl via configure
`--disable-openssl-conf' option. Show status of that in configure.
Move config loading from libimaevm to evmctl.
Finish engine initialization properly by calling ENGINE_set_default(),
as suggested by James Bottomley.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changes since v2:
- Display `--disable-openssl-conf` status under "Give some feedback".
- Move config load from libimaevm to evmctl.

 configure.ac    | 10 ++++++++--
 src/evmctl.c    |  6 ++++++
 src/libimaevm.c |  4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 60f3684..10d1d88 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,6 +39,12 @@ AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
 	    [KERNEL_HEADERS="$withval"],
 	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])
 
+AC_ARG_ENABLE([openssl_conf],
+	      [AS_HELP_STRING([--disable-openssl-conf], [disable loading of openssl config by evmctl])],
+	      [if test "$enable_openssl_conf" = "no"; then
+		AC_DEFINE(DISABLE_OPENSSL_CONF, 1, [Define to disable loading of openssl config by evmctl.])
+	      fi], [enable_openssl_conf=yes])
+
 #debug support - yes for a while
 PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
 if test $pkg_cv_enable_debug = yes; then
@@ -65,6 +71,6 @@ AC_OUTPUT
 echo
 echo
 echo	"Configuration:"
-echo	"	debug:	$pkg_cv_enable_debug"
+echo	"          debug: $pkg_cv_enable_debug"
+echo	"   openssl-conf: $enable_openssl_conf"
 echo
-
diff --git a/src/evmctl.c b/src/evmctl.c
index 0459798..15a7226 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1779,6 +1779,11 @@ int main(int argc, char *argv[])
 	int err = 0, c, lind;
 	ENGINE *eng = NULL;
 
+	OPENSSL_init_crypto(
+#ifndef DISABLE_OPENSSL_CONF
+			    OPENSSL_INIT_LOAD_CONFIG |
+#endif
+			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
 	g_argv = argv;
 	g_argc = argc;
 
@@ -1899,6 +1904,7 @@ int main(int argc, char *argv[])
 				ENGINE_free(eng);
 				eng = NULL;
 			}
+			ENGINE_set_default(eng, ENGINE_METHOD_ALL);
 			break;
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6783110..3a9ab63 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -937,7 +937,7 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 
 static void libinit()
 {
-	OpenSSL_add_all_algorithms();
-	OPENSSL_add_all_algorithms_conf();
+	OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS |
+			    OPENSSL_INIT_ADD_ALL_DIGESTS, NULL);
 	ERR_load_crypto_strings();
 }
-- 
2.11.0

