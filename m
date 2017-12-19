Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:52911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdLSNSd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 08:18:33 -0500
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        linux-kernel@vger.kernel.org, james.l.morris@oracle.com
References: <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
 <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
 <20171214191052.GA20833@ziepe.ca>
 <20171215145630.ftsnj4azqqhzqwsh@linux.intel.com>
 <20171215173826.GD12434@ziepe.ca> <1513443676.29063.0.camel@linux.intel.com>
 <d3984354-56d4-747a-1266-bf28c657daae@redhat.com>
 <16609e73-e35d-4bb0-410d-e87915daba39@redhat.com>
 <6b41f2a7-3b6e-69f2-fd49-d2ae774ff0f5@ettle.org.uk>
 <20171219130017.dhley2g4avwo3vbu@linux.intel.com>
From: James Ettle <james@ettle.org.uk>
Message-ID: <5d899290-c959-fa27-b0cf-83c86ac7f28c@ettle.org.uk>
Date: Tue, 19 Dec 2017 13:18:09 +0000
MIME-Version: 1.0
In-Reply-To: <20171219130017.dhley2g4avwo3vbu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I'm OK with that.

Do you need any more info on the specifics of the machine I'm using?

(Note: I'm not currently aware of any BIOS updates for it. If this is ultimately a BIOS problem I wouldn't know what sort of report to file, or how to file it anyway...)

Thanks,
James

On 19/12/17 13:00, Jarkko Sakkinen wrote:
> On Mon, Dec 18, 2017 at 06:26:35PM +0000, James Ettle wrote:
>> The keyboard and touchpad work OK with the patch quoted below and the earlier two applied, i.e. the three patches with signatures:
>>
>> 667dcc75be864ff4c17cf58891853b7393bba3e2
>> db3248e8a036c39141c8f7e9f1cf5c5ae6815f76
>> 370d45a34dc8914066a995a3a6d6df1953ea9f60
>>
>> I applied these to a vanilla kernel.org 4.14.7 source using Fedora 4.14.5-300.fc27 .config. Confirmed the tpm modules are loaded.
>>
>> Tests:
>> 1. Keyboard and touchpad work OK on boot - PASS
>> 2. Still work after suspend/resume - PASS
>>
>> Let me know if you want any further tests.
>>
>> Many thanks,
>> James.
> 
> Thank you for your awesome help! I guess Javier can add your
> Tested-by to the patch?
> 
> /Jarkko
> 
