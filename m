Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbeJPNan (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Oct 2018 09:30:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so21758489wme.3
        for <linux-integrity@vger.kernel.org>; Mon, 15 Oct 2018 22:41:58 -0700 (PDT)
Date: Mon, 15 Oct 2018 23:41:55 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Message-ID: <20181016054155.GA18664@ziepe.ca>
References: <20181015111434.7777-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181015111434.7777-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 15, 2018 at 02:14:34PM +0300, Tomas Winkler wrote:
> Ignore the return value of go_to_idle() in tpm_try_transmit().
> Once it may shadow the return value of actual tpm operation,
> second the consequent command will fail as well and the error
> will be caought anyway.
> Last fix wrong goto, that jumped back instead of forward.
> 
> Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>  drivers/char/tpm/tpm-interface.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 129f640424b7..f69c711bf74a 100644
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>  		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
>  
>  out:
> -	rc = tpm_go_idle(chip, flags);
> -	if (rc)
> -		goto out;
> +	(void)tpm_go_idle(chip, flags);

We don't really use this style in the kernel, AFAIK.

Jason
