Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbeDSTzd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Apr 2018 15:55:33 -0400
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 09/10] ima: CRYPTO_LIBS are needed only for ima_boot_aggregate
Date: Thu, 19 Apr 2018 21:55:02 +0200
Message-Id: <20180419195503.7194-10-pvorel@suse.cz>
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/src/Makefile b/testcases/kernel/security/integrity/ima/src/Makefile
index 0f4cf8c12..f7a818578 100644
--- a/testcases/kernel/security/integrity/ima/src/Makefile
+++ b/testcases/kernel/security/integrity/ima/src/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS			+= $(CRYPTO_LIBS) -ldl
+ima_boot_aggregate: LDLIBS += $(CRYPTO_LIBS) -ldl
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.16.3
