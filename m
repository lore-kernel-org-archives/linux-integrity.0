Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32110 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755458AbdLVSfL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:35:11 -0500
Date: Fri, 22 Dec 2017 20:35:06 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] tpm: fix access attempt to an already unmapped I/O
 memory region
Message-ID: <20171222183506.3jwv5c3v7bro7xaf@linux.intel.com>
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
> ---
> 
>  drivers/char/tpm/tpm_tis_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c2227983ed88..3455abbb2035 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -923,7 +923,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  
>  	rc = tpm_chip_register(chip);
>  	if (rc && is_bsw())
> -		iounmap(priv->ilb_base_addr);
> +		goto out_err;
>  
>  	if (chip->ops->clk_enable != NULL)
>  		chip->ops->clk_enable(chip, false);
> @@ -931,12 +931,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	return rc;
>  out_err:
>  	tpm_tis_remove(chip);
> -	if (is_bsw())
> -		iounmap(priv->ilb_base_addr);
>  
>  	if (chip->ops->clk_enable != NULL)
>  		chip->ops->clk_enable(chip, false);
>  
> +	if (is_bsw())
> +		iounmap(priv->ilb_base_addr);
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm_tis_core_init);
> -- 
> 2.14.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
