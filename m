Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:62950 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937796AbeFSMxz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jun 2018 08:53:55 -0400
Date: Tue, 19 Jun 2018 15:53:49 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH] tpm: Return the actual size when receiving an
 unsupported command
Message-ID: <20180619125349.GA5609@linux.intel.com>
References: <20180615121821.23376-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180615121821.23376-1-Ricardo.Schwarzmeier@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 15, 2018 at 02:18:21PM +0200, Ricardo Schwarzmeier wrote:
> The command size is computed for the header anyway.
> It can as well indicate the correct number of bytes to read from the driver.
> 
> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e32f6e85dc6d..0923e81505a5 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -423,7 +423,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>  		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
>  		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
>  						  TSS2_RESMGR_TPM_RC_LAYER);
> -		return bufsiz;
> +		return header->length;
>  	}
>  
>  	if (bufsiz > TPM_BUFSIZE)
> -- 
> 2.17.1
> 

Isn't this a regression (just came from one week leave might be
overlooking something)? Should always return either error or response
length. If so, please add the fixes tag.

And please send to linux-integrity and CC to linux-integrity and
linux-kernel.

Thanks anyway.

/Jarkko
