Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC02BCF4C;
	Mon, 12 Oct 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811906; cv=none; b=k+ZqDgeRyOzMgs908pzrfrAs9btILxg9N8+sDFkDCzwkaw1TKLPaloS/cGSBP4xd2Aq3RuPXPCShrJWigZYQgcJNcYpI/DW6wPyrzSVYdaJS22gYQjPgn8VasgK/clvOqNZpeNo/uqNVNdMrFC5CQYg19iz/r0Haeu+vtqkCbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811906; c=relaxed/simple;
	bh=4QdYo964dCeKwsklKxBBMW3Lqm5MpmUfYpsjPbAPMAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1+jmM1R+u9uAcEG4SFsdReP6C9YDCpTIbNCnZ1FgLGnP63Js+XlAvhEpmsi5bP1nqcR1XUquZ39OMY+NLrkY551HQZonavbdo04w3vmth4if2hMld7Gxy9KVmG+G+NvQYeMA/EWtMH7tnjYiIT9gPkDjSHv1cwCGsgELNcRZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsqBesq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsqBesq0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B78021F0089B;
	Mon, 12 Oct 2026 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811905;
	bh=gigJzefooR7VsWcPCKIZEa7NsLeADq5ShSpsInfLSPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IsqBesq07pdKuJFpdnZiecToY8Ojzbc5pFwGTi/PHcj4Nl92rLOWVXSkUNRW5bx2c
	 1hH7EUwGnuIKaM5Oyc7jy3ZW+4+98GRIHaVWxMu+7b65t/DiVFQPCNC1nSeBq500ks
	 KhdDOZcg5OagIPP96buasNs4xjVN3Gea09ibRpzvZeJ6pHJLsRB5mcB9j1OC8z4k8C
	 +jVDCBq7V1YLZ8pNq446vueqIH/xjgpOVcs3nwE8BUD64bg1YbPvsyBiiOazkkBS4G
	 a2ng+5aq7Xv0qmFc8X8ufGXlITabL23fThb++x3+7OgfCuk7OmFqg9i17H9G0Dyazt
	 IxZPELlS+52Pw==
Date: Mon, 12 Oct 2026 16:31:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder <stuart.yoder@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <aszhPcubTH8HKxh2@kernel.org>
References: <20261010235500.2915629-1-jarkko@kernel.org>
 <asy0K_6VkuAn9rTB@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asy0K_6VkuAn9rTB@sgarzare-redhat>

On Mon, Oct 12, 2026 at 12:23:05PM +0200, Stefano Garzarella wrote:
> On Sun, Oct 11, 2026 at 02:54:57AM +0300, Jarkko Sakkinen wrote:
> > In all the pre-existing call sites both @iomem and @iobase_ptr are either
> 
> Do you mean @iores ?
> 
> > both NULL or have a valid address.
> > 
> > Add an invariant for the expeced conditions and remove a dead basic block.
> > The second block is dead given that if @iomem turns out not to be NULL,
> > neither can't be @iobase_ptr.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Updated the commit message in order to clarify things better.
> > - Updated the invariant in order to address checkpatch.pl --strict
> >   errors.
> >  drivers/char/tpm/tpm_crb.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index ceb4100ba400..833226966fa2 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
> >  	if (start != new_res.start)
> >  		return IOMEM_ERR_PTR(-EINVAL);
> > 
> > +	if (!iores != !iobase_ptr)
> > +		return IOMEM_ERR_PTR(-EINVAL);
> > +
> >  	if (!iores)
> >  		return devm_ioremap_resource(dev, &new_res);
> > 
> > -	if (!*iobase_ptr) {
> 
> Sorry to insist, but in the commit description we talk about @iobase_ptr 
> can't be null, and I agree, but here we were checking the value of the 
> pointer, so IMO this code was not dead.
> 
> But again, I know nothing on this code. So, if you think it's correct go 
> head, I'm surely missing something.

Ugh, you're actually right, and this is not, and should not have sent
this. And it is for lazy init. 

I need to sanity check my test environment because I thought I was
testing this with swtpm emulated tpm_crb but tests passed, and this
should not work.

Sorry and thanks :-)

Just wanted to make it explicit that I was making somehting extremely
stupid.

> 
> Thanks,
> Stefano
> 
> > -		*iobase_ptr = devm_ioremap_resource(dev, iores);
> > -		if (IS_ERR(*iobase_ptr))
> > -			return *iobase_ptr;
> > -	}
> > -
> >  	return *iobase_ptr + (new_res.start - iores->start);
> >  }
> > 
> > --
> > 2.47.3
> > 
> 

Br, Jarkko
