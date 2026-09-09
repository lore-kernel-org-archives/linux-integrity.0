Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0663493D2D;
	Wed,  9 Sep 2026 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994326; cv=none; b=tww9trRqEiaNO3sexeafcUmlB79vAK6me7oD7ErinPkG055wSE45bpMK4KKNKHkH/JfFKF8eJnZn4WgTGBHxbrvwAntuzWHxahbxu5tXgV4dX+XAmI8BeM0vUWlVw4U/UFHQaKBjprWJ45+yGkCVYrB13KGfUaRgKVdCWRbzCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994326; c=relaxed/simple;
	bh=teFGMqveRiOY8/qlv1aplNyGrG5WT8rKfzR8zDz/2LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvZluazRe9dyX3me/FsUfx4P16AI5UBtjghhAl98P6AEuGSv5OSvRhxbk2TopYtaEh/DRdM+nxflDI8il0UX3ZBYhCckG2XJCJFrjMRTyY7UvnBsLxACCc8VGAqOaJ1RbW7p8vwCU8ygnhWKaGOSn/N0doaxrS5G5W7ylwF9pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFxrLIsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFxrLIsu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2DC411F00899;
	Wed,  9 Sep 2026 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788994320;
	bh=SJqBu6VvjN1UBTNuwydo4Tp3hZHR+5dvmbAV7cYHE3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kFxrLIsujOwH4UfBEh5Tw/9nRHbUt0OjNnUrmmM9l+qGYq485YMBQwkMhtvi7ewbU
	 bFDCqOx/x1QUbUTiHRKXC/7xN+tWM2/WD3rzck1cAX7Tt5WphXG4SuNhIMsdV3WeVP
	 XuagMZkx7KMDB5jmKV+PG6SfnqHGhBqaFfdF1BvuGYLrMi7hwMzRFFSU9bLHJAqB4T
	 6vedc/gT2wFF6s73vt6iUVz8EqVw9jRd5Wil6GjAHVIWVSeTguflScwSJr9zTb4zDr
	 wJUq4dq5yxhGe1RHL+MPnZaCrELD9grNBXn8Nt+TgB+QTl4kHuG4F+NIdG+J9/OzQY
	 /dDtOxg1gxG+w==
Date: Thu, 10 Sep 2026 01:51:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Richard Lyu <richard.lyu@suse.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, fourier.thomas@gmail.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Remove ineffective wmb() from tpm_pm_resume()
Message-ID: <aqHjDClIsaboPBSh@kernel.org>
References: <20260908095748.78967-1-richard.lyu@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908095748.78967-1-richard.lyu@suse.com>

On Tue, Sep 08, 2026 at 05:58:02PM +0800, Richard Lyu wrote:
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
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Link: https://lore.kernel.org/all/a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com/
> Signed-off-by: Richard Lyu <richard.lyu@suse.com>

I agree that wmb() is necessary but what is the bug here?

Agree with the change but I'm not convinced about fixes tag here.

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

BR, Jarkko
