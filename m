Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeI2FBJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 29 Sep 2018 01:01:09 -0400
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
Subject: [PATCH v5 14/21] tpm: tpm-interface.c drop unused macros
Date: Sat, 29 Sep 2018 01:30:28 +0300
Message-Id: <20180928223035.14471-15-tomas.winkler@intel.com>
In-Reply-To: <20180928223035.14471-1-tomas.winkler@intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
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
V5: Resend.

 drivers/char/tpm/tpm-interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index fb142e229f95..98f9a0bbeed9 100644
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
