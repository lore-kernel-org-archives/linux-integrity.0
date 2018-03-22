Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51390 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751553AbeCVQbk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 12:31:40 -0400
Message-ID: <1521736298.7197.4.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/2] tpm: add retry logic
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Thu, 22 Mar 2018 09:31:38 -0700
In-Reply-To: <7236ada1-43b5-8280-ce21-3d0c095dfe9d@linux.vnet.ibm.com>
References: <1521657747.6397.18.camel@HansenPartnership.com>
         <1521657828.6397.19.camel@HansenPartnership.com>
         <7236ada1-43b5-8280-ce21-3d0c095dfe9d@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-22 at 21:43 +0530, Nayna Jain wrote:
> 
> > 
> >   /**
> > + * tpm_transmit - Internal kernel interface to transmit TPM
> > commands.
> > + *
> > + * @chip: TPM chip to use
> > + * @space: tpm space
> > + * @buf: TPM command buffer
> > + * @bufsiz: length of the TPM command buffer
> > + * @flags: tpm transmit flags - bitmap
> > + *
> > + * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
> > + * returns from the TPM and retransmits the command after a delay
> > up
> > + * to a maximum wait of TPM2_DURATION_LONG.
> > + *
> > + * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is
> > TPM2
> > + * only
> > + *
> > + * Return:
> > + *     the length of the return when the operation is successful.
> > + *     A negative number for system errors (errno).
> > + */
> > +ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space
> > *space,
> > +		     u8 *buf, size_t bufsiz, unsigned int flags)
> > +{
> > +	struct tpm_output_header *header = (struct
> > tpm_output_header *)buf;
> > +	/* space for header and handles */
> > +	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
> > +	unsigned int delay_msec = TPM2_DURATION_SHORT;
> > +	u32 rc = 0;
> > +	ssize_t ret;
> > +	const size_t save_size = min(space ? sizeof(save) :
> > TPM_HEADER_SIZE,
> > +				     bufsiz);
> > +
> > +	/*
> > +	 * Subtlety here: if we have a space, the handles will be
> > +	 * transformed, so when we restore the header we also have
> > to
> > +	 * restore the handles.
> > +	 */
> > +	memcpy(save, buf, save_size);
> > +
> > +	for (;;) {
> > +		ret = tpm_try_transmit(chip, space, buf, bufsiz,
> > flags);
> > +		if (ret < 0)
> > +			break;
> > +		rc = be32_to_cpu(header->return_code);
> > +		if (rc != TPM2_RC_RETRY)
> > +			break;
> > +		delay_msec *= 2;
> 
> Was wondering if this increment could be moved after 
> tpm_msleep(delay_msec) ?

I thought about that when I saw the logic in the original but what it
would do is double the maximum delay (which is already nearly double
TPM2_DURATION_LONG).  I figured doubling the initial timeout was fine
rather than trying to do complex logic to get the delay exact (and then
having to litter the file with comments explaining why).

James
