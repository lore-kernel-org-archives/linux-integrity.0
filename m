Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B793D9041
	for <linux-integrity@vger.kernel.org>; Fri, 18 Sep 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699410; cv=none; b=n55P7S373a4KTl/Ztc1M8x8Ku5WXLt7+fOaklHE8xarmF5TvUFQ1dshNZ347AK0qvLh2TCS60SlXupAAJV4piiTDVVhDTUHIct+0B3biw1X1ZvQMeavuxNQghcpN0DMvsh1y5uo+Jt+AiY1Z+QrsT1qeCw9Y3sigI1E6KVXQvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699410; c=relaxed/simple;
	bh=ii/KUerlHpdKCqG61yJIttjpItBwKK2w1SWMpRNbDIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovzbw/PTg4uizpmETh1lCVvPdo+/TUMkIDcKGgHyxNq32Xebesa7W2AGXserSfY+flllbHtJcDWTQwCduWhQuPM7FYbUxZnvYFdJLNcmHGELWxCf0M1vzjXzH7F3MjhgGhTeq4MGdfi2QDlGihQQWwc0MVqt/hb+Q8acNzNC2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH1WTfnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH1WTfnI"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BC3861F000FF;
	Fri, 18 Sep 2026 02:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699400;
	bh=E/+TrCS7lsqYLW12jpP9QNv8NrplzgC4xJS68u5lKNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iH1WTfnI35JNWjOskd95Q4U7yLofepUFGhRKH5lc7bucYPI12lQpbMu7/oZ0QKPMB
	 466IkY7I8il49FhE+BVE/vM/56WN/4C1R+MoDcyQSjBOYsz1ILFaPqnFPgB27Cdp7r
	 yKgUnOkInas3MJwazrzC3JFSDbaGx2f8X8XuopUAtz0km8n1Q1sRjutJEWu2Hjs2oi
	 9ITjaWzK4NKTo65nZg1R2RV+GX4qk0C6TLDqOIwpTQFTxN9vNEaTpgKiZSJvb10VyH
	 +Wi2vLlvy1zwTcK2kZIVAZguRnnXs4G+UHVqZoovXNGpSw4PAw2LP8gCK/grZNP6aN
	 tu0m8+Oz5AOnA==
Date: Fri, 18 Sep 2026 05:43:16 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Li Jun <lijun01@kylinos.cn>, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()
Message-ID: <aqylRLC72F58oG6Z@kernel.org>
References: <20260909082459.796628-1-lijun01@kylinos.cn>
 <20260914233601.GA1539446@ax162>
 <aqyjp9A3tk3l9AI1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqyjp9A3tk3l9AI1@kernel.org>

On Fri, Sep 18, 2026 at 05:36:27AM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 14, 2026 at 04:36:01PM -0700, Nathan Chancellor wrote:
> > On Wed, Sep 09, 2026 at 04:24:59PM +0800, Li Jun wrote:
> > > Replace the deprecated SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
> > > and wrap the struct assignment with pm_sleep_ptr(). The old code keeps
> > > a completely empty dev_pm_ops structure -- all callbacks are NULL --
> > > as dead code in the object file when CONFIG_PM_SLEEP=n, because
> > > SET_SYSTEM_SLEEP_PM_OPS() expands to nothing while __maybe_unused on
> > > the struct only silences the warning without removing the struct.
> > > Switching to DEFINE_SIMPLE_DEV_PM_OPS() lets pm_sleep_ptr() eliminate
> > > the callback references at compile time, and wrapping the struct
> > > assignment with pm_sleep_ptr() drops the entire structure when
> > > CONFIG_PM_SLEEP is disabled, instead of retaining an empty one.
> > > 
> > > Signed-off-by: Li Jun <lijun01@kylinos.cn>
> > ...
> > > diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> > > index 7638b65b851b..84a0d3e5f679 100644
> > > --- a/drivers/char/tpm/tpm_infineon.c
> > > +++ b/drivers/char/tpm/tpm_infineon.c
> > > @@ -612,7 +612,7 @@ static int tpm_inf_resume(struct device *dev)
> > >  	return tpm_pm_resume(dev);
> > >  }
> > >  #endif
> > > -static SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> > > +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> > >  
> > >  static struct pnp_driver tpm_inf_pnp_driver = {
> > >  	.name = "tpm_inf_pnp",
> > > @@ -620,7 +620,7 @@ static struct pnp_driver tpm_inf_pnp_driver = {
> > >  	.probe = tpm_inf_pnp_probe,
> > >  	.remove = tpm_inf_pnp_remove,
> > >  	.driver = {
> > > -		.pm = &tpm_inf_pm,
> > > +		.pm = pm_sleep_ptr(&tpm_inf_pm),
> > >  	}
> > >  };
> > >  
> > 
> > This patch is in -next as commit 2249200ee420 ("tpm: use
> > DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()"), where it breaks the build
> > for CONFIG_PM_SLEEP=n kernels because some of the functions are not
> > visible in these configurations.
> > 
> >   https://lore.kernel.org/202609121207.tM2OfBmR-lkp@intel.com/
> >   https://lore.kernel.org/202609121338.qo2mQWRl-lkp@intel.com/
> > 
> > It should be fairly easy enough to expose these functions regardless of
> > CONFIG_PM_SLEEP (or add some stubs) but I think this patch should be
> > dropped until it can be done in a new version.
> > 
> > -- 
> > Cheers,
> > Nathan
> 
> See:
> 
> https://lore.kernel.org/linux-integrity/aqyOUgIa4lsUwO0I@kernel.org/
> 
> So I would squash Arnd's fixes and call it a day?

The fire has been extinguished anyhow.

I.e. I updated for-next-tpm not to have Li's patch.

The patch and Arnd's fixes to it remain in my master branch instead.

BR, Jarkko
