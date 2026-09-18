Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCF37AA9E;
	Fri, 18 Sep 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693534; cv=none; b=sD2520CgY9Dz3KMGSnTjxfsa1cDBJc3Aik3kFLT74EyWmgSiQSNXFbMx2+QEYyXzjVafhlMEDju3ApPVg7M1ZkNYsihpLpZzCzemTI+jQxGGl7CBOqDbw3S+2tjl/WXxaLC+bF3sGkiuEdDbM7q8SSybFgfpQN2uUVW4MAJapcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693534; c=relaxed/simple;
	bh=1MGc3GubgHe85U87MTTuMs8VfEueiO77L05VVps3b+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFVSsvBLYAdtpoz9oyUViGO7Ke22Rq9EDIABTj7L7u5LbMoVAYXZiYZXG11XH4FQ1YSzl2OEE/OnVn8aWF2dSjrPHFKHj/6FY/0FUrEBLZNQeQ1MbgdOXfnNBA4Uvzhz8UqCJ/gWnunmeMmMF+7JODtKAL73+vYmQF3bx/c2CL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXSBKnVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXSBKnVl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B3E281F000FF;
	Fri, 18 Sep 2026 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693526;
	bh=8AAvyYfMqKLOuILxKhqzjpQoDOHDMPszKxF9qCrIIGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eXSBKnVlt0G+2Lyu5pNEL74GuZK1vHrsDjQ8MTdkIBveGymu7HVal7YnW6w+2dCcq
	 QACsez3hYZ+EpBWg1XeZRGrxNP9K5xxd+GJw5i+2C+mTGFm7IV8P91JI+PfyH77czM
	 n1Nr+xaD7OzVFbk4FEjBr9zO7/4E001iOouY/ijS6GC/lCk7kYFpbsZDhfPH7uHIob
	 Ddns/M+zH0qFlFVmFa4Fxb0fUozskfD/Gze9p41b1BumADMWtCZKQf3yFr34Vs1ItX
	 VMFz+BDlfIX88H9bgAr11Lap9SJRrUk5X2UWNylpBXBKVI5Ub0fyQ4r1/cMLg6dBDf
	 bLLXIPdcDNTwQ==
Date: Fri, 18 Sep 2026 04:05:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Li Jun <lijun01@kylinos.cn>,
	Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Message-ID: <aqyOUgIa4lsUwO0I@kernel.org>
References: <20260915201305.3529682-1-arnd@kernel.org>
 <aqyMnwklQX3ciUzf@kernel.org>
 <aqyNgA5NdSTdrP_6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqyNgA5NdSTdrP_6@kernel.org>

On Fri, Sep 18, 2026 at 04:01:57AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 03:58:11AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 15, 2026 at 10:12:58PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Changing to DEFINE_SIMPLE_DEV_PM_OPS() broke here because the
> > > tpm_inf_resume() function is hidden in an #ifdef:
> > > 
> > > drivers/char/tpm/tpm_infineon.c:615:61: error: 'tpm_inf_resume' undeclared here (not in a function); did you mean 'tpm_pm_resume'?
> > >   615 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> > >       |                                                             ^~~~~~~~~~~~~~
> > > 
> > > Remove the #ifdef check.
> > > 
> > > Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/char/tpm/tpm_infineon.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> > > index 84a0d3e5f679..d6edd2ca39a5 100644
> > > --- a/drivers/char/tpm/tpm_infineon.c
> > > +++ b/drivers/char/tpm/tpm_infineon.c
> > > @@ -594,7 +594,6 @@ static void tpm_inf_pnp_remove(struct pnp_dev *dev)
> > >  	}
> > >  }
> > >  
> > > -#ifdef CONFIG_PM_SLEEP
> > >  static int tpm_inf_resume(struct device *dev)
> > >  {
> > >  	/* Re-configure TPM after suspending */
> > > @@ -611,7 +610,7 @@ static int tpm_inf_resume(struct device *dev)
> > >  	tpm_data_out(RESET_LP_IRQC_DISABLE, CMD);
> > >  	return tpm_pm_resume(dev);
> > >  }
> > > -#endif
> > > +
> > >  static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> > >  
> > >  static struct pnp_driver tpm_inf_pnp_driver = {
> > > -- 
> > > 2.53.0
> > > 
> > 
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I pushed this to for-next-tpm, which mirrors to linux-next.
> 
> However, since this is -next only bug, I guess I should squash these to
> the original commit?
> 
> Just sanity checking before taking action :-)

My suggestion would be to amend Co-authored-by to the original commit
message as two bug fixes is significant amount of effort to make the
change right.

BR, Jarkko
