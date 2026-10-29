Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302062;
	b=GErvk1u8K6fDBaLc6ObS8qp2jfHhk/bqnodeMWZ9rgfOqcRKaXemdDovpacb2FMKaGGM
	 fUjPulNn6NFLQDQAujgIwaJrDS/6TBUb8oBTSiBOWEKQUSCEYkQXNqYufvYr2tPJoxJuB
	 JsVx9lK/mMlBQri7uALclA7y2tZPMMOCTaPdgh+V/eV/KrMebXOqkkl7F2oH/B89QKOCl
	 ibAcxSDVew9qXC6Ajuzr6111EjjTWnqiEJBEDTdJCA3ZIeYyPafQax0AriCaievXSCK8D
	 5Cpd36XWkIrcRm2rRS6/dlDQvIdxlcZIZUJHw2ZbLTr+I6NlbHWPRGfT28LAR7a1g4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302062;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b6C3IgC63Yg4T4VT4zapDx84kHz/3nyKlMkMNCzW0UY=;
	b=ckcMt5NsBm3Lm01Rf0LIxfJeElfceo4TB4KnmipvR5MeH1Rr+eSL0KVlrkTEowyqU8hG
	 ysMFt0W9hoUhRJsyjrFcj0w1GnQUFRPZPJKUN1S24fUq2Js67Mhm+EpvIeyvx9r/TPlkU
	 Jl6+hlTmuXgzEk64ZjHY5CVEBxaHLUn6A4FDLInooutKpP5SGkDmfjQ0J93UGeLlkKk1z
	 g9P3vFqXfogzDgCpLT8+Xlc5VeOCA03q+XjcjqFuJf/ai8nQksqAuP4fblPGkyW+cIvGd
	 jn4H8OLD7J92EtX/Eaj2/JQkuevnJSJ8dIXWwAjd3qb+QNF3I5+N99xJBokwM1xRCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QuXOi3BP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A1CA4606A31A;
	Thu, 29 Oct 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QuXOi3BP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AC9B01F01816;
	Thu, 29 Oct 2026 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302062;
	bh=b6C3IgC63Yg4T4VT4zapDx84kHz/3nyKlMkMNCzW0UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QuXOi3BPMGByOoGYTuUHJbnR230bAPbwV3UrhNYugSVyqXC8INUn3T3AWX4uTywO3
	 p8OrzYeoPSH8D4S9GxefEU7+e4zDfagy3RsPzX6uzVB/aqb1zOP/xSG21/UvVIqU9c
	 eiHFlagjjN2QJPbMZqzCoeU77rQw8uLCcthMKKINoAzX3XctlRv0t2McDcHMRBvXlY
	 /MxmGhhWtwy1DvkI1QRJR1ovN2kof7iLwd6SOBc2CJkNGeo7FhkNBcmn/Lo8QKMY8D
	 FdUFRK4rCExx9b6dFKTVEc+V9wi4jZ32yJi6LqlGV7Jq9+t1QFAb0qfn9F/7iVAeq4
	 OArXT94ynj3MA==
Date: Thu, 29 Oct 2026 21:27:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 6/7] tpm_crb: Factor crb_send()/crb_recv() bodies into
 helpers
Message-ID: <auOeKsRQP2WSbRxe@kernel.org>
References: <20261029181541.99505-1-armenon@redhat.com>
 <20261029181541.99505-7-armenon@redhat.com>
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
In-Reply-To: <20261029181541.99505-7-armenon@redhat.com>

On Thu, Oct 29, 2026 at 11:45:40PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> A later patch adds CRB chunking, which needs its own send/receive
> loops alongside the existing single-shot transfer. Move the body of
> crb_send() into tpm_crb_send_no_chunks() and the body of crb_recv()
> into tpm_crb_recv_no_chunks().
> 
> Pure code motion, no behavior change. Also fix the block comment to the
> kernel's preferred multi-line style.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 71 ++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 30ca8192d3a8..f0bac9e1f1e8 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -369,24 +369,13 @@ static u8 crb_status(struct tpm_chip *chip)
>  	return sts;
>  }
>  
> -static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
>  	unsigned int expected;
>  
> -	/* A sanity check that the upper layer wants to get at least the header
> -	 * as that is the minimum size for any TPM response.
> -	 */
> -	if (count < TPM_HEADER_SIZE)
> -		return -EIO;
> -
> -	/* If this bit is set, according to the spec, the TPM is in
> -	 * unrecoverable condition.
> -	 */
> -	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> -		return -EIO;
> -
> -	/* Read the first 8 bytes in order to get the length of the response.
> +	/*
> +	 * Read the first 8 bytes in order to get the length of the response.
>  	 * We read exactly a quad word in order to make sure that the remaining
>  	 * reads will be aligned.
>  	 */
> @@ -399,6 +388,28 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
>  
>  	return expected;
> +
> +}
> +
> +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +
> +	/*
> +	 * A sanity check that the upper layer wants to get at least the header
> +	 * as that is the minimum size for any TPM response.
> +	 */
> +	if (count < TPM_HEADER_SIZE)
> +		return -EIO;
> +
> +	/*
> +	 * If this bit is set, according to the spec, the TPM is in
> +	 * unrecoverable condition.
> +	 */
> +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> +		return -EIO;
> +
> +	return tpm_crb_recv_no_chunks(chip, buf, count);
>  }
>  
>  static int crb_do_acpi_start(struct tpm_chip *chip)
> @@ -474,12 +485,29 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
>  	return rc;
>  }
>  
> -static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> +static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
>  	int rc = 0;
>  
> -	/* Zero the cancel register so that the next command will not get
> +	memcpy_toio(priv->cmd, buf, len);
> +
> +	/* Make sure that cmd is populated before issuing start. */
> +	wmb();
> +
> +	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> +	if (rc)
> +		return rc;
> +
> +	return crb_try_pluton_doorbell(priv, false);
> +}
> +
> +static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +
> +	/*
> +	 * Zero the cancel register so that the next command will not get
>  	 * canceled.
>  	 */
>  	iowrite32(0, &priv->regs_t->ctrl_cancel);
> @@ -494,16 +522,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
> -	memcpy_toio(priv->cmd, buf, len);
> -
> -	/* Make sure that cmd is populated before issuing start. */
> -	wmb();
> -
> -	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> -	if (rc)
> -		return rc;
> -
> -	return crb_try_pluton_doorbell(priv, false);
> +	return tpm_crb_send_no_chunks(chip, buf, len);
>  }
>  
>  static void crb_cancel(struct tpm_chip *chip)
> -- 
> 2.56.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
