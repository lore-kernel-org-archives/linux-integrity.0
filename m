Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40937 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932168AbdLOPiL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 10:38:11 -0500
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
To: Mario Limonciello <mario.limonciello@dell.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
 <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
 <20171208155641.GA2883@ziepe.ca>
 <c544a476-5ea9-df81-ea8b-01fa578738f0@molgen.mpg.de>
 <20171208161814.GB2883@ziepe.ca>
 <d70c683a-9ac2-e731-d6fd-173ac35c5b1b@molgen.mpg.de>
 <c700bf23fcf44221bc179a7b0e6df5c9@infineon.com>
 <3159adc4-4236-c963-a118-500a61f21338@molgen.mpg.de>
 <10b81a727ba940889095fa4bb29d0863@infineon.com>
 <f3371f11c6fa42fba3a07cffa571d6a6@ausx13mpc120.AMER.DELL.COM>
 <cdbfa6c972684ed28a92b5105be71071@infineon.com>
 <5efeaf9e50e54b999efa91c39f311bd9@ausx13mpc120.AMER.DELL.COM>
 <127aefc5-44e1-7382-2548-5cd4774275b0@molgen.mpg.de>
 <39ff773039e04506affc4a8522bde99f@ausx13mpc120.AMER.DELL.COM>
 <6344e116-763f-98d5-5174-7395d761de45@molgen.mpg.de>
 <5bb6d2bc874f4227b7341c88373cf01f@ausx13mpc120.AMER.DELL.COM>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <6076476b-ee73-d7f4-481b-3bc98e1127c5@molgen.mpg.de>
Date: Fri, 15 Dec 2017 16:38:09 +0100
MIME-Version: 1.0
In-Reply-To: <5bb6d2bc874f4227b7341c88373cf01f@ausx13mpc120.AMER.DELL.COM>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030908010307060503020408"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Mario,


On 12/15/17 16:24, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
>> Sent: Friday, December 15, 2017 9:11 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Alexander Steffen
>> <Alexander.Steffen@infineon.com>; Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
>> rafael.j.wysocki@intel.com; len.brown@intel.com
>> Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
>> occurred continue selftest`
>>
>> Dear Mario,
>>
>>
>> On 12/15/17 15:39, Mario.Limonciello@dell.com wrote:
>>>> -----Original Message-----
>>>> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
>>>> Sent: Friday, December 15, 2017 5:54 AM
>>>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Alexander Steffen
>>>> <Alexander.Steffen@infineon.com>; Jason Gunthorpe <jgg@ziepe.ca>
>>>> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Rafael J.
>>>> Wysocki <rafael.j.wysocki@intel.com>; Len Brown <len.brown@intel.com>
>>>> Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
>>>> occurred continue selftest`

[...]

>>>> Mario, thank you for your quick reaction.
>>>>
>>>> [...]
>>>>
>>>> 1.  Can you reproduce this issue too?
>>>
>>> I haven't seen this, but if this is a regression I also have not run anything
>>> later than 4.15-rc1 right now.
>>
>> Well as far as I understood it, it's not a regression, and there is now
>> just better error reporting. Did you ever get the TPM to work?
> 
> I don't personally use a TPM with Linux on the XPS 9360, but TPM was
> tested by our partners when the XPS 9360 was enabled for Ubuntu.

It'd be great to know how it was tested, as currently it doesn't work 
here. I included the output in my reply to Alexander just now.

>>>> 2.  How do I find out, what TPM firmware version is installed?
>>>
>>> fwupd will tell you.  Documentation (and code) here:
>>> https://github.com/hughsie/fwupd/tree/master/plugins/dell
>>
>> Unfortuntately it's not listed with fwupd 0.7.0-0ubuntu4.3 in Ubuntu
>> 16.04.3 LTS installed by Dell.
> 
> If you're unwilling to upgrade to a newer userspace, you can write
> a simple application that can use the new dell-smbios from 4.15 interface to look this up.

Is the newer userspace officially supported by Dell. Because I really 
like to avoid the time-waste with the Dell support again, if I do not 
use their installed OS. Sometimes the Dell support even claims the 
installed Ubuntu flavor does not get any support by Dell.

> Most of the work is already done (see
> https://github.com/torvalds/linux/blob/master/tools/wmi/dell-smbios-example.c#L179)
> 
> You'll just need to add some parsing around the output (see fwupd code) to
> tell the version.  If you do this, please feel free to submit it platform-x86, it may be useful
> for someone else in this sample application too.
> 
> Given you don't have a newer fwupd on your system you won't be able to "easily" flash
> the newer TPM firmware.

I assume you don't make these decisions, but please relay to your 
superiors that working functionality in the recommended/shipped OS is 
really what customers expect buying a device with GNU/Linux support. In 
my opinion, Dell and Canonical really need to step up there.


Kind regards,

Paul



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
