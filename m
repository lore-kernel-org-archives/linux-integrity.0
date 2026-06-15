Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0630F92D;
	Mon, 15 Jun 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525868; cv=none; b=T4/Odkns0sGNbRPcfbQ52DXd+mt5AhtC+tWx+cRZ+YRFFYQlVGctyGHaShekOvscmRLLPPobIwsho+QDRsCn3gfBUloMvQc2FhSdXfC2VSiGg8f41cK3d1U0rNtViJNy9auA1B9lmm96H+4Mf95oLm6ycyYkIpOcyGMwpynB6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525868; c=relaxed/simple;
	bh=fLIGOXgAZtsSKBEYYodyCYn2FgEOA2Fme6i2MBSLr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4la+XPfoADszT74wCebR47U7lVZdf1sJkFTjGiozAV3P+UMQOvO7dJGmxVe3ru8LLXy1uRMACo0aNBIM+kXg/+XcxBmGtq8Zc3T+SiL9IvqFzp7TyeYbot+BEX8Eqgz7IpobN2LgOuSsL1OKHoJxBmGSy533iB9Ab9la1+hWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkKpD52b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkKpD52b"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0A2291F000E9;
	Mon, 15 Jun 2026 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525866;
	bh=KsX+Beu6boU4Mdxu5+HSbWrO8RbfbRLaAx1VTbiHGk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkKpD52bCO8oeSI1lsueit/Wm+dI6Idw9gXOnZIZzHR+hVSsrqk1RqbY5O8I/2jxK
	 Ecg9LREPFnJdWbsiAjqFLgqDGUbMgaC5wV0iF3gNcdDaOWVNehLPiNYo2rzO4a4SZQ
	 pPM2M4L+CasdBSa/rNvCYkvI8DKhvqU/hPbRl2P3dzNuZcUwnTKHUVOwKZR1as7rx5
	 iJl6OQJw1/c8fQcvc7h2Su3yM+wjIoS9lVSVby0V0Y2o+p+A7huT23YAd817UvZEAZ
	 LJJ8RE/ILREK218iXLAJIK4l0ofE2FmD5SuGZxvPrhmKxbuvQL20rAet6zzrJhzUHS
	 lX7KkJddZltyQ==
Date: Mon, 15 Jun 2026 15:17:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Jun <chenjun102@huawei.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis: add settle delay after releasing locality
Message-ID: <ai_tZ0VM9PDCRMfl@kernel.org>
References: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086949bcf2c10bead892b0b4befd98da370cd3ee.1781498837.git.daniel@makrotopia.org>

On Mon, Jun 15, 2026 at 05:48:43AM +0100, Daniel Golle wrote:
> tpm_tis_core_init() releases locality 0 then immediately reclaims it via
> tpm_chip_start(); some TPMs (e.g. Nuvoton NPCT, TPM 2.0) need a few ms
> before granting it again, so probe fails with -1. This back-to-back
> release/request was added with the locality claim around TPM_INT_ENABLE.
> 
> Wait for the chip to settle after releasing the locality. A delay of
> TPM_TIMEOUT (5 ms) in __tpm_tis_relinquish_locality() is reliable; values
> below 3 ms are not.
> 
> Fixes: 0ef333f5ba7f ("tpm: add request_locality before write TPM_INT_ENABLE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 21d79ad3b164..6b90ff50c78d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -171,6 +171,8 @@ static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
>  {
>  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>  
> +	tpm_msleep(TPM_TIMEOUT);
> +
>  	return 0;
>  }
>  
> -- 
> 2.54.0
> 

Can rebase to my for-next-tpm and resend v2?

BR, Jarkko
