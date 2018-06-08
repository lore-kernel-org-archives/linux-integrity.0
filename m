Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45414 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeFHHCX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jun 2018 03:02:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id n3-v6so18410647lfe.12
        for <linux-integrity@vger.kernel.org>; Fri, 08 Jun 2018 00:02:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] tpm_tis_spi: Pass the SPI IRQ down to the driver
Date: Fri,  8 Jun 2018 09:02:09 +0200
Message-Id: <20180608070209.14769-1-linus.walleij@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

An SPI TPM device managed directly on an embedded board using
the SPI bus and some GPIO or similar line as IRQ handler will
pass the IRQn from the TPM device associated with the SPI
device. This is already handled by the SPI core, so make sure
to pass this down to the core as well.

(The TPM core habit of using -1 to signal no IRQ is dubious
(as IRQ 0 is NO_IRQ) but I do not want to mess with that
semantic in this patch.)

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 424ff2fde1f2..9914f6973463 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -199,6 +199,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 static int tpm_tis_spi_probe(struct spi_device *dev)
 {
 	struct tpm_tis_spi_phy *phy;
+	int irq;
 
 	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
 			   GFP_KERNEL);
@@ -211,7 +212,13 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	if (!phy->iobuf)
 		return -ENOMEM;
 
-	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_spi_phy_ops,
+	/* If the SPI device has an IRQ then use that */
+	if (dev->irq > 0)
+		irq = dev->irq;
+	else
+		irq = -1;
+
+	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
 				 NULL);
 }
 
-- 
2.17.0
