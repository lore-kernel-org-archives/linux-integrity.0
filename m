Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948896;
	b=EDhuRTve/j9/ajASzoaezwTG7meCaLLMmr7Y/vFUTEfvAlUspe90NuAvyhQ9R+P/uGdx
	 o8Pf5cb/KAmG1x2j+zIiAGpo6aGyWMmBwGFvnIS1BVvIGo8borhBkI8+fHuXyrnvPCT8s
	 9Oq7QsoQXY1rkGcFTS45yU7k2BpUPN3VjewXrXR7UJVbF+HZrVDsnilqi6Ac+WR52+IwL
	 f4Q6/k6+yP3o5YYk51A1WIo9BrBCyzMsG3M9aj7FtAxb5UV2IvnrOULvubQdGGyOdgLge
	 Sm8U9jJ1qnombEePvk7xTxedOc5WuwGl8AdlgND6USc51C09zToT1f2pBiPKzOOtsFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948896;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XRrmtaJXQcHPgHjUtAr7Ja7rU75296IprzuTdzeTZgc=;
	b=GCxRgFYZMFJwF/YBZSSIim1p1d5mbfmlXvr+PLVBBvGtRGr+Jg8HisPCPmumAhx/GiK5
	 nzzk0KhmCeV43RGo6pPe5pk47aMoUHm+bFo4iJmnhjWVzu1KCDwje7RqpTQQdWRTZM1Dv
	 f0jjcIkVJn+Vmu+bVVi5ttsR6NJMY7xpYuwCRFlG0t95DbREoM7DJ5vJUjfxPNSXgZk8M
	 F6IUNwcIC22Bp1VNkfdyOSFP0ZShMS8TqqOczXsgzlkRe1R7W7ze7uFMsJiyrWYtROo9+
	 8jGW08Suo9C6yqb9M1FDdw5Rbktb/QenugwCn63qOReWSqeRwxcNPswJP6o+DXF/f8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSIOw+23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C64AF606A31C;
	Tue, 17 Nov 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSIOw+23
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D4F9D1F000C4;
	Tue, 17 Nov 2026 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794948896;
	bh=XRrmtaJXQcHPgHjUtAr7Ja7rU75296IprzuTdzeTZgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSIOw+23KO7sT+peMfCgKOW21k98uNBwkMQsEzuUKBPCr045oc0uM3N1levgzR9ju
	 oXwBzKwvbsWv8uCelcqd68ngfi+lEhCasNh9kt5f1sYN55Yc9EI1vXdRGUKmLgL+2r
	 KM5DkBU4dp4qUsyyfudAMK7oONRsyzyzA4Z2b7dIuc8StNGoxjc1Mv106yu28apZie
	 ViDhUSKBgkvva38bYzIHb+2MbgaY5qbfQASGBlXy92nIhpF3a1eMWXhw2GMCQ7xZS5
	 eS0Qm9EVMdW8tbhAoN69qz5P+Dgp6da0wwcxeWUwdy83mS4dmt6+JS59npU6FkG5TR
	 9lXRs0lrCueTw==
Date: Tue, 17 Nov 2026 22:54:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rachelmenge@linux.microsoft.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tpm: Cache TPM2 start method
Message-ID: <avy_HKn6whTYgCV4@kernel.org>
References: <20261115013456.212141-1-sidchintamaneni@gmail.com>
 <20261115013456.212141-2-sidchintamaneni@gmail.com>
 <avy3xBltfKeCs85x@e129823.arm.com>
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
In-Reply-To: <avy3xBltfKeCs85x@e129823.arm.com>

On Tue, Nov 17, 2026 at 08:23:32PM +0000, Yeoreum Yun wrote:
> LGTM.
> 
> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> On Sun, Nov 15, 2026 at 01:34:53AM +0000, Siddharth Chintamaneni wrote:
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Both tpm_tis and tpm_crb retrieve the start method from the ACPI TPM2
> > table during device probe, and tpm_crb_ffa also needs it before chip
> > allocation.
> > 
> > Cache the start method in tpm2_acpi_start_method during tpm_init(), log
> > it when a TPM2 ACPI table is present, and export it for the leaf
> > drivers, defaulting to ACPI_TPM2_NOT_ALLOWED when the table is absent or
> > invalid.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Co-developed-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
> >  drivers/char/tpm/tpm.h           |  1 +
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index e0385b16616b..c18b060d7da2 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -534,8 +534,17 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_get_random);
> >  
> > +#ifdef CONFIG_ACPI
> > +u32 tpm2_acpi_start_method = ACPI_TPM2_NOT_ALLOWED;
> > +EXPORT_SYMBOL_GPL(tpm2_acpi_start_method);
> > +#endif
> > +
> >  static int __init tpm_init(void)
> >  {
> > +#ifdef CONFIG_ACPI
> > +	struct acpi_table_tpm2 *tbl;
> > +	acpi_status status;
> > +#endif
> >  	int rc;
> >  
> >  	rc = class_register(&tpm_class);
> > @@ -562,6 +571,18 @@ static int __init tpm_init(void)
> >  		goto out_unreg_chrdev;
> >  	}
> >  
> > +#ifdef CONFIG_ACPI
> > +	if (!acpi_disabled) {
> > +		status = acpi_get_table(ACPI_SIG_TPM2, 1, (typeof(tbl->header) **)&tbl);
> > +		if (ACPI_SUCCESS(status)) {
> > +			if (tbl->header.length >= sizeof(*tbl))
> > +				tpm2_acpi_start_method = tbl->start_method;
> > +			acpi_put_table((struct acpi_table_header *)tbl);
> > +			pr_info("tpm: TPM2 ACPI start method: 0x%02x\n", tpm2_acpi_start_method);
> > +		}
> > +	}
> > +#endif
> > +
> >  	return 0;
> >  
> >  out_unreg_chrdev:
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index fa554c5ad80b..212ca2410c93 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -100,6 +100,7 @@ void tpm_sysfs_add_device(struct tpm_chip *chip);
> >  
> >  
> >  #ifdef CONFIG_ACPI
> > +extern u32 tpm2_acpi_start_method;
> >  extern void tpm_add_ppi(struct tpm_chip *chip);
> >  #else
> >  static inline void tpm_add_ppi(struct tpm_chip *chip)
> > 
> > base-commit: 7e52fc165aa50e70e8df3c879d04fc0ff1673d4a
> > -- 
> > 2.45.4
> > 
> 
> -- 
> Sincerely,
> Yeoreum Yun

Thank you. OK, I'll just apply these.

Br, Jarkko
