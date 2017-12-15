Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56856 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932262AbdLOP0m (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 10:26:42 -0500
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
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
 <a494a7397207458a9e7063ac0aa28195@infineon.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <b1162c76-2629-e041-9bc6-54678b999e6b@molgen.mpg.de>
Date: Fri, 15 Dec 2017 16:26:40 +0100
MIME-Version: 1.0
In-Reply-To: <a494a7397207458a9e7063ac0aa28195@infineon.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020304070509070503020104"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Alexander,


On 12/15/17 15:54, Alexander.Steffen@infineon.com wrote:

[...]

>> the added line breaks to the quoted parts really mess up the citation.
>> Can we please try to use MUAs avoiding that, or fixing that manually?
> 
> Sorry, I'm not sure whether my company has a way for me to avoid using Outlook ;-) But if there are any configuration changes to make it behave better, I will gladly apply them. Do you know of any documentation on this? All I found so far either is already applied or was outdated.

No idea, lines in quotes should probably not be touch and wrapped. At 
least not without adding the right quoting level on the next line.

> I'll remove some of the less relevant quoted parts, so that this is less of an issue.
> 
>>>>>>> To be clear, this issue is not reproducible during every start. (But
>>>>>>> that was the same before.)
>>
>> I think I found out how to reproduce the issue. Cold start the system
>> without the power supply connected.
>>
>>>>>> Thanks for testing. Now you are in the unlucky situation that your TPM was
>>>>>> probably always broken, but old kernels did not detect that and used it anyway.
>>
>> Just to clarify, I do not know if the TPM could ever be used. I believe
>> the module loaded but the user space tools (tpm2_version or so) always
>> returned an error in my tests.
> 
> Interesting. So maybe it is not a bug in your TPM's firmware, but really a single defective TPM? Can you try to figure that out? That is, when using an older kernel in the cold start scenario, can you execute any useful commands on your TPM successfully?

```
$ uname -a
Linux Ixpees 4.10.0-42-generic #46~16.04.1-Ubuntu SMP Mon Dec 4 15:57:59 
UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
$ more /proc/version
Linux version 4.10.0-42-generic (buildd@lgw01-amd64-007) (gcc version 
5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16
.04.5) ) #46~16.04.1-Ubuntu SMP Mon Dec 4 15:57:59 UTC 2017
$ dmesg | grep tpm
[    0.999122] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
$ sudo tpm_version
Tspi_Context_Connect failed: 0x00003011 - layer=tsp, code=0011 (17), 
Communication failure
$ tpm_version --version
tpm_version version: 1.3.8
```

>>>>> Something that Paul can consider is to upgrade the TPM firmware if it's not
>>>>> already upgraded.  Since the launch of XPS 9360 there was at least one TPM
>>>>> firmware update issued.  It has been posted to LVFS and can be upgraded using
>>>>> fwupd/fwupdate.
>>>>> Note: If your TPM is currently owned you will need to go into BIOS setup to
>>>>> clear it first before upgrading.
>>>>
>>>> I'm not familiar with the specific TPM in your model, but according to the
>>>> log it is a TPM 2.0, which does not really carry over the owner concept of
>>>> a TPM 1.2. Is clearing it still necessary for an upgrade then?
>>>
>>> Yes it's required for the TPM model/vendor that is used in the XPS model that
>>> Paul has.  If you try to run the upgrade without clearing it the firmware will
>>> reject the upgrade.
>>
>> Mario, thank you for your quick reaction.
>>
>> [...]
>>
>> 1.  Can you reproduce this issue too?
>> 2.  How do I find out, what TPM firmware version is installed?
> 
> If you get the driver loaded, you can ask the TPM (TPM2_GetCapability for TPM_PT_FIRMWARE_VERSION_1 and TPM_PT_FIRMWARE_VERSION_2):
> 
> python3 -c 'f=open("/dev/tpm0", "r+b", buffering=0); f.write(b"\x80\x01\x00\x00\x00\x16\x00\x00\x01z\x00\x00\x00\x06\x00\x00\x01\x0b\x00\x00\x00\x02"); print(f.readall())'

```
$ sudo python3
Python 3.5.2 (default, Nov 23 2017, 16:37:01)
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
 >>> f=open("/dev/tpm0", "r+b", buffering=0)
 >>> 
f.write(b"\x80\x01\x00\x00\x00\x16\x00\x00\x01z\x00\x00\x00\x06\x00\x00\x01\x0b\x00\x00\x00\x02")
22
 >>> print(f.readall())
b'\x80\x01\x00\x00\x00#\x00\x00\x00\x00\x01\x00\x00\x00\x06\x00\x00\x00\x02\x00\x00\x01\x0b\x00\x01\x00\x03\x00\x00\x01\x0c\x00\x00\x00\x01'
```

>> 3.  Updating to the firmware 2.4.2 from December 17th, 2017 didn't fix
>> the issue.
> 
> You've got a firmware from the future? ;-)

Uups, right. It's from December 12th, 2017. ;-)


Kind regards,

Paul



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
