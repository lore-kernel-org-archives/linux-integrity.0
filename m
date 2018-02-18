Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47628 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbeBRSGl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Feb 2018 13:06:41 -0500
Message-ID: <1518977199.4611.31.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: fix selftest failure regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date: Sun, 18 Feb 2018 10:06:39 -0800
In-Reply-To: <20180218173607.GC4476@ziepe.ca>
References: <1518122886.21828.20.camel@HansenPartnership.com>
         <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
         <1518812108.4475.21.camel@HansenPartnership.com>
         <20180218170831.GA4476@ziepe.ca>
         <1518974202.4611.13.camel@HansenPartnership.com>
         <20180218173607.GC4476@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-02-18 at 10:36 -0700, Jason Gunthorpe wrote:
> On Sun, Feb 18, 2018 at 09:16:42AM -0800, James Bottomley wrote:
> > 
> > On Sun, 2018-02-18 at 10:08 -0700, Jason Gunthorpe wrote:
> > > 
> > > On Fri, Feb 16, 2018 at 12:15:08PM -0800, James Bottomley wrote:
> > > > 
> > > > 
> > > > It isn't currently since it uses tpm_transmit directly.  My
> > > > thought on this is that if the TPM hasn't got its testing crap
> > > > together by the time we enter userspace (which will be 10 or
> > > > more seconds after we first sent the test commands), then we
> > > > really have a problem and the user should see it.
> > > 
> > > Why would it be 10s? My embedded systems got to userspace in
> > > something like 0.5s after sending the startup.
> > 
> > The misbehaving chips seem to be laptop, and that's about what it
> > takes mine to get through the boot sequence ... and I thought
> > waiting 2s for the TPM to self test was a long time for me; it must
> > be an eternity to you ...
> 
> Yes :) The TPMs I used did not take 2 seconds to self test. Maybe all
> the new algorithms in TPM2 make it take much longer?

Heh, this is all undefined territory.  The spec says what the TPM is
allowed to do (and some of the TPMs don't even respect that), but it
doesn't say what we should do, so we're winging it.

However, if my TPM returns TPM_RC_TESTING and we wait for all self-
tests to complete, it's definitely taking over 2s.  Hence my argument
that we shouldn't wait.

> > > Not sure what to do here.. Our model has been that userspace gets
> > > a raw view - but it has also been that the kernel makes the TPM
> > > fully ready.
> > 
> > Well, I could move the wait for testing to finish loop to
> > tpm_transmit().  That would cope with both cases.  However, I've
> > never actually seen this loop activate, even with all the TPM
> > misbehaviour I've managed to induce, so I have no objective measure
> > for whether it's useful or not.
> 
> That is just a time issue, right? Or does the kernel send no commands
> early on that are depending on self test?

I've got IMA enabled on my system, so they get an immediate read and
update of PCR values within milliseconds of exiting the self test,
which succeeds.  Now the TPM is allowed to process systems that have
completed test even if some others are under testing and I'd guess that
the PCR systems are the simplest to test and first to complete.

The first thing my system does in userspace is start the VPN which has
a TPM key, so I'm using the cryptographic function reasonably fast as
well, but that's after the initial kernel bring up, so the fastest I've
seen it is 5s after the TPM exits self test.

James
