Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498359;
	b=AApPjz9bC4/e4kYcIW0OipT+3V+IwY11iE/VRD2uWBH0X8e30cCdYMS9BL2SQKCq23rb
	 tY7GqYbNf+OvG3s/y0RcqssWEoDDB+ZKWpZhCWQCc8GIisX73ZoBqsIU0qiepvUdi+7ZV
	 JtHVwXqLA6PlP7aou/xmuVQY4iJ3NRRdVse8j68xD30EtQPjq417jUo0poxq84jRvZXF2
	 xked6cGRUfhdytRv6KlIDoqTKWucD737E1WwBYn5t5DH6nkdU/ICXmL9jc6A5umAAjUAO
	 M909lsa33hw+tZtFMDEogPbVUCiRbHqXviLGF559TstV4reFS6TzKpVEx1V6yq54lUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498359;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=jfSIQmPFwdN9GPMgvzjz1BR7/Ta6DUUXWzOCdxMud3I=;
	b=f1ZPylDmjGo8T+D0NS4p4z4wW/oZANjYOqxyNDg4TdZQ9C/KiBWu3eQjeOQ0ma8JTh/X
	 GnAOaUj3pRKyP3+4PmTsqnmI6cMJBd9OQype/BXyuqx2hKpHc7a/vVPPUdbtOX5a/U+5f
	 PuasgG0iNznSAUhNtzNqgRNbF6SfCkbqn/9o0fhQX7Ueq2CaOuXZ4PQ4GNt3Nz1FYICuo
	 MjlS/z/Tqt90bHCWBzLV+B7AS96OqMEylQmRYE3U1uructuGZ7hwNyI5ET1b8eXHOORI7
	 ct7x/XWJdY7n7IlrfabDm9OAecZT9zF1dviH0Uxn/N6JDghCkjGvdxvXVjWAKKrNNqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=deKwVwLZ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36AB606A31C;
	Thu, 12 Nov 2026 15:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D36AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=deKwVwLZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jfSIQmPFwdN9GPMgvzjz1BR7/Ta6DUUXWzOCdxMud3I=; b=deKwVwLZyTuJqbP/Oac9WXhyP+
	7gyEYkFb3L8eKsRFvQNyJjpuUZQ/SB+iFhxs5M7PXA8iPHxr17VuLipKvWpmJzeos8a0cBZDh8SCz
	EfAxmuW4lcUI90bBOihrFVwz9HqvifXjtcQvn6Qa0d0r5hClG+PW3Oqc8NnN9Kn9qeEUlEDsyOyT4
	m6IOipUib49vEzY0ByzgBdOLp6fhN2wNvL92FzxP33GDn0mv0cGAX2cHo9Q/p4ZnonhrXQSNrV5p5
	QNNitUwXUETvnk0WucYQrNT3AodV/zmeEH8hTG3Wdn68l7VUOpZeIU8npqam47KHv6ovY5vbcR9MW
	kBa8hg6A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRWzp-00E4ip-2s;
	Thu, 12 Nov 2026 15:45:54 +0000
Date: Thu, 12 Nov 2026 07:45:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, surenkj@amazon.com, 
	noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avXfIroRj3CXvr7L@gmail.com>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
 <avXGjiejK2ZlldKs@kernel.org>
 <avXHGmmdY-CVgxEf@kernel.org>
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
In-Reply-To: <avXHGmmdY-CVgxEf@kernel.org>
X-Debian-User: leitao

On Thu, Nov 12, 2026 at 04:03:06PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 04:00:50PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 12, 2026 at 04:30:17AM -0800, Breno Leitao wrote:
> > > A TPM that stops responding fails each command only after the transport
> > > timeout, and its callers keep sending more: the hwrng thread every 10
> > > seconds forever, and userspace through /dev/tpmrm0. Each attempt holds
> > > tpm_mutex for the whole timeout and logs an error:
> > > 
> > >   tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
> > >   tpm tpm0: tpm_try_transmit: send(): error -62
> > >   tpm tpm0: tpm_try_transmit: send(): error -62
> > >   ...
> > > 
> > > The core already stops using a TPM it cannot trust: tpm_try_get_ops()
> > > fails with -EIO once TPM_CHIP_FLAG_DISABLE is set, which
> > > tpm2_load_null() does when it cannot restore the null key. Set the same
> > > flag once 60 commands in a row have timed out.
> > > 
> > > A completed command, whatever its TPM return code, resets the count.
> > > Some TPMs stall for half a minute, time out a handful of commands, and
> > > then recover, so a short streak must not disable them.
> > > 
> > > With only the hwrng retrying every 10 seconds, 60 timeouts take more
> > > than ten minutes. A userspace poller gets there sooner, but each of its
> > > commands still waits out the transport timeout.
> > > 
> > > The limit is the tpm.max_unanswered boot parameter, so that slow
> > > pre-production parts, such as FPGA prototypes, can raise it, or set it
> > > to 0 to never disable the TPM. A disabled TPM stays disabled until the
> > > driver is rebound or the machine reboots.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
> > >  include/linux/tpm.h              |  1 +
> > >  2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index e0385b16616b46..b7865ccb799289 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
> > >  MODULE_PARM_DESC(suspend_pcr,
> > >  		 "PCR to use for dummy writes to facilitate flush on suspend.");
> > >  
> > > +static unsigned int tpm_max_unanswered = 60;
> > > +module_param_named(max_unanswered, tpm_max_unanswered, uint, 0444);
> > > +MODULE_PARM_DESC(max_unanswered,
> > > +		 "Disable the TPM after this many commands in a row time out (0 = never).");
> > 
> > Documentation/admin/kernel-parameters.txt update is also needed.
> > 
> > tpm_max_missed_responses is what I would suggest, because it is more
> > accurate e.g., on stating what is being counted :-)
> > 
> > 
> > > +
> > >  /**
> > >   * tpm_calc_ordinal_duration() - calculate the maximum command duration
> > >   * @chip:    TPM chip to use.
> > > @@ -268,6 +273,16 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
> > >  		delay_msec *= 2;
> > >  		memcpy(buf, save, save_size);
> > >  	}
> > > +
> > > +	if (ret >= 0) {
> > > +		/* we are good, reset nr_unanswered */
> > 
> > I'm not a huge fan in general of third person plural in the source code
> > comments. Probably a comment here is not needed at all as it does not
> > state anything that would not be obvious (i.e. something nothing
> > non-obvious is documented).
> > 
> > > +		chip->nr_unanswered = 0;
> > > +	} else if (ret == -ETIME &&
> > > +		   ++chip->nr_unanswered == tpm_max_unanswered) {
> > > +		dev_err(&chip->dev, "%u commands in a row timed out, disabling the TPM\n",
> > > +			chip->nr_unanswered);
> > > +		chip->flags |= TPM_CHIP_FLAG_DISABLE;
> > > +	}
> > >  	return ret;
> > >  }
> > >  
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index 0db277af45c393..e8191585a68e7a 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -131,6 +131,7 @@ struct tpm_chip {
> > >  	struct hwrng hwrng;
> > >  
> > >  	struct mutex tpm_mutex;	/* tpm is processing */
> > > +	unsigned int nr_unanswered;	/* commands in a row that timed out */
> > 
> > This would be then nr_lost_responses.
> 
> Oops sorry.
> 
> I mean nr_missed_responses (and I would prefer "missed" over "lost").

Ack, respining...

--breno
