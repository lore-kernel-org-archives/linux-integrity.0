Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14224 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932093AbdJWNiR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:38:17 -0400
Date: Mon, 23 Oct 2017 15:38:13 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm_i2c_nuvoton: Use common error handling code in
 i2c_nuvoton_send()
Message-ID: <20171023133813.3xflw4k2npydp26c@linux.intel.com>
References: <6d2dcc64-af7a-fb71-f863-10d30914269e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d2dcc64-af7a-fb71-f863-10d30914269e@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Oct 21, 2017 at 10:11:36PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Oct 2017 22:07:39 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/char/tpm/tpm_i2c_nuvoton.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index c6428771841f..f0037e9e2d0e 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -440,15 +440,13 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	}
>  	if (rc < 0) {
>  		/* retries == TPM_RETRY */
> -		i2c_nuvoton_ready(chip);
> -		return rc;
> +		goto write_ready;
>  	}
>  	/* execute the TPM command */
>  	rc = i2c_nuvoton_write_status(client, TPM_STS_GO);
>  	if (rc < 0) {
>  		dev_err(dev, "%s() fail to write Go\n", __func__);
> -		i2c_nuvoton_ready(chip);
> -		return rc;
> +		goto write_ready;
>  	}
>  	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
>  	rc = i2c_nuvoton_wait_for_data_avail(chip,
> @@ -457,12 +455,15 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  					     &priv->read_queue);
>  	if (rc) {
>  		dev_err(dev, "%s() timeout command duration\n", __func__);
> -		i2c_nuvoton_ready(chip);
> -		return rc;
> +		goto write_ready;
>  	}
>  
>  	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
>  	return len;
> +
> +write_ready:
> +	i2c_nuvoton_ready(chip);
> +	return rc;
>  }
>  
>  static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
> -- 
> 2.14.2
> 

Setting the commandReady bit gives means to abort the command. Setting
the bit is not the end goal. Use something like err_cancel instead.

/Jarkko
