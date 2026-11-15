Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749563;
	b=qaVglolbn8JOO7ywq9h8Q2LKhwU+mIu1gTu3TOElueFxeMaMNJjZUzuPzFsnqQYZ92Eb
	 KtFvnfVITmPf/0u8Stg1xfC/ygwqkdsFqH3tGHsEKp/Bg+04pvllbtx7Se1bVuPZDEibH
	 tOffPlHBIJLFp2HVC07aYyeI5IpBFMbeJwUtAZb/QqZpP7wtL9xfG/D3zplA0jN8z9TNw
	 iLjsUc4mbJ1lhUmLl71nUlFP2aARRwH9bZAWg57ABuxWOh2RqjCFvN1HlTKcuBpmQToK9
	 Hf5O3GAysmSQXMG4Y5Oq13FqON/4pxFR3pwBWyH0yBBfeQZ7Fbh6q+dVQPJrmN/mBYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DOuKLQTv6yFSfHDgE4gwPAhy1aGA7qa0gtGA9y3WDVU=;
	b=K0ScnedrLg3JYUMww0SUuobQsjfEE7kel+UPRCBfo6Anv3EfrT7sH9D9BgrNOPa59eCi
	 yPTNddaAFbefRnmLjY/SR1518+TWi3p4+MWf41qbAElnES25nvkCluvJjwsRY93S3ee90
	 2acOt4PGyg9PlDuoIQiovsKKxL8PdEShmHUU/Zkhg5sHQl1aVTny/47Z9QHPO7fA0ynrY
	 6RLxO5RPURG+U11+bJbcZgQmzdOMs8TPnzQpE4Gayb0ZgsYN4Ur6s54xbFEX0IpDHfYyt
	 2+lGvnnqLB62BOELEojwQPGCx+HERuh/UYui0YwBdPd6Wl40i104LpgolCNN/bLlBmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYZNTrwz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 61DA2606A327;
	Sun, 15 Nov 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYZNTrwz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7A2301F000C4;
	Sun, 15 Nov 2026 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794749563;
	bh=DOuKLQTv6yFSfHDgE4gwPAhy1aGA7qa0gtGA9y3WDVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dYZNTrwzCzvsmlvCKwiOB52eIoDDv/uMnNNFHuR9K21pgNtP5jQ2fiLmqSWkcgC6/
	 JJY/F2Vd1QOnFfeviaLg3LA+9l+6GDh5FkprS4WzlZwH6Yz1OJiZUGl5FT7auVNtzY
	 3MCB1x4jwybHNtlx4cTNcla47ijKkBEWvi/1VjhevTYkjaovg7gLg5nIJ3z0s+5oxR
	 hTYDTvqSZxYhILTFp0r613hnQITDD3FO8nL6aUb6vzRhLHj4fJAb4QwNe61+RB3SSl
	 F4QDBuBqU+2XeM0lx9szir6IiwzegEfNwZQTBRxCNfR/e6KQ2d9Vu/TaRAgq5ZjmSX
	 2Gkbe/scHQmXA==
Date: Sun, 15 Nov 2026 15:32:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rachelmenge@linux.microsoft.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] tpm: tpm_tis: Use cached tpm2_acpi_start_method
Message-ID: <avm0d4iOX6V9O0-p@kernel.org>
References: <20261115013456.212141-1-sidchintamaneni@gmail.com>
 <20261115013456.212141-4-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261115013456.212141-4-sidchintamaneni@gmail.com>

On Sun, Nov 15, 2026 at 01:34:55AM +0000, Siddharth Chintamaneni wrote:
> Use the cached tpm2_acpi_start_method value instead of mapping and
> unmapping the ACPI TPM2 table again during probe. Remove
> check_acpi_tpm2() and open-code the start method check directly in
> tpm_tis_init(), returning -ENODEV when the device does not use
> ACPI_TPM2_MEMORY_MAPPED.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis.c | 45 +++++---------------------------------
>  1 file changed, 6 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 6f8344894ea5..df2d8c1c2be0 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -127,45 +127,11 @@ static inline int is_itpm(struct acpi_device *dev)
>  #endif
>  
>  #if defined(CONFIG_ACPI)
> -#define DEVICE_IS_TPM2 1
> -
>  static const struct acpi_device_id tpm_acpi_tbl[] = {
> -	{"MSFT0101", DEVICE_IS_TPM2},
> +	{"MSFT0101"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, tpm_acpi_tbl);
> -
> -static int check_acpi_tpm2(struct device *dev)
> -{
> -	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
> -	struct acpi_table_tpm2 *tbl;
> -	acpi_status st;
> -	int ret = 0;
> -
> -	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
> -		return 0;


Jason, can you remind me what was the deal with this flag?

> -
> -	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
> -	 * table is mandatory
> -	 */
> -	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
> -	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
> -		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
> -		return -EINVAL;
> -	}
> -
> -	/* The tpm2_crb driver handles this device */
> -	if (tbl->start_method != ACPI_TPM2_MEMORY_MAPPED)
> -		ret = -ENODEV;
> -
> -	acpi_put_table((struct acpi_table_header *)tbl);
> -	return ret;
> -}
> -#else
> -static int check_acpi_tpm2(struct device *dev)
> -{
> -	return 0;
> -}
>  #endif
>  
>  static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
> @@ -222,11 +188,12 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  {
>  	struct tpm_tis_tcg_phy *phy;
>  	int irq = -1;
> -	int rc;
>  
> -	rc = check_acpi_tpm2(dev);
> -	if (rc)
> -		return rc;
> +#ifdef CONFIG_ACPI
> +	if (acpi_match_device(tpm_acpi_tbl, dev) &&
> +	    tpm2_acpi_start_method != ACPI_TPM2_MEMORY_MAPPED)
> +		return -ENODEV;
> +#endif
>  
>  	phy = devm_kzalloc_obj(dev, struct tpm_tis_tcg_phy);
>  	if (phy == NULL)
> -- 
> 2.45.4
> 

Br, Jarkko
