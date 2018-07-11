Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58156 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726611AbeGKVBB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jul 2018 17:01:01 -0400
Message-ID: <1531342491.3260.26.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm.h: increase poll timings to fix tpm_tis regression
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 11 Jul 2018 13:54:51 -0700
In-Reply-To: <EA1F52B6-C56D-4910-A88A-9C0FC0F6E1FE@gmx.de>
References: <1531328689.3260.8.camel@HansenPartnership.com>
         <1531329074.3260.9.camel@HansenPartnership.com>
         <20180711182120.GF23935@ziepe.ca>
         <1531336133.3260.16.camel@HansenPartnership.com>
         <20180711200101.GH23935@ziepe.ca>
         <1531341545.3260.24.camel@HansenPartnership.com>
         <EA1F52B6-C56D-4910-A88A-9C0FC0F6E1FE@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-07-11 at 22:51 +0200, Peter Huewe wrote:
> 
> Am 11. Juli 2018 22:39:05 MESZ schrieb James Bottomley <James.Bottoml
> ey@HansenPartnership.com>:
> > On Wed, 2018-07-11 at 14:01 -0600, Jason Gunthorpe wrote:
> > > On Wed, Jul 11, 2018 at 12:08:53PM -0700, James Bottomley wrote:
> > > > On Wed, 2018-07-11 at 12:21 -0600, Jason Gunthorpe wrote:
[...]
> > > > > I wonder if something about triggering ETIME even once breaks
> > > > > the driver so it can't talk to the chip at all thereafter..
> > > > > 
> > > > > Ie it doesn't abort the command properly and becomes desynced
> > > > > with the TIS execution protocol.
> > > > 
> > > > Yes, I wondered about this, but I don't understand the bus
> > > > protocol well enough.  The tpm-interface:tpm_try_transmit()
> > > > which throws the first ETIME says after we get that we send
> > > > chip->ops->cancel() which tpm_tis simply translates to
> > > > tpm_tis_ready() which also times out.  Is there a bigger hammer
> > > > I can hit it with?
> > > 
> > > I don't remember off hand.. But this is, IMHO, a better guess
> > > than the firmware crashes from reading the status register..
> > 
> > Oh, actually, I think the bus crashes or wedges, not the TPM.  I
> > just don't have any tools to probe the LPC.
> > 
> 
> I doubt that your fTPM is actually attached to LPC.
> And usually if lpc  wedges it takes down your pc with it (from my
> experience)

How do I tell what it is attached to?  Sysfs doesn't seem to know but I
assume the ACPI information should contain something relevant.

> I wonder what the contents of the acc and sts registers actually are.
> 
> 
> If you want i can send you a small tis 'debug' tool tomorrow.

Sure, that would help ... I'm just leafing through the TIS manual now
to see if there's anything I can build into the driver.

James
