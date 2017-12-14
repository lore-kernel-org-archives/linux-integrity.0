Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34227 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750844AbdLNKd5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 05:33:57 -0500
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
To: Alexander Steffen <alexander.steffen@infineon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
References: <a45f96a3-6948-4ef9-4631-29631329e833@molgen.mpg.de>
 <32b0e6c1292f4818825e9e0e9bff4d39@infineon.com>
 <20171207183743.GB16884@ziepe.ca>
 <37b47bbcce5d4cf1b1fad32576e501d4@infineon.com>
 <20171208155641.GA2883@ziepe.ca>
 <c544a476-5ea9-df81-ea8b-01fa578738f0@molgen.mpg.de>
 <20171208161814.GB2883@ziepe.ca>
 <d70c683a-9ac2-e731-d6fd-173ac35c5b1b@molgen.mpg.de>
 <c700bf23fcf44221bc179a7b0e6df5c9@infineon.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3159adc4-4236-c963-a118-500a61f21338@molgen.mpg.de>
Date: Thu, 14 Dec 2017 11:33:54 +0100
MIME-Version: 1.0
In-Reply-To: <c700bf23fcf44221bc179a7b0e6df5c9@infineon.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090302070009090506030307"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Mario from Dell added to CC list.]

Dear Alexander,


On 12/11/17 17:08, Alexander.Steffen@infineon.com wrote:

>> On 12/08/17 17:18, Jason Gunthorpe wrote:
>>> On Fri, Dec 08, 2017 at 05:07:39PM +0100, Paul Menzel wrote:
>>>
>>>> I have no access to the system right now, but want to point out, that the
>>>> log was created by `journactl -k`, so I do not know if that messes with the
>>>> time stamps. I checked the output of `dmesg` but didn't see the TPM error
>>>> messages in the output - only `tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE,
>>>> rev-id 4)`. Do I need to pass a different error message to `dmesg`?
>>>
>>> It is a good question, I don't know.. If your kernel isn't setup to
>>> timestamp messages then the journalstamp will certainly be garbage.
>>>
>>> No idea why you wouldn't see the messages in dmesg, if they are not in
>>> dmesg they couldn't get into the journal
>>
>> It looks like I was running an older Linux kernel version, when running
>> `dmesg`. Sorry for the noise. Here are the messages with the Linux
>> kernel time stamps, showing that the delays work correctly.
>>
>> ```
>> $ uname -a
>> Linux Ixpees 4.15.0-041500rc2-generic #201712031230 SMP Sun Dec 3
>> 17:32:03 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
>> $ sudo dmesg | grep TPM
>> [    0.000000] ACPI: TPM2 0x000000006F332168 000034 (v03        Tpm2Tabl
>> 00000001 AMI  00000000)
>> [    1.114355] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
>> [    1.125250] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    1.156645] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    1.208053] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    1.299640] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    1.471223] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    1.802819] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    2.454320] tpm tpm0: A TPM error (2314) occurred continue selftest
>> [    3.734808] tpm tpm0: TPM self test failed
>> [    3.759675] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
>> ```
> 
> Thanks for the fixed log. So your TPM seems to be rather slow with executing the selftests. Could try to apply the patch that I've just sent you? It ensures that your TPM gets more time to execute all the tests, up to the limit set in the PTP.

Thank you for your patch. Judging from the time stamps, it seems it 
works, but the TPM still fails.

```
$ dmesg | grep tpm
[    1.100958] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
[    1.111768] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.143020] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.194251] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.285509] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.457103] tpm tpm0: A TPM error (2314) occurred continue selftest
[    1.788709] tpm tpm0: A TPM error (2314) occurred continue selftest
[    2.440216] tpm tpm0: A TPM error (2314) occurred continue selftest
[    3.731704] tpm tpm0: A TPM error (2314) occurred continue selftest
[    6.303216] tpm tpm0: A TPM error (2314) occurred continue selftest
[    6.303242] tpm tpm0: TPM self test failed
```

To be clear, this issue is not reproducible during every start. (But 
that was the same before.)


Kind regards,

Paul



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
