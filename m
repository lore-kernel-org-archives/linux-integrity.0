Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:39682 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbdLHSrp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:47:45 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 2/9] tpm_tis_core: access single TIS registers before doing complex transfers
Date: Fri, 8 Dec 2017 19:46:51 +0100
Message-ID: <20171208184658.9588-3-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

There are several TIS registers that contain information on how exactly the
TPM implements the TIS protocol. Complex commands that are used by the
probe functions should only be sent to the TPM after all other registers
have been read and the driver is properly configured to handle those
transactions.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index ca6b2b5..d367016 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -781,10 +781,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
 
-	rc = tpm2_probe(chip);
-	if (rc)
-		goto out_err;
-
 	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
 	if (rc < 0)
 		goto out_err;
@@ -795,16 +791,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (rc < 0)
 		goto out_err;
 
-	dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
-		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
-		 vendor >> 16, rid);
-
-	probe = probe_itpm(chip);
-	if (probe < 0) {
-		rc = -ENODEV;
-		goto out_err;
-	}
-
 	/* Figure out the capabilities */
 	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
 	if (rc < 0)
@@ -831,6 +817,20 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
 		dev_dbg(dev, "\tData Avail Int Support\n");
 
+	rc = tpm2_probe(chip);
+	if (rc)
+		goto out_err;
+
+	dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
+		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
+		 vendor >> 16, rid);
+
+	probe = probe_itpm(chip);
+	if (probe < 0) {
+		rc = -ENODEV;
+		goto out_err;
+	}
+
 	/* INTERRUPT Setup */
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
-- 
2.7.4
