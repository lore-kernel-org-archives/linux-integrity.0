Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21177 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHNKL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 08:10:11 -0500
Date: Thu, 8 Feb 2018 15:10:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: TPM selftest failure in 4.15
Message-ID: <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
 <1517510764.3145.38.camel@HansenPartnership.com>
 <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517515204.3145.51.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 09:00:04PM +0100, James Bottomley wrote:
> On Thu, 2018-02-01 at 11:59 -0700, Jason Gunthorpe wrote:
> > On Thu, Feb 01, 2018 at 07:46:04PM +0100, James Bottomley wrote:
> > 
> > > 
> > > I honestly don't think we should be waiting for the self test at
> > > all.
> > > We should kick it off and treat any TPM_RC_TESTING error as
> > > -EAGAIN.
> > > We're already under fire for slow boot sequences and adding 2s just
> > > to
> > > wait for the TPM to self test adds to that for no real value.
> > 
> > Arguably the BIOS should have completed the selftest - this stuff
> > generally only exists to support embedded.
> > 
> > I don't like the idea of EAGAIN, that just expose all our users to
> > this mess.
> > 
> > I would support making transmit_cmd genericly wait and retry if the
> > TPM insists we need to wait for selftest to complete the specific
> > command though.
> 
> OK, how about this then?
> 
> James

As long as there is no identified a regression it is a waste
of time to review these...

/Jarkko
