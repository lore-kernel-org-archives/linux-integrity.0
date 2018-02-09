Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750981AbeBIM0s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Feb 2018 07:26:48 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w19CQhAT089573
        for <linux-integrity@vger.kernel.org>; Fri, 9 Feb 2018 07:26:48 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g17fa408m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Feb 2018 07:26:47 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 9 Feb 2018 12:26:44 -0000
Subject: Re: TPM selftest failure in 4.15
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 09 Feb 2018 07:26:40 -0500
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
Message-Id: <1518179200.3445.31.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-09 at 12:02 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
> > There is an identified regression: the TPM driver will now periodically
> > fail to attach.  However, there's no point reviewing until we agree
> > what the fix is.  I was just waiting to verify this fixed my problem
> > (which means seeing the messages it spits out proving the TPM has
> > remained in self test).  I have now seen this and the driver still
> > works, so I can submit a formal patch.
> 
> For the self-test the duration falls down to 2 seconds as the specs do
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

Please take into account that the TPM must complete initialization
BEFORE IMA looks for the TPM, otherwise IMA goes into TPM-bypass mode.
 This consistently happens with a full self-test (option 1).
Increasing the wait duration will most likely cause this to happen as
well (option 2).

Based on James' patch description, which says "There are various
theories that resending the self-test command actually causes the
tests to restart and thus triggers more TPM_RC_TESTING returns until
the timeout is exceeded", I think IMA's detecting the TPM, by doing a
PCR read, will cause the self-test to restart (option 2).

Reverting the patch that enabled the TPM full self-test, or commenting
out self-test completely, allows IMA to properly find the TPM.

Side note, if the kernel emits TPM initialization warnings, there
should be a successfully completed message as well.

Mimi
