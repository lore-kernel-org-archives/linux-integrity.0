Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256536F429;
	Sat, 18 Jul 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405985; cv=none; b=sFzq8Jbiqt5jwTxMdahQQpkXQUAo5I+MMiTDelzmQEXHlOAwKN2Z5go19JIM9Ows1hmWbnMBxNpH2ijeDLRV6eN6RTtRlnADPpovQOag1qBfUPT0OP69mLzWqpAvGKTl/zfTFko1SuRs2rhj4b2FZ4Rc17nATAkS2/wS4gYV+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405985; c=relaxed/simple;
	bh=tzyzvkZMyD/+/FeZqpKJ+YhIAyW8diZSFThS4B+dt9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0MFipneqRlfWNXGJOfPg2FdfolohfxTuz86aOo0BGroSkL9phAhIw/chne0kCnw3zZXxtwZSEPLicGUI73FRs2Ea4eGfBgKjp85NkDgcSYSRIgin7tPnADReDiQAleTXYMSy5pTV9xwWrjReyJuoGZtwyNz6klyQXLb20kwlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxuBripS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxuBripS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 70BDE1F000E9;
	Sat, 18 Jul 2026 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784405984;
	bh=UZnpNbDLkAVr6hxfC8uAvHZFmAIoTyJv/VkAg6Hi1pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PxuBripSfJbR2clTiFKOpVbb/KP1K3F1Jkz0PLwhqya4e29BUf8KkyjjIA/Yd0g8L
	 lOoqZBHVTrXl8O5zi43vSNvxZD+tUUMpEDlrbTdUAAss2Eo5SD9iQAQVnS0poO1zWj
	 zYRActUZLIjfB8CmotoXcKIQ2D3SZrUsdmAOSPTrpKo7+o4eZv6Sk3pEWl0v2miCyc
	 ZXZM2iEGV6kVEqVWNvGKl44DeenRgYvIerO4D1DS+OpcixxG/hSzpFO1P3Bi2EK2lU
	 4AJPFmsm/ytBjrihaRTcHUYjNGgzQ32bp/BSLfQzG2/FN6pBxrpfo+qBCqF8gZYV/5
	 GPEnY+gGJiRbw==
Date: Sat, 18 Jul 2026 23:19:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: use kfree_sensitive() for context and session
 buffers
Message-ID: <alvf3E15MZ36EzTx@kernel.org>
References: <20260716000355.13825-1-skunkolee@gmail.com>
 <alvIY-6-NtgH0pzR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alvIY-6-NtgH0pzR@kernel.org>

On Sat, Jul 18, 2026 at 09:39:35PM +0300, Jarkko Sakkinen wrote:
> On Wed, Jul 15, 2026 at 06:03:55PM -0600, Ivy Lopez wrote:
> > The context_buf and session_buf fields in struct tpm_space contain
> > TPM context blobs which may include sensitive cryptographic material.
> > Use kfree_sensitive() instead of kfree() to ensure the memory is
> > zeroed before being freed, consistent with how chip->auth is handled
> > in the same tpm_dev_release() function since commit c424d2664f08
> > ("tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()")
> > 
> > Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
> > ---
> >  drivers/char/tpm/tpm-chip.c   | 4 ++--
> >  drivers/char/tpm/tpm2-space.c | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 12b7394b34bd..6f16fc358175 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -244,8 +244,8 @@ static void tpm_dev_release(struct device *dev)
> >  	idr_remove(&dev_nums_idr, chip->dev_num);
> >  	mutex_unlock(&idr_lock);
> >  
> > -	kfree(chip->work_space.context_buf);
> > -	kfree(chip->work_space.session_buf);
> > +	kfree_sensitive(chip->work_space.context_buf);
> > +	kfree_sensitive(chip->work_space.session_buf);
> >  #ifdef CONFIG_TCG_TPM2_HMAC
> >  	kfree_sensitive(chip->auth);
> >  #endif
> > diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> > index 60354cd53b5c..a7200e6dc462 100644
> > --- a/drivers/char/tpm/tpm2-space.c
> > +++ b/drivers/char/tpm/tpm2-space.c
> > @@ -46,7 +46,7 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
> >  
> >  	space->session_buf = kzalloc(buf_size, GFP_KERNEL);
> >  	if (space->session_buf == NULL) {
> > -		kfree(space->context_buf);
> > +		kfree_sensitive(space->context_buf);
> >  		/* Prevent caller getting a dangling pointer. */
> >  		space->context_buf = NULL;
> >  		return -ENOMEM;
> > @@ -64,8 +64,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
> >  		tpm_put_ops(chip);
> >  	}
> >  
> > -	kfree(space->context_buf);
> > -	kfree(space->session_buf);
> > +	kfree_sensitive(space->context_buf);
> > +	kfree_sensitive(space->session_buf);
> >  }
> >  
> >  int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> > -- 
> > 2.55.0
> > 
> 
> Yep, as James said, there's no plain text to uncover.

And also tied to power cycle.

BR, Jarkko
