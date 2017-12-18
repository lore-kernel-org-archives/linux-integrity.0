Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37980 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934431AbdLRRzH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 12:55:07 -0500
Received: by mail-wr0-f193.google.com with SMTP id o2so15061817wro.5
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 09:55:07 -0800 (PST)
Date: Mon, 18 Dec 2017 10:55:02 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
Message-ID: <20171218175502.GC19056@ziepe.ca>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca>
 <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 18, 2017 at 01:29:01PM +0100, Javier Martinez Canillas wrote:
> On 12/18/2017 01:22 PM, Javier Martinez Canillas wrote:
> 
> [snip]
> 
> > 
> > James,
> > 
> > Can you please test the following (untested) patch on top of the other two
> > mentioned patches to see if it makes a difference for you?
> > 
> 
> I should had tried to at least compile the patch :)

I think this is backwards..

If CLKRUN_EN is on (eg power management is NOT enabled on LPC) then
TPM shouldn't do anything at all.

If CLKRUN_EN is off, then it should try to turn it on/off to save
power.

Perhaps the best work around is to just delete the turning off of
CLKRUN_EN ? Uses more power but keeps the clock running which should
keep both TPM and superio happy.

Jason
