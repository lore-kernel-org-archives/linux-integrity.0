Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44750 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754434AbeFVUnV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 16:43:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so3997200plk.11
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 13:43:20 -0700 (PDT)
Date: Fri, 22 Jun 2018 14:43:19 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tpm: Implement tpm_chip_find() for other
 subsystems to find a TPM chip
Message-ID: <20180622204319.GE19151@ziepe.ca>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 22, 2018 at 12:46:11PM -0400, Stefan Berger wrote:
> Implement tpm_chip_find() for other subsystems to find a TPM chip and
> get a reference to that chip.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
>  include/linux/tpm.h         |  5 +++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 4e83695af068..2520555b1e17 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -81,6 +81,33 @@ void tpm_put_ops(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> + * tpm_chip_find() - find a TPM chip and get a reference to it
> + */
> +struct tpm_chip *tpm_chip_find(void)

I feel like this should be called 'tpm_default_chip()'

> +{
> +	struct tpm_chip *chip, *res = NULL;
> +	int chip_num = 0;
> +	int chip_prev;
> +
> +	mutex_lock(&idr_lock);
> +
> +	do {
> +		chip_prev = chip_num;
> +		chip = idr_get_next(&dev_nums_idr, &chip_num);
> +		if (chip) {
> +			get_device(&chip->dev);
> +			res = chip;
> +			break;
> +		}
> +	} while (chip_prev != chip_num);
> +
> +	mutex_unlock(&idr_lock);

And what was tpm_chip_find_get should just call this function..

Jason
