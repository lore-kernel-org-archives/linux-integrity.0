Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52448 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750727AbeBPUPJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 15:15:09 -0500
Message-ID: <1518812108.4475.21.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org
Date: Fri, 16 Feb 2018 12:15:08 -0800
In-Reply-To: <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-16 at 10:34 +0200, Jarkko Sakkinen wrote:
> Hi
> 
> See the comments below and please include this as a prequel patch for
> the next version:
> 
> https://patchwork.kernel.org/patch/10208965/

OK, and responding to review comments now rather than reporting other
anomalies seen.

[...]
> diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 3cec403a80b3..c3e6d0248af8 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -521,12 +521,32 @@ ssize_t tpm_transmit_cmd(struct tpm_chip
> > *chip, struct tpm_space *space,
> >  	const struct tpm_output_header *header = buf;
> >  	int err;
> >  	ssize_t len;
> > +	unsigned int delay_msec = 20;
> >  
> > -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> > -	if (len <  0)
> > -		return len;
> > +	/*
> > +	 * on first probe we kick off a TPM self test in the
> > +	 * background This means the TPM may return RC_TESTING to
> > any
> > +	 * command that tries to use a subsystem under test, so do
> > an
> > +	 * exponential backoff wait if that happens
> > +	 */
> > +	for (;;) {
> > +		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz,
> > flags);
> > +		if (len <  0)
> > +			return len;
> > +
> > +		err = be32_to_cpu(header->return_code);
> > +		if (err != TPM2_RC_TESTING ||
> > +		    (flags & TPM_TRANSMIT_NOWAIT))
> > +			break;
> > +
> > +		delay_msec *= 2;
> > +		if (delay_msec > TPM2_DURATION_LONG) {
> > +			dev_err(&chip->dev,"TPM: still running
> > self tests, giving up waiting\n");
> > +			break;
> > +		}
> > +		tpm_msleep(delay_msec);
> > +	}
> 
> Please have a helper function for this.

OK.

> > 
> >  
> > -	err = be32_to_cpu(header->return_code);
> >  	if (err != 0 && desc)
> >  		dev_err(&chip->dev, "A TPM error (%d) occurred
> > %s\n", err,
> >  			desc);
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 528cffbd49d3..47c5a5206325 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -495,6 +495,7 @@ extern struct idr dev_nums_idr;
> >  enum tpm_transmit_flags {
> >  	TPM_TRANSMIT_UNLOCKED	= BIT(0),
> >  	TPM_TRANSMIT_RAW	= BIT(1),
> > +	TPM_TRANSMIT_NOWAIT	= BIT(2),
> 
> Note to myself: TPM_TRANSMIT_RAW is a retarded name that does not
> mean
> anything. That should be renamed simply as
> TPM_TRANSMIT_IGNORE_LOCALITY.
> 
> It is really hard to interpret what TPM_TRANSMIT_NOWAIT means. Please
> just name it as TPM_TRANSMIT_IGNORE_TESTING or propose something
> better. I think that name makes it obvious what the flag means.

TPM_TRANSMIT_NO_WAIT_TESTING?

[...]
> I'm not sure how tpm_write() call path is handled.

It isn't currently since it uses tpm_transmit directly.  My thought on
this is that if the TPM hasn't got its testing crap together by the
time we enter userspace (which will be 10 or more seconds after we
first sent the test commands), then we really have a problem and the
user should see it.

James
