Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961725;
	b=pK1BxshupZuDYEM0HRAbWwlPD2BP+nQQ3y5xYHl4CoS+ZkKoUXvta4DrYuAj483whxR8
	 PqQSJwPOq7mFqXT0nfbnJwQfT/fd8r73l5k/ClEv3CY1XZO+2VC4QPsK+pUBMRCiyzTKP
	 iZ8YmuswSicgG2ctXx2gNR/KPQO3ZSXsUZWBISiU0hpCJJ/j7tbBfWOmprxqz2zQy6uc5
	 E+0h39bLYfpZ7il1Y2y63mDHnE9KrGHCTaLoj6ug68bEFifOCn04n4wIgHF9tTLQCpqlP
	 gRSNqQ2h0fEEW1J7EM7zjBy0qvyagqUGW9nxVmzLQasTa/KEFPyqUTZ4vCbZnMl1NdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961725;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Xlst4q4osbp3xBElDqM7kzf52k+f1l0jbUFEvVMDUsc=;
	b=an9qRBVOutybCed4z1PwIQ80mD8jUNtcMFKHks+7C+n8iLhfEE9QFrFcuqVrw2l6mOr6
	 3Xi8HdzxeuPbzFyZkNkwe3nYMnZSLeYYDVRJ9UWRGBxtCiQEB8iaU2s+0XvLS/bLgK1bq
	 DHJkg+lCRR2d0L1b08/A7egoVf8pNuryE8PT4bY3tjhBcHiV6m+ySCjQ0C4mqLZXzE71c
	 7pVfKEVMm13ti5CrE+Pb3Q27JEypIeK2LDRv4o6RywmSRT3RQxM2gkmcNhyv22qi/YewS
	 MCO+lk27YVXLShVq172RQ6KJbyPoDRJFSSIXAk0wLvdE/U45G1hHRPMEoKp9TQwN/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ZPGtBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5AEF7606A31A;
	Sun, 25 Oct 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ZPGtBv
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 622441F01825;
	Sun, 25 Oct 2026 20:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792961724;
	bh=Xlst4q4osbp3xBElDqM7kzf52k+f1l0jbUFEvVMDUsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S3ZPGtBvvvqhQZUV538FxVS8M2XkE3lg9QbZHLLhJSGS5/uPVLlvefa4/vuqQlIF8
	 Fk6lQ4Zppfs6XUKs3o6KdYoDlEYfEqZV3RUNkCzD/xkjLDJMeRlZIbvmudPminrxfC
	 9l23mcilsnSkLM1ILC8PoQ+9/pyUpCo1MISBbedsZibbpKeg025xo2+AviywD38ruU
	 Qf58iDEMSgo1wHZHqgwkxZ3Z4ah+4Q8ovp8LH2EMcJ1L/GSFhnoijs8B1dGfyHeDri
	 wiLB5t8zHWkrWc9Goe03ToWwImZDaMTWt+OfUqV/6E9UjMX1T2E7h8LsuU5/HwTCl7
	 IYQlP1vaiP3YQ==
Date: Sun, 25 Oct 2026 22:55:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 2/6] tpm_crb: Split start method into a separate header
Message-ID: <at5suDJyVOusvc3R@kernel.org>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-3-armenon@redhat.com>
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
In-Reply-To: <20261025201859.221991-3-armenon@redhat.com>

On Mon, Oct 26, 2026 at 01:48:54AM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> The current implementation handles different platform start methods
> (ACPI, ARM SMC, and ARM FFA) directly within crb_send().
> Move this logic into a new helper function, tpm_crb_start(). This is a
> pure refactor with no functional changes intended.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index d76f9e30f036..9a2f512b4ae3 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -446,6 +446,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
>  }
>  #endif
>  
> +static int tpm_crb_start(struct tpm_chip *chip)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	int rc = 0;

After declarations thre should be empty line. checkpatch.pl should
complain about this.

> +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs

I probably did not spot this last time but:

	/*
	 * ...

https://docs.kernel.org/process/coding-style.html

> +	 * report only ACPI start but in practice seems to require both
> +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> +	 */
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> +	    !strcmp(priv->hid, "MSFT0101"))
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> +		rc = crb_do_acpi_start(chip);
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> +	}
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> +	}
> +	return rc;
> +}
> +
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -471,29 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	/* Make sure that cmd is populated before issuing start. */
>  	wmb();
>  
> -	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> -	 * report only ACPI start but in practice seems to require both
> -	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> -	 */
> -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> -	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> -	    !strcmp(priv->hid, "MSFT0101"))
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> -
> -	if (priv->sm == ACPI_TPM2_START_METHOD ||
> -	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> -		rc = crb_do_acpi_start(chip);
> -
> -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> -		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> -	}
> -
> -	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> -		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> -	}
> -
> +	rc = tpm_crb_start(chip);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.54.0
> 

Br, Jarkko
