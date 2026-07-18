Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBE212FAD;
	Sat, 18 Jul 2026 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399725; cv=none; b=JNPiOrngntkG7wSqi4CdMU43I68oPh2BBoBEzcVj2sb0OtSX2+pDQbYVsQh9QjuEHs4/rYR++zqzDg2uJklWcn8fI6WTawkd5iBpbUAZyiquSofkhnxPdaVVWdgVYIpKxWErA2JBSCrUCcJ11toqdqV5/uG+mt0OtjsgDeB27po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399725; c=relaxed/simple;
	bh=ekhwc2Brci30oZTP9vwTKDr7x9yUXsPW/+gttCkRu1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkWVNpwf5EL3WE8gzWOuPW9gc5m+ZsW2dzG/O1zO+EmedyWRP0nZbRhdzvIqzdZMJl1vcdNaHoJrLZwlHq3B7BQJ2AfUULylfNK0zLL/rfJeGKI76TTNXIzQLvoNWeUQKBqRfUxfX0DaxyPlXWn3BX5kLWMvo38JYp1Yby4mRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9hLtmFy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9hLtmFy"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4D30C1F000E9;
	Sat, 18 Jul 2026 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399723;
	bh=891uDDxwlxIQSvZOY47rFcL38hh0FAisfZb0rSq3BC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c9hLtmFyo/WP9R8Q/H4Kq/bPsG8CYLR9+woXQ+fe5s33uzZSgBBRShwITkJSmDAvh
	 SdlQuv12jDz84rORs61cza1/Hk8GE4GIKH/4KbB/UOLUDgJIlcjKPDP4XpSy+sCqAv
	 Q4yx8AgQpMTAD/32zRgoJZS0mrKHWSHeQjWK6aiNNcHd/ViKhs+5w2XYT/ZIHtrMlL
	 s0S3EPYU9GfdV/GNHHWPzHouN7HF3yEjvw6FYVo9McB+euw02vlgNMKtHIin1cpthw
	 MasqO/Cqso0DrD2UMjDX7JyFsw3C7PhhkyeBRz1b4v3/+sASf2rFSZ5f7K85rKX6dz
	 gA71wt2HkxyAg==
Date: Sat, 18 Jul 2026 21:35:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: atmel: depend on X86
Message-ID: <alvHaDuqU-HIm_G1@kernel.org>
References: <20260712183234.23125-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712183234.23125-1-kmehltretter@gmail.com>

On Sun, Jul 12, 2026 at 08:32:34PM +0200, Karl Mehltretter wrote:
> tpm_atmel probes for the chip at fixed x86 Super-I/O ports (0x4e) with
> inb()/outb(), so it only works on x86. TCG_ATMEL nevertheless depends
> only on HAS_IOPORT_MAP/HAS_IOPORT, which arm and arm64 also satisfy.
> There the probe is useless, and on platforms whose unbacked I/O access
> faults it oopses in init_atmel() at boot (e.g. arm/versatile):
> 
>   Unable to handle kernel paging request at virtual address fee0004e
>   PC is at init_atmel+0x34/0x244
> 
> TCG_NSC and TCG_TIS already "depends on X86" (commit 2f592f2a7d74 ("TPM:
> NSC and TIS drivers X86 dependency fix")); TCG_ATMEL was missed. Add the
> same dependency.
> 
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/char/tpm/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 8a8f692b6088..5f672f2c01b0 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -163,8 +163,7 @@ config TCG_NSC
>  
>  config TCG_ATMEL
>  	tristate "Atmel TPM Interface"
> -	depends on HAS_IOPORT_MAP
> -	depends on HAS_IOPORT
> +	depends on X86
>  	help
>  	  If you have a TPM security chip from Atmel say Yes and it 
>  	  will be accessible from within Linux.  To compile this driver 
> -- 
> 2.39.5 (Apple Git-154)
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
