Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEF45038;
	Fri, 18 Sep 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693092; cv=none; b=IpAaR97saMp3XPx0k3odmAifNBBU7YEIktsibqyUU7FSdGtCEh3ab+G1TBP53yJJZiSCCBxqq1Pg2N2O3gtV7AIwYz2tU2m/p/3qCkvbt8EX5sJNm0fkPQDfuI/aGewzy9ydGKZXrTtWtW70JNBY0lqbv7bKxVnQ14PtM3zTma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693092; c=relaxed/simple;
	bh=hUaLARFPqzMu9Ebta676xImG5fTpiCS9LbbVSS4IZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/A9oF5kUEmSTz2krZIll2HjB1QdTWTIoxG3QX9ArA8qiAVXilDllRH6fEDldv7nDpIeHdmh7xJj+zdXNx9Sa/JW3ldRG8p5/jmr1Qk1f01XxG9GYRCO9SRgxWsv8OhaKk/p3878YmofCDqNE4k1o4bP49rGx+4BgtJXzMWI58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6YuuJqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6YuuJqU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D64EB1F000FF;
	Fri, 18 Sep 2026 00:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693091;
	bh=dMudoqixZuHduEGUS+C+EP809IDd5PnK4BWkDlML82c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d6YuuJqUbALbdHUnnXXRrbHCHxh6olWhWlURTEPdVkHiVP9r+cO/QGkOM9tztvOIj
	 dlPMXceeTpYO0m6PSk5kgoNsbl2DKlNRjMmG4weFQoeQVj1Dycykuu4/z5lPctjD59
	 +sbgVFQQuN8sDMo93qQ/9F66d1Itz6qa0P1eA0xzAg3zgNiamT5L8J4pbwmanBDxLz
	 2yqmugA/xLWH58DCfyvtcHxrSmn0sNh/EWnZJxpFnCNfzZKHAIWWOh3JfrC8/AI6A1
	 ziuQLbrGP0u+zgpdInkh/ooF6krKikRc5sZysvhOWDzPsng5B3Mgysgn0SkGhEvBD4
	 5JLXPiNRBWtYg==
Date: Fri, 18 Sep 2026 03:58:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Li Jun <lijun01@kylinos.cn>,
	Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Message-ID: <aqyMnwklQX3ciUzf@kernel.org>
References: <20260915201305.3529682-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915201305.3529682-1-arnd@kernel.org>

On Tue, Sep 15, 2026 at 10:12:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Changing to DEFINE_SIMPLE_DEV_PM_OPS() broke here because the
> tpm_inf_resume() function is hidden in an #ifdef:
> 
> drivers/char/tpm/tpm_infineon.c:615:61: error: 'tpm_inf_resume' undeclared here (not in a function); did you mean 'tpm_pm_resume'?
>   615 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
>       |                                                             ^~~~~~~~~~~~~~
> 
> Remove the #ifdef check.
> 
> Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/tpm/tpm_infineon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 84a0d3e5f679..d6edd2ca39a5 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -594,7 +594,6 @@ static void tpm_inf_pnp_remove(struct pnp_dev *dev)
>  	}
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int tpm_inf_resume(struct device *dev)
>  {
>  	/* Re-configure TPM after suspending */
> @@ -611,7 +610,7 @@ static int tpm_inf_resume(struct device *dev)
>  	tpm_data_out(RESET_LP_IRQC_DISABLE, CMD);
>  	return tpm_pm_resume(dev);
>  }
> -#endif
> +
>  static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
>  
>  static struct pnp_driver tpm_inf_pnp_driver = {
> -- 
> 2.53.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
