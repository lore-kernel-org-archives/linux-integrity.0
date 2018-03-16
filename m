Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63482 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeCPNoV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 09:44:21 -0400
Date: Fri, 16 Mar 2018 15:44:17 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Daniel Drake <drake@endlessm.com>
Cc: chiu@endlessm.com, linux@endlessm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: TPM driver breaks S3 suspend
Message-ID: <20180316134417.GB7387@linux.intel.com>
References: <20180102144305.jjjss4nj5yviyiwd@linux.intel.com>
 <20180315101119.30222-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315101119.30222-1-drake@endlessm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 15, 2018 at 06:11:19PM +0800, Daniel Drake wrote:
> Hi,
> 
> Sorry for the delayed response.
> 
> Unfortunately we had to return the affected machine to the vendor
> (Acer Veriton X4110G) although given we have a fairly complete
> understanding of the problem, perhaps we can find and push a fix
> anyway.
> 
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > Can you try it on git://git.infradead.org/users/jjs/linux-tpmdd.git ?
> > Maybe it is related to the LPC #CLKRUN issues we've had.
> 
> I don't see anything relevant in that git tree, and it seems like
> a distant issue from the CLKRUN changes that have been made.
> 
> To recap, the first suspend works OK, and then the TPM shows shows the
> following message on the first resume:
>   tpm tpm0: A TPM error(38) occured continue selftest
> And error(38) is TPM_ERR_INVALID_POSTINIT which means the TPM is
> not in the correct state. Then the following suspend will always
> fail with the following messages.
>   tpm tpm0: Error (38) sending savestate before suspend
>   PM: Device 00:0b failed to suspend: error 38
> 
> tpm_crb is the driver here (not tpm2).
> 
> This exact problem was also discussed in depth years ago at
> https://lists.gt.net/linux/kernel/1358716
> 
> The patch that we used to avoid the issue is below. What do you think?

I think this would work for me.

/Jarkko

> 
> Thanks
> Daniel
> 
> 
> ---
>  drivers/char/tpm/tpm-interface.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1d6729be4cd6..444ae2df4a06 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -953,6 +953,10 @@ int tpm_do_selftest(struct tpm_chip *chip)
>  	loops = jiffies_to_msecs(duration) / delay_msec;
>  
>  	rc = tpm_continue_selftest(chip);
> +	if (rc == TPM_ERR_INVALID_POSTINIT) {
> +		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
> +		dev_info(&chip->dev, "TPM not ready (%d)\n", rc);
> +	}
>  	/* This may fail if there was no TPM driver during a suspend/resume
>  	 * cycle; some may return 10 (BAD_ORDINAL), others 28 (FAILEDSELFTEST)
>  	 */
> -- 
> 2.14.1
> 
