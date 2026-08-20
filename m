Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2262E92BA
	for <linux-integrity@vger.kernel.org>; Thu, 20 Aug 2026 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268970; cv=none; b=B79CGGDeSmcbaLn2VGaU8BLPJ/MFPzdkR4uHQtgIvFEYv2SHX56/ec9XUm1gd04XZtdr4p9aqcEKNxLrup9dQ2ejSEThZymiyIspdRcYS6kkmGUU/2cfZ7Bs7ONGampJkhYCIEQj1gP7a1YopFkr44yoUpn1szOcMRAyqXrGnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268970; c=relaxed/simple;
	bh=k56U3/TeDJx4xaZCeNeCMqtTl0gFlsMrMqeRe3SqIng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSwMbd9g1g3MSiLJt988BYi7nYTvt+z7spPczAGw3mTykr3ppYagAG8zTJR753T2jqrptlEICTLf8VNXg+JxvyWkEMwA88s3V5iDyC9VoqKW1K/19MN1yuZJuvzRncA4Q8/SAd+LI1dZDjbc9OaaVTUHff9ZWvyQlWKzo4lxVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZWk7zBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZWk7zBN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BE1AC1F000E9;
	Thu, 20 Aug 2026 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787268969;
	bh=3wWbCywc7rHk7M10qNsMrsFx3GqV+4Ia0dAz6sbHjPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jZWk7zBNRgiz/Y6dWJ/kMA/EAQysiR8lOuo0Me+q5KFcU99kVLckr+fociLZbYJ0P
	 0fenrSbvGCY5UiB0XyPdTnFNKF2qdDgGS42s7kKMjbkziv2DSVL3xGZcTGIyrXsOyx
	 erRCVUcScLzUcXDJx7vCrlu6yrKMmtkfZvY8EK09pjEypRqK0nseI7T6ACIIk5MAwW
	 7fUAzviasvTlFn49kGqvEAfItpm1UNWuTsEYibi7Y/30P0iSXJ2OMo8XXmx0pL1YUU
	 WdsFADkchrwSXCCT47Rem0M1/hT5d0Y5aUdPLS+Vo7IbD8GxvZFmacg4ZBFjMqlrIU
	 s3qtWe8e5MGxA==
Date: Fri, 21 Aug 2026 02:36:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Li Jun <lijun01@kylinos.cn>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is
 null
Message-ID: <aoePZSImVOBKHyZ4@kernel.org>
References: <20260812100914.3540149-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812100914.3540149-1-lijun01@kylinos.cn>

On Wed, Aug 12, 2026 at 06:09:14PM +0800, Li Jun wrote:
> if no define CONFIG_TCG_TIS_SPI_CR50 in config,
> the add of tpm_tis_spi_resume is null, this cause the tpm chip to
> fail to resume.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_tis_spi.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
> index d0f66f6f1931..ced416ecd92c 100644
> --- a/drivers/char/tpm/tpm_tis_spi.h
> +++ b/drivers/char/tpm/tpm_tis_spi.h
> @@ -40,8 +40,12 @@ static inline int cr50_spi_probe(struct spi_device *spi)
>  }
>  #endif
>  
> -#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_TCG_TIS_SPI_CR50)
> -extern int tpm_tis_spi_resume(struct device *dev);
> +#if defined(CONFIG_PM_SLEEP)
> +	#if defined(CONFIG_TCG_TIS_SPI_CR50)
> +		extern int tpm_tis_spi_resume(struct device *dev);
> +	#else
> +		#define  tpm_tis_spi_resume tpm_tis_resume
> +	#endif
>  #else
>  #define tpm_tis_spi_resume	NULL
>  #endif
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

thanks

BR, Jarkko
