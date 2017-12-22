Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45617 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756150AbdLVSgT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 13:36:19 -0500
Date: Fri, 22 Dec 2017 20:36:15 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 4/4] tpm: only attempt to disable the LPC CLKRUN if is
 already enabled
Message-ID: <20171222183615.ovfvf6jszsaontos@linux.intel.com>
References: <20171220113538.16099-1-javierm@redhat.com>
 <20171220113538.16099-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220113538.16099-5-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Dec 20, 2017 at 12:35:38PM +0100, Javier Martinez Canillas wrote:
> Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
> added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
> signal during TPM transactions.
> 
> Unfortunately this breaks other devices that are attached to the LPC bus
> like for example PS/2 mouse and keyboards.
> 
> One flaw with the logic is that it assumes that the CLKRUN is always
> enabled, and so it unconditionally enables it after a TPM transaction.
> 
> But it could be that the CLKRUN# signal was already disabled in the LPC
> bus and so after the driver probes, CLKRUN_EN will remain enabled which
> may break other devices that are attached to the LPC bus but don't have
> support for the CLKRUN protocol.
> 
> Fixes: 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: James Ettle <james@ettle.org.uk>
> 
> ---
> 
> This patch fixes the bug reported for the Fedora kernel [0] and the kernel
> bugzilla [1]. The issue and the propossed solution were discussed in this
> [2] thread.
> 
> [0]: https://bugzilla.redhat.com/show_bug.cgi?id=1498987
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=197287
> [2]: https://patchwork.kernel.org/patch/10119417/
> 
> 
>  drivers/char/tpm/tpm_tis.c      |  2 +-
>  drivers/char/tpm/tpm_tis_core.c | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index d0ad9a89b02b..c79193f6d092 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -314,7 +314,7 @@ static int tpm_tis_plat_remove(struct platform_device *pdev)
>  	tpm_chip_unregister(chip);
>  	tpm_tis_remove(chip);
>  
> -	if (is_bsw())
> +	if (is_bsw() && priv->ilb_base_addr)
>  		iounmap(priv->ilb_base_addr);
>  
>  	return 0;
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 534cd46fdfae..17fb9c600d0e 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -742,7 +742,8 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>  	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
>  	u32 clkrun_val;
>  
> -	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
> +	if (!IS_ENABLED(CONFIG_X86) || !is_bsw() ||
> +	    !data->ilb_base_addr)
>  		return;
>  
>  	if (value) {
> @@ -801,6 +802,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	u32 vendor;
>  	u32 intfcaps;
>  	u32 intmask;
> +	u32 clkrun_val;
>  	u8 rid;
>  	int rc, probe;
>  	struct tpm_chip *chip;
> @@ -826,6 +828,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  					ILB_REMAP_SIZE);
>  		if (!priv->ilb_base_addr)
>  			return -ENOMEM;
> +
> +		clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
> +		/* Check if CLKRUN# is already not enabled in the LPC bus */
> +		if (!(clkrun_val & LPC_CLKRUN_EN)) {
> +			iounmap(priv->ilb_base_addr);
> +			priv->ilb_base_addr = NULL;
> +		}
>  	}
>  
>  	if (chip->ops->clk_enable != NULL)
> @@ -935,7 +944,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	if (chip->ops->clk_enable != NULL)
>  		chip->ops->clk_enable(chip, false);
>  
> -	if (is_bsw())
> +	if (is_bsw() && priv->ilb_base_addr)
>  		iounmap(priv->ilb_base_addr);
>  
>  	return rc;
> -- 
> 2.14.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
