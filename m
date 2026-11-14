Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689682;
	b=s+2JeoGq2KPZ4Bx9xsD+C/ihloN562I2zAwlINaHiuRI1eqIHfbZcldO25pZjmyfNjMt
	 skQkUE6Ji9/gLB8mMu8/jhasWRYJcSNOYQGe1EljxiKWB/MttUA6Y10RmeCNSGVPomHVT
	 8qe+SlXefbFQPcVUPLY2inImrMbv5Mgtl2IZc3EPbV1QAKzcTQgN50Plo0vON63SiRpn7
	 HlbTTEsHUqfkYWSCegbnYEeYHir3DIoxcThJVo1uQHwGGctaXJX/IYAsmw4UNW/Gwy9Dg
	 jJOXZfmLUuHfRZLIz+x33AZP8h0KsyhbbH7nVoMU2+UnMdRDP2oJfQfgm3109v98/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689682;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TQ5kdfKoDSHHA0HH18rdLeWqyiK2C+E+94Dvl/EaRP4=;
	b=T/I2cuToBQmtT2pfGOUze3Muh850J6Y0eC9o4FEPzp0rycCY2Hc5bA35VUFjYer7IVlt
	 +MwnNhdOMWkHXine9DXbTjHor6+h2reQIeU37KZByTMYXC8A+BdZlvTcXuxlJ/N3KxBQo
	 DW/Vz6SHDyRlOXGKFEHDb8zc0BFFtrqI8tvzZM0VNtljUPPi8YPirYn4wxflxfo/KB2Oc
	 eBcy25Dy4TE43QcTHaN60Mg6iHT2+L3jodq8KleJvBc4ngzj8Xgq+2FkLcA/AC8hgMFIf
	 mDJA2UvR/eeWJNbvgKa4Qa/iA2mkCQ8RoJz363SOyO5I3WM58SubVKb/XrH6Kb3xLlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNLafLHh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 91528606A327;
	Sat, 14 Nov 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNLafLHh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 889CE1F000C4;
	Sat, 14 Nov 2026 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794689682;
	bh=TQ5kdfKoDSHHA0HH18rdLeWqyiK2C+E+94Dvl/EaRP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TNLafLHhzihIlLmpX3PZK0OvfuUoTn8XvOH66sIKV/vACxM7YxgJmIA5XI8Ts83jW
	 HgrxQndKz1If7qPrDB4UyQmEuh+V8FIOKyBoSmlA79x0xdxQK4AQygoXnzzN7GpvmV
	 XMnReFMgq90uxInCSuF8opZHsm1O9hlb1hSFcTTi6U/1HDlK6GEW/LaFMYyK43rgKz
	 iOKwTZuwcxRm1yg5n5aBD5XZpd00YFqs6dvX2q4uPda0Nf56mqPXIxahKTWwopGi3s
	 DvMOj7NkQ/XCfunBcoMTvnlkLBDCe+BctOm02N16Bf6lqz2fWP8yCd6Apt62COZ56f
	 FJ2WXFJaV8BjQ==
Date: Sat, 14 Nov 2026 22:54:38 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rlmenge@gmail.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Cache TPM2 start method
Message-ID: <avjKjhmtPChVMaF2@kernel.org>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
 <20261114193434.117714-2-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261114193434.117714-2-sidchintamaneni@gmail.com>

On Sat, Nov 14, 2026 at 07:34:31PM +0000, Siddharth Chintamaneni wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Both tpm_tis and tpm_crb retrieve the start method from the ACPI TPM2
> table during device probe, and tpm_crb_ffa also needs it before chip
> allocation.
> 
> Cache the start method in tpm2_acpi_start_method during tpm_init() and
> export it for the leaf drivers, defaulting to ACPI_TPM2_NOT_ALLOWED when
> the table is absent or invalid.
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
> index e0385b16616b..7b7da79bee7c 100644
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
> +		status = acpi_get_table(ACPI_SIG_TPM2, 1,
> +					(struct acpi_table_header **)&tbl);
> +		if (ACPI_SUCCESS(status)) {
> +			if (tbl->header.length >= sizeof(*tbl))
> +				tpm2_acpi_start_method = tbl->start_method;
> +			acpi_put_table((struct acpi_table_header *)tbl);

I would add right after acpi_put_table:

	pr_info("tpm: TPM2 ACPI start method: 0%02x\n", tpm2_acpi_start_method);

It covers all three possible conditions:

1. No TPM2: nothing gets printed.
2. Has TPM2 and start method: start method gets printed.
3. Has TPM2 but no start emthod: 0x00 gets printed.

I hate fostering klog messages as we have acquired great tracing
capabilities over the years but here I think having this is even
"sysadmin-useful".

Br, Jarkko
