Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47508 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751422AbeBRRQo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Feb 2018 12:16:44 -0500
Message-ID: <1518974202.4611.13.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date: Sun, 18 Feb 2018 09:16:42 -0800
In-Reply-To: <20180218170831.GA4476@ziepe.ca>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518812108.4475.21.camel@HansenPartnership.com>
         <20180218170831.GA4476@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-02-18 at 10:08 -0700, Jason Gunthorpe wrote:
> On Fri, Feb 16, 2018 at 12:15:08PM -0800, James Bottomley wrote:
> > 
> > It isn't currently since it uses tpm_transmit directly.  My thought
> > on this is that if the TPM hasn't got its testing crap together by
> > the time we enter userspace (which will be 10 or more seconds after
> > we first sent the test commands), then we really have a problem and
> > the user should see it.
> 
> Why would it be 10s? My embedded systems got to userspace in
> something like 0.5s after sending the startup.

The misbehaving chips seem to be laptop, and that's about what it takes
mine to get through the boot sequence ... and I thought waiting 2s for
the TPM to self test was a long time for me; it must be an eternity to
you ...

> Not sure what to do here.. Our model has been that userspace gets a
> raw view - but it has also been that the kernel makes the TPM fully
> ready.

Well, I could move the wait for testing to finish loop to
tpm_transmit().  That would cope with both cases.  However, I've never
actually seen this loop activate, even with all the TPM misbehaviour
I've managed to induce, so I have no objective measure for whether it's
useful or not.

James
