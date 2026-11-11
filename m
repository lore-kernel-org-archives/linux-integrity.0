Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435281;
	b=jz6um9M/hzRpZDigVOMfDTwM3gO1c7c31qYazmaLA/lYy6qmcXdaCfspuQcsVQCxFiKc
	 Q9NgychFgJSF9yBRPWAbbO5RoYxDtydjrPWMFHVnH/zYmg9ezP0XdDH21Y8lu2MmhdS9J
	 TIOdxC+E2cwZc4UyPVIs0JGLUKSDszuYbjM563e4J3nzsbEhaH/ultiogA7LfoBi14tN1
	 nTXAQwKUShp5kXJ5gPbkM5pwUfDQJs/MuXjIAFX58FxfEsohi4md83kInlDn9OpMNIJpU
	 KeOL1mb+rThdz/ImXteP8ALmoSqo2aHLrGFD5FSQDUazsvYG3/NO05/VWrMU2bDOOMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435281;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GkRyrszX8UJVtjX8Z+U6dYtJLlrY4LyZ1l2LN2wXkNA=;
	b=Hrgepvvf2xpWgwDuUK0ygLVAV7YXbnAujLCa3S3yILQnTyC9SEOeTijMHNa6PBe78/0Y
	 3XQg0gjIDSve+52xTGg8PGwdUWBpccyGoq9DD9XyU/3sNQpS/kSNqcd2C3e0cuLMBW5de
	 NXEaszjJU/sMA4rxYLUzuKBkcQ7EvCG/KkCZ6EqpNyqftJad6uuQAWx0z6rf/WWOiYIog
	 scaAnO4/2ylp/nP+EcbskOfoAMeZx3IWwq7y8Ikeocl/J6VNuO5ymjl2NkgdAeL6oA2r3
	 zNmrQhif593wyWQAGrqGHVtdM0adZNHiEWF45WQJLgzNLJpFJroX3QwS3R/ETjQ7AdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9mYfUro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6D978606A321;
	Wed, 11 Nov 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9mYfUro
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DAAF1F00A05;
	Wed, 11 Nov 2026 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435281;
	bh=GkRyrszX8UJVtjX8Z+U6dYtJLlrY4LyZ1l2LN2wXkNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m9mYfUroil4Y25OYvevDH/CzzkPxDXVAcnbxRUOZQFG8af96ao4XRX23vDJeek1Vr
	 0e2E0IjVk0YCCetoTN0YDfjpU5Yw8SIE+RxdGRtBXSxILtRJKka0wxVC0akDk7ilbv
	 h8CynFK4dfRIBjsNMAafyX0oi3xBtR/XHIETpsEqxaiwI+C8oTueMsJZBdktGX3FkP
	 J4kvHEMUc0rE0cjvPdCqikrq+8IbSRsB5SzvWKkdlrn35h9EkTvU/1lC9kIBM0WNGB
	 QFO1PFv3ufexZZ770pGmdUHROyva67Ncu3dxeeJxojH8B/f6OIj9368liyIp3fSDAw
	 b/z+ZOlwLPbyQ==
Date: Thu, 12 Nov 2026 00:14:37 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avTozTIuOTxhxJ6l@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <20261111-tpm_unresponsive-v1-1-42ac1b965eb9@debian.org>
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
In-Reply-To: <20261111-tpm_unresponsive-v1-1-42ac1b965eb9@debian.org>

On Wed, Nov 11, 2026 at 01:57:33AM -0800, Breno Leitao wrote:
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
> flag when commands have kept timing out for ten minutes, with none
> completing in between.
> 
> A completed command, whatever its TPM return code, resets the clock. A
> disabled TPM stays disabled until the driver is rebound or the machine
> reboots.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Some other word than "timeout" should be used for added variables, and
this simply because it makes code more confusing to read given the
collision with the TCG spec terminology.

> ---
>  drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e0385b16616b46..c6278ef8d1095e 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -30,6 +30,8 @@
>  
>  #include "tpm.h"
>  
> +#define TPM_UNRESPONSIVE_TIMEOUT	(10 * 60 * HZ)

What is measured here is the accumulated time of the whole operation.

The problem with having compile-time only constant is a problem because
it makes FPGA pre-production phase more difficult. And I think to this
extent also considering pre-production makes sense even tho for most
part we only care about in-production ASIC :-)

So... It should be instead a boot-time parameter with a default value;
nothing more complicated than that.

Essentially this is watchdog timeout i.e. it detects hw malfunction
with a deadline timer.

So I'd suggest TPM_WDT_TIMEOUT because I think that will better separate
it from chip state transition timeouts.


> +
>  /*
>   * Bug workaround - some TPM's don't flush the most
>   * recently changed pcr on suspend, so force the flush
> @@ -206,6 +208,31 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	return rc ? rc : len;
>  }
>  
> +/*
> + * Disable the TPM once commands keep timing out for TPM_UNRESPONSIVE_TIMEOUT.
> + * A few timeouts are not enough: some TPMs stall for half a minute and recover.
> + */
> +static void tpm_check_unresponsive(struct tpm_chip *chip, ssize_t ret)
> +{
> +	if (ret >= 0) {
> +		chip->nr_timeouts = 0;
> +		return;
> +	}
> +	if (ret != -ETIME || (chip->flags & TPM_CHIP_FLAG_DISABLE))
> +		return;
> +	if (!chip->nr_timeouts++) {
> +		chip->first_timeout = jiffies;
> +		return;
> +	}
> +	if (time_before(jiffies,
> +			chip->first_timeout + TPM_UNRESPONSIVE_TIMEOUT))
> +		return;
> +
> +	dev_err(&chip->dev, "%u commands timed out in %lu seconds, disabling the TPM\n",
> +		chip->nr_timeouts, (jiffies - chip->first_timeout) / HZ);
> +	chip->flags |= TPM_CHIP_FLAG_DISABLE;
> +}
> +
>  /**
>   * tpm_transmit - Internal kernel interface to transmit TPM commands.
>   * @chip:	a TPM chip to use
> @@ -268,6 +295,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  		delay_msec *= 2;
>  		memcpy(buf, save, save_size);
>  	}
> +
> +	tpm_check_unresponsive(chip, ret);

This wrapper is only making things more confusing. Should be open-coded.

>  	return ret;
>  }
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 0db277af45c393..4264c87a04d98c 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -131,6 +131,8 @@ struct tpm_chip {
>  	struct hwrng hwrng;
>  
>  	struct mutex tpm_mutex;	/* tpm is processing */
> +	unsigned int nr_timeouts;	/* consecutive command timeouts */


Isn't this a bool? Could be a chip flag instead if this is the right
approach in the first place.

> +	unsigned long first_timeout;	/* jiffies */

Don't really understand this name when comparing what gets recorded
into it.

>  
>  	unsigned long timeout_a; /* jiffies */
>  	unsigned long timeout_b; /* jiffies */
> 
> -- 
> 2.53.0-Meta
> 

I'm not really confident whether a new timeout is needed. Couldn't
alternative be just have a max number of trials and count -ETIME's.

Br, Jarkko
