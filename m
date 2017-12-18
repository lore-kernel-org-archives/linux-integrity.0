Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46128 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbdLRMWb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Dec 2017 07:22:31 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so28915407wme.5
        for <linux-integrity@vger.kernel.org>; Mon, 18 Dec 2017 04:22:30 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Ettle <james@ettle.org.uk>, linux-integrity@vger.kernel.org,
        azhar.shaikh@intel.com, linux-kernel@vger.kernel.org,
        james.l.morris@oracle.com
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
Date: Mon, 18 Dec 2017 13:22:28 +0100
MIME-Version: 1.0
In-Reply-To: <1513443676.29063.0.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/16/2017 06:01 PM, Jarkko Sakkinen wrote:
> On Fri, 2017-12-15 at 10:38 -0700, Jason Gunthorpe wrote:
>> On Fri, Dec 15, 2017 at 04:56:30PM +0200, Jarkko Sakkinen wrote:
>>> On Thu, Dec 14, 2017 at 12:10:52PM -0700, Jason Gunthorpe wrote:
>>>> On Thu, Dec 14, 2017 at 08:08:58PM +0100, Javier Martinez Canillas wrote:
>>>>
>>>>> Although probably reverting the offending commits is the right thing to do
>>>>> until a proper solution is proposed.
>>>>
>>>> Yes, if a fix is not forthcoming soon Jarkko should revert.
>>>>
>>>
>>> I think I should drop the current patch going to 4.16 and revert the old
>>> patch. Do we agree on this?
>>
>> I think the entire is_bsw thing needs to go, clearly manipulating
>> CLKRUN directly was not fully thought out?
>>
>> Hopefully Intel will come up with a fix patch to preserve PS/2
>> functionality and it won't come to a revert..
> 
> Agreed.

One flaw I found with the logic is that it assumes that the CLKRUN signal will
always be enabled. And so the driver enables it unconditionally after is probed
(I believe Jason mentioned that before?).

But I wonder if what's causing issues with the PS/2 devices is that the devices
assume the CLKRUN signal is disabled but this changes because of the tpm driver?

James,

Can you please test the following (untested) patch on top of the other two
mentioned patches to see if it makes a difference for you?
