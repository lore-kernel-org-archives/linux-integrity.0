Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:60144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIEPo5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 11:44:57 -0400
Date: Wed, 5 Sep 2018 14:14:27 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: suppress transmit cmd error logs when TPM 1.2 is
 disabled/deactivated
Message-ID: <20180905111427.GB9696@linux.intel.com>
References: <20180830144005.6768-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180830144005.6768-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Aug 30, 2018 at 04:40:05PM +0200, Javier Martinez Canillas wrote:
> For TPM 1.2 chips the system setup utility allows to set the TPM device in
> one of the following states:
> 
>   * Active: Security chip is functional
>   * Inactive: Security chip is visible, but is not functional
>   * Disabled: Security chip is hidden and is not functional
> 
> When choosing the "Inactive" state, the TPM 1.2 device is enumerated and
> registered, but sending TPM commands fail with either TPM_DEACTIVATED or
> TPM_DISABLED depending if the firmware deactivated or disabled the TPM.
> 
> Since these TPM 1.2 error codes don't have special treatment, inactivating
> the TPM leads to a very noisy kernel log buffer that shows messages like
> the following:
> 
>   tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
>   tpm tpm0: A TPM error (6) occurred attempting to read a pcr value
>   tpm tpm0: TPM is disabled/deactivated (0x6)
>   tpm tpm0: A TPM error (6) occurred attempting get random
>   tpm tpm0: A TPM error (6) occurred attempting to read a pcr value
>   ima: No TPM chip found, activating TPM-bypass! (rc=6)
>   tpm tpm0: A TPM error (6) occurred attempting get random
>   tpm tpm0: A TPM error (6) occurred attempting get random
>   tpm tpm0: A TPM error (6) occurred attempting get random
>   tpm tpm0: A TPM error (6) occurred attempting get random
> 
> Let's just suppress error log messages for the TPM_{DEACTIVATED,DISABLED}
> return codes, since this is expected when the TPM 1.2 is set to Inactive.
> 
> In that case the kernel log is cleaner and less confusing for users, i.e:
> 
>   tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
>   tpm tpm0: TPM is disabled/deactivated (0x6)
>   ima: No TPM chip found, activating TPM-bypass! (rc=6)
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> 
>  drivers/char/tpm/tpm-interface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf98..9f61106502a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -663,7 +663,8 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>  		return len;
>  
>  	err = be32_to_cpu(header->return_code);
> -	if (err != 0 && desc)
> +	if (err != 0 && err != TPM_ERR_DISABLED && err != TPM_ERR_DEACTIVATED
> +	    && desc)
>  		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
>  			desc);
>  	if (err)
> -- 
> 2.17.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
