Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:33387 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdLHSr1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:47:27 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 1/9] tpm_tis_core: clean up whitespace
Date: Fri, 8 Dec 2017 19:46:50 +0100
Message-ID: <20171208184658.9588-2-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Replace tabs with spaces where those are commonly used.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6bbac31..357df13 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -67,17 +67,17 @@ enum tis_defaults {
 #define TIS_TIMEOUT_C_MAX	max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
 #define TIS_TIMEOUT_D_MAX	max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
 
-#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
-#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
-#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
-#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
-#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
-#define	TPM_STS(l)			(0x0018 | ((l) << 12))
-#define	TPM_STS3(l)			(0x001b | ((l) << 12))
-#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
-
-#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
-#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
+#define TPM_ACCESS(l)			(0x0000 | ((l) << 12))
+#define TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
+#define TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
+#define TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
+#define TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
+#define TPM_STS(l)			(0x0018 | ((l) << 12))
+#define TPM_STS3(l)			(0x001b | ((l) << 12))
+#define TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
+
+#define TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
+#define TPM_RID(l)			(0x0F04 | ((l) << 12))
 
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
-- 
2.7.4
