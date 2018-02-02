Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46736 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750781AbeBBFqj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 00:46:39 -0500
Message-ID: <1517550394.3222.21.camel@HansenPartnership.com>
Subject: Re: TPM selftest failure in 4.15 (Dell XPS 13, Nuvoton 6xx)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Mario.Limonciello@dell.com
Cc: Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org,
        regressions@leemhuis.info, pmenzel@molgen.mpg.de
Date: Fri, 02 Feb 2018 06:46:34 +0100
In-Reply-To: <20180201222251.GB17053@ziepe.ca>
References: <1517487371.3251.9.camel@HansenPartnership.com>
         <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
         <1517488970.3251.26.camel@HansenPartnership.com>
         <1517498648.3145.4.camel@HansenPartnership.com>
         <4384419e-b2c6-7c51-e905-281ddfe68442@molgen.mpg.de>
         <d9c63b11-363a-2007-d7d5-a0112e58cb46@molgen.mpg.de>
         <d95f60f2e375446db3987f7d082d5cdd@ausx13mpc120.AMER.DELL.COM>
         <0d6c700430264d9584426a587b7c056e@ausx13mpc120.AMER.DELL.COM>
         <20180201222251.GB17053@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-02-01 at 15:22 -0700, Jason Gunthorpe wrote:
> On Thu, Feb 01, 2018 at 09:06:55PM +0000, Mario.Limonciello@dell.com
> wrote:
> 
> > 
> > I discussed this with some folks and although it would fix the
> > problem it is not accurately characterizing the situation.  What is
> > likely happening here is that issuing the self test command in
> > succession is causing the TPM to restart the self test and not
> > complete.  Instead the selfTestDone bit should be polled.
> 
> Oh, I wonder if that is beacuse this was copied from the TPM1 version
> where we don't have a bit like that??
> 
> Should we check this selfTestDone bit before event sending the self
> test?

The proposed patch already takes care of that by only sending the self
test once.  I suppose checking the selfTestDone bit and not sending a
self test at all could be an additional optimization on top, though.

James
