Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53838 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752227AbeCZO2a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Mar 2018 10:28:30 -0400
Message-ID: <1522074507.4417.15.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/2] tpm: add retry logic
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Mon, 26 Mar 2018 07:28:27 -0700
In-Reply-To: <3733a124-1746-d5d9-4fda-838c9ffdaa81@linux.vnet.ibm.com>
References: <1521657747.6397.18.camel@HansenPartnership.com>
         <1521657828.6397.19.camel@HansenPartnership.com>
         <7236ada1-43b5-8280-ce21-3d0c095dfe9d@linux.vnet.ibm.com>
         <1521736298.7197.4.camel@HansenPartnership.com>
         <3733a124-1746-d5d9-4fda-838c9ffdaa81@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-26 at 19:41 +0530, Nayna Jain wrote:
> 
> On 03/22/2018 10:01 PM, James Bottomley wrote:
> > 
> > On Thu, 2018-03-22 at 21:43 +0530, Nayna Jain wrote:
[...]
> > > > +ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space
> > > > *space,
> > > > +		     u8 *buf, size_t bufsiz, unsigned int
> > > > flags)
> > > > +{
> > > > +	struct tpm_output_header *header = (struct
> > > > tpm_output_header *)buf;
> > > > +	/* space for header and handles */
> > > > +	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
> > > > +	unsigned int delay_msec = TPM2_DURATION_SHORT;
> > > > +	u32 rc = 0;
> > > > +	ssize_t ret;
> > > > +	const size_t save_size = min(space ? sizeof(save) :
> > > > TPM_HEADER_SIZE,
> > > > +				     bufsiz);
> > > > +
> > > > +	/*
> > > > +	 * Subtlety here: if we have a space, the handles will
> > > > be
> > > > +	 * transformed, so when we restore the header we also
> > > > have
> > > > to
> > > > +	 * restore the handles.
> > > > +	 */
> > > > +	memcpy(save, buf, save_size);
> > > > +
> > > > +	for (;;) {
> > > > +		ret = tpm_try_transmit(chip, space, buf,
> > > > bufsiz,
> > > > flags);
> > > > +		if (ret < 0)
> > > > +			break;
> > > > +		rc = be32_to_cpu(header->return_code);
> > > > +		if (rc != TPM2_RC_RETRY)
> > > > +			break;
> > > > +		delay_msec *= 2;
> > > Was wondering if this increment could be moved after
> > > tpm_msleep(delay_msec) ?
> > I thought about that when I saw the logic in the original but what
> > it would do is double the maximum delay (which is already nearly
> > double TPM2_DURATION_LONG).  I figured doubling the initial timeout
> > was fine rather than trying to do complex logic to get the delay
> > exact (and then having to litter the file with comments explaining
> > why).
> 
> Sorry James, I didn't understand exactly about what complex logic is 
> involved. Can you please explain it more ?
> My point was to just move "delay_msec *= 2"  after tpm_msleep() as
> shown below:
> 
> if (delay_msec > TPM2_DURATION_LONG) {
>      dev_err(&chip->dev, "TPM is in retry loop\n");
>      break;
> }
> tpm_msleep(delay_msec)
> delay_msec *= 2;

Yes, I understand the suggestion; however, if you simply do that,
you'll end up with a useless sleep at the end of the wait period before
you check to see if you've waited too long, which is even more
suboptimal than the current situation.  The cardinal rule is we should
only sleep if we know we're going to retry.

James
