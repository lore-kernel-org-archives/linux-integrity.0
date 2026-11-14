Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690894;
	b=H2RXPF1MGHeud3RFNzj6G0vV626cBlSuLp4MtI5s7pQRWex0HQXbxJEHoLdBFdpGZIWH
	 QFFBcfIGrXS0VHZ8sM0dKpZcSznQoUTi+We9REij6tvT0zSmnia5FL7rsnaJyXW39qTW5
	 Iye8ZtukN8DaKmHXOSHNnKprtz5hvVTtzJ/29Y5GxIJ5gFX7tg/BKx/L4+WteRA+a1on2
	 R8WGunTU3MLuEIBn0Ptp8vR3V513u0Q2oe2rtNA7Nj/hhV9eD5fuSbAtkV62R+dEP/Yil
	 yQ/u665VT/e7OloOwaWOUm+v8uragBO59uMvCtBRwFwO1eH2vTkBxcqrbp+NlET9ADQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690894;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I/xn5VK9WmirnuCgk0IeQxX3/IaOL/2L/hCjRfFD/1Q=;
	b=3ML0hfFlIGTSjeaq2jvgMhkv2q4uxOZVEY4aUMC5QHFyoxkXeYPe9DkFIEtG6ZS9lMaf
	 kfN6VSjzDwoJm+Q1Mpg4rXpx2TY2fXt8jVCQBaj2xm+H/byr2I5zfq9QnqNDuKRzbdbtk
	 f37RSgRr2JgtxKMcgYNc0ztZncmNlYORKgxPViTSXdSva87zZzRKVmIP0A40izrnEEYWh
	 xiubKnupDfHVe6lSPRe3wxYgvEvwPHTW9ZBHIL3TgRri+JIXO9fDhNMUNPc9UcTH/G7/r
	 WioMVJwYs5meP9UyAxK0KoUZG0EB+Yf86i00miL9jQtAhJR1vVY1xISns/dOZS/yR1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3gNtaXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 60C82606A323;
	Sat, 14 Nov 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3gNtaXa
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 603081F000C4;
	Sat, 14 Nov 2026 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794690893;
	bh=I/xn5VK9WmirnuCgk0IeQxX3/IaOL/2L/hCjRfFD/1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3gNtaXaNXqkaGoQ4AtB/oTBLMitBuphKFfRbX7Z41cO4CnPTcWHw+rd/4N9ZoO9F
	 IeqZabYwMFiduGBtdt00T+vS7LzcuIbtpO8R/jZRuuzfFV1RLZG2cBdkSwIW7hiMuT
	 fnA7IVj9i5W+K6bdZUrfRzi98L0Ayd05hPfq+NahLdJ5svWdmQFcPH01Y55EHLHu4l
	 x9RrwrToIVfnfmtVrR3xdPHvbhhp6ek0M8d2pnFLircO8UnRPwG+wEoQMCWHWuvR+6
	 YtN7+jHezeBmf3F865Dhp9siQXh1Ob3D6TZHrYzvWBpsgfs0g5Og77dJM4rIZ6Vtlv
	 yeKyYZtaH5NzA==
Date: Sat, 14 Nov 2026 23:14:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rlmenge@gmail.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tpm: tpm_tis: Use cached tpm2_acpi_start_method
Message-ID: <avjPSnd2nhnBpsfZ@kernel.org>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
 <20261114193434.117714-4-sidchintamaneni@gmail.com>
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
In-Reply-To: <20261114193434.117714-4-sidchintamaneni@gmail.com>

On Sat, Nov 14, 2026 at 07:34:33PM +0000, Siddharth Chintamaneni wrote:
> Use the cached tpm2_acpi_start_method value in check_acpi_tpm2() instead
> of mapping and unmapping the ACPI TPM2 table again during probe.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 6f8344894ea5..a6fb6f889e7d 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -138,28 +138,24 @@ MODULE_DEVICE_TABLE(acpi, tpm_acpi_tbl);
>  static int check_acpi_tpm2(struct device *dev)



>  {
>  	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
> -	struct acpi_table_tpm2 *tbl;
> -	acpi_status st;
> -	int ret = 0;
>  
>  	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
>  		return 0;
>  
> -	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
> -	 * table is mandatory
> +	/*
> +	 * If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
> +	 * table is mandatory.
>  	 */

Delete this comment entirely. It has a low value.

> -	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
> -	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
> +	if (tpm2_acpi_start_method == ACPI_TPM2_NOT_ALLOWED) {
>  		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");

Delete dev_err()

>  		return -EINVAL;

-ENODEV

>  	}
>  
>  	/* The tpm2_crb driver handles this device */
> -	if (tbl->start_method != ACPI_TPM2_MEMORY_MAPPED)
> -		ret = -ENODEV;
> +	if (tpm2_acpi_start_method != ACPI_TPM2_MEMORY_MAPPED)
> +		return -ENODEV;
>  
> -	acpi_put_table((struct acpi_table_header *)tbl);
> -	return ret;
> +	return 0;
>  }
>  #else
>  static int check_acpi_tpm2(struct device *dev)
> -- 
> 2.45.4
> 


Finally after those suggestions this collapses into almost nothing i.e.,
please remove check_acpi_tpm2 entirely and open-code to the two call
sites.

Br, Jarkko
