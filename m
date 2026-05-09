Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315536606E;
	Sat,  9 May 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337794; cv=none; b=Zq01pjxOQCY9NrVHymR+1AGpIwl5pcBYKmb22k8wCJnoHiWxG8nuILnL72MrlCgoIiIeewHT7OxeqpzwFS+ZPAcfPxvVYpDcwZZO3x5jtp0TU91aB6qPTmtzSe1jpDd8+hUfCT+CVa/SJct/CExejRgre2Aejc2pIYZuMcrNeYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337794; c=relaxed/simple;
	bh=ERECIz1ehHELZjSBlQtMJDO+wclaARoliG08Tj6VDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpARzNihg+EQe4AZhZ6Q/FC8rEFzXCjB+upjUpb+LnD/ilKfoA1o7/TG4UDeg8J64/XcHfTaYYJi1Y1/dGWWO1f45/FU470aDewQGq0IxlY+LLFYFN4t73ituEXoq4l5vmQNCMDCRcTHWMoqQPhrZL0sn1szGSGDqOV22Oh+Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbE2dxQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbE2dxQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B98C2BCB2;
	Sat,  9 May 2026 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337794;
	bh=ERECIz1ehHELZjSBlQtMJDO+wclaARoliG08Tj6VDm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbE2dxQO5A3mWjvIyY2K81B7OrLSm1CL02ZDVt6tPH/kHmQVKPhGOYe7pCMn52aKa
	 PlqZIcDPJeeNLi7VNtVRUM2XMEPyPPLQgWL2W+zsXgq3BJr7L6wWJtvYQUcXNNUGtX
	 3iKyJ0H1rXMK0/HLPiMNPLCEagLJF0TDCxB5CnuX/oiFgtcPAA5B8vMEprgHyPXXrj
	 P3LaKkBHA4tP9ZIXl21yrfC20IHF+NES0OsMMDrSi/PaE2zZafDnKEQAPb6Fh2+6Bw
	 DiH4yhnB8z7JvkdI2ehkYULFbRQgkP0IRYRK+vPaBJxd8RfZlZqq+Ag0uwvKnNPETi
	 K4m/fiNqeMsSw==
Date: Sat, 9 May 2026 17:43:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 2/5] tpm_crb: Add new wrapper function to invoke start
 method
Message-ID: <af9H_rFY5-lGEr2g@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-3-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324181244.17741-3-armenon@redhat.com>

On Tue, Mar 24, 2026 at 11:42:41PM +0530, Arun Menon wrote:
> The current implementation handles different platform start methods
> (ACPI, ARM SMC, and ARM FFA) directly within crb_send(), but it is
> limited to triggering the CRB_START_INVOKE bit.
> 
> To support cmd/rsp chunking, the driver must be able to send other
> control bits, like CRB_START_NEXT_CHUNK, using these same
> platform-specific paths.
> 
> By moving this logic into a new helper function, crb_trigger_tpm(),
> the driver can now send any required control bit across all supported
> platforms. This prepares the driver for the upcoming chunking support.
> 
> No functional change is intended.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 67c0061d4cab7..922bcf7a69ad5 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -445,6 +445,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
>  }
>  #endif
>  
> +static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)

tpm_crb_start?

I'd also split this into two commits:

1. One that splits the helper.
2. Second that adds the new stuff.

> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	int rc = 0;
> +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> +	 * report only ACPI start but in practice seems to require both
> +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> +	 */
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> +	    !strcmp(priv->hid, "MSFT0101"))
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> +		rc = crb_do_acpi_start(chip);
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> +	}
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> +	}
> +	return rc;
> +}
> +
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -470,29 +496,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
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
> +	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.53.0
> 

BR, Jarkko
