Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54234 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751437AbeCQBUd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 21:20:33 -0400
Message-ID: <1521249631.12827.5.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        stable@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Fri, 16 Mar 2018 18:20:31 -0700
In-Reply-To: <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
         <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> index 9e80a953d693..1adb976a2e37 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -537,14 +537,26 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip,
> struct tpm_space *space,
>  			 const char *desc)
>  {
>  	const struct tpm_output_header *header = buf;
> +	unsigned int delay_msec = TPM2_DURATION_SHORT;
>  	int err;
>  	ssize_t len;
>  
> -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> -	if (len <  0)
> -		return len;
> +	for (;;) {
> +		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz,
> flags);
> +		if (len <  0)
> +			return len;
> +		err = be32_to_cpu(header->return_code);
> +		if (err != TPM2_RC_TESTING)
> +			break;
> +
> +		delay_msec *= 2;
> +		if (delay_msec > TPM2_DURATION_LONG) {
> +			dev_err(&chip->dev, "the self test is still
> running\n");
> +			break;
> +		}
> +		tpm_msleep(delay_msec);
> +	}

It turns out this bit is wrong ... I just discovered it testing the
RC_RETRY code.  You can't feed the buf back to tpm_transmit because the
header has already been changed to give you back the return code.  To
make this work, you have to save the header and handle area and restore
it before the command is resent.

I think the best solution for this hunk of code is to merge it with the
retry code.

James
