Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:8129 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBILrQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 06:47:16 -0500
Subject: Re: TPM selftest failure in 4.15
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
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
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <6066758e-efe3-7432-0b8f-540a781cb3aa@infineon.com>
Date: Fri, 9 Feb 2018 12:47:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180209100204.likckglpdx427dnl@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 09.02.2018 11:02, Jarkko Sakkinen wrote:
> On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
>> There is an identified regression: the TPM driver will now periodically
>> fail to attach.  However, there's no point reviewing until we agree
>> what the fix is.  I was just waiting to verify this fixed my problem
>> (which means seeing the messages it spits out proving the TPM has
>> remained in self test).  I have now seen this and the driver still
>> works, so I can submit a formal patch.
> 
> For the self-test the duration falls down to 2 seconds as the specs do
> not contain any well-defined duration for it, or at least I haven't
> found it.
> 
> I see three alternative ways the fix the self-test:
> 
> 1. Execute self-test with fullTest = YES.

I had proposed some fixes in this direction last year:
https://patchwork.kernel.org/patch/10105483/
https://patchwork.kernel.org/patch/10130535/

Those combine the fast test execution with fullTest = NO for 
spec-compliant TPMs with a fallback to fullTest = YES.

> 2. Have a flag TPM_CHIP_TESTING that is set when the self-test is
>     started. Issue a warning on time-out. Check for this flag in
>     tpm_transmit_cmd() and tpm_write() and resend self-test command
>     if the flag is stil test before the actual command. Return -EBUSY
>     and print a warning if self-test is still active.
> 3. Increase the duration to the "correct" value if we have one.

What about option #4? Just not calling TPM2_SelfTest at all.

I had already proposed that solution in 
https://www.spinics.net/lists/linux-integrity/msg01007.html, but did not 
get much feedback. According to the specification, that won't lose any 
test coverage ("If a command requires use of an untested algorithm or 
functional module, the TPM performs the test and then completes the 
command actions." 
(https://trustedcomputinggroup.org/wp-content/uploads/TPM-Rev-2.0-Part-1-Architecture-01.38.pdf 
chapter 12.3, page 83/59).) and will definitely be the best option in 
terms of performance and complexity of the driver code.

Alexander
