Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF53D6CA4;
	Mon,  4 May 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907594; cv=none; b=Tgaahc/cTf6KvrYpAJKak5M47kNvjybyJLrt9i3E6AH1UWon8uQWPVI+1rVIBh7spQD6A11v2bFxmDdYZ/6NL8EpDTcqT8aPznUqP/zLpj5C4+4+UrXK7FyV6+mkU8Ao7ncWJU0j2F1uc+ZP8vDYdQefL3tVDPjh71ngcTjGXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907594; c=relaxed/simple;
	bh=8IMBww72mpNOQ+8SVFoeClU+nma0jaNxAOAbgxUsFKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvCuA3rBCq5fuSzyIMepiwY3178kLoO9t0EbP4MRUuyl7wCmV18TMbLIYnBCJ7e9B1WF1u5juYnFuOo1GDgkEmSKyCGo4cwYuz10EOmiLebZkjw/8wvIOgNXx4MOKACrCoD0PyjEi7dZFcKrCOK08E9eN7A0w41Fzbzemrn6s3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhB+/Fex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhB+/Fex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB67C2BCB8;
	Mon,  4 May 2026 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777907594;
	bh=8IMBww72mpNOQ+8SVFoeClU+nma0jaNxAOAbgxUsFKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhB+/FexXLXKiNtVYurVAdcY44Le2VYRnRc7cjh7urOPBd6ObJ3Tz5gh2/bUuxO8p
	 tJqF2PqKVfy8QNd00uFq4WmrY9GUMHw6VjwF+S6rhQfPdqIfG15/g/Npglnkq+uupT
	 gMemgMvZEcoaNIaJHLyijXXQtwD3iIJueRZay4d8tjti0cQxT5yPC/flfXD+Kv3UjE
	 r7nuzr2jI98ZfoHypErmuyQGR7YNXyNfdcWoJLg9vWUTsZZIg131xGX7Sj08/9i3+h
	 YvLzjVRZISBL0GFX/2H8jafDvUd9woCUFiJaG4ha4mGcdz7+piXqALh1w0s7HpniNW
	 poqoPK7hR4FHA==
Date: Mon, 4 May 2026 18:13:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Baoli Zhang <baoli.zhang@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>, Lili Li <lili.li@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: restore timeout for key creation commands
Message-ID: <afi3hrjLm36qPc_T@kernel.org>
References: <20260421005021.13765-1-baoli.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421005021.13765-1-baoli.zhang@linux.intel.com>

On Tue, Apr 21, 2026 at 08:50:20AM +0800, Baoli Zhang wrote:
> From: "Baoli Zhang" <baoli.zhang@linux.intel.com>
> 
> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> inadvertently reduced the timeout for TPM2 key creation commands
> (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) from 300 seconds to 30
> seconds.
> 
> This causes intermittent timeout failures, with several failures observed
> across hundreds of test runs on some Intel platforms using Infineon
> SLB9670 and SLB9672 TPM modules. Restore the timeout to 300 seconds to
> avoid spurious failures.

Is this a production case?

I'm not sure if there is anything to fix tbh. I mean it is
pretty much the same as "maintaining compatibility to OTT driver"
to addresses issues on undisclosed hardware.

Please correct me if I'm wrong. Otherwise, I'd carry out internal patch
to tweak this for pre-production hardware (presumably).

> 
> Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> Co-developed-by: Lili Li <lili.li@intel.com>
> Signed-off-by: Lili Li <lili.li@intel.com>
> Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
> ---
> Changes in v2:
> - Add description of intermittent nature of the timeout issue.
> - Fix Co-developed-by and Signed-off-by tag ordering.
> 
> v1: https://patchwork.kernel.org/project/linux-integrity/patch/20260410014940.3557934-1-baoli.zhang@linux.intel.com/
> 
>  drivers/char/tpm/tpm2-cmd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 3a77be7ebf4aa..430022f695f24 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -71,9 +71,9 @@ static const struct {
>  	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
>  	{TPM2_CC_GET_CAPABILITY, 750},
>  	{TPM2_CC_NV_READ, 2000},
> -	{TPM2_CC_CREATE_PRIMARY, 30000},
> -	{TPM2_CC_CREATE, 30000},
> -	{TPM2_CC_CREATE_LOADED, 30000},
> +	{TPM2_CC_CREATE_PRIMARY, 300000},
> +	{TPM2_CC_CREATE, 300000},
> +	{TPM2_CC_CREATE_LOADED, 300000},
>  };
>  
>  /**
> -- 
> 2.43.0
> 

BR, Jarkko
