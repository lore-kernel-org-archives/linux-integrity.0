Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:36368 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752904AbdLSNCF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 08:02:05 -0500
Date: Tue, 19 Dec 2017 15:02:00 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171219130200.7zez4bnh3f3yvuzv@linux.intel.com>
References: <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218175502.GC19056@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 18, 2017 at 10:55:02AM -0700, Jason Gunthorpe wrote:
> On Mon, Dec 18, 2017 at 01:29:01PM +0100, Javier Martinez Canillas wrote:
> > On 12/18/2017 01:22 PM, Javier Martinez Canillas wrote:
> > 
> > [snip]
> > 
> > > 
> > > James,
> > > 
> > > Can you please test the following (untested) patch on top of the other two
> > > mentioned patches to see if it makes a difference for you?
> > > 
> > 
> > I should had tried to at least compile the patch :)
> 
> I think this is backwards..
> 
> If CLKRUN_EN is on (eg power management is NOT enabled on LPC) then
> TPM shouldn't do anything at all.
> 
> If CLKRUN_EN is off, then it should try to turn it on/off to save
> power.
> 
> Perhaps the best work around is to just delete the turning off of
> CLKRUN_EN ? Uses more power but keeps the clock running which should
> keep both TPM and superio happy.
> 
> Jason

On some BSW systems keeping CLKRUN_EN on during TPM command caused
issues. That was the original reason for the fixes.

/Jarkko
