Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:38797 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756029AbdLTSI5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 13:08:57 -0500
Received: by mail-it0-f65.google.com with SMTP id r6so7841216itr.3
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 10:08:57 -0800 (PST)
Date: Wed, 20 Dec 2017 11:08:55 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
Message-ID: <20171220180855.GB22908@ziepe.ca>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220113538.16099-2-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 12:35:35PM +0100, Javier Martinez Canillas wrote:
> The driver maps the I/O memory address to control the LPC bus CLKRUN_EN,
> but on the error path the memory is accessed by the .clk_enable handler
> after this was already unmapped. So only unmap the I/O memory region if
> it will not be used anymore.
> 
> Also, the correct thing to do is to cleanup the resources in the inverse
> order that were acquired to prevent issues like these.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
>  drivers/char/tpm/tpm_tis_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c2227983ed88..3455abbb2035 100644
> +++ b/drivers/char/tpm/tpm_tis_core.c

Yoiks. This patch is helping but the more I look at this the wronger
everything looks..

1) tpm_chip_unregister makes chip->ops == NULL, so this sequence:

static int tpm_tis_plat_remove(struct platform_device *pdev)
	tpm_chip_unregister(chip);
	tpm_tis_remove(chip);
void tpm_tis_remove(struct tpm_chip *chip)
	if (chip->ops->clk_enable != NULL)

Will oops

2) tpm_chip_register can also NULL ops in error cases, so this
   sequence can oops:

       rc = tpm_chip_register(chip);
       if (rc && is_bsw())
               iounmap(priv->ilb_base_addr);

        if (chip->ops->clk_enable != NULL)
                chip->ops->clk_enable(chip, false);

3) iounmap should not be split between tpm_tis and tpm_tis_core
   Put it at the end of tpm_tis_remove.

4) This sequence:

+       return tpm_chip_register(chip);
+out_err:
+       tpm_tis_remove(chip);
+       return rc;

   Doesn't look right. If tpm_chip_register fails then
   tpm_tis_remove will never be called. This was sort of OK when
   tpm_tis_remove didn't manage any resources, but now that it does
   the above needs fixing too.

The below draft fixes everything except #1. That needs a more thoughtful
idea..

Jason

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index d29add49b03388..09f18e2e644774 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -275,9 +275,6 @@ static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
-
 }
 
 static struct pnp_driver tis_pnp_driver = {
@@ -328,10 +325,6 @@ static int tpm_tis_plat_remove(struct platform_device *pdev)
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
-
 	return 0;
 }
 
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c2227983ed88d4..ffda1694a6aba3 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -727,6 +727,9 @@ void tpm_tis_remove(struct tpm_chip *chip)
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
+
+	if (priv->ilb_base_addr)
+		iounmap(priv->ilb_base_addr);
 }
 EXPORT_SYMBOL_GPL(tpm_tis_remove);
 
@@ -921,22 +924,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		}
 	}
 
-	rc = tpm_chip_register(chip);
-	if (rc && is_bsw())
-		iounmap(priv->ilb_base_addr);
-
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-	return rc;
+	rc = tpm_chip_register(chip);
+	if (rc):
+		goto out_err;
+	return 0;
 out_err:
 	tpm_tis_remove(chip);
-	if (is_bsw())
-		iounmap(priv->ilb_base_addr);
-
-	if (chip->ops->clk_enable != NULL)
-		chip->ops->clk_enable(chip, false);
-
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_core_init);
