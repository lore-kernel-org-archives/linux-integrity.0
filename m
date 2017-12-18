Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:64464 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937045AbdLRS1O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 13:27:14 -0500
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
From: James Ettle <james@ettle.org.uk>
Message-ID: <6b41f2a7-3b6e-69f2-fd49-d2ae774ff0f5@ettle.org.uk>
Date: Mon, 18 Dec 2017 18:26:35 +0000
MIME-Version: 1.0
In-Reply-To: <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The keyboard and touchpad work OK with the patch quoted below and the earlier two applied, i.e. the three patches with signatures:

667dcc75be864ff4c17cf58891853b7393bba3e2
db3248e8a036c39141c8f7e9f1cf5c5ae6815f76
370d45a34dc8914066a995a3a6d6df1953ea9f60

I applied these to a vanilla kernel.org 4.14.7 source using Fedora 4.14.5-300.fc27 .config. Confirmed the tpm modules are loaded.

Tests:
1. Keyboard and touchpad work OK on boot - PASS
2. Still work after suspend/resume - PASS

Let me know if you want any further tests.

Many thanks,
James.


On 18/12/17 12:29, Javier Martinez Canillas wrote:
> On 12/18/2017 01:22 PM, Javier Martinez Canillas wrote:
> 
> [snip]
> 
>>
>> James,
>>
>> Can you please test the following (untested) patch on top of the other two
>> mentioned patches to see if it makes a difference for you?
>>
> 
> I should had tried to at least compile the patch :)
> 
> Updated patch below:
> 
> From 370d45a34dc8914066a995a3a6d6df1953ea9f60 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javierm@redhat.com>
> Date: Mon, 18 Dec 2017 12:56:28 +0100
> Subject: [PATCH v2] tpm: only attempt to disable the LPC CLKRUN if is already
>  enabled
> 
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
> But it could be that the CLKRUN signal was already disabled in the LPC
> bus and so after the driver probes, the signal will remain enabled which
> may break other devices transactions since the clocks will be restarted
> by the CLKRUN# signal.
> 
> Fixes: 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e7bd2e750f69..5f2b1fc2194f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -688,7 +688,8 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>  	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
>  	u32 clkrun_val;
>  
> -	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
> +	if (!IS_ENABLED(CONFIG_X86) || !is_bsw() ||
> +	    !data->ilb_base_addr)
>  		return;
>  
>  	if (value) {
> @@ -746,7 +747,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		      const struct tpm_tis_phy_ops *phy_ops,
>  		      acpi_handle acpi_dev_handle)
>  {
> -	u32 vendor, intfcaps, intmask;
> +	u32 vendor, intfcaps, intmask, clkrun_val;
>  	u8 rid;
>  	int rc, probe;
>  	struct tpm_chip *chip;
> @@ -772,6 +773,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  					ILB_REMAP_SIZE);
>  		if (!priv->ilb_base_addr)
>  			return -ENOMEM;
> +
> +		clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
> +		/* Check if CLKRUN# is already not enabled in the LPC bus */
> +		if (!(clkrun_val & LPC_CLKRUN_EN)) {
> +			priv->flags |= TPM_TIS_CLK_ENABLE;
> +			iounmap(priv->ilb_base_addr);
> +			priv->ilb_base_addr = NULL;
> +		}
>  	}
>  
>  	if (chip->ops->clk_enable != NULL)
> @@ -868,7 +877,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	}
>  
>  	rc = tpm_chip_register(chip);
> -	if (rc && is_bsw())
> +	if (rc && is_bsw() && priv->ilb_base_addr)
>  		iounmap(priv->ilb_base_addr);
>  
>  	if (chip->ops->clk_enable != NULL)
> 
