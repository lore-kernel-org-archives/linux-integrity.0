Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:19571 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdLHSvA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:51:00 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 5/9] tpm_tis_core: use XDATA_FIFO for transfers if available
Date: Fri, 8 Dec 2017 19:46:54 +0100
Message-ID: <20171208184658.9588-6-Alexander.Steffen@infineon.com>
In-Reply-To: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The TPM indicates in DataTransferSizeSupport in TPM_INTF_CAPABILITY what
the maximum supported transfer size is. Transfers larger than four bytes
are only supported for the XDATA_FIFO, not the legacy DATA_FIFO. Therefore,
always use the XDATA_FIFO when the TPM indicates support for non-legacy
transfer sizes for maximum throughput.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 24 ++++++++++++++++++++++--
 drivers/char/tpm/tpm_tis_core.h |  4 ++++
 drivers/char/tpm/tpm_tis_spi.c  |  2 +-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1359c52..7240ee4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -255,7 +255,8 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 		}
 		burstcnt = min_t(int, burstcnt, count - size);
 
-		rc = tpm_tis_read_bytes(priv, TPM_DATA_FIFO(priv->locality),
+		rc = tpm_tis_read_bytes(priv, ADD_LOCALITY(priv->fifo_address,
+							   priv->locality),
 					burstcnt, buf + size);
 		if (rc < 0)
 			return rc;
@@ -340,7 +341,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 			goto out_err;
 		}
 		burstcnt = min_t(int, burstcnt, len - count);
-		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
+		rc = tpm_tis_write_bytes(priv, ADD_LOCALITY(priv->fifo_address,
+							    priv->locality),
 					 burstcnt, buf + count);
 		if (rc < 0)
 			goto out_err;
@@ -742,6 +744,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
 	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
 	priv->phy_ops = phy_ops;
+	priv->max_transfer_size = 4;
 	dev_set_drvdata(&chip->dev, priv);
 
 	if (wait_startup(chip, 0) != 0) {
@@ -794,6 +797,23 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		dev_dbg(dev, "\tSts Valid Int Support\n");
 	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
 		dev_dbg(dev, "\tData Avail Int Support\n");
+	switch ((intfcaps >> 9) & 3) {
+		case 0:
+			priv->fifo_address = TPM_DATA_FIFO(0);
+			break;
+		case 1:
+			priv->fifo_address = TPM_XDATA_FIFO(0);
+			priv->max_transfer_size = 8;
+			break;
+		case 2:
+			priv->fifo_address = TPM_XDATA_FIFO(0);
+			priv->max_transfer_size = 32;
+			break;
+		case 3:
+			priv->fifo_address = TPM_XDATA_FIFO(0);
+			priv->max_transfer_size = 64;
+			break;
+	}
 
 	rc = tpm2_probe(chip);
 	if (rc)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 357df13..b7df6ee 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -67,6 +67,7 @@ enum tis_defaults {
 #define TIS_TIMEOUT_C_MAX	max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
 #define TIS_TIMEOUT_D_MAX	max(TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
 
+#define ADD_LOCALITY(r, l)		((r) | ((l) << 12))
 #define TPM_ACCESS(l)			(0x0000 | ((l) << 12))
 #define TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
 #define TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
@@ -75,6 +76,7 @@ enum tis_defaults {
 #define TPM_STS(l)			(0x0018 | ((l) << 12))
 #define TPM_STS3(l)			(0x001b | ((l) << 12))
 #define TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
+#define TPM_XDATA_FIFO(l)		(0x0080 | ((l) << 12))
 
 #define TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
 #define TPM_RID(l)			(0x0F04 | ((l) << 12))
@@ -86,6 +88,8 @@ enum tpm_tis_flags {
 struct tpm_tis_data {
 	u16 manufacturer_id;
 	int locality;
+	u8 fifo_address;
+	u8 max_transfer_size;
 	int irq;
 	bool irq_tested;
 	unsigned int flags;
diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 424ff2f..c4f511b 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -67,7 +67,7 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 	spi_bus_lock(phy->spi_device->master);
 
 	while (len) {
-		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
+		transfer_len = min_t(u16, len, data->max_transfer_size);
 
 		phy->iobuf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
 		phy->iobuf[1] = 0xd4;
-- 
2.7.4
