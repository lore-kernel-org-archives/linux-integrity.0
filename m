Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249736;
	b=gMVocoMDnON8dzbqfkajoct7pLy0jhRMDKj0wmif8OBP9Sto14Oifcpq+v2yQUuozWj2
	 KYpAL5RKY8983G61W2GlDch1tlG8ArkxltMHCq3+7qDczqMYWIIKAbkTOLD3dhBkjZD2Z
	 R98ml5nIt7GObOVWc0mZrKUnYhCiDiOQj0SbYxxqQVTQFyEd7GaJ+Ey1DY1QC7oBBKCv3
	 Rqo+0LRGx7Ep8O3Ta6o7bUXDSoiQ4CHqsXyyFRoAo+nmyBJ3qE073He3e/gu0D1EdmxsL
	 +KO4xaYwVkyTWR+2sYs1cqXstj4IL2mwecdW9CAh3pMu+x2Q40vHR5LwXGATeMkMxIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249736;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6Nh13piCaLBFueQC0nlxMCXeZfF3rxEmpj5rMvCEqxU=;
	b=Ugbem73RRjhrgJbHz8b8QgjQzuyA+wZqVc4uxxiToBclCQOcHmff1qyS+j7WhAuyNyYo
	 VKYycKOAdR1JaeJpDw+6PyzcWpdz+ZLojPcPPqtUaLbpk4RAlHMemRQIFP51DaeG9nGP5
	 sNx9TzPYROvhZdBdGVMy4kqYzPTWGVc9RMjpBOy6nfy67Lao9W+pCHI5AFup+YTDZzc+0
	 ATyOoa09x2XcOd1fskWQqU1MlMBEUcOStGwQpxonH+v6QXm48dcaaF4h1EKGgRxR0LFKY
	 Yih9h06Fn/gryRE8WDKug9CnzZpcVbio5Z2MfuVibb7JtTRCYJ8PNvCP3HvoLnuGNtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCqB7UIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 531B5606A338;
	Mon,  9 Nov 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCqB7UIX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 53F101F008A1;
	Mon,  9 Nov 2026 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249735;
	bh=6Nh13piCaLBFueQC0nlxMCXeZfF3rxEmpj5rMvCEqxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCqB7UIX5+smAZhQRWRJVTdtCZLFWm141RXX46p6W5RgdYaJeXE+7KCMOWjVewCMp
	 41/fI0MwiaC+DjZrIZDVUgMmOKPlXOKBOCK73AaUlTTwkehwL7pZUqn7RHI6+Q1LxQ
	 ja9Km4nfhSatG+q+PiNM/3EkcG/SEOiVdc4sdobuii4/+/z9muif8KUaciDT4DSwjX
	 uQGawFktlafxiR/KNmMBjvPu+oZ8CFV5lf0ukdSh7V5MgwRleggPFEtr2gZ+pmqbpZ
	 k4zi5vQTE19JYiPRlNGqAFQB3dg6YlXFqcvE71jIzsqUYs6K/0KZNV5966jwtA0VVr
	 FxC2nWcJVMG4g==
Date: Mon, 9 Nov 2026 20:42:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: acpi: Fix memory leak at tpm_read_log_acpi()
 error path
Message-ID: <avIUA2WeE51HVOEa@kernel.org>
References: <20261109173756.742248-1-tiwai@suse.de>
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
In-Reply-To: <20261109173756.742248-1-tiwai@suse.de>

On Mon, Nov 09, 2026 at 06:37:52PM +0100, Takashi Iwai wrote:
> When devm_add_action() returns an error, tpm_read_log_acpi() clears
> log->bios_event_log unnecessarily to NULL before calling
> tpm_bios_log_free(), and it would lead to a memory leak of the
> allocated log buffer.
> 
> Fix it by simply jumping to the err.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a3a860bc0fd6 ("tpm: Change to kvalloc() in eventlog/acpi.c")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: minor update of patch description and tags order
> 
>  drivers/char/tpm/eventlog/acpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index cf02ec646f46..50770cafa835 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -167,10 +167,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	}
>  
>  	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> -	if (ret) {
> -		log->bios_event_log = NULL;
> +	if (ret)
>  		goto err;
> -	}
>  
>  	return format;
>  
> -- 
> 2.53.0
> 

Thank you!


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
