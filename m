Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43230 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752894AbeBASqI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 13:46:08 -0500
Message-ID: <1517510764.3145.38.camel@HansenPartnership.com>
Subject: Re: TPM selftest failure in 4.15
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 01 Feb 2018 19:46:04 +0100
In-Reply-To: <20180201174053.GQ17053@ziepe.ca>
References: <1517487371.3251.9.camel@HansenPartnership.com>
         <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
         <1517488970.3251.26.camel@HansenPartnership.com>
         <1517498648.3145.4.camel@HansenPartnership.com>
         <20180201174053.GQ17053@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-02-01 at 10:40 -0700, Jason Gunthorpe wrote:
> On Thu, Feb 01, 2018 at 03:24:08PM +0000, James Bottomley wrote:
> 
> > 
> > OK, I investigated but now my TPM has returned to normal (as in it
> > passes the selftest immediately).  There's clearly something that
> > makes it return TPM_RC_TESTING to every self test probe for seconds
> > at a time, but I don't know what it is.  Sending a different
> > command seems to cause the problem to clear (Managed to reproduce
> > once with the patch to verify), so this is my proposed fix.  It's
> > clearly nonsensical to detach the driver because the self test
> > still returns TPM_RC_TESTING, so convert that return to a
> > TPM_RC_SUCCESS on timeout.  It prints a warning message so we'll
> > see it in the logs if it causes problems.  Given that this seems to
> > be some type of internal TPM issue, I don't believe changing the
> > timings would work.
> 
> But if a selftest returns TPM2_RC_TESTING I would expect the next
> command to also fail with a testing in progress code? At least by the
> spec..

No, the spec says only that the command may fail with TPM_RC_TESTING
*if* the system it requires is under test.

I have no idea what's up with my TPM.  The selftests usually complete
in under 1ms and return TPM_RC_SUCCESS.  However occasionally the self
test can return TPM_RC_TESTING for seconds.

I've already booted with the patch and verified it doesn't induce any
failures for me.  Either the long running test is in a completely
unconnected subsystem or invoking a different command forces the TPM to
clear the testing state.

> The point of invoking selftest is to get to a state where future TPM
> commands will succeed, so returning immediately on RC_TESTING seems
> wrong?

Well it's definitely less wrong than the converse of actually detaching
the TPM driver because a self test is apparently still in progress.  If
you depend on the TPM for a critical function, your entire system is
hosed at that point.

I honestly don't think we should be waiting for the self test at all.
 We should kick it off and treat any TPM_RC_TESTING error as -EAGAIN.
 We're already under fire for slow boot sequences and adding 2s just to
wait for the TPM to self test adds to that for no real value.

James
