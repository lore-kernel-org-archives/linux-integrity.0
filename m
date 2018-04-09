Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:24105 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeDILLP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Apr 2018 07:11:15 -0400
Message-ID: <4ea103c15998af56813fb870ac9a27a34a694f49.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: st33zp24: remove redundant null check on chip
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Colin King <colin.king@canonical.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Apr 2018 14:11:08 +0300
In-Reply-To: <20180406162144.14717-1-colin.king@canonical.com>
References: <20180406162144.14717-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-04-06 at 17:21 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently chip is being dereferenced by the call to dev_get_drvdata
> before it is being null checked, however, chip can never be null, so
> this check is misleading and redundant. Remove it.
> 
> Detected by CoverityScan, CID#1357806 ("Dereference before null check")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> 
> V2: don't check for null, just remove redundant null check,
>     thanks to Jason Gunthorpe for spotting that.
> 
> ---
>  drivers/char/tpm/st33zp24/st33zp24.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c
> b/drivers/char/tpm/st33zp24/st33zp24.c
> index f95b9c75175b..abd675bec88c 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -373,8 +373,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned
> char *buf,
>  	int ret;
>  	u8 data;
>  
> -	if (!chip)
> -		return -EBUSY;
>  	if (len < TPM_HEADER_SIZE)
>  		return -EBUSY;
>  

Reviewed-by: Jarkko Sakkinen <jarkkko.sakkinen@linux.intel.com>

/Jarkko
