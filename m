Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56937 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755222AbdLOLyV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 06:54:21 -0500
Subject: Re: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
To: Mario Limonciello <mario.limonciello@dell.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
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
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <127aefc5-44e1-7382-2548-5cd4774275b0@molgen.mpg.de>
Date: Fri, 15 Dec 2017 12:54:18 +0100
MIME-Version: 1.0
In-Reply-To: <5efeaf9e50e54b999efa91c39f311bd9@ausx13mpc120.AMER.DELL.COM>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030100090504040107010300"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Adding Rafael and Len as they, to my knowledge, also use or have a 
access to a Dell XPS 13 9360. With latest Linux master do you get TPM 
self-test errors, when cold starting the system without the power supply 
plugged in?]

Dear Mario, dear Alexander,


the added line breaks to the quoted parts really mess up the citation. 
Can we please try to use MUAs avoiding that, or fixing that manually?


On 12/14/17 20:43, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Alexander.Steffen@infineon.com [mailto:Alexander.Steffen@infineon.com]
>> Sent: Thursday, December 14, 2017 10:12 AM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>; pmenzel@molgen.mpg.de;
>> jgg@ziepe.ca
>> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
>> occurred continue selftest`
>>
>>>> -----Original Message-----
>>>> From: Alexander.Steffen@infineon.com
>>> [mailto:Alexander.Steffen@infineon.com]
>>>> Sent: Thursday, December 14, 2017 6:21 AM
>>>> To: pmenzel@molgen.mpg.de; jgg@ziepe.ca
>>>> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> Limonciello,
>>>> Mario <Mario_Limonciello@Dell.com>
>>>> Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error
>>> (2314)
>>>> occurred continue selftest`
>>>>
>>>>> [Mario from Dell added to CC list.]
>>>>>
>>>>> Dear Alexander,
>>>>>
>>>>>
>>>>> On 12/11/17 17:08, Alexander.Steffen@infineon.com wrote:
>>>>>
>>>>>>> On 12/08/17 17:18, Jason Gunthorpe wrote:
>>>>>>>> On Fri, Dec 08, 2017 at 05:07:39PM +0100, Paul Menzel wrote:
>>>>>>>>
>>>>>>>>> I have no access to the system right now, but want to point out,
>>> that
>>>>> the
>>>>>>>>> log was created by `journactl -k`, so I do not know if that messes
>>> with
>>>>> the
>>>>>>>>> time stamps. I checked the output of `dmesg` but didn't see the
>>> TPM
>>>>> error
>>>>>>>>> messages in the output - only `tpm_tis MSFT0101:00: 2.0 TPM
>>> (device-
>>>>> id 0xFE,
>>>>>>>>> rev-id 4)`. Do I need to pass a different error message to `dmesg`?
>>>>>>>>
>>>>>>>> It is a good question, I don't know.. If your kernel isn't setup to
>>>>>>>> timestamp messages then the journalstamp will certainly be
>>> garbage.
>>>>>>>>
>>>>>>>> No idea why you wouldn't see the messages in dmesg, if they are
>>> not in
>>>>>>>> dmesg they couldn't get into the journal
>>>>>>>
>>>>>>> It looks like I was running an older Linux kernel version, when running
>>>>>>> `dmesg`. Sorry for the noise. Here are the messages with the Linux
>>>>>>> kernel time stamps, showing that the delays work correctly.
>>>>>>>
>>>>>>> ```
>>>>>>> $ uname -a
>>>>>>> Linux Ixpees 4.15.0-041500rc2-generic #201712031230 SMP Sun Dec 3
>>>>>>> 17:32:03 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>> $ sudo dmesg | grep TPM
>>>>>>> [    0.000000] ACPI: TPM2 0x000000006F332168 000034 (v03
>>> Tpm2Tabl
>>>>>>> 00000001 AMI  00000000)
>>>>>>> [    1.114355] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
>>>>>>> [    1.125250] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    1.156645] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    1.208053] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    1.299640] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    1.471223] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    1.802819] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    2.454320] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>>>> [    3.734808] tpm tpm0: TPM self test failed
>>>>>>> [    3.759675] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
>>>>>>> ```
>>>>>>
>>>>>> Thanks for the fixed log. So your TPM seems to be rather slow with
>>>>> executing the selftests. Could try to apply the patch that I've just sent
>>> you? It
>>>>> ensures that your TPM gets more time to execute all the tests, up to the
>>> limit
>>>>> set in the PTP.
>>>>>
>>>>> Thank you for your patch. Judging from the time stamps, it seems it
>>>>> works, but the TPM still fails.
>>>>>
>>>>> ```
>>>>> $ dmesg | grep tpm
>>>>> [    1.100958] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
>>>>> [    1.111768] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    1.143020] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    1.194251] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    1.285509] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    1.457103] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    1.788709] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    2.440216] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    3.731704] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    6.303216] tpm tpm0: A TPM error (2314) occurred continue selftest
>>>>> [    6.303242] tpm tpm0: TPM self test failed
>>>>> ```
>>>>>
>>>>> To be clear, this issue is not reproducible during every start. (But
>>>>> that was the same before.)

I think I found out how to reproduce the issue. Cold start the system 
without the power supply connected.

>>>> Thanks for testing. Now you are in the unlucky situation that your TPM was
>>>> probably always broken, but old kernels did not detect that and used it anyway.

Just to clarify, I do not know if the TPM could ever be used. I believe 
the module loaded but the user space tools (tpm2_version or so) always 
returned an error in my tests.

