Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755452AbdLTPZo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 10:25:44 -0500
From: "Shaikh, Azhar" <azhar.shaikh@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
Date: Wed, 20 Dec 2017 15:25:42 +0000
Message-ID: <5FFFAD06ADE1CA4381B3F0F7C6AF582898874E@ORSMSX109.amr.corp.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-2-javierm@redhat.com>
In-Reply-To: <20171220113538.16099-2-javierm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>-----Original Message-----
>From: Javier Martinez Canillas [mailto:javierm@redhat.com]
>Sent: Wednesday, December 20, 2017 3:36 AM
>To: linux-kernel@vger.kernel.org
>Cc: James Ettle <james@ettle.org.uk>; Hans de Goede
><hdegoede@redhat.com>; Shaikh, Azhar <azhar.shaikh@intel.com>; Javier
>Martinez Canillas <javierm@redhat.com>; Arnd Bergmann <arnd@arndb.de>;
>Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
><peterhuewe@gmx.de>; Jason Gunthorpe <jgg@ziepe.ca>; Greg Kroah-
>Hartman <gregkh@linuxfoundation.org>; linux-integrity@vger.kernel.org
>Subject: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
>memory region
>
>The driver maps the I/O memory address to control the LPC bus CLKRUN_EN,
>but on the error path the memory is accessed by the .clk_enable handler after
>this was already unmapped. So only unmap the I/O memory region if it will
>not be used anymore.
>
>Also, the correct thing to do is to cleanup the resources in the inverse order
>that were acquired to prevent issues like these.
>

Thanks for catching this!

>Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>---
>
> drivers/char/tpm/tpm_tis_core.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.c
>b/drivers/char/tpm/tpm_tis_core.c index c2227983ed88..3455abbb2035
>100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -923,7 +923,7 @@ int tpm_tis_core_init(struct device *dev, struct
>tpm_tis_data *priv, int irq,
>
> 	rc = tpm_chip_register(chip);
> 	if (rc && is_bsw())
>-		iounmap(priv->ilb_base_addr);
>+		goto out_err;
>
> 	if (chip->ops->clk_enable != NULL)
> 		chip->ops->clk_enable(chip, false);
>@@ -931,12 +931,13 @@ int tpm_tis_core_init(struct device *dev, struct
>tpm_tis_data *priv, int irq,
> 	return rc;
> out_err:
> 	tpm_tis_remove(chip);
>-	if (is_bsw())
>-		iounmap(priv->ilb_base_addr);
>
> 	if (chip->ops->clk_enable != NULL)
> 		chip->ops->clk_enable(chip, false);
>
>+	if (is_bsw())
>+		iounmap(priv->ilb_base_addr);
>+
> 	return rc;
> }
> EXPORT_SYMBOL_GPL(tpm_tis_core_init);
>--
>2.14.3
