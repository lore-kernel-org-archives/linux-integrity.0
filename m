Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D5357CF3;
	Fri, 18 Sep 2026 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693322; cv=none; b=iBy320p4yv38bC2s+La8B8iYqkwYP3Xz0P8fa9XSNAMcceul0UYXLdhYdOWgve83joMJ1GmGKkzq+cnobXb89/8WbUBvS2h/qWh+XwYkmoXOXS0tf+6I0DkDeFg2ZVlyXBIJJRPUMP5IPQeXT21R+DHVz+fZAPQ5QqSD4JXKYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693322; c=relaxed/simple;
	bh=Jm8AiPEhNTc/WqwclRgL6Yls04DC1cZcjb55hPE9S8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb5sCuBfp8MIEgIysvCPje3/5z63WUpjywhASARRZ+V/WTwjfcvKjVLY6XLxq04r4wrTe3K4vKf73CpSYYu2+aMyk1CanZvRv7qZ8RvTcvrKoo7xtgRdZPvBzTUp+xpvqjJycgggV4L484UdKpd+h7EkDv8DVdtpU5f0RhwBuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNbtNY+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNbtNY+5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5792F1F000FF;
	Fri, 18 Sep 2026 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693316;
	bh=l/ep4puwLyPvOisOdFWRxt6h4UpgEyvyLpfflsTSLek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cNbtNY+5/QNf+cnZQIn77WTl41WjvKa3dia+EHroMSBjXBcMSwNM+7ZTc65IwA+Cu
	 qL59pFMW0KbDTjts2fYJsiT4wf8301MPMW2udtPVhfx7y4XYXLaW5bqD3OKLhq6VqO
	 rZ0oHZjMdtIEWT0bhwRvTArFybD9oJoQOORRaMcJlysJu6sqV27u0eI96NInPMXdoH
	 zPKQ5ttdDt8g01k2HG/JOuUsX9/8eD172BvgZevSUR0+thXPaSB030ndlohxKFEeRk
	 X2IItHCDyVrlQol7p5dq1WZR7mQrhUC+5Gbd7MBJROGq9AHquIQWfWwBV3cO9GwKXl
	 kF0cUJdTIMYzQ==
Date: Fri, 18 Sep 2026 04:01:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Li Jun <lijun01@kylinos.cn>,
	Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: remove extraneous #ifdef
Message-ID: <aqyNgA5NdSTdrP_6@kernel.org>
References: <20260915201305.3529682-1-arnd@kernel.org>
 <aqyMnwklQX3ciUzf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqyMnwklQX3ciUzf@kernel.org>

On Fri, Sep 18, 2026 at 03:58:11AM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 15, 2026 at 10:12:58PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Changing to DEFINE_SIMPLE_DEV_PM_OPS() broke here because the
> > tpm_inf_resume() function is hidden in an #ifdef:
> > 
> > drivers/char/tpm/tpm_infineon.c:615:61: error: 'tpm_inf_resume' undeclared here (not in a function); did you mean 'tpm_pm_resume'?
> >   615 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> >       |                                                             ^~~~~~~~~~~~~~
> > 
> > Remove the #ifdef check.
> > 
> > Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/char/tpm/tpm_infineon.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> > index 84a0d3e5f679..d6edd2ca39a5 100644
> > --- a/drivers/char/tpm/tpm_infineon.c
> > +++ b/drivers/char/tpm/tpm_infineon.c
> > @@ -594,7 +594,6 @@ static void tpm_inf_pnp_remove(struct pnp_dev *dev)
> >  	}
> >  }
> >  
> > -#ifdef CONFIG_PM_SLEEP
> >  static int tpm_inf_resume(struct device *dev)
> >  {
> >  	/* Re-configure TPM after suspending */
> > @@ -611,7 +610,7 @@ static int tpm_inf_resume(struct device *dev)
> >  	tpm_data_out(RESET_LP_IRQC_DISABLE, CMD);
> >  	return tpm_pm_resume(dev);
> >  }
> > -#endif
> > +
> >  static DEFINE_SIMPLE_DEV_PM_OPS(tpm_inf_pm, tpm_pm_suspend, tpm_inf_resume);
> >  
> >  static struct pnp_driver tpm_inf_pnp_driver = {
> > -- 
> > 2.53.0
> > 
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I pushed this to for-next-tpm, which mirrors to linux-next.

However, since this is -next only bug, I guess I should squash these to
the original commit?

Just sanity checking before taking action :-)

BR, Jarkko
