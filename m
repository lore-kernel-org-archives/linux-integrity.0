Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E478E54A7E7;
	Wed,  9 Sep 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969675; cv=none; b=bBW9QKQ/MlCLKLSrpmjhOpNPRUlVZdZbS43IZrHI1tzxcbCJRHXVmV2s0GMmTa36qFEq/4A7ft3rpVv7lem4ALqPuvQyWO2oIdqoi8zDMSviI6RYUarmxEwQWsaUio7xbwdytj52TUHxKjC8qVF0vhXc4FLzBWp3aVk+sO2aBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969675; c=relaxed/simple;
	bh=LbhUwDtwkuIFwb9VISc5HQ5A50vpg/Ht3Pl0+/2hX8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq9XG9PyydBDif2N/8GFi2ktCjktsxV5V7zR0sM8MgKNDjb3D6yuj2R04GS2rvBZOfENnROhNi4N7TQeC5lcGHFUXnr6KSn2Czu9KYwkVqkQDR6njcLM1nibwvylypHcnuqOs5EiGuJlYEm+BWniiFQ74E0QKgMf+oBmMuOGdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxUC9ZeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxUC9ZeF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EF42E1F00A3A;
	Wed,  9 Sep 2026 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969673;
	bh=NgTepbvixwaQqPVtQ0p03eDIqVfMNa2FY5nEPoVJHdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MxUC9ZeFOuHjElAI/j8FjkwYu7J35UP3/FglLsmZNx2DJk6r9GwVhhpdRx1mdK7oV
	 Pc4j72hQTy9KxlPlrE3giCrblS7/jLeB06xIlq71he5hdKfr49KD36cp+IAiicc36H
	 VtExdfVWuPBu6fOGVeCfSjHrV2FhymupeXV2wtuPka5yJ0mS9BVLXlHV6dKgsq5QKb
	 9YXwnxTl37mah/0ap+asfsvDSM0dCG6iNJ9syIXQ2vxPfhXs1LrNqG/arEuzoX6JD4
	 B0iez3+D4Pa1yeRxaRcGAWuj604J97plhxc/u72FPihndpu1Zr4VsM/7cGEp/ibsZ5
	 2xfwFmX0koLWA==
Date: Wed, 9 Sep 2026 19:01:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <aqGCxok4dYhSR9pQ@kernel.org>
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
> 
> Stefano
> 
> > 	return *iobase_ptr + (new_res.start - iores->start);
> > }
> 

Thanks for the remarks and ack for receiving this ;-)

I'll move this to my TODO-folder and read it with thought some days from now.

BR, Jarkko
