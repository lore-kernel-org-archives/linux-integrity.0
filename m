Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57930 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751544AbeBHRCC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 12:02:02 -0500
Message-ID: <1518109320.21828.2.camel@HansenPartnership.com>
Subject: Re: TPM selftest failure in 4.15
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 08 Feb 2018 09:02:00 -0800
In-Reply-To: <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
References: <1517487371.3251.9.camel@HansenPartnership.com>
         <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
         <1517488970.3251.26.camel@HansenPartnership.com>
         <1517498648.3145.4.camel@HansenPartnership.com>
         <20180201174053.GQ17053@ziepe.ca>
         <1517510764.3145.38.camel@HansenPartnership.com>
         <20180201185909.GW17053@ziepe.ca>
         <1517515204.3145.51.camel@HansenPartnership.com>
         <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-02-08 at 15:10 +0200, Jarkko Sakkinen wrote:
> On Thu, Feb 01, 2018 at 09:00:04PM +0100, James Bottomley wrote:
> > 
> > On Thu, 2018-02-01 at 11:59 -0700, Jason Gunthorpe wrote:
> > > 
> > > On Thu, Feb 01, 2018 at 07:46:04PM +0100, James Bottomley wrote:
> > > 
> > > > 
> > > > 
> > > > I honestly don't think we should be waiting for the self test
> > > > at
> > > > all.
> > > > We should kick it off and treat any TPM_RC_TESTING error as
> > > > -EAGAIN.
> > > > We're already under fire for slow boot sequences and adding 2s
> > > > just
> > > > to
> > > > wait for the TPM to self test adds to that for no real value.
> > > 
> > > Arguably the BIOS should have completed the selftest - this stuff
> > > generally only exists to support embedded.
> > > 
> > > I don't like the idea of EAGAIN, that just expose all our users
> > > to
> > > this mess.
> > > 
> > > I would support making transmit_cmd genericly wait and retry if
> > > the
> > > TPM insists we need to wait for selftest to complete the specific
> > > command though.
> > 
> > OK, how about this then?
> > 
> > James
> 
> As long as there is no identified a regression it is a waste
> of time to review these...

There is an identified regression: the TPM driver will now periodically
fail to attach.  However, there's no point reviewing until we agree
what the fix is.  I was just waiting to verify this fixed my problem
(which means seeing the messages it spits out proving the TPM has
remained in self test).  I have now seen this and the driver still
works, so I can submit a formal patch.

James
