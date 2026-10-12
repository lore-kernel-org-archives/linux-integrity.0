Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407543537E5;
	Mon, 12 Oct 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813237; cv=none; b=oeyYJyHKZ6If8nWISOmRCNafqvI+8JU3qcffy7dMr0Om/tqd+pHGbZffiRYVBcgfe4WvRfIh2sRb7RiGBYoH3OxTOY6jl1NqLhBDThoQmjLYL9783rRR6XZXq1SnxRtNVYPfkW6NFg7Vfng9fMNXrrqrP0XhCA09uuNDrNbis0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813237; c=relaxed/simple;
	bh=zv6NzR0Sm99vbeMQ12TfgQdnEcPkEYkJjtJMVz+tPfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8O+oNcRkESvvclq9t/txlDGJbzMRwMpRX46GXVF4Cl1qUs6CSXWtnaxMhBR3R3A+GMTKvtzzzywAl+V6GFQxBZsGebQzsA89g6LafgZzymHhZCnpNyem+xO25rEK2FhDsd1cP0nji7WLKiFbLFSUhGC7cU/l5O4dYMSU1DDDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF6dFbTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF6dFbTz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 98E1A1F0089B;
	Mon, 12 Oct 2026 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813236;
	bh=Z+Rho8ZTtKfOhsqpshW3VIXwlCZWfw9gJyDnbrtZEa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kF6dFbTzbaGdEyQUpQSdGi5r3WSnCddyYymvbHrHQNXhDPoKzo8ElnI5fv7AsCgha
	 uzM5BSJFNWPtRpjKwLnJNk3vgRkhejiXckKgV4PPH/2JZr1rGRMDWG3QnLDga/rnr4
	 faYfXDEL404cJynlc/1xOYcIQu450dnNGqAmxG9uu8Oh3lOLk55w7l+NrIFGUT61I1
	 9JBjbmj7uihRFrApcIVQ4TAk9hjrhOS3XWW7Ela+wUUf+H4g/14tzGz6U/4PgmdasX
	 KWhPIg9Z+ntq1rm39y5yQzAKic1dRAkbsCUNiXPh0R8Relsx9fL885KDA/IYlcnLjT
	 WIuwhNJGTiZYQ==
Date: Mon, 12 Oct 2026 16:53:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder <stuart.yoder@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <aszmcDeBBIJ5zvPw@kernel.org>
References: <20261010235500.2915629-1-jarkko@kernel.org>
 <asy0K_6VkuAn9rTB@sgarzare-redhat>
 <aszhPcubTH8HKxh2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aszhPcubTH8HKxh2@kernel.org>

On Mon, Oct 12, 2026 at 04:31:45PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 12, 2026 at 12:23:05PM +0200, Stefano Garzarella wrote:
> > On Sun, Oct 11, 2026 at 02:54:57AM +0300, Jarkko Sakkinen wrote:
> > > In all the pre-existing call sites both @iomem and @iobase_ptr are either
> > 
> > Do you mean @iores ?
> > 
> > > both NULL or have a valid address.
> > > 
> > > Add an invariant for the expeced conditions and remove a dead basic block.
> > > The second block is dead given that if @iomem turns out not to be NULL,
> > > neither can't be @iobase_ptr.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > v2:
> > > - Updated the commit message in order to clarify things better.
> > > - Updated the invariant in order to address checkpatch.pl --strict
> > >   errors.
> > >  drivers/char/tpm/tpm_crb.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > > index ceb4100ba400..833226966fa2 100644
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
> > >  	if (start != new_res.start)
> > >  		return IOMEM_ERR_PTR(-EINVAL);
> > > 
> > > +	if (!iores != !iobase_ptr)
> > > +		return IOMEM_ERR_PTR(-EINVAL);
> > > +
> > >  	if (!iores)
> > >  		return devm_ioremap_resource(dev, &new_res);
> > > 
> > > -	if (!*iobase_ptr) {
> > 
> > Sorry to insist, but in the commit description we talk about @iobase_ptr 
> > can't be null, and I agree, but here we were checking the value of the 
> > pointer, so IMO this code was not dead.
> > 
> > But again, I know nothing on this code. So, if you think it's correct go 
> > head, I'm surely missing something.
> 
> Ugh, you're actually right, and this is not, and should not have sent
> this. And it is for lazy init. 
> 
> I need to sanity check my test environment because I thought I was
> testing this with swtpm emulated tpm_crb but tests passed, and this
> should not work.
> 
> Sorry and thanks :-)
> 
> Just wanted to make it explicit that I was making somehting extremely
> stupid.

Probably too much multitasking lately with all these bugs.

Lessons learned is that from now on I keep my own contributions
and reviewing in separate sessions. Things have gotten much
busier than they used to be so need to adapt and learn how
to have focus on all actitivies :-)

Br, Jarkko
