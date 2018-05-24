Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40840 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965515AbeEXOEU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 10:04:20 -0400
From: Lars Wendler <polynomial-c@gentoo.org>
To: linux-integrity@vger.kernel.org
Cc: Lars Wendler <polynomial-c@gentoo.org>
Subject: [PATCH] ima-evm-utils: attr/xattr.h is deprecated. Use sys/xattr.h instead
Date: Thu, 24 May 2018 16:04:10 +0200
Message-Id: <20180524140410.16988-1-polynomial-c@gentoo.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

See also:
http://git.savannah.nongnu.org/cgit/attr.git/commit/?id=7921157890d07858d092f4003ca4c6bae9fd2c38
---
 configure.ac | 2 +-
 src/evmctl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0497eb7..1f017e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,7 +30,7 @@ AC_SUBST(OPENSSL_LIBS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
 
-AC_CHECK_HEADERS(attr/xattr.h, , [AC_MSG_ERROR([attr/xattr.h header not found. You need the libattr development package.])])
+AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
 
 #debug support - yes for a while
diff --git a/src/evmctl.c b/src/evmctl.c
index 2ffee78..3fbcd33 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -49,7 +49,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <dirent.h>
-#include <attr/xattr.h>
+#include <sys/xattr.h>
 #include <linux/xattr.h>
 #include <getopt.h>
 #include <keyutils.h>
-- 
2.17.0
