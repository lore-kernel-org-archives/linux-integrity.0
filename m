Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C1F29827E;
	Wed, 15 Apr 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220267; cv=none; b=V88TBcl0u1YsvzIWtZrLFevOCg1exMG1RADbednYdsokyvpakSr/TltPbZekME+7DikU57wXMD1Mofi12OOjRCg1VjTKn4CfpmxEOvsKLsZroP/tAb5AB6mYEGUtCgoye4/Q8YVcwWQ1KoB7KOkDWvVafI2VX1Ezd1BzQhgpOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220267; c=relaxed/simple;
	bh=UYKlLWlVtfjwbRiUI0nF0S/H1logZGDlMsNXw8bz1zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDRvMWAvX2JlVaQpMn0FUW+g5cz5pObJDb8zNcSnn1/3Zx8fns6ANJRHnxdF59waXVOLfWHXWRc57tRiKw14LHSqRvTRcmlPQTHHNzmkUqbg/ZDVb4/aRqawk6sDzL5d7XFuHaFIgnKzLBjYtk4kurU4qf4ODHg6PTaZS+FVX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKZtfNki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKZtfNki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEF7C19425;
	Wed, 15 Apr 2026 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776220267;
	bh=UYKlLWlVtfjwbRiUI0nF0S/H1logZGDlMsNXw8bz1zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKZtfNkiM03NSSjZqHAPhB0Q7JFnbNMpyxCQ0/s5BJo8F+73c/97vsG8EGNF+p4IS
	 HJCxJbjgVRb1wPrGRsIV2UF39QEAojoZ604ge2sRZorPW0UCI+zTm6iki7MjaArDWY
	 1QF0rd3YSbbVPswkhR4Rh4wE37cYm+RGJuzzU7y4y/j6mkfXnkgfmn/O2+8fDOokc4
	 SkxgSJ7pKq83WmqXsi5D49dqMoc3z18TQOfWbY53YEESs9bK/zRxRLKTWYnQN9CWuN
	 d76jTZZTVCbTHpGYUm1Dxa+39WeacUtO2mVCeSFoLRe/AvdGM7ziwl43X0RA2rlbOX
	 S5rJZUIPSdKtQ==
Date: Wed, 15 Apr 2026 05:31:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Baoli.Zhang" <baoli.zhang@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>, "lili . li" <lili.li@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tpm: restore timeout for key creation commands
Message-ID: <ad74Z1ev6toxcozf@kernel.org>
References: <20260410014940.3557934-1-baoli.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410014940.3557934-1-baoli.zhang@linux.intel.com>

On Fri, Apr 10, 2026 at 09:49:39AM +0800, Baoli.Zhang wrote:
> After the per-command duration map was introduced, TPM2 key creation
> commands (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) were limited to
> 30 seconds.
> 
> On some platforms this is not sufficient and key creation can time out.
> Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> inadvertently reduced these command timeouts from 300 seconds to 30
> seconds. Restore them to 300 seconds to avoid spurious failures.

Is this like pre-silicon (FPGA) type of situation? I have doubts these
latencies happening on ASIC.

If it is pre-release hardware, maybe there should be option to extend
the delay, or does this happen on actual production hardware?

Just want to understand this better...

> 
> Fixes: 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> 

Extra empty line.

> Signed-off-by: Baoli.Zhang <baoli.zhang@linux.intel.com>
> Co-developed-by: lili.li <lili.li@intel.com>

"Co-developed-by: states that the patch was co-created by several
developers; it is a used to give attribution to co-authors (in addition
to the author attributed by the From: tag) when multiple people work on
a single patch. Every Co-developed-by: must be immediately followed by a
Signed-off-by: of the associated co-author. Details and examples can be
found in Documentation/process/submitting-patches.rst." [1]

[1] https://docs.kernel.org/process/5.Posting.html

> ---
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
