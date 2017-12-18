Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:40268 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935424AbdLRXGs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 18:06:48 -0500
Received: by mail-wm0-f50.google.com with SMTP id f206so660363wmf.5
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 15:06:47 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Ettle <james@ettle.org.uk>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.l.morris@oracle.com" <james.l.morris@oracle.com>
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
 <379b4165-bf82-70e9-4fc9-018fb62ee23c@redhat.com>
 <5FFFAD06ADE1CA4381B3F0F7C6AF5828987F13@ORSMSX109.amr.corp.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <d98db0d0-2615-d13a-e341-749173f3ec1d@redhat.com>
Date: Tue, 19 Dec 2017 00:06:44 +0100
MIME-Version: 1.0
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF5828987F13@ORSMSX109.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Azhar,

On 12/18/2017 08:34 PM, Shaikh, Azhar wrote:
> 
> 
>> -----Original Message-----
>> From: Javier Martinez Canillas [mailto:javierm@redhat.com]
>> Sent: Monday, December 18, 2017 11:30 AM
>> To: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; James Ettle
>> <james@ettle.org.uk>; linux-integrity@vger.kernel.org; Shaikh, Azhar
>> <azhar.shaikh@intel.com>; linux-kernel@vger.kernel.org;
>> james.l.morris@oracle.com
>> Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
>> Braswell system
>>
>> Hello Jason,
>>
>> Thanks a lot for your feedback.
>>
>> On 12/18/2017 06:55 PM, Jason Gunthorpe wrote:
>>> On Mon, Dec 18, 2017 at 01:29:01PM +0100, Javier Martinez Canillas wrote:
>>>> On 12/18/2017 01:22 PM, Javier Martinez Canillas wrote:
>>>>
>>>> [snip]
>>>>
>>>>>
>>>>> James,
>>>>>
>>>>> Can you please test the following (untested) patch on top of the
>>>>> other two mentioned patches to see if it makes a difference for you?
>>>>>
>>>>
>>>> I should had tried to at least compile the patch :)
>>>
>>> I think this is backwards..
>>>
>>> If CLKRUN_EN is on (eg power management is NOT enabled on LPC) then
>>> TPM shouldn't do anything at all.
>>>
>>> If CLKRUN_EN is off, then it should try to turn it on/off to save
>>> power.
>>>
>>
>> My knowledge of LPC is near to non-existent so I please forgive me if I'm
>> wrong, but my understanding is that it's the opposite of what you said.
>>
>> When CLKRUN_EN is SET, power management is ENABLED on the LPC bus and
>> the host LCLK clock may be stopped when entering in some low-power states.
>>
>> The CLKRUN# signal is then used by peripherals to restart the LCLK clock after
>> resuming from low-power states to be able to transmit again.
>>
>> When CLKRUN_EN is CLEAR, power management is DISABLED on the LPC bus
>> and the host LCLK clock is never stopped even when entering in some low-
>> power states.
>>
> 
> Hi Javier,
> 
> Yes you are correct with the above understanding of the CLKRUN.
>

Thanks for the confirmation.
 
>> IIUC, if CLKRUN_EN is enabled, then all the devices attached to the LPC bus
>> have to support the CLKRUN protocol. My guess is that on some Braswell
>> systems LPC power management is enabled but the TPM device doesn't have
>> CLKRUN support.
>>
> 
> I think this is what might be happening here.
>

One question, what happens if the CLKRUN protocol is disabled and never enabled
again? My understanding is that the CLKRUN# signal is not required if the host
never stops the LCLK clock, and peripherals that do support the CLKRUN protocol
should still work if the CLKRUN protocol is disabled and the LCLK isn't stopped.

So from what we discussed above, I think it may be correct to completely disable
CLKRUN protocol if there's a peripheral that doesn't support it.
 
> Since I do not have an end product to test this on, I managed to get one BSW Reference Verification Platform(RVP). I flashed the latest Ubuntu (17.10) which is on 4.13.13 kernel version and does have the patch.
> 
> I was able to use the PS/2 mouse and keyboard immediately after bootup and also after suspend/resume cycle. The system does have a TPM.(/dev/tpm0 and /dev/tpmrm0 exist)
>

It's not clear to me if the RVP system is the same one where you found the issue
and lead to the commit that caused the regression.

Could you please test what happens if you disable the CLKRUN_EN and never enable
it again?

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
