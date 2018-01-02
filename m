Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:64414 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbeABKjx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jan 2018 05:39:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        James Morris <james.l.morris@oracle.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: remove unused variables
Date: Tue,  2 Jan 2018 11:38:54 +0100
Message-Id: <20180102103924.1035536-1-arnd@arndb.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The CLKRUN fix caused a few harmless compile-time warnings:

drivers/char/tpm/tpm_tis.c: In function 'tpm_tis_pnp_remove':
drivers/char/tpm/tpm_tis.c:274:23: error: unused variable 'priv' [-Werror=unused-variable]
drivers/char/tpm/tpm_tis.c: In function 'tpm_tis_plat_remove':
drivers/char/tpm/tpm_tis.c:324:23: error: unused variable 'priv' [-Werror=unused-variable]

This removes the variables that have now become unused.

Fixes: 6d0866cbc2d3 ("tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/tpm/tpm_tis.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index c847fc69a2fc..1bcbf355141e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -271,7 +271,6 @@ MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
@@ -321,7 +320,6 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
 static int tpm_tis_plat_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-- 
2.9.0
