Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28729 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967889AbeBOMMm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Feb 2018 07:12:42 -0500
Date: Thu, 15 Feb 2018 14:12:31 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180215121231.yc74vwg3fqz3ybop@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6066758e-efe3-7432-0b8f-540a781cb3aa@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Feb 09, 2018 at 12:47:10PM +0100, Alexander Steffen wrote:
> On 09.02.2018 11:02, Jarkko Sakkinen wrote:
> > On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
> > > There is an identified regression: the TPM driver will now periodically
> > > fail to attach.  However, there's no point reviewing until we agree
> > > what the fix is.  I was just waiting to verify this fixed my problem
> > > (which means seeing the messages it spits out proving the TPM has
> > > remained in self test).  I have now seen this and the driver still
> > > works, so I can submit a formal patch.
> > 
> > For the self-test the duration falls down to 2 seconds as the specs do
> > not contain any well-defined duration for it, or at least I haven't
> > found it.
> > 
> > I see three alternative ways the fix the self-test:
> > 
> > 1. Execute self-test with fullTest = YES.
> 
> I had proposed some fixes in this direction last year:
> https://patchwork.kernel.org/patch/10105483/
> https://patchwork.kernel.org/patch/10130535/
> 
> Those combine the fast test execution with fullTest = NO for spec-compliant
> TPMs with a fallback to fullTest = YES.

The first was accepted.

The 2nd wasn't accpeted mainly for reasons that for me only acceptable
dependency is:

1. Patch that is part of the same patch set.
2. A merged commit.

I didn't event look at the code for the second one at that point because
it was formally done wrong.

What it is doing would be acceptable for me. I still think that TPM
should be fully tested before letting IMA for example to use it.

/Jarkko
