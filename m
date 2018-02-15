Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033088AbeBOPPf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Feb 2018 10:15:35 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1FFFI33084576
        for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2018 10:15:35 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g5bymjgkw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2018 10:15:32 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 15 Feb 2018 15:13:59 -0000
Subject: Re: TPM selftest failure in 4.15
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 15 Feb 2018 10:13:52 -0500
In-Reply-To: <20180215121231.yc74vwg3fqz3ybop@linux.intel.com>
References: <1517488970.3251.26.camel@HansenPartnership.com>
         <1517498648.3145.4.camel@HansenPartnership.com>
         <20180201174053.GQ17053@ziepe.ca>
         <1517510764.3145.38.camel@HansenPartnership.com>
         <20180201185909.GW17053@ziepe.ca>
         <1517515204.3145.51.camel@HansenPartnership.com>
         <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
         <1518109320.21828.2.camel@HansenPartnership.com>
         <20180209100204.likckglpdx427dnl@linux.intel.com>
         <6066758e-efe3-7432-0b8f-540a781cb3aa@infineon.com>
         <20180215121231.yc74vwg3fqz3ybop@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1518707632.5667.118.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-02-15 at 14:12 +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 09, 2018 at 12:47:10PM +0100, Alexander Steffen wrote:
> > On 09.02.2018 11:02, Jarkko Sakkinen wrote:
> > > On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
> > > > There is an identified regression: the TPM driver will now periodically
> > > > fail to attach.  However, there's no point reviewing until we agree
> > > > what the fix is.  I was just waiting to verify this fixed my problem
> > > > (which means seeing the messages it spits out proving the TPM has
> > > > remained in self test).  I have now seen this and the driver still
> > > > works, so I can submit a formal patch.
> > > 
> > > For the self-test the duration falls down to 2 seconds as the specs do
> > > not contain any well-defined duration for it, or at least I haven't
> > > found it.
> > > 
> > > I see three alternative ways the fix the self-test:
> > > 
> > > 1. Execute self-test with fullTest = YES.
> > 
> > I had proposed some fixes in this direction last year:
> > https://patchwork.kernel.org/patch/10105483/
> > https://patchwork.kernel.org/patch/10130535/
> > 
> > Those combine the fast test execution with fullTest = NO for spec-compliant
> > TPMs with a fallback to fullTest = YES.
> 
> The first was accepted.
> 
> The 2nd wasn't accpeted mainly for reasons that for me only acceptable
> dependency is:
> 
> 1. Patch that is part of the same patch set.
> 2. A merged commit.
> 
> I didn't event look at the code for the second one at that point because
> it was formally done wrong.
> 
> What it is doing would be acceptable for me. I still think that TPM
> should be fully tested before letting IMA for example to use it.

Why?  The short selftest has worked fine up to now.  The full selftest
delays the TPM way too long and causes IMA to go into TPM-bypass mode.
 The faster the TPM is available, the better for IMA.

It seems all commands, except selftest, the code sleeps in a loop and
checks for the command to finish, but doesn't resend the command.
 Only for selftest is the command resent, instead of just waiting for
it to complete.  Is there any reason for this?

Mimi