>>> Something that Paul can consider is to upgrade the TPM firmware if it's not
>>> already
>>> upgraded.  Since the launch of XPS 9360 there was at least one TPM firmware
>>> update
>>> issued.  It has been posted to LVFS and can be upgraded using
>>> fwupd/fwupdate.
>>> Note: If your TPM is currently owned you will need to go into BIOS setup to
>>> clear it
>>> first before upgrading.
>>
>> I'm not familiar with the specific TPM in your model, but according to the log it is a
>> TPM 2.0, which does not really carry over the owner concept of a TPM 1.2. Is
>> clearing it still necessary for an upgrade then?
> 
> Yes it's required for the TPM model/vendor that is used in the XPS model that
> Paul has.  If you try to run the upgrade without clearing it the firmware will
> reject the upgrade.

Mario, thank you for your quick reaction.

[...]

1.  Can you reproduce this issue too?
2.  How do I find out, what TPM firmware version is installed?
3.  Updating to the firmware 2.4.2 from December 17th, 2017 didn't fix 
the issue.

>>>> To add some more details to what the problem is: The PTP limits the
>>> maximum
>>>> runtime of the TPM2_SelfTest command that we try to execute here to
>>> 2000ms
>>>> (see https://trustedcomputinggroup.org/wp-
>>>>
>>> content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_Specification_
>>> Family
>>>> _2.0_Revision_1.3v22.pdf table 15, page 65 in the PDF, page 57 according to
>>> the
>>>> printed page numbers). Technically, we have no evidence that your TPM is
>>> in
>>>> violation of that specification, because it does reply to the command within
>>>> 2000ms, it just has not completed the selftests within that timeframe. But
>>> clearly
>>>> the intention of the specification authors was to have the selftests
>>> completed
>>>> within that limit, there is no sense in allowing 2s just for the TPM to
>>> generate an
>>>> answer without actually making any progress.
>>>>
>>>> The TPM2_SelfTest command is special in that it is allowed to either
>>> execute all
>>>> selftests and then return TPM_RC_SUCCESS or just schedule the selftest
>>> execution
>>>> in the background and return TPM_RC_TESTING immediately (see
>>>> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Rev-2.0-
>>> Part-3-
>>>> Commands-01.38.pdf chapter 10.2.1, page 43/29). Your TPM apparently
>>> chooses
>>>> the second option, but (sometimes?) fails to complete the selftests within
>>> the limit
>>>> that we set (which is far longer than the 2s from the PTP).
>>>>
>>>> I'm not sure what to do about that now. We could increase the timeout
>>> even
>>>> further, but if your TPM does not abide by the specification, what would be
>>> the
>>>> right limit? Maybe there is a bug in your TPM that sometimes causes it to
>>> end up in
>>>> a state where it can never complete the selftests.
>>>
>>> Are there any representatives from the other TPM vendors on the linux-
>>> integrrity
>>> mailing list?  Maybe someone from the vendor involved in this laptop can
>>> comment
>>> if they know of limitations in the self tests on this particular model and can
>>> recommend a solution.
>>>
>>>>
>>>> The only other idea I have would be to use a different variant of the
>>> TPM2_SelfTest
>>>> command. Currently, we execute the selftest command with the
>>> parameter
>>>> fullTest=NO, so that the TPM only has to execute the missing tests (which
>>> should be
>>>> the fastest implementation for a spec-compliant TPM). Maybe instead of
>>> giving up,
>>>> we can extend the current algorithm to try fullTest=YES once, which should
>>> reset
>>>> the selftest state so that maybe then your TPM can complete them
>>> successfully. I'll
>>>> try to implement a patch to that effect.
>>>
>>> If you're fairly certain it's a TPM bug, another possibility is to quirk to skip self
>>> tests
>>> based on TPM model + TPM firmware version.
>>
>> As a last resort maybe, yes. But currently the kernel's policy is that it only wants to
>> talk to a TPM device that is guaranteed to be error-free, i.e. has executed the
>> selftests correctly. I'd like to change that for other reasons (see the patches that I
>> just posted for details), but now that you mention it, maybe there is a simple
>> solution that solves both problems:
>>
>> The TPM specification says "If a command requires use of an untested algorithm or
>> functional module, the TPM performs the test and then completes the command
>> actions." (https://trustedcomputinggroup.org/wp-content/uploads/TPM-Rev-2.0-
>> Part-1-Architecture-01.38.pdf chapter 12.3, page 83/59). So as far as I understand
>> that, there is no need for us to explicitly execute selftests on any TPM (2.0) device,
>> the TPM is required to do that automatically. So what about getting rid of the
>> selftest call completely?
>>
>> It will improve startup performance, because we do not have to wait for the TPM to
>> complete all selftests. The worst case is that the first execution of a command
>> requiring a specific functionality will be a bit slower, because the TPM has to do the
>> selftests first. But maybe even that won't be the case, since the same chapter in the
>> specification also says "It is preferable for the TPM to perform self-tests on
>> untested algorithms and functional blocks as a background task to increase the
>> likelihood that algorithms are tested before they are needed."
>>
>> The only disadvantage I can see from a user's point of view is that he will discover a
>> broken TPM device only when he tries to use it, not already when the kernel tries to
>> load the driver. But that also applies to other devices, you will not notice a broken
>> flash drive unless you try to access the data, not from just plugging it in. And if a
>> user really cares, he is always free to execute TPM2_SelfTest via /dev/tpm*. Any
>> other objections?
> 
> Your logic to this idea sounds good to me.  The only potential problem would be if
> the kernel were ever to directly use the TPM for storing data.  It perhaps might hit
> this at an inopportune time.
> Otherwise no objections from my side, but I'm no decision maker in this area.


Kind regards,

Paul



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
