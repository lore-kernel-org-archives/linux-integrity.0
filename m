Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:22985 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbdIOWjV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Sep 2017 18:39:21 -0400
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, tpmdd@selhorst.net,
        ashleydlai@gmail.com, zohar@linux.vnet.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?q?H=C3=A5vard=20Skinnemoen?= <hskinnemoen@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Gertjan van Wingerde <gwingerde@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] MAINTAINERS: update TPM driver infrastructure changes
Date: Fri, 15 Sep 2017 15:38:01 -0700
Message-Id: <20170915223811.21368-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 CREDITS     |  7 +++++++
 MAINTAINERS | 13 ++-----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/CREDITS b/CREDITS
index 5d09c26d69cd..dcd761885ea8 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4130,6 +4130,13 @@ D: MD driver
 D: EISA/sysfs subsystem
 S: France
 
+N: Marcel Selhorst
+E: tpmdd@selhorst.net
+D: TPM driver
+
+N: Ashley Lai
+E: ashleydlai@gmail.com
+D: IBM VTPM driver
 
 # Don't add your name here, unless you really _are_ after Marc
 # alphabetically. Leonard used to be very proud of being the 
diff --git a/MAINTAINERS b/MAINTAINERS
index dfca9a4f1112..00f0610c3ec9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13291,23 +13291,14 @@ F:	drivers/platform/x86/toshiba-wmi.c
 
 TPM DEVICE DRIVER
 M:	Peter Huewe <peterhuewe@gmx.de>
-M:	Marcel Selhorst <tpmdd@selhorst.net>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 R:	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
-W:	http://tpmdd.sourceforge.net
-L:	tpmdd-devel@lists.sourceforge.net (moderated for non-subscribers)
-Q:	https://patchwork.kernel.org/project/tpmdd-devel/list/
+L:	linux-integrity@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
 S:	Maintained
 F:	drivers/char/tpm/
 
-TPM IBM_VTPM DEVICE DRIVER
-M:	Ashley Lai <ashleydlai@gmail.com>
-W:	http://tpmdd.sourceforge.net
-L:	tpmdd-devel@lists.sourceforge.net (moderated for non-subscribers)
-S:	Maintained
-F:	drivers/char/tpm/tpm_ibmvtpm*
-
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
-- 
2.14.1
