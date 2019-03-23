Return-Path: <SRS0=cYyd=R2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9353BC43381
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67454218E2
	for <linux-integrity@archiver.kernel.org>; Sat, 23 Mar 2019 01:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCWBmM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:42:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58166 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfCWBmM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Mar 2019 21:42:12 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5025672CCAC;
        Sat, 23 Mar 2019 04:42:08 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 094FC4A4A16;
        Sat, 23 Mar 2019 04:42:08 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/2] ima-evm-utils: Extract digest algorithms from hash_info.h
Date:   Sat, 23 Mar 2019 04:41:51 +0300
Message-Id: <20190323014152.14701-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190323014152.14701-1-vt@altlinux.org>
References: <20190323014152.14701-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If configured with "--with-kernel-headers=PATH" try to extract hash
algorithms from "hash_info.h" from the kernel source tree or
kernel-headers package located in the specified path. (Otherwise, it
will be tried to get from the installed kernel.)

This also introduces two algorithm lists, one is built-in and another is
from the kernel source. (They should never contain conflicting algorithm
IDs by their append-only nature.) If the digest is not found in the
built-in list it will be searched in the list from kernel's
"hash_info.h".

This patch will allow evmctl to be just recompiled to work with digest
algorithms introduced in the newer kernels.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 configure.ac      |  6 ++++++
 src/Makefile.am   |  6 ++++++
 src/hash_info.gen | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/libimaevm.c   | 23 ++++++++++++++++++++++-
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100755 src/hash_info.gen

diff --git a/configure.ac b/configure.ac
index a5b4288..60f3684 100644
--- a/configure.ac
+++ b/configure.ac
@@ -27,12 +27,18 @@ AC_HEADER_STDC
 PKG_CHECK_MODULES(OPENSSL, [ openssl >= 0.9.8 ])
 AC_SUBST(OPENSSL_CFLAGS)
 AC_SUBST(OPENSSL_LIBS)
+AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
 
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
 
+AC_ARG_WITH(kernel_headers, [AS_HELP_STRING([--with-kernel-headers=PATH],
+	    [specifies the Linux kernel-headers package location or kernel root directory you want to use])],
+	    [KERNEL_HEADERS="$withval"],
+	    [KERNEL_HEADERS=/lib/modules/$(uname -r)/source])
+
 #debug support - yes for a while
 PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
 if test $pkg_cv_enable_debug = yes; then
diff --git a/src/Makefile.am b/src/Makefile.am
index deb18fb..d74fc6f 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -9,6 +9,11 @@ libimaevm_la_LIBADD =  $(OPENSSL_LIBS)
 
 include_HEADERS = imaevm.h
 
+nodist_libimaevm_la_SOURCES = hash_info.h
+BUILT_SOURCES = hash_info.h
+hash_info.h: Makefile
+	./hash_info.gen $(KERNEL_HEADERS) >$@
+
 bin_PROGRAMS = evmctl
 
 evmctl_SOURCES = evmctl.c
@@ -18,5 +23,6 @@ evmctl_LDADD =  $(OPENSSL_LIBS) -lkeyutils libimaevm.la
 
 INCLUDES = -I$(top_srcdir) -include config.h
 
+CLEANFILES = hash_info.h
 DISTCLEANFILES = @DISTCLEANFILES@
 
diff --git a/src/hash_info.gen b/src/hash_info.gen
new file mode 100755
index 0000000..54532ca
--- /dev/null
+++ b/src/hash_info.gen
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Generate hash_info.h from kernel headers
+#
+# Copyright (C) 2018 <vt@altlinux.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+KERNEL_HEADERS=$1
+HASH_INFO_H=uapi/linux/hash_info.h
+HASH_INFO=$KERNEL_HEADERS/include/$HASH_INFO_H
+
+# Allow to specify kernel-headers past include/
+if [ ! -e $HASH_INFO ]; then
+  HASH_INFO2=$KERNEL_HEADERS/$HASH_INFO_H
+  if [ -e $HASH_INFO2 ]; then
+    HASH_INFO=$HASH_INFO2
+  fi
+fi
+
+if [ ! -e $HASH_INFO ]; then
+  echo "/* $HASH_INFO is not found */"
+  HASH_INFO=/dev/null
+else
+  echo "/* $HASH_INFO is found */"
+fi
+
+echo "enum hash_algo {"
+grep HASH_ALGO_.*, $HASH_INFO
+printf "\tHASH_ALGO__LAST\n"
+echo "};"
+
+echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
+sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
+  while read a b; do
+    # Normalize text hash name: if it contains underscore between
+    # digits replace it with a dash, other underscores are removed.
+    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
+    printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
+  done
+echo "};"
diff --git a/src/libimaevm.c b/src/libimaevm.c
index ca77532..bc7be1e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -50,6 +50,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <assert.h>
+#include <ctype.h>
 
 #include <openssl/crypto.h>
 #include <openssl/pem.h>
@@ -58,6 +59,7 @@
 #include <openssl/err.h>
 
 #include "imaevm.h"
+#include "hash_info.h"
 
 const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_MD4]		= "md4",
@@ -153,6 +155,17 @@ void dump(const void *ptr, int len)
 	do_dump(stdout, ptr, len, true);
 }
 
+const char *get_hash_algo_by_id(int algo)
+{
+	if (algo < PKEY_HASH__LAST)
+		return pkey_hash_algo[algo];
+	if (algo < HASH_ALGO__LAST)
+		return hash_algo_name[algo];
+
+	log_err("digest %d not found\n", algo);
+	return "unknown";
+}
+
 int get_filesize(const char *filename)
 {
 	struct stat stats;
@@ -532,11 +545,19 @@ int get_hash_algo(const char *algo)
 {
 	int i;
 
+	/* first iterate over builtin algorithms */
 	for (i = 0; i < PKEY_HASH__LAST; i++)
 		if (pkey_hash_algo[i] &&
 		    !strcmp(algo, pkey_hash_algo[i]))
 			return i;
 
+	/* iterate over algorithms provided by kernel-headers */
+	for (i = 0; i < HASH_ALGO__LAST; i++)
+		if (hash_algo_name[i] &&
+		    !strcmp(algo, hash_algo_name[i]))
+			return i;
+
+	log_info("digest %s not found, fall back to sha1\n", algo);
 	return PKEY_HASH_SHA1;
 }
 
@@ -611,7 +632,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 		return -1;
 	}
 	/* Use hash algorithm as retrieved from signature */
-	params.hash_algo = pkey_hash_algo[sig_hash_algo];
+	params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
 
 	/*
 	 * Validate the signature based on the digest included in the
-- 
2.11.0

