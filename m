Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490654;
	b=Kks+3VPQw+0+lbT9bwOEN8xBsL7j4s4Hlgua1+utumz721JTznaoPH2CQcm7eMJzl3bB
	 6VYTNFU3IJnqwYe2z14Iou6HYnIEkDEJflWooFQDKjyaPTE8lgIvgFmHkVVcsLPqyhoAp
	 YvDW1EfvTM4bTANt/M2d++TifLMuYWGvqSQo+deoOJNwCVF1WzBCVTRRUTK1OghMxxAR8
	 R7tuSGRSaG2zH9WVsIeu5bEA97He+YXSoutnJic701POaXQ6jaGC3vu0U+4wtpqHgyfUT
	 LOU9NB2Lmoe2swoyv9A0iIT8vGGaDgc6s7nma/lozFKdf4LfZj2bgoFEhVst8oPDdQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490654;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QsoWmQnYzC5PyKY1NB+zpFWHVv8yt3LRHs7iNDyQWHI=;
	b=l0yaJ4J0/YxeJ8ESauIs2acodO7vYi2GDpiSo7AXjo6wTtNiZnunP6ZbFiw3AHSr1n7f
	 i5xCOR/R7avMp1SAeOQZnTomQOYroX1mYhNDl9E7XLfE60LgRbUDLYchjubyYMSbiZcoK
	 CtB688rZysZsHbSDvHbLDaWN/dkJ+KUUtJvZ9SpY+Wk6MA4qTwM2Bdrr49vhmVoP+qgMx
	 lEPDHu6oFT4x75k0HXt+IGLR7o+ZQaOmCRjRIt4sYDbfHjTInl2TIrVUldUq9sdBZxitz
	 hxRCc0f57f6jcYlvVkOGgqMcIKHqpjP1QGQ2SADrKan6VrLYpFxaxYLnW1fHLe2doOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2b8cIO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2A50B606A321;
	Thu, 12 Nov 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2b8cIO5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3F7E91F00A05;
	Thu, 12 Nov 2026 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490653;
	bh=QsoWmQnYzC5PyKY1NB+zpFWHVv8yt3LRHs7iNDyQWHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2b8cIO5o5DDk+fwt0dNGmu/TUofFLTuDaVDk0WO6Zr0vI0wTKAA7QNNYOfmr9sVr
	 GMWW5SdOQnyoO2e/2kuo3/a5BDfV9/sDn7/qv4iSwRndHQTmgMb/Alrz1DeNxxUD3K
	 QL7lG0DNv+6XmcpqIFNPddnFzmMhIGhOZZMrxeD4EeDn9cNieWvCw56Uel48ao1USo
	 qCLqVLr/Nsw8Rpub664NOqRSTC3kGNL7GA0idPniXCtItEWdrpxCJDu5Z4ffkO5Y+5
	 QSw1myRfzCrHYgcwKaYdmy0zYGTGU/ItGfTxdhUs3Pb0oiZ4uxfVdyKZlNEk4ZGPEJ
	 17hwo6yMQa/sQ==
Date: Thu, 12 Nov 2026 15:37:29 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
Message-ID: <avXBGZegq9ptFz8H@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>
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
In-Reply-To: <20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>

On Thu, Nov 12, 2026 at 04:30:18AM -0800, Breno Leitao wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> If the TPM has been spuriously disabled, the game is over. Let's reflect
> this truth with TPM_CHIP_FLAG_DISABLE.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> [leitao@debian.org: check rc before the loop breaks out on anything but
>  RETRY/TESTING, skip TPM2_Startup, which a TPM that is already started
>  fails with TPM2_RC_INITIALIZE, and fix the TPM2_RC_INITIALIZE and
>  chip->flags typos]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/char/tpm/tpm-interface.c | 5 +++++
>  drivers/char/tpm/tpm2-cmd.c      | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index b7865ccb799289..144e2dbae66853 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -252,6 +252,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  		if (ret < 0)
>  			break;
>  		rc = be32_to_cpu(header->return_code);
> +		/* A TPM that is already started fails TPM2_Startup this way. */
> +		if (rc == TPM2_RC_INITIALIZE && cc != TPM2_CC_STARTUP) {

Good catch! Thanks.

> +			chip->flags |= TPM_CHIP_FLAG_DISABLE;
> +			break;
> +		}
>  		if (rc != TPM2_RC_RETRY && rc != TPM2_RC_TESTING)
>  			break;
>  		/*
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 4b2bb2ddc321a9..65928ae85b496c 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -724,6 +724,8 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  		goto out;
>  
>  	if (rc == TPM2_RC_INITIALIZE) {
> +		chip->flags &= ~TPM_CHIP_FLAG_DISABLE;
> +
>  		rc = tpm2_startup(chip);
>  		if (rc)
>  			goto out;
> 
> -- 
> 2.53.0-Meta
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
