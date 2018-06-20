Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40102 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933148AbeFTUuJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 16:50:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id g18-v6so847334wro.7
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 13:50:09 -0700 (PDT)
Date: Wed, 20 Jun 2018 14:50:04 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180620205004.GG27445@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> Implement tpm_chip_find() for other subsystems to find a TPM chip and
> get a reference to that chip. Once done with using the chip, the reference
> is released using tpm_chip_put().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h         |  9 +++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..eaaf41ce73d8 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -81,6 +81,43 @@ void tpm_put_ops(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> + * tpm_chip_put() - Release a ref to the tpm_chip
> + * @chip: Chip to put
> + */
> +void tpm_chip_put(struct tpm_chip *chip)
> +{
> +	if (chip)
> +		put_device(&chip->dev);

Rarely like to see those if's inside a put function.. Does it actually
help anything?

Jason
