Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBBA3B27E2;
	Tue, 29 Sep 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720542; cv=none; b=QuagTDvy0+7UunD6KmlmGn13K2+NhO3yq5qkGRWiRGPPWHUxDdf57AbsQZXg4HtMwyItOCPpc/2o9Smu503GDOBFAJsiwq0Xf/5GrA41mkZl65J4m6iPNQZP3fMZKi65BCSg00cPDvVN2Y+a9fkfiyDs69zzODI8CJ6GNjLePb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720542; c=relaxed/simple;
	bh=YC+iyIjz5uqf23WRDerHTOppl0qBIpuHF8Xlgjv7DF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6Jvrsp3HU5ILZFY/rkz5u/w/AoaNJcS75pWAxMwNYDdBsD6Vunxt+GLraHgxneCbTIMV2aeJO6dCn6XIee31qv6OIYArLFW0l4v7xh1a2KP5up8F7JdX1hrn4oaos2l9ZYV3Wz0Ewh1qriGtJYkLHFORqpN5vMnSjvGSHO8wJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyMHaTDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyMHaTDY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 325531F000FF;
	Tue, 29 Sep 2026 22:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790720540;
	bh=woMNByGZdozSY51jOgCnIsvzYuxzLL7kdbpiLCyratk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QyMHaTDYMDTSTr6f4Uigi01+wWVKqC6ZUltkatQ5g/P9feFRhAbaIXSruUDPIWhC0
	 JLL+qZmPEPChwiojMxNQ0DdhT+is0Nlp8VcJ22W3jcRWqehsPe6lqxFHZIxMob0GKP
	 wKEYWuuIUQ/vnaAjPRWIVBFEHICUutS8WS9CTzSxSLxWF7qGs/8xCDLszJi0Sy9x2C
	 Dd9kNcHSdebD393++Js0k0PU5pHJxHysT3IV66IEVZe5ynh+AYVOYcDGPwryvAxJCU
	 RVrxtOQn+y+kX2WygD9a59jis27zWTW5SSpzrqG6R2+wgeHYZcGzatpzFp612hKInw
	 bVNpx6D9JS56g==
Date: Wed, 30 Sep 2026 01:22:16 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: graf@amazon.de, gunnarku@amazon.com, jgg@ziepe.ca, joshlev@amazon.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	nh-open-source@amazon.com, peterhuewe@gmx.de
Subject: Re: [PATCH 2/2] tpm_crb: Raise timeouts for Amazon NitroTPM
Message-ID: <arw6GJymRFjesinz@kernel.org>
References: <araZZzKDqzrPdY9f@kernel.org>
 <20260928210953.29183-1-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928210953.29183-1-surenkj@amazon.com>

On Mon, Sep 28, 2026 at 09:09:53PM +0000, Surendran Kanagaraj wrote:
> On Fri, Sep 25, 2026, Jarkko Sakkinen wrote:
> > On Wed, Sep 23, 2026 at 02:28:34PM +0000, Surendran Kanagaraj wrote:
> > > +/* Longest unavailability seen from NitroTPM */
> > > +#define CRB_AMZN_BUSY_TIMEOUT_MS     30000
> >
> > Use TPM_CRB prefix.
> 
> Thanks for taking time to review my patches. Will update this in v2.
> 
> > > +	crb_apply_vendor_quirks(priv, chip);
> >
> > I.e., all this complexity equals to:
> >
> >         if (crb_vendor_id(priv) == CRB_INTF_VID_AMZN)
> >                 chip->busy_timeout_ms = CRB_AMZN_BUSY_TIMEOUT_MS;
> >
> > ?
> 
> Yes. I added the table to keep vendor specific quirks out of the probe
> and could be extended without touching the probe. tpm_tis_core does
> something similar with vendor_dur_overrides. what do you think? I am
> happy to switch to the plain check if you prefer.

See my suggestion for 1/2.

I.e. we need two patches:

1. One that makes all duration assignments indirect lookups to
   chip->duration in the main TPM driver.
2. This patch should then update that array.

> 
> Thanks,
> Surendran

Br, Jarkko
