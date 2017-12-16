Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:45105 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756964AbdLPVAA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 Dec 2017 16:00:00 -0500
Received: by mail-wm0-f45.google.com with SMTP id 9so23037785wme.4
        for <linux-integrity@vger.kernel.org>; Sat, 16 Dec 2017 12:59:59 -0800 (PST)
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
Message-ID: <34783fa1-4235-0057-1351-f7da9ee57024@redhat.com>
Date: Sat, 16 Dec 2017 21:59:57 +0100
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
>

Agreed. Although it would be good to have a solution soon, because this has been
broken since v4.13 and v4.15-rc4 is likely to come this weekend. So we may end
with Braswell system being non-function for 3 kernel releases...

As mentioned I can write a patch to hide this behavior under a Kconfig option
that's disabled by default (and maybe depend on BROKEN) or a module parameter
until a proper solution is found.

> /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
