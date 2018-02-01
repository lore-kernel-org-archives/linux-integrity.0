Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33541 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeBAUgB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 15:36:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id x4-v6so1732757wmc.0
        for <linux-integrity@vger.kernel.org>; Thu, 01 Feb 2018 12:36:01 -0800 (PST)
Date: Thu, 1 Feb 2018 13:35:56 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180201203556.GX17053@ziepe.ca>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
 <1517510764.3145.38.camel@HansenPartnership.com>
 <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517515204.3145.51.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 09:00:04PM +0100, James Bottomley wrote:
> On Thu, 2018-02-01 at 11:59 -0700, Jason Gunthorpe wrote:
> > On Thu, Feb 01, 2018 at 07:46:04PM +0100, James Bottomley wrote:
> > 
> > > 
> > > I honestly don't think we should be waiting for the self test at
> > > all.
> > > We should kick it off and treat any TPM_RC_TESTING error as
> > > -EAGAIN.
> > > We're already under fire for slow boot sequences and adding 2s just
> > > to
> > > wait for the TPM to self test adds to that for no real value.
> > 
> > Arguably the BIOS should have completed the selftest - this stuff
> > generally only exists to support embedded.
> > 
> > I don't like the idea of EAGAIN, that just expose all our users to
> > this mess.
> > 
> > I would support making transmit_cmd genericly wait and retry if the
> > TPM insists we need to wait for selftest to complete the specific
> > command though.
> 
> OK, how about this then?

Yeah, I like this concept much better, thanks

> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1d6729be4cd6..84ed271c060b 100644
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -521,12 +521,32 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>  	const struct tpm_output_header *header = buf;
>  	int err;
>  	ssize_t len;
> +	unsigned int delay_msec = 20;
>  
> -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> -	if (len <  0)
> -		return len;
> +	/*
> +	 * on first probe we kick off a TPM self test in the
> +	 * background This means the TPM may return RC_TESTING to any
> +	 * command that tries to use a subsystem under test, so do an
> +	 * exponential backoff wait if that happens
> +	 */
> +	for (;;) {
> +		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> +		if (len <  0)
> +			return len;
> +
> +		err = be32_to_cpu(header->return_code);
> +		if (err != TPM2_RC_TESTING ||
> +		    (flags & TPM_TRANSMIT_NOWAIT))
> +			break;

Do TPM and TPM2 use a different return code here?

Jason
