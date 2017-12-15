Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54846 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756619AbdLOPK4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 10:10:56 -0500
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
To: Mario Limonciello <mario.limonciello@dell.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, len.brown@intel.com
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
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <6344e116-763f-98d5-5174-7395d761de45@molgen.mpg.de>
Date: Fri, 15 Dec 2017 16:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <39ff773039e04506affc4a8522bde99f@ausx13mpc120.AMER.DELL.COM>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050805080601040802090300"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Mario,


On 12/15/17 15:39, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Paul Menzel [mailto:pmenzel@molgen.mpg.de]
>> Sent: Friday, December 15, 2017 5:54 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; Alexander Steffen
>> <Alexander.Steffen@infineon.com>; Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Rafael J.
>> Wysocki <rafael.j.wysocki@intel.com>; Len Brown <len.brown@intel.com>
>> Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
>> occurred continue selftest`

[...]

>> the added line breaks to the quoted parts really mess up the citation.
>> Can we please try to use MUAs avoiding that, or fixing that manually?
> 
> I don't know what you mean.  I think this is directed at Alexander?
> If this is directed to me I can't change mail clients, sorry.

I think it started in Alexander's reply (Message-ID: 
<10b81a727ba940889095fa4bb29d0863@infineon.com>) that line breaks were 
added to quotes. Your only adds a long "Original Message" header.

> <snip>
>
>>> Yes it's required for the TPM model/vendor that is used in the XPS model that
>>> Paul has.  If you try to run the upgrade without clearing it the firmware will
>>> reject the upgrade.
>>
>> Mario, thank you for your quick reaction.
>>
>> [...]
>>
>> 1.  Can you reproduce this issue too?
> 
> I haven't seen this, but if this is a regression I also have not run anything
> later than 4.15-rc1 right now.

Well as far as I understood it, it's not a regression, and there is now 
just better error reporting. Did you ever get the TPM to work?

>> 2.  How do I find out, what TPM firmware version is installed?
> 
> fwupd will tell you.  Documentation (and code) here:
> https://github.com/hughsie/fwupd/tree/master/plugins/dell

Unfortuntately it's not listed with fwupd 0.7.0-0ubuntu4.3 in Ubuntu 
16.04.3 LTS installed by Dell.

```
$ fwupdmgr get-devices
ro__sys_devices_pci0000_00_0000_00_02_0
   Guid:                 3ec3df3a-2290-56e5-9d2f-eda62e9ab50b
   Provider:             Udev
   Flags:                internal|locked
   DeviceVendor:         Intel Corporation
   Created:              2017-12-15
   Trusted:              none

UEFI-5ffdbc0d-f340-441c-a803-8439c8c0ae10-dev0
   Guid:                 5ffdbc0d-f340-441c-a803-8439c8c0ae10
   DisplayName:          XPS 13 9360
   Provider:             UEFI
   Flags:                internal|allow-offline|require-ac
   Version:              0.2.4.2
   VersionLowest:        0.2.4.2
   Created:              2017-12-15
   Trusted:              none

usb:00:05
   Guid:                 87c78d19-a3ed-5778-9b69-8eb701529940
   DisplayName:          Integrated_Webcam_HD
   Provider:             USB
   Flags:                none
   Version:              99.24
   Created:              2017-12-15
   Trusted:              none

usb:00:04
   Guid:                 0f15c153-cc04-589b-8886-aba87f98918d
   DisplayName:          Touchscreen
   Provider:             USB
   Flags:                none
   Version:              17.17
   Created:              2017-12-15
   Trusted:              none

```

>> 3.  Updating to the firmware 2.4.2 from December 17th, 2017 didn't fix

[The date is December 12th, 2017.]

> The TPM in the XPS is a discrete TPM that is treated separately from the system
> firmware payload.  It supports both a "1.2" and a "2.0" firmware.
> 
> It is independently flashed from a separate TPM payload that is distributed
> on LVFS.

It looks like I am out of luck with Ubuntu 16.04.3 [1].


Kind regards,

Paul


[1] https://github.com/hughsie/fwupd/issues/301#issuecomment-342164366



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
