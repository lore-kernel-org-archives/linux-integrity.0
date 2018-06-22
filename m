Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43863 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbeFVUmG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 16:42:06 -0400
Received: by mail-pg0-f66.google.com with SMTP id a14-v6so3445625pgw.10
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 13:42:06 -0700 (PDT)
Date: Fri, 22 Jun 2018 14:42:04 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tpm: rename tpm_chip_find_get() to tpm_get_ops()
Message-ID: <20180622204204.GD19151@ziepe.ca>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622164613.1609313-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 22, 2018 at 12:46:10PM -0400, Stefan Berger wrote:
> Rename tpm_chip_find_get() to tpm_get_ops(). This now matches
> the name of its counter part tpm_put_ops() better.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c      |  4 ++--
>  drivers/char/tpm/tpm-interface.c | 14 +++++++-------
>  drivers/char/tpm/tpm.h           |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..4e83695af068 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -81,7 +81,7 @@ void tpm_put_ops(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> - * tpm_chip_find_get() - find and reserve a TPM chip
> + * tpm_get_ops() - find and reserve a TPM chip
>   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
>   *
>   * Finds a TPM chip and reserves its class device and operations. The chip must
> @@ -92,7 +92,7 @@ EXPORT_SYMBOL_GPL(tpm_put_ops);
>   * %NULL if a chip is not found.
>   * %NULL if the chip is not available.
>   */
> -struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
> +struct tpm_chip *tpm_get_ops(struct tpm_chip *chip)
>  {

It is sort of weird that this returns a tpm_chip, but I think if you
revise the comment it would be OK.

 This function is for internal use only, it supports existing TPM
 callers by accepting NULL, but those callers should be converted to
 pass in a chip directly.

Jason
