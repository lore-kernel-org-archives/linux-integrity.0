Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27206 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755458AbdLVScU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:32:20 -0500
Date: Fri, 22 Dec 2017 20:32:16 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/4] tpm: follow coding style for variable declaration in
 tpm_tis_core_init()
Message-ID: <20171222183216.pdwajmnxexyocxol@linux.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220113538.16099-4-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 12:35:37PM +0100, Javier Martinez Canillas wrote:
> The coding style says "use just one data declaration per line (no commas
> for multiple data declarations)" so follow this convention.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/char/tpm/tpm_tis_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 09da1e1adc40..534cd46fdfae 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -798,7 +798,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		      const struct tpm_tis_phy_ops *phy_ops,
>  		      acpi_handle acpi_dev_handle)
>  {
> -	u32 vendor, intfcaps, intmask;
> +	u32 vendor;
> +	u32 intfcaps;
> +	u32 intmask;
>  	u8 rid;
>  	int rc, probe;
>  	struct tpm_chip *chip;
> -- 
> 2.14.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
