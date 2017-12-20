Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41907 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754875AbdLTLfs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 06:35:48 -0500
Received: by mail-wr0-f196.google.com with SMTP id p69so13170995wrb.8
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 03:35:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O memory region
Date: Wed, 20 Dec 2017 12:35:35 +0100
Message-Id: <20171220113538.16099-2-javierm@redhat.com>
In-Reply-To: <20171220113538.16099-1-javierm@redhat.com>
References: <20171220113538.16099-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The driver maps the I/O memory address to control the LPC bus CLKRUN_EN,
but on the error path the memory is accessed by the .clk_enable handler
after this was already unmapped. So only unmap the I/O memory region if
it will not be used anymore.

Also, the correct thing to do is to cleanup the resources in the inverse
order that were acquired to prevent issues like these.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/char/tpm/tpm_tis_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c2227983ed88..3455abbb2035 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -923,7 +923,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	rc = tpm_chip_register(chip);
 	if (rc && is_bsw())
-		iounmap(priv->ilb_base_addr);
+		goto out_err;
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
@@ -931,12 +931,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	return rc;
 out_err:
 	tpm_tis_remove(chip);
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
+	if (is_bsw())
+		iounmap(priv->ilb_base_addr);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_core_init);
-- 
2.14.3
