Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2BF3B6C05;
	Wed, 23 Sep 2026 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207875; cv=none; b=DXVmr2rgzx+SHI7RW4/+U7IKB4zWbaANeOhGgi5zlHv+C1WKAU/VPlWUfkvVyASUvBB6uNPtVOIaR5DHr8rcbHFrQInh6CzL+nV6K5bGIkOh0nd/Vzan+yzAPPsSvvQhNRZO2Yo3f0KMENk35G4iIxJLhm2YTqkLKfUmrHOupUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207875; c=relaxed/simple;
	bh=sARll6dt3QP4S8odBFxoEdpjFtk/E0y48hfXzWmMyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eACAX6kHLOdrTgmjj2PYoedq9EhOgW4inKuMX+cj0JxxqttEDD3fu/XnMfyGyTMF5L18niXIwvJrEXzClxGoRbPRncBwED27/x91/rss7464D3Xd27HuclCFHdiyVoll6qfmve35FnfpCkFRec7lovlkkdg6ASrLcQUI1AYErvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6HYBAzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6HYBAzw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CB9DB1F000FF;
	Wed, 23 Sep 2026 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207873;
	bh=nkcq63Rzsebaj2EUvNxrKG1auMiaFg1ydMoSB24f+dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n6HYBAzwRLUoVNES1oLtJQN61hNeAhYwIuwCJfEmx1Wf4u3PZeuJe9+GO0ZqMMkvD
	 EAV46BJPr+anjTHHKYMRwIrXZmhH7CoeNoPQM88IUTkOicbUbFaXyBfMp4yvAv4xg8
	 H5OmFXJssrYlVIxRrhbPyLQgeg8JEqR0lrf9yWbBmtlr1yJOe7mydSw8ll1MgbqDNr
	 V7Dm7+vB41NwGjn6DQqhfr60e7g4kWbW2vcN6o0Xu97uhI4edKIUqDbL0RWN5NiJ+0
	 GT3i/ENqBVMqClxWPbUllWSwtD2cWKlueWrZvP/C8eQ/UYQU7xMKyQzKQpkThdph/E
	 LEzIuj/+aqGvA==
Date: Thu, 24 Sep 2026 02:57:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <arRnfB3OCOQB_sA1@kernel.org>
References: <20260901142955.187856-1-jarkko@kernel.org>
 <apb2LdIAqUHROYBt@sgarzare-redhat>
 <apcDfzVRBtwghIuN@kernel.org>
 <apfg2kg2jkmooZoq@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apfg2kg2jkmooZoq@sgarzare-redhat>

On Wed, Sep 02, 2026 at 10:54:32AM +0200, Stefano Garzarella wrote:
> On Tue, Sep 01, 2026 at 07:55:27PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 01, 2026 at 06:06:40PM +0200, Stefano Garzarella wrote:
> > > On Tue, Sep 01, 2026 at 05:29:46PM +0300, Jarkko Sakkinen wrote:
> > > > In all the pre-existing call sites both @iomem and @iobase_ptr are
> > > > either NULL or non-NULL.
> > > 
> > > I don't know this code, but I'm a bit worried about iobase_ptr and
> > > *iobase_ptr. IIUC it is true that iobase_ptr and iores are either NULL or
> > > non-NULL, but here we are removing the case where *iobase_ptr is NULL.
> > > 
> > > Now looking at crb_map_io(), IIUC iobase_array is initialized with NULL
> > > pointers and the code we are removing was the only one initializing those
> > > pointers IIUC, or am I missing something?
> > 
> > crb_map_io() sets both to non-NULL value, or leaves both as NULL.
> > 
> > crb_map_pluton() explicitly calls both explicitly with NULL.
> > 
> > If anything else will arrive too crb_map_res, that'd be unexpected
> > input, which without this patch will go unnoticed and will lead to
> > undefined behavior.
> 
> This is clear, and it's what is done in the first hunk, what is not clear to
> me is why removing the second hunk.
> 
> > 
> > Not sure what is the argument here really.
> 
> Sorry, I should have commented in the diff:
> 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index ceb4100ba400..e7a61f36c58b 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
> > 	if (start != new_res.start)
> > 		return IOMEM_ERR_PTR(-EINVAL);
> > 
> > +	if ((iores == NULL) != (iobase_ptr == NULL))
> > +		return IOMEM_ERR_PTR(-EINVAL);
> > +
> 
> This makes sense to me.
> 
> > 	if (!iores)
> > 		return devm_ioremap_resource(dev, &new_res);
> > 
> > -	if (!*iobase_ptr) {
> > -		*iobase_ptr = devm_ioremap_resource(dev, iores);
> > -		if (IS_ERR(*iobase_ptr))
> > -			return *iobase_ptr;
> > -	}
> > -
> 
> This is unclear to me, here we are checking if the value stored in
> iobase_ptr is NULL (so something different from the check we are adding
> above, but appropriate because it only makes sense when both are non-NULL).
> If the value stored in the pointer is NULL we are setting it.
> Looking at the code, I can't see any other point where that values
> (iobase_array[]) are initialized, but again, I don't know this code, so I
> may missing something.

If iobase_ptr would be NULL, so would iores given previous guards.

Call sites for crb_map_res:

- crb_map_io: both are non-NULL
- crb_map_pluton: both are NULL

> 
> Stefano

Br, Jarkko

