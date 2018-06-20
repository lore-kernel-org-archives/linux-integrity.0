Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36914 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeFTSi4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 14:38:56 -0400
Received: by mail-pg0-f66.google.com with SMTP id r21-v6so212627pgv.4
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 11:38:56 -0700 (PDT)
Date: Wed, 20 Jun 2018 12:38:54 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] tpm: Introduce a kref for the tpm_chip
Message-ID: <20180620183854.GC27445@ziepe.ca>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
 <20180620161948.1464255-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620161948.1464255-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 20, 2018 at 12:19:43PM -0400, Stefan Berger wrote:
> Introduce a kref for the tpm_chip that we initialize when the tpm_chip has
> been allocated and release before the tpm_chip is to be freed.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c | 24 +++++++++++++++++++-----
>  drivers/char/tpm/tpm.h      |  1 +
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..a933676194a4 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -119,8 +119,24 @@ struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
>  	return res;
>  }
>  
> +static void tpm_chip_free(struct kref *kref)
> +{
> +	struct tpm_chip *chip = container_of(kref, struct tpm_chip, kref);
> +
> +	kfree(chip->log.bios_event_log);
> +	kfree(chip->work_space.context_buf);
> +	kfree(chip->work_space.session_buf);
> +	kfree(chip);
> +}
> +
> +static void tpm_chip_put(struct tpm_chip *chip)
> +{
> +	if (chip)
> +		kref_put(&chip->kref, tpm_chip_free);
> +}
> +
>  /**
> - * tpm_dev_release() - free chip memory and the device number
> + * tpm_dev_release() - free the device number and release reference to chip
>   * @dev: the character device for the TPM chip
>   *
>   * This is used as the release function for the character device.
> @@ -133,10 +149,7 @@ static void tpm_dev_release(struct device *dev)
>  	idr_remove(&dev_nums_idr, chip->dev_num);
>  	mutex_unlock(&idr_lock);
>  
> -	kfree(chip->log.bios_event_log);
> -	kfree(chip->work_space.context_buf);
> -	kfree(chip->work_space.session_buf);
> -	kfree(chip);
> +	tpm_chip_put(chip);
>  }
>  static void tpm_devs_release(struct device *dev)
> @@ -195,6 +208,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  
>  	mutex_init(&chip->tpm_mutex);
>  	init_rwsem(&chip->ops_sem);
> +	kref_init(&chip->kref);
>  
>  	chip->ops = ops;
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 7f2d0f489e9c..098d7dcc04a4 100644
> +++ b/drivers/char/tpm/tpm.h
> @@ -211,6 +211,7 @@ struct tpm_chip {
>  	struct cdev cdev;
>  	struct cdev cdevs;
>  
> +	struct kref kref;

NAK, there is already a kref in struct device, that one must be used.

Jason
