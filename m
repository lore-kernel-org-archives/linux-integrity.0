Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5A339714;
	Fri, 18 Sep 2026 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692920; cv=none; b=SffdP64CeE30sbjz9qWCR/RxiSdwJqn5ofmbSXTG5ptUuiCPJfh/ENJuilQoJkaVol80RAJH2njuBepqKxWR5P7Ar7Hrh2Ya5+A35hmFxghtGMzOnYXK8V9x7F2E/jQBI8+Q6owIXVRI93n46KWQbQr814jLYsoOVya43IS6YeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692920; c=relaxed/simple;
	bh=gk4WPqEvTswRxAOCvy6OW+OPESzKuxGZkdL4rI5YR0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHsR0F3VuyefFPwjK/zM8V9UC5GHWEW8Zr65ngyxQRbvEtb7kEKkUVeQWrcxhT3tiTRiLJogmPd40OGtHKdb0ZyvM7a6vLiurMYSQimnoSMZ98FThmsid0WH/S5OxrUtYCoDbNir2Gh/SwPO+d1Pem95c2of/fnZKQpM+KVmysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/Jc4Iuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/Jc4Iuy"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8D4DD1F000FF;
	Fri, 18 Sep 2026 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789692919;
	bh=s+fzD5Qq5ldl6yAGN4TDRdep8xhWWkgNXR7u1TjX7t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P/Jc4IuyAmXx0zoF4J3fvmHirQuBwbhn/RmDJuhH8lyxjKe47mJ+HsMIRqHILAU6T
	 3Yx9bARciI2tlNUlxEm7YME/B3Da4pzL9lF0nW32C20/wJQZnK0maBARUrn/dtbVid
	 4RgJlZWTNnK352RQn0VjGO29FGNKWQG7FAPjats7Fxg9AB1IkGR6T/JcX9gAIdD3iE
	 r0IBKYperch64A5xbDggSRQPba1mcrd5Ueuq191PucXkAoCX0CptyuOa594xNHSyyk
	 JoDL+b+L8xySIzN8fLJWcdIS1c1ug9TR2o59vbN7cLEMI1H4S0WJp6AmXbi+wJxQlK
	 rCuewfI6LwbPw==
Date: Fri, 18 Sep 2026 03:55:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Richard Lyu <richard.lyu@suse.com>
Cc: fourier.thomas@gmail.com, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm: Remove ineffective wmb() from tpm_pm_resume()
Message-ID: <aqyL87YNcLrAZ0fV@kernel.org>
References: <aqIVn0cDBvIYKggE@r1chard>
 <20260910024430.40418-1-richard.lyu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910024430.40418-1-richard.lyu@suse.com>

On Thu, Sep 10, 2026 at 10:44:31AM +0800, Richard Lyu wrote:
> The comment above the wmb() in tpm_pm_resume() states that the barrier
> guarantees TPM_CHIP_FLAG_SUSPENDED is written last, so that hwrng does
> not activate before the chip has been fully resumed.  It cannot do so:
> it is placed after the store that clears the flag, and therefore does
> not order the preceding resume work before that store.  It also has
> nothing to pair with, as tpm_try_get_ops() contains no matching read
> barrier.
> 
> Drop the barrier along with the comment rather than leave a no-op
> behind.  Should such ordering turn out to be needed, it would require
> paired barriers or locking.
> 
> Link: https://lore.kernel.org/all/a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com/
> Signed-off-by: Richard Lyu <richard.lyu@suse.com>
> 
> ---
> v2:
> - Drop the Fixes tag: this is a cleanup, not a bug fix.
> - Link to v1: https://lore.kernel.org/all/aqIVn0cDBvIYKggE@r1chard/
> ---
>  drivers/char/tpm/tpm-interface.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index b4e749e70b02..0bab78c8767c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -497,12 +497,6 @@ int tpm_pm_resume(struct device *dev)
>  
>  	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>  
> -	/*
> -	 * Guarantee that SUSPENDED is written last, so that hwrng does not
> -	 * activate before the chip has been fully resumed.
> -	 */
> -	wmb();
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_pm_resume);
> -- 
> 2.51.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


BR, Jarkko


