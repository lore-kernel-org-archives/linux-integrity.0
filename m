Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752618AbeC0RrU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Mar 2018 13:47:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2RHjAna062475
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 13:47:20 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gyrpse6m3-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Mar 2018 13:47:19 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 27 Mar 2018 18:47:17 +0100
Subject: Re: [PATCH v2 1/2] tpm: add retry logic
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Tue, 27 Mar 2018 13:47:12 -0400
In-Reply-To: <1522165174.4539.11.camel@HansenPartnership.com>
References: <1521657747.6397.18.camel@HansenPartnership.com>
         <1521657828.6397.19.camel@HansenPartnership.com>
         <7236ada1-43b5-8280-ce21-3d0c095dfe9d@linux.vnet.ibm.com>
         <1521736298.7197.4.camel@HansenPartnership.com>
         <3733a124-1746-d5d9-4fda-838c9ffdaa81@linux.vnet.ibm.com>
         <1522074507.4417.15.camel@HansenPartnership.com>
         <1522080857.3541.92.camel@linux.vnet.ibm.com>
         <1522165174.4539.11.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1522172832.3541.172.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-27 at 08:39 -0700, James Bottomley wrote:
> On Mon, 2018-03-26 at 12:14 -0400, Mimi Zohar wrote:
> > On Mon, 2018-03-26 at 07:28 -0700, James Bottomley wrote:
> > > 
> > > On Mon, 2018-03-26 at 19:41 +0530, Nayna Jain wrote:
> > > > 
> > > > 
> > > > On 03/22/2018 10:01 PM, James Bottomley wrote:
> > > > > 
> > > > > 
> > > > > On Thu, 2018-03-22 at 21:43 +0530, Nayna Jain wrote:
> > > [...]
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > +ssize_t tpm_transmit(struct tpm_chip *chip, struct
> > > > > > > tpm_space
> > > > > > > *space,
> > > > > > > +		     u8 *buf, size_t bufsiz, unsigned int
> > > > > > > flags)
> > > > > > > +{
> > > > > > > +	struct tpm_output_header *header = (struct
> > > > > > > tpm_output_header *)buf;
> > > > > > > +	/* space for header and handles */
> > > > > > > +	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
> > > > > > > +	unsigned int delay_msec = TPM2_DURATION_SHORT;
> > > > > > > +	u32 rc = 0;
> > > > > > > +	ssize_t ret;
> > > > > > > +	const size_t save_size = min(space ? sizeof(save)
> > > > > > > :
> > > > > > > TPM_HEADER_SIZE,
> > > > > > > +				     bufsiz);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * Subtlety here: if we have a space, the handles
> > > > > > > will
> > > > > > > be
> > > > > > > +	 * transformed, so when we restore the header we
> > > > > > > also
> > > > > > > have
> > > > > > > to
> > > > > > > +	 * restore the handles.
> > > > > > > +	 */
> > > > > > > +	memcpy(save, buf, save_size);
> > > > > > > +
> > > > > > > +	for (;;) {
> > > > > > > +		ret = tpm_try_transmit(chip, space, buf,
> > > > > > > bufsiz,
> > > > > > > flags);
> > > > > > > +		if (ret < 0)
> > > > > > > +			break;
> > > > > > > +		rc = be32_to_cpu(header->return_code);
> > > > > > > +		if (rc != TPM2_RC_RETRY)
> > > > > > > +			break;
> > > > > > > +		delay_msec *= 2;
> > > > > > Was wondering if this increment could be moved after
> > > > > > tpm_msleep(delay_msec) ?
> > > > > I thought about that when I saw the logic in the original but
> > > > > what
> > > > > it would do is double the maximum delay (which is already
> > > > > nearly
> > > > > double TPM2_DURATION_LONG).  I figured doubling the initial
> > > > > timeout
> > > > > was fine rather than trying to do complex logic to get the
> > > > > delay
> > > > > exact (and then having to litter the file with comments
> > > > > explaining
> > > > > why).
> > > > 
> > > > Sorry James, I didn't understand exactly about what complex logic
> > > > is 
> > > > involved. Can you please explain it more ?
> > > > My point was to just move "delay_msec *= 2"  after tpm_msleep()
> > > > as
> > > > shown below:
> > > > 
> > > > if (delay_msec > TPM2_DURATION_LONG) {
> > > >      dev_err(&chip->dev, "TPM is in retry loop\n");
> > > >      break;
> > > > }
> > > > tpm_msleep(delay_msec)
> > > > delay_msec *= 2;
> > > 
> > > Yes, I understand the suggestion; however, if you simply do that,
> > > you'll end up with a useless sleep at the end of the wait period
> > > before
> > > you check to see if you've waited too long, which is even more
> > > suboptimal than the current situation.  The cardinal rule is we
> > > should
> > > only sleep if we know we're going to retry.
> > 
> > By the time delay_msec is incremented here, you've already finished
> > sleeping and will resend the command.  This is the reason I assume
> > you
> > didn't use a normal for loop:
> > 
> >     for (delay_msec = TPM2_DURATION_SHORT; delay_msec
> > <TPM2_DURATION_LONG;
> >          delay_msec *= 2)
> > 
> > Incrementing the sleep here will only affect the next sleep.
> 
> Yes, looking at it again, that seems to be true.  I remember thinking
> the same of the original code when I looked at it, but saw there was
> some problem.  However, it's so long ago, I can't remember what it
> actually was and I can't see it now.

As this patch is already in the security's next-testing branch, it's
too late to change it.  I assume Nayna should post a patch that moves
it.

Mimi
