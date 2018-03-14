Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeCNP5w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 11:57:52 -0400
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH v2 3/4] ima/ima_boot_aggregate: Increase MAX_EVENT_SIZE to 8k
Date: Wed, 14 Mar 2018 16:57:30 +0100
Message-Id: <20180314155731.5943-4-pvorel@suse.cz>
In-Reply-To: <20180314155731.5943-1-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This is needed as according IMA developers there are BIOS events larger
than 4k [1]. Actual size for TPM 1.2 is undefined, TPM 2.0 specifies:
"For software parsing the event log, the parser can choose an arbitrary
maximum size, but this specification recommends a maximum value for the
TCG_PCR_EVENT2.eventSize field of 1MB." [2].

So hope 8k is enough.

[1] http://lists.linux.it/pipermail/ltp/2018-January/006970.html
[2] http://lists.linux.it/pipermail/ltp/2018-January/007002.html

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index f7ae77cb1..c52cea4c9 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -30,7 +30,7 @@ char *TCID = "ima_boot_aggregate";
 #if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
 
-#define MAX_EVENT_SIZE 500
+#define MAX_EVENT_SIZE 8192
 #define EVENT_HEADER_SIZE 32
 #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
 #define NUM_PCRS 8		/*  PCR registers 0-7 in boot aggregate */
-- 
2.16.2
