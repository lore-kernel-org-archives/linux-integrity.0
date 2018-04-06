Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36158 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDFQHN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Apr 2018 12:07:13 -0400
Received: by mail-pl0-f66.google.com with SMTP id 91-v6so904992pld.3
        for <linux-integrity@vger.kernel.org>; Fri, 06 Apr 2018 09:07:13 -0700 (PDT)
Date: Fri, 6 Apr 2018 10:07:11 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin King <colin.king@canonical.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: st33zp24: check if chip is null before dereferencing
Message-ID: <20180406160711.GA14097@ziepe.ca>
References: <20180406160541.8188-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180406160541.8188-1-colin.king@canonical.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Apr 06, 2018 at 05:05:41PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently chip is being dereferenced by the call to dev_get_drvdata
> before it is being null checked, hence we have a potential null
> pointer dereference bug. Fix this by only dereferencing it after the
> null check.
> 
> Detected by CoverityScan, CID#1357806 ("Dereference before null check")
> 
> Fixes: 9e0d39d8a6a0 ("tpm: Remove useless priv field in struct tpm_vendor_specific")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>  drivers/char/tpm/st33zp24/st33zp24.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index f95b9c75175b..476865d66a0e 100644
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -367,7 +367,7 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
>  static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
>  			 size_t len)
>  {
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> +	struct st33zp24_dev *tpm_dev;
>  	u32 status, i, size, ordinal;
>  	int burstcnt = 0;
>  	int ret;

Chip can't be NULL here, so I would prefer to see the NULL test
deleted.

Thanks,
Jason
