Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:4116 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeJQOo6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Oct 2018 10:44:58 -0400
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v6 13/20] tpm: tpm-interface.c drop unused macros
Date: Wed, 17 Oct 2018 09:46:06 +0300
Message-Id: <20181017064613.19746-14-tomas.winkler@intel.com>
In-Reply-To: <20181017064613.19746-1-tomas.winkler@intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The commit:
"tpm_tis: further simplify calculation of ordinal duration"
left unused macros, we can drop them now.

Fixes compilation warnings:
tpm-interface.c:37:0: warning: macro "TPM_PROTECTED_COMMAND" is not used [-Wunused-macros]
tpm-interface.c:36:0: warning: macro "TSC_MAX_ORDINAL" is not used [-Wunused-macros]
tpm-interface.c:38:0: warning: macro "TPM_CONNECTION_COMMAND" is not used [-Wunused-macros]


Fixes: f72864300139 ("tpm_tis: further simplify calculation of ordinal duration")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
V3: New in the series.
V4: Fix the commit message.
V5-V6: Rebase

 drivers/char/tpm/tpm-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 69e007a198ce..ba50554e34d3 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -33,10 +33,6 @@
 
 #include "tpm.h"
 
-#define TSC_MAX_ORDINAL 12
-#define TPM_PROTECTED_COMMAND 0x00
-#define TPM_CONNECTION_COMMAND 0x40
-
 /*
  * Bug workaround - some TPM's don't flush the most
  * recently changed pcr on suspend, so force the flush
-- 
2.14.4
