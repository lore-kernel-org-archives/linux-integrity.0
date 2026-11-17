Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947018;
	b=WAsc8IMATQd7Ssdn2Y4jNe/8UIUa0g7DOads0u3HuFBEOMDbnX2/MC3TAN2w+5+qIjIf
	 Ym/Z2BbW3zJlh2DllPPGcRZYh517wr8dUvF+EleLfIBSU0ACDdmwZcjz+88QJQ4/ZZ4U5
	 7JjBt6Zo+OK0HJYxcLFBr1wBeNzXAk4dMjdLqReSiHmICpF28CtSY6/k3v/QXhFHUy4rL
	 MvHEguJFh6Ivezi121kI6lkJHkKNGfmisjKy2m2yK39p28hlvf8MNTw7oNIstuiDFYeYW
	 opsRiqx+czVxKaLVPImlh7MAVkYjnIyusJ8f/Op4MCY7prOoY7qCi+rrZmkHok1/eew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947018;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+wrl1M/b0W1Lw5nefg+G5DrghWCaF5PMvxCyu48WSo8=;
	b=lb6WnLye0M10p4a8w5+fIj+a32EgMr0+G2kGMTN5H/MRLEsCKmFX6nCgS5bQhvLym89T
	 /3/c+LEdjEyWl1h2qsw9HjtMGlAADVdw2EjqQ8oZM2KY0Xv3uWlVdRJuG9FEJeZ6Tw5Be
	 sXNnWn4jqzXo5i2dFfVIxjB7eISTG8gM5FrEv6TvsiEKDYij6/kxwWSKEQOeLIEk7oMzj
	 tZJ3N9vOwSVjWCI0zOEgnFkVy+oV5D8GLe2+R4oPPYSlEPkMO65FPs6tNoCHxHP2K1upj
	 TNSjviJLwjnvQk2R4w6KIFaat75uL+XtMj89wXQE3tqlRAJfs8B7MgF3VllyEOmvUbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="n/FLe2lg";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A1606A31C;
	Tue, 17 Nov 2026 20:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n/FLe2lg
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4190C339;
	Tue, 17 Nov 2026 12:23:33 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89E0C3F632;
	Tue, 17 Nov 2026 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794947016; bh=pvkFaWZYQ10//zppwuCukKaIMWK7ZxkW4IommctNevs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/FLe2lgmJ4q16F6SbvRRo1Yv3qp7wRG5pgoXT+A4Y7SqbZTUiLZuoZqXy9Q6af5l
	 S/QJ8e87IU8aun4elbhPRl5LSCbX5dW6Dioqhpj/JGWkII5n0cbjmhv4KO4i6etjXz
	 G24Hx3nv1HrAvDg2ySgCrMwU5Vbtuzu7inDMg70A=
Date: Tue, 17 Nov 2026 20:23:32 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rachelmenge@linux.microsoft.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tpm: Cache TPM2 start method
Message-ID: <avy3xBltfKeCs85x@e129823.arm.com>
References: <20261115013456.212141-1-sidchintamaneni@gmail.com>
 <20261115013456.212141-2-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261115013456.212141-2-sidchintamaneni@gmail.com>

LGTM.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

On Sun, Nov 15, 2026 at 01:34:53AM +0000, Siddharth Chintamaneni wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Both tpm_tis and tpm_crb retrieve the start method from the ACPI TPM2
> table during device probe, and tpm_crb_ffa also needs it before chip
> allocation.
> 
> Cache the start method in tpm2_acpi_start_method during tpm_init(), log
> it when a TPM2 ACPI table is present, and export it for the leaf
> drivers, defaulting to ACPI_TPM2_NOT_ALLOWED when the table is absent or
> invalid.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Co-developed-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
>  drivers/char/tpm/tpm.h           |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e0385b16616b..c18b060d7da2 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -534,8 +534,17 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  }
>  EXPORT_SYMBOL_GPL(tpm_get_random);
>  
> +#ifdef CONFIG_ACPI
> +u32 tpm2_acpi_start_method = ACPI_TPM2_NOT_ALLOWED;
> +EXPORT_SYMBOL_GPL(tpm2_acpi_start_method);
> +#endif
> +
>  static int __init tpm_init(void)
>  {
> +#ifdef CONFIG_ACPI
> +	struct acpi_table_tpm2 *tbl;
> +	acpi_status status;
> +#endif
>  	int rc;
>  
>  	rc = class_register(&tpm_class);
> @@ -562,6 +571,18 @@ static int __init tpm_init(void)
>  		goto out_unreg_chrdev;
>  	}
>  
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled) {
> +		status = acpi_get_table(ACPI_SIG_TPM2, 1, (typeof(tbl->header) **)&tbl);
> +		if (ACPI_SUCCESS(status)) {
> +			if (tbl->header.length >= sizeof(*tbl))
> +				tpm2_acpi_start_method = tbl->start_method;
> +			acpi_put_table((struct acpi_table_header *)tbl);
> +			pr_info("tpm: TPM2 ACPI start method: 0x%02x\n", tpm2_acpi_start_method);
> +		}
> +	}
> +#endif
> +
>  	return 0;
>  
>  out_unreg_chrdev:
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index fa554c5ad80b..212ca2410c93 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -100,6 +100,7 @@ void tpm_sysfs_add_device(struct tpm_chip *chip);
>  
>  
>  #ifdef CONFIG_ACPI
> +extern u32 tpm2_acpi_start_method;
>  extern void tpm_add_ppi(struct tpm_chip *chip);
>  #else
>  static inline void tpm_add_ppi(struct tpm_chip *chip)
> 
> base-commit: 7e52fc165aa50e70e8df3c879d04fc0ff1673d4a
> -- 
> 2.45.4
> 

-- 
Sincerely,
Yeoreum Yun
