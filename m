Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26914481B1;
	Fri, 26 Jun 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491471; cv=none; b=qYrjrNR9DnxhX6fYT3XL4cutCHQZXCaEX0R/FieYfA0WsTxyZQ3yTg085CLt/GMDWMhXHUe8ISKLKNWqc3b9Y7kIZ9mu/b+XJityofyZZFAuOiI3pRfPcw24U0TPZctcBfllgTD4E4Eb/OQtl9XVsqYiwmCwTay78PCfsSQ4vHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491471; c=relaxed/simple;
	bh=1mX9S9uPaUq7GVEO+a3y3bUYYKPbnwa/8k7eNOuinDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyLlMIgM/Zp+M0+Pb8iwLlbzUsaJc0b0NUE7Fa0ltvJKwauKIDj4Q0TR/E2SSRQntUxkIRHhlvUnioTpducZFxe2v/QdwRMBU9/5PkiPvZrcsbZYu3uHNl/1u9beQuOXBkW/9X0+MWfS0TA1RhAZda+sl8iCnGcc/obf4xnoAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2qB/Spc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2qB/Spc"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 426171F000E9;
	Fri, 26 Jun 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491469;
	bh=KSUXXThL3kXhHXKekdycU/4DYWBl4hsTFRqara9qxKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2qB/SpcQauAkDXBD3F2tw7W4gP5dv09/dG7UA2uO5SikqV3sBDQqUpZNQVm8yQr+
	 FkEtNHC8nAcp/uuPQO6VgYxjiTJAr1kI3iBFLJPIxc+vUfPQSfUkjSTmomBimxjCdR
	 xCSyVOtiRr0C4cxo5Mbl9Cj6EYl6vlRL8vZf3Kle5zd1OfUH2eomCePfpBoGcZf3V7
	 I1HWDPOXdtslUaL1uR6ccbItpZchXJEzad6IIWAxLvIR8k00O/BJV+cf8A6n2QDEPz
	 TAnR2exSipqJ80BDjTJAv+8t7Lb8PuOQeJfdvTXcA8yKeSiqVIU8XMKtNfyut+Z+gd
	 l9p290BuHg5HA==
Date: Fri, 26 Jun 2026 19:31:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
Message-ID: <aj6pSWaCs9yZ_nmY@kernel.org>
References: <20260626091653.54929-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626091653.54929-1-mhun512@gmail.com>

On Fri, Jun 26, 2026 at 06:16:53PM +0900, Myeonghun Pak wrote:
> i2c_nuvoton_wait_for_stat() enables the IRQ before waiting for the
> interrupt handler to report a status change. If the wait times out, or is
> interrupted before the handler runs, the function returns without
> balancing the enable_irq() call.
> 
> Disable the IRQ before leaving the failed wait path. Also preserve an
> interrupted wait's original error code instead of converting it to
> -ETIMEDOUT inside the helper.
> 
> Fixes: 4c336e4b1556 ("tpm: Add support for the Nuvoton NPCT501 I2C TPM")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/char/tpm/tpm_i2c_nuvoton.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index d44903b..aa36730 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -182,8 +182,10 @@ static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
>  						      timeout);
>  		if (rc > 0)
>  			return 0;
> -		/* At this point we know that the SINT pin is asserted, so we
> -		 * do not need to do i2c_nuvoton_check_status */
> +
> +		disable_irq(priv->irq);
> +		if (rc < 0)
> +			return rc;
>  	} else {
>  		unsigned long ten_msec, stop;
>  		bool status_valid;
> -- 
> 2.47.1

LGTM

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
