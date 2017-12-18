Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35260 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932808AbdLRT3d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 14:29:33 -0500
Received: by mail-wm0-f45.google.com with SMTP id f9so6268wmh.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 11:29:32 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <20171218175502.GC19056@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
Date: Mon, 18 Dec 2017 20:29:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171218175502.GC19056@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jason,

Thanks a lot for your feedback.

On 12/18/2017 06:55 PM, Jason Gunthorpe wrote:
> On Mon, Dec 18, 2017 at 01:29:01PM +0100, Javier Martinez Canillas wrote:
>> On 12/18/2017 01:22 PM, Javier Martinez Canillas wrote:
>>
>> [snip]
>>
>>>
>>> James,
>>>
>>> Can you please test the following (untested) patch on top of the other two
>>> mentioned patches to see if it makes a difference for you?
>>>
>>
>> I should had tried to at least compile the patch :)
> 
> I think this is backwards..
> 
> If CLKRUN_EN is on (eg power management is NOT enabled on LPC) then
> TPM shouldn't do anything at all.
> 
> If CLKRUN_EN is off, then it should try to turn it on/off to save
> power.
>

My knowledge of LPC is near to non-existent so I please forgive me if I'm wrong,
but my understanding is that it's the opposite of what you said.

When CLKRUN_EN is SET, power management is ENABLED on the LPC bus and the host
LCLK clock may be stopped when entering in some low-power states.

The CLKRUN# signal is then used by peripherals to restart the LCLK clock after
resuming from low-power states to be able to transmit again.

When CLKRUN_EN is CLEAR, power management is DISABLED on the LPC bus and the
host LCLK clock is never stopped even when entering in some low-power states.

IIUC, if CLKRUN_EN is enabled, then all the devices attached to the LPC bus
have to support the CLKRUN protocol. My guess is that on some Braswell systems
LPC power management is enabled but the TPM device doesn't have CLKRUN support.

And that was the motivation of commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol
for Braswell systems") that introduced the regression.

> Perhaps the best work around is to just delete the turning off of
> CLKRUN_EN ? Uses more power but keeps the clock running which should
> keep both TPM and superio happy.
>

But that's exactly the goal of the commit 5e572cab92f0, to disable the CLKRUN
protocol (probably for what I mentioned before). So doing so will cause issues
for those systems again.

What the patch I shared with James does is to avoid disabling the CLKRUN_EN
if this is already disabled. Which should be a no-op anyways but the problem
is that latter it's enabled even when the driver found disabled to start with.

I still don't like the overall solution since it's too error prone. Touching a
global bus configuration in a driver for a single peripheral isn't safe to say
the least.

But regardless of that, the patch I shared has merits on its own since is wrong
to keep the bus configuration in a different state that was before the driver
was probed. And in fact, James reported that it makes his system to work again.

> Jason
>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
