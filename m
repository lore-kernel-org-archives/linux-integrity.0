Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63032 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753443AbdLOMDU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 07:03:20 -0500
Date: Fri, 15 Dec 2017 14:03:03 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm: remove type and name fields from the I2C Infineon
 OF table entries
Message-ID: <20171215120303.v3jh6g43lgktaykp@linux.intel.com>
References: <20171204173916.4874-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171204173916.4874-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi

Some basic questions about DT, which I'm not expert of.

On Mon, Dec 04, 2017 at 06:39:16PM +0100, Javier Martinez Canillas wrote:
> The commit 21dc02eab989 ("tpm/tpm_i2c_infineon.c: Add OF attributes type
> and name to the of_device_id table entries") added type and name fields
> to the OF device ID table entries for the I2C Infineon TPM driver.
> 
> The only justification for the change in the commit message is that it's
> probably a good idea to have these fields populated in the OF entries.
> 
> But I don't think that's true. In fact, I believe that's not correct to
> add these fields for the following reasons:
> 
>  * The struct of_device_id .type field matches the device_type property
>    in the Device Tree nodes. The ePAPR document says that new use of the
>    property is deprecated and should only be included in cpu and memory
>    nodes for compatibility with the IEEE 1275-derived Device Trees.
>    Also, mainline Device Tree source files don't include this property
>    in the TPM nodes defined.
> 
>  * The struct of_device_id .name field matches the Device Tree node name
>    but the ePAPR document says that the node name should be generic and
>    reflect the function of the device, not it's programming model. So in
>    the case of TPM chips, it should just be "tpm" but the name fields are
>    set in the OF table entries to the actual device model (i.e: slb9645tt).

So why the name field is not changed to "tpm"?

> Now, from a practical point of view this means that the OF module aliases
> for the supported devices include the name and type of the device entries:
> 
> $ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
> alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645ttC*
> alias:          of:Nslb9645ttTtpm*Cinfineon,slb9645tt
> alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635ttC*
> alias:          of:Nslb9635ttTtpm*Cinfineon,slb9635tt
> alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineonC*
> alias:          of:Ntpm_i2c_infineonTtpm*Cinfineon,tpm_i2c_infineon
> 
> But since the device_type isn't set in the tpm DT nodes and the node name
> is a generic one, the reported MODALIAS when a device is registered via OF
> won't match the driver's module aliases:
> 
> $ cat /sys/class/tpm/tpm0/device/modalias
> of:NtpmT<NULL>Cinfineon,slb9645tt
> 
> So remove these fields from the OF entries to allow the module aliases to
> match the MODALIAS reported by the kernel when the device is registered:
> 
> $ modinfo drivers/char/tpm/tpm_i2c_infineon.ko | grep alias
> alias:          of:N*T*Cinfineon,slb9645ttC*
> alias:          of:N*T*Cinfineon,slb9645tt
> alias:          of:N*T*Cinfineon,slb9635ttC*
> alias:          of:N*T*Cinfineon,slb9635tt
> alias:          of:N*T*Cinfineon,tpm_i2c_infineonC*
> alias:          of:N*T*Cinfineon,tpm_i2c_infineon
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/char/tpm/tpm_i2c_infineon.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index 79d6bbb58e39..005c38879b2e 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -675,24 +675,9 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_table);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id tpm_tis_i2c_of_match[] = {
> -	{
> -		.name = "tpm_i2c_infineon",
> -		.type = "tpm",
> -		.compatible = "infineon,tpm_i2c_infineon",
> -		.data = (void *)0
> -	},
> -	{
> -		.name = "slb9635tt",
> -		.type = "tpm",
> -		.compatible = "infineon,slb9635tt",
> -		.data = (void *)0
> -	},
> -	{
> -		.name = "slb9645tt",
> -		.type = "tpm",
> -		.compatible = "infineon,slb9645tt",
> -		.data = (void *)1
> -	},
> +	{ .compatible = "infineon,tpm_i2c_infineon", .data = (void *)0 },
> +	{ .compatible = "infineon,slb9635tt", .data = (void *)0 },
> +	{ .compatible = "infineon,slb9645tt", .data = (void *)1 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, tpm_tis_i2c_of_match);
> -- 
> 2.14.3
> 

What does the "data" field mean?

/Jarkko
