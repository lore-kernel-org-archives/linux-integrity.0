Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD43914FE
	for <linux-integrity@vger.kernel.org>; Mon, 14 Sep 2026 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428966; cv=none; b=EG9kV5AlwYT8yttifsDh+xh0wC5vL8LMPVXUOmLsSyMdGJ+S9unTlzlyqEuck89Y7HE7Rzgee7Kx+TsXae2B4BYssM6Qrxn3duWVZhaK1FsEtxJXuMVPItmucivFtWM0EWxDPALRhm88oWkvWMwqOqu2byYEAGOoQJP/YVGFvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428966; c=relaxed/simple;
	bh=C6gBG4bmHJaYB2L1NbHkhbrAMkyZpJP7jPmhzZNFI/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBLLNo8sw2YBnFiq7PslLrA49bYGZikWSyCwWBkqRjpirdV+KdVUkow7NnUdWy4ZdSaBUV3rglCpwczOFN+RM1zdAhVa7oNszrcXqvNx0YNnj+mIkPcXqDYevCRn5ZNJ0qzQnohRqn2laTxpWtz6ws8pahXkfSmqlkt/BtRLs8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZBOAR9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZBOAR9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD0C1F000FF;
	Mon, 14 Sep 2026 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428965;
	bh=fBuFIsRUIYKxn/1+pDwpc3hyu++xeTr5cSM+1ao+XQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iZBOAR9Wn7oJt5/NSHQcDRkKhkMcuM+h/uMq54foAaKN1P4koO0V3+UUpwbI5LOg8
	 oeO2dSfR0A3/4Yr27l07bsjr14R5Pek/wzATxVDvX/qtTJxhrEnjdEETbOiKq4/kRF
	 QjNeV+K3/GGYWQTHUAy7a3Oxat+TanjbF9/MLk9BtjZBCI9Bv+57pS12O+0lc3sV5e
	 mewVLays88oxn70uFZW215X0/5pBbOz6SGmJT5Rf1NKS+E6d7gb+vA5wlhsHIbC+5F
	 lXj5mHpu2DTM3CJgYp5jLFYSr2CvzhfhBg8U0pRUeRwhhW0BD7MpNNzO5XKiqZ9B59
	 5k1la9FXHPg0Q==
Date: Mon, 14 Sep 2026 16:36:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Li Jun <lijun01@kylinos.cn>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()
Message-ID: <20260914233601.GA1539446@ax162>
References: <20260909082459.796628-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909082459.796628-1-lijun01@kylinos.cn>

On Wed, Sep 09, 2026 at 04:24:59PM +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
> and wrap the struct assignment with pm_sleep_ptr(). The old code keeps
> a completely empty dev_pm_ops structure -- all callbacks are NULL --
> as dead code in the object file when CONFIG_PM_SLEEP=n, because
> SET_SYSTEM_SLEEP_PM_OPS() expands to nothing while __maybe_unused on
> the struct only silences the warning without removing the struct.
> Switching to DEFINE_SIMPLE_DEV_PM_OPS() lets pm_sleep_ptr() eliminate
> the callback references at compile time, and wrapping the struct
> assignment with pm_sleep_ptr() drops the entire structure when
> CONFIG_PM_SLEEP is disabled, instead of retaining an empty one.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
...
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 7638b65b851b..84a0d3e5f679 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -612,7 +612,7 @@ static int tpm_inf_resume(struct device *dev)
>  	return tpm_pm_resume(dev);
>  }
>  #endif
> -static SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
>  
>  static struct pnp_driver tpm_inf_pnp_driver = {
>  	.name = "tpm_inf_pnp",
> @@ -620,7 +620,7 @@ static struct pnp_driver tpm_inf_pnp_driver = {
>  	.probe = tpm_inf_pnp_probe,
>  	.remove = tpm_inf_pnp_remove,
>  	.driver = {
> -		.pm = &tpm_inf_pm,
> +		.pm = pm_sleep_ptr(&tpm_inf_pm),
>  	}
>  };
>  

This patch is in -next as commit 2249200ee420 ("tpm: use
DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()"), where it breaks the build
for CONFIG_PM_SLEEP=n kernels because some of the functions are not
visible in these configurations.

  https://lore.kernel.org/202609121207.tM2OfBmR-lkp@intel.com/
  https://lore.kernel.org/202609121338.qo2mQWRl-lkp@intel.com/

It should be fairly easy enough to expose these functions regardless of
CONFIG_PM_SLEEP (or add some stubs) but I think this patch should be
dropped until it can be done in a new version.

-- 
Cheers,
Nathan
