Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492050;
	b=Um/4j78v4M0x0Khwj+t+mL7s2dmnt5KpWJoB+5Rbp2lta32LQdekTmZiZNwf9Yb5WeV7
	 4bsTtQ+gCYbt0khJkC/Z8CI5R2F+Wn4ecwud1ZdWg/joo38fHZSNCVbgBU723/BJneq+P
	 I2ZHmat2BdCyUjDCMOW4E7ewVF4y2BF/8/sh4GtvDRgND8Mu4mogmQh+tkHz3sufNVpUb
	 av/kjhff/JJe8WKhkPlx37Pi4ByFHSh60MBjQYcRWPfgCMtYPX9V2m4OWztwdIMEAovDZ
	 v3ShOk6hJ8Wx0rWtdWlK8TqgBp9sYeQwvGTnki4+EjzAgBHqJQiCUYJZ5dfalKOnDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492050;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9AYBncbKt6OLkkaaAIBSAFE3gIw17mjNbdLU8o9JQ08=;
	b=vh6NjwIpC3b5KrgPYMR3hHwL7x6QcfB1JsCgVaLSKM4FLb6p4Q4XAWxvdjyT1FMibaZa
	 48xk9+HJK6yI3eycO211H7rfRE0Budgn1WeZHmECGlPQghwkTgQyPiozpR6ZO+zFPVE9l
	 6uc/iDm6QJEoN+An3F99W6tOpiO+qlh5zDziLsu7YtnwsqqIY0DlbNmU3uxI4zYawc1tb
	 m8INtc7jq9+w9dSIuzWvR5qJKTYBUmcjlfyWYOCQb+SSFM+UlbjHBI8RwByCncP3h+RKX
	 /kIiSBe9kwR6CW6IacQatAOBd/EYSXcjJZN9u/rLUWDv8wavbT3P92dyyuiW+gyNidw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6bGhatX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 99B66606C72B;
	Thu, 12 Nov 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6bGhatX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9C7521F00A06;
	Thu, 12 Nov 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492050;
	bh=9AYBncbKt6OLkkaaAIBSAFE3gIw17mjNbdLU8o9JQ08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6bGhatXEii/0J1Qx1w+sPPjBWOJonniSHMxFcNAzkewu+ZhTdumconLFnsxgvwJL
	 CDsCi6InovdzspcV2fcIva24t9Ubf2CPr5VbVKh8Y5rFN20uo9CXv5IcgVWoXDCY01
	 Pc9RsB6pacSnVxiiAHMQ/Wg2eI9krlmSP7igVimd7SUT0uGzkADpKnd3yo77fedLI/
	 YwjiSLLBTwC2dTCOTshm0jQa8ENtZrcx9GrCqNTxUhhhuGaCeDrUmOsD+rqo56bnZI
	 yZPxedhyq5SruX8eyLiaTUnFaAn0vYBhKK4KbH29ff35EFasTw9tDzu8G7uZrX9cHl
	 QgRmrleFuzhiA==
Date: Thu, 12 Nov 2026 16:00:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avXGjiejK2ZlldKs@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>

On Thu, Nov 12, 2026 at 04:30:17AM -0800, Breno Leitao wrote:
> A TPM that stops responding fails each command only after the transport
> timeout, and its callers keep sending more: the hwrng thread every 10
> seconds forever, and userspace through /dev/tpmrm0. Each attempt holds
> tpm_mutex for the whole timeout and logs an error:
> 
>   tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
>   tpm tpm0: tpm_try_transmit: send(): error -62
>   tpm tpm0: tpm_try_transmit: send(): error -62
>   ...
> 
> The core already stops using a TPM it cannot trust: tpm_try_get_ops()
> fails with -EIO once TPM_CHIP_FLAG_DISABLE is set, which
> tpm2_load_null() does when it cannot restore the null key. Set the same
> flag once 60 commands in a row have timed out.
> 
> A completed command, whatever its TPM return code, resets the count.
> Some TPMs stall for half a minute, time out a handful of commands, and
> then recover, so a short streak must not disable them.
> 
> With only the hwrng retrying every 10 seconds, 60 timeouts take more
> than ten minutes. A userspace poller gets there sooner, but each of its
> commands still waits out the transport timeout.
> 
> The limit is the tpm.max_unanswered boot parameter, so that slow
> pre-production parts, such as FPGA prototypes, can raise it, or set it
> to 0 to never disable the TPM. A disabled TPM stays disabled until the
> driver is rebound or the machine reboots.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
>  include/linux/tpm.h              |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e0385b16616b46..b7865ccb799289 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
>  MODULE_PARM_DESC(suspend_pcr,
>  		 "PCR to use for dummy writes to facilitate flush on suspend.");
>  
> +static unsigned int tpm_max_unanswered = 60;
> +module_param_named(max_unanswered, tpm_max_unanswered, uint, 0444);
> +MODULE_PARM_DESC(max_unanswered,
> +		 "Disable the TPM after this many commands in a row time out (0 = never).");

Documentation/admin/kernel-parameters.txt update is also needed.

tpm_max_missed_responses is what I would suggest, because it is more
accurate e.g., on stating what is being counted :-)


> +
>  /**
>   * tpm_calc_ordinal_duration() - calculate the maximum command duration
>   * @chip:    TPM chip to use.
> @@ -268,6 +273,16 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  		delay_msec *= 2;
>  		memcpy(buf, save, save_size);
>  	}
> +
> +	if (ret >= 0) {
> +		/* we are good, reset nr_unanswered */

I'm not a huge fan in general of third person plural in the source code
comments. Probably a comment here is not needed at all as it does not
state anything that would not be obvious (i.e. something nothing
non-obvious is documented).

> +		chip->nr_unanswered = 0;
> +	} else if (ret == -ETIME &&
> +		   ++chip->nr_unanswered == tpm_max_unanswered) {
> +		dev_err(&chip->dev, "%u commands in a row timed out, disabling the TPM\n",
> +			chip->nr_unanswered);
> +		chip->flags |= TPM_CHIP_FLAG_DISABLE;
> +	}
>  	return ret;
>  }
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 0db277af45c393..e8191585a68e7a 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -131,6 +131,7 @@ struct tpm_chip {
>  	struct hwrng hwrng;
>  
>  	struct mutex tpm_mutex;	/* tpm is processing */
> +	unsigned int nr_unanswered;	/* commands in a row that timed out */

This would be then nr_lost_responses.

>  
>  	unsigned long timeout_a; /* jiffies */
>  	unsigned long timeout_b; /* jiffies */
> 
> -- 
> 2.53.0-Meta
> 

Br, Jarkko
