Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36254 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751029AbeBIQSK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 11:18:10 -0500
Message-ID: <1518193087.3930.4.camel@HansenPartnership.com>
Subject: Re: TPM selftest failure in 4.15
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 09 Feb 2018 08:18:07 -0800
In-Reply-To: <20180209100204.likckglpdx427dnl@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
         <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
         <1517488970.3251.26.camel@HansenPartnership.com>
         <1517498648.3145.4.camel@HansenPartnership.com>
         <20180201174053.GQ17053@ziepe.ca>
         <1517510764.3145.38.camel@HansenPartnership.com>
         <20180201185909.GW17053@ziepe.ca>
         <1517515204.3145.51.camel@HansenPartnership.com>
         <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
         <1518109320.21828.2.camel@HansenPartnership.com>
         <20180209100204.likckglpdx427dnl@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-09 at 12:02 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
> > 
> > There is an identified regression: the TPM driver will now
> > periodically
> > fail to attach.  However, there's no point reviewing until we agree
> > what the fix is.  I was just waiting to verify this fixed my
> > problem
> > (which means seeing the messages it spits out proving the TPM has
> > remained in self test).  I have now seen this and the driver still
> > works, so I can submit a formal patch.
> 
> For the self-test the duration falls down to 2 seconds as the specs
> do
> not contain any well-defined duration for it, or at least I haven't
> found it.
> 
> I see three alternative ways the fix the self-test:
> 
> 1. Execute self-test with fullTest = YES.
> 2. Have a flag TPM_CHIP_TESTING that is set when the self-test is
>    started. Issue a warning on time-out. Check for this flag in
>    tpm_transmit_cmd() and tpm_write() and resend self-test command
>    if the flag is stil test before the actual command. Return -EBUSY
>    and print a warning if self-test is still active.
> 3. Increase the duration to the "correct" value if we have one.

Actually, I disagree.  The first principle we got out of the discussion
was don't re-send the selftest command if the TPM says it's still
running self tests, so we definitely need only to send it once.

I think if the TPM returns returns RC_TESTING we continue on booting
and let it run selftest in the background.  We don't need a flag
because it will return RC_TESTING to any command that tries to exercise
a system under test.  So all we need to do is look for that return,
pause and retry up to a timeout.  If you look at the patch I submitted:

https://marc.info/?l=linux-integrity&m=151812288917753

That's pretty much what it does.

I really think adding more delay to boot up to try and determine when
the selftests "finish" is the wrong way to do this given that data from
the XPS-13 confirms this is somewhere above 2s, which is already a huge
boot wait.

James
