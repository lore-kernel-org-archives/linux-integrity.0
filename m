Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492190;
	b=aHEiAvPkCif50HI0Jyo6ma86AHTsRlT5g4D8egKBcwqB4UyonaFAMy8J9v+EZAym/+5U
	 dJY0xJY4Uk/yeC9kkYWXlqpcffh1PebN6MdY6seEkYpbtcr4uj88AElhVEmIhxqWkPrHv
	 AzxCPbc4lrdjLWErrZghRZDqtI/gXf4cdNCI5JxJXBSpY5QqQ3neWWjJiapzYIrBaDwgF
	 NXSxxkbNqVKAhP1LJoMrwLYk4QqfczOottVK7lITTtVfWnEj+qVpQVX3MPLOwF29PcJgM
	 dx1FE+N1uoY6+1N2KqHQ+JR8j+aXeZks/Lj71kkEdbBXicl93cqr7pR+0H62OADd+Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TA4BuHCeVd076kx67gcKZIXCxu35nOH0XjgXzmeDvnk=;
	b=0HPKMyOtfxlCNGoXDiBfyoVNGtScyjw9xWOcn/OnmELxfC9HSp8b0J+RWg/lvs1ssBS9
	 S0mRRO1/hb/aLcWZRx9S43S3Z4jSGc4JWHsYsOy83DprBY52f2Sd0KiGS1JwENQsDlt1P
	 qGs4vTiNpBCraDgqnPQkMjV84cx1tfzUsMuzNoqTx9eCETKDgWMhlO755c7uG9JRVXyrg
	 CZMnn/9bSJXzjXyQlqvej4Kr1n5ni2mnywyaMEJBJPRVbGalEEdqKh484E8bFWp4FVGDq
	 xyWb0P42v8JHhNZCblUbrQgtnW8TIinwTcZkcErIFxrFJykk87u046uD0ZOiwkpqp/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkg9i1uz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 90BFE606A323;
	Thu, 12 Nov 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkg9i1uz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ABEB31F00A06;
	Thu, 12 Nov 2026 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492190;
	bh=TA4BuHCeVd076kx67gcKZIXCxu35nOH0XjgXzmeDvnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bkg9i1uz+Vc7xVgxHNHPUBKtRXypUl8eYBY7QqFv5S3X0pi3hV4qLh79DsucxUTgn
	 3h24mjI91Wgd3FkdxM827gqWPOfv9idxvrl26iC5sEOYMzR7ySYnzHwr9kvYeHAAU7
	 imWD3M0VoHx8NGXZi7+5BA9bRg7lWH3C6J6b2zxI/ZytpRJvdB2cuzWwspxxFTzpQj
	 WIaYF++w/lRGTSWz8FD745GzDW/9l1agUDPFiSgYcgiFgVdYo8U8yBSeIjOWDvLj2T
	 0pkCwhcIG2hM0iPQKOMuF1jk+9NxzA1MKR2AgsK6FAypVKGyU+713aXkj3rTTvj+Uu
	 AdS/0BIlAHI3Q==
Date: Thu, 12 Nov 2026 16:03:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avXHGmmdY-CVgxEf@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
 <avXGjiejK2ZlldKs@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avXGjiejK2ZlldKs@kernel.org>

On Thu, Nov 12, 2026 at 04:00:50PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 04:30:17AM -0800, Breno Leitao wrote:
> > A TPM that stops responding fails each command only after the transport
> > timeout, and its callers keep sending more: the hwrng thread every 10
> > seconds forever, and userspace through /dev/tpmrm0. Each attempt holds
> > tpm_mutex for the whole timeout and logs an error:
> > 
> >   tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
> >   tpm tpm0: tpm_try_transmit: send(): error -62
> >   tpm tpm0: tpm_try_transmit: send(): error -62
> >   ...
> > 
> > The core already stops using a TPM it cannot trust: tpm_try_get_ops()
> > fails with -EIO once TPM_CHIP_FLAG_DISABLE is set, which
> > tpm2_load_null() does when it cannot restore the null key. Set the same
> > flag once 60 commands in a row have timed out.
> > 
> > A completed command, whatever its TPM return code, resets the count.
> > Some TPMs stall for half a minute, time out a handful of commands, and
> > then recover, so a short streak must not disable them.
> > 
> > With only the hwrng retrying every 10 seconds, 60 timeouts take more
> > than ten minutes. A userspace poller gets there sooner, but each of its
> > commands still waits out the transport timeout.
> > 
> > The limit is the tpm.max_unanswered boot parameter, so that slow
> > pre-production parts, such as FPGA prototypes, can raise it, or set it
> > to 0 to never disable the TPM. A disabled TPM stays disabled until the
> > driver is rebound or the machine reboots.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
> >  include/linux/tpm.h              |  1 +
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index e0385b16616b46..b7865ccb799289 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
> >  MODULE_PARM_DESC(suspend_pcr,
> >  		 "PCR to use for dummy writes to facilitate flush on suspend.");
> >  
> > +static unsigned int tpm_max_unanswered = 60;
> > +module_param_named(max_unanswered, tpm_max_unanswered, uint, 0444);
> > +MODULE_PARM_DESC(max_unanswered,
> > +		 "Disable the TPM after this many commands in a row time out (0 = never).");
> 
> Documentation/admin/kernel-parameters.txt update is also needed.
> 
> tpm_max_missed_responses is what I would suggest, because it is more
> accurate e.g., on stating what is being counted :-)
> 
> 
> > +
> >  /**
> >   * tpm_calc_ordinal_duration() - calculate the maximum command duration
> >   * @chip:    TPM chip to use.
> > @@ -268,6 +273,16 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
> >  		delay_msec *= 2;
> >  		memcpy(buf, save, save_size);
> >  	}
> > +
> > +	if (ret >= 0) {
> > +		/* we are good, reset nr_unanswered */
> 
> I'm not a huge fan in general of third person plural in the source code
> comments. Probably a comment here is not needed at all as it does not
> state anything that would not be obvious (i.e. something nothing
> non-obvious is documented).
> 
> > +		chip->nr_unanswered = 0;
> > +	} else if (ret == -ETIME &&
> > +		   ++chip->nr_unanswered == tpm_max_unanswered) {
> > +		dev_err(&chip->dev, "%u commands in a row timed out, disabling the TPM\n",
> > +			chip->nr_unanswered);
> > +		chip->flags |= TPM_CHIP_FLAG_DISABLE;
> > +	}
> >  	return ret;
> >  }
> >  
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 0db277af45c393..e8191585a68e7a 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -131,6 +131,7 @@ struct tpm_chip {
> >  	struct hwrng hwrng;
> >  
> >  	struct mutex tpm_mutex;	/* tpm is processing */
> > +	unsigned int nr_unanswered;	/* commands in a row that timed out */
> 
> This would be then nr_lost_responses.

Oops sorry.

I mean nr_missed_responses (and I would prefer "missed" over "lost").

Br, Jarkko
