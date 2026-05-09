Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2E22576E;
	Sat,  9 May 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778339235; cv=none; b=c4+zsdM9rj7OJE2B6P6KptgwasxeQiuPjBRqQnIWr8r3FnWMCYdZJruDDmYORvMqfTJvOiEQ/Hk/eVQ4C4ywA0UQ290QbboaVK65sBVqAoARkpZVH58sH5C8qpgIzhR/sJtkpq8eClYsgAhFmSan67tyLnoLn0PjlVyO7cI2NEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778339235; c=relaxed/simple;
	bh=Dx+6+/BMXOy50CwLPmolFrutZIX9yyLlAvk56p1p6Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNR3RAoD9IWoHeIWX4Elt+ogZb1OwULlfP2dXvnGQMa8F/G+ZOtC0szj/iFMwe8o6H6dWJBandtM4BUDyJXeqIqqbxcg7+GMUOi9/h/eIT+qTYPDbsD+K7GlIlv50y2aP5lwgTyG0pSHmOTAqWizPB0+JxIfM4EkJXOEmCdM3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOCrh152; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOCrh152"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC904C2BCB2;
	Sat,  9 May 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778339235;
	bh=Dx+6+/BMXOy50CwLPmolFrutZIX9yyLlAvk56p1p6Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOCrh152QeQH7eCulsMZpVgaz9uvFEZjuRhJDbqpmVqBZqoXHfuwlgjC9AEEUI32B
	 HOpBvqAMZ5gY4bvD4GxzwvOfyanG6m2BmOVoBCsnJV6XE989z0d1wSKsjb0fKOKDJJ
	 +QRnMsojwYfjyON4nGrSGES+GrPMd2dVcTbXAbZLxe9pqI5O5x1cFEd6q7rTuX/E6e
	 loMyItk4l0HSKa3Sq5+xHoz7GMv8xUuSmx2+Ly6Bi46sBMgPELIhaZyK0ho9UQQaDz
	 y6xv+EZecO6nkF0MPnem5F0TQQSmdV5iL754c+NAAV2bDDS48jnfLI4mP3pX5eMt+m
	 jyNWgmluVmtLw==
Date: Sat, 9 May 2026 18:07:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 4/5] tpm: Increase TPM_BUFSIZE to 8kB for chunking
 support
Message-ID: <af9Nn3WA7bWVI1nO@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-5-armenon@redhat.com>
 <af9KnU90yMf8MxnQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9KnU90yMf8MxnQ@kernel.org>

On Sat, May 09, 2026 at 05:54:25PM +0300, Jarkko Sakkinen wrote:
> On Tue, Mar 24, 2026 at 11:42:43PM +0530, Arun Menon wrote:
> > The size of the command is checked against TPM_BUFSIZE early on before
> > even sending it to the backend. We therefore need to increase the
> > TPM_BUFSIZE to allow support for larger commands.
> > 
> > For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
> > also order-1 safe.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  drivers/char/tpm/tpm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 87d68ddf270a7..26c3765fbd732 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -33,7 +33,7 @@
> >  #endif
> >  
> >  #define TPM_MINOR		224	/* officially assigned */
> > -#define TPM_BUFSIZE		4096
> > +#define TPM_BUFSIZE		8192
> >  #define TPM_NUM_DEVICES		65536
> >  #define TPM_RETRY		50
> >  
> > -- 
> > 2.53.0
> > 
> 
> Shouldn't this prepend previous patch?

Also did you remark that tpm_buf would also need changes as it is fixed
to PAGE_SIZE?

I've made a patch that essentially makes tpm_buf size variable as caller
does kzalloc:

https://lore.kernel.org/linux-integrity/20260125192526.782202-12-jarkko@kernel.org/

I'd see this as pretty good long-term solution.

BR, Jarkko
