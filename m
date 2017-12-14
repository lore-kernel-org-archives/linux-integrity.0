Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38121 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754470AbdLNT2z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 14:28:55 -0500
Received: by mail-wr0-f196.google.com with SMTP id o2so6085459wro.5
        for <linux-integrity@vger.kernel.org>; Thu, 14 Dec 2017 11:28:55 -0800 (PST)
Date: Thu, 14 Dec 2017 12:28:51 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] tpm-chip: Export TPM device to user space even
 when startup failed
Message-ID: <20171214192851.GC20833@ziepe.ca>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
 <20171214160614.11808-4-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214160614.11808-4-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 14, 2017 at 05:06:14PM +0100, Alexander Steffen wrote:
> When one of the commands during the auto_startup sequences does not return
> TPM_RC_SUCCESS, tpm_chip_register misleadingly returns ENODEV, even though
> a TPM device is definitely present.
> 
> An error response during those sequences is indeed unexpected, so to
> prevent subsequent errors, the kernel should not make use of the TPM
> device. But user space applications still might be able to communicate with
> the TPM, so they can be used to further diagnose and/or fix the problem. To
> allow this, with this patch the device is still exported to user space,
> even if a TPM error code has been received, but the kernel itself will not
> be allowed to use the device for anything.
> 
> This is not a hypothetical scenario, but there are devices in the wild that
> show this behavior. With this fix, those devices can be recovered from
> their failed state.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>  drivers/char/tpm/tpm-chip.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 9cbe1ef..c4636e1 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -384,7 +384,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
>   *
>   * Creates a character device for the TPM chip and adds sysfs attributes for
>   * the device. As the last step this function adds the chip to the list of TPM
> - * chips available for in-kernel use.
> + * chips available for in-kernel use, if the TPM startup was successful.
>   *
>   * This function should be only called after the chip initialization is
>   * complete.
> @@ -392,6 +392,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
>  int tpm_chip_register(struct tpm_chip *chip)
>  {
>  	int rc;
> +	bool startup_successful = true;
>  
>  	if (chip->ops->flags & TPM_OPS_AUTO_STARTUP) {
>  		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> @@ -401,7 +402,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>  		if (rc < 0)
>  			return rc;
>  		else if (rc > 0)
> -			return -ENODEV;
> +			startup_successful = false;
>  	}

The sysfs files probably shouldn't be created either in this case, and
the RM cdev should be disabled too.

Jsaon
