Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:37940 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753065AbdLNOPb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 09:15:31 -0500
From: <Mario.Limonciello@dell.com>
To: <Alexander.Steffen@infineon.com>, <pmenzel@molgen.mpg.de>,
        <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
 occurred continue selftest`
Date: Thu, 14 Dec 2017 14:15:25 +0000
Message-ID: <f3371f11c6fa42fba3a07cffa571d6a6@ausx13mpc120.AMER.DELL.COM>
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
In-Reply-To: <10b81a727ba940889095fa4bb29d0863@infineon.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> -----Original Message-----
> From: Alexander.Steffen@infineon.com [mailto:Alexander.Steffen@infineon.com]
> Sent: Thursday, December 14, 2017 6:21 AM
> To: pmenzel@molgen.mpg.de; jgg@ziepe.ca
> Cc: linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello,
> Mario <Mario_Limonciello@Dell.com>
> Subject: RE: [Regression 4.15-rc2] New messages `tpm tpm0: A TPM error (2314)
> occurred continue selftest`
> 
> > [Mario from Dell added to CC list.]
> >
> > Dear Alexander,
> >
> >
> > On 12/11/17 17:08, Alexander.Steffen@infineon.com wrote:
> >
> > >> On 12/08/17 17:18, Jason Gunthorpe wrote:
> > >>> On Fri, Dec 08, 2017 at 05:07:39PM +0100, Paul Menzel wrote:
> > >>>
> > >>>> I have no access to the system right now, but want to point out, that
> > the
> > >>>> log was created by `journactl -k`, so I do not know if that messes with
> > the
> > >>>> time stamps. I checked the output of `dmesg` but didn't see the TPM
> > error
> > >>>> messages in the output - only `tpm_tis MSFT0101:00: 2.0 TPM (device-
> > id 0xFE,
> > >>>> rev-id 4)`. Do I need to pass a different error message to `dmesg`?
> > >>>
> > >>> It is a good question, I don't know.. If your kernel isn't setup to
> > >>> timestamp messages then the journalstamp will certainly be garbage.
> > >>>
> > >>> No idea why you wouldn't see the messages in dmesg, if they are not in
> > >>> dmesg they couldn't get into the journal
> > >>
> > >> It looks like I was running an older Linux kernel version, when running
> > >> `dmesg`. Sorry for the noise. Here are the messages with the Linux
> > >> kernel time stamps, showing that the delays work correctly.
> > >>
> > >> ```
> > >> $ uname -a
> > >> Linux Ixpees 4.15.0-041500rc2-generic #201712031230 SMP Sun Dec 3
> > >> 17:32:03 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
> > >> $ sudo dmesg | grep TPM
> > >> [    0.000000] ACPI: TPM2 0x000000006F332168 000034 (v03        Tpm2Tabl
> > >> 00000001 AMI  00000000)
> > >> [    1.114355] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
> > >> [    1.125250] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    1.156645] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    1.208053] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    1.299640] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    1.471223] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    1.802819] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    2.454320] tpm tpm0: A TPM error (2314) occurred continue selftest
> > >> [    3.734808] tpm tpm0: TPM self test failed
> > >> [    3.759675] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> > >> ```
> > >
> > > Thanks for the fixed log. So your TPM seems to be rather slow with
> > executing the selftests. Could try to apply the patch that I've just sent you? It
> > ensures that your TPM gets more time to execute all the tests, up to the limit
> > set in the PTP.
> >
> > Thank you for your patch. Judging from the time stamps, it seems it
> > works, but the TPM still fails.
> >
> > ```
> > $ dmesg | grep tpm
> > [    1.100958] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
> > [    1.111768] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    1.143020] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    1.194251] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    1.285509] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    1.457103] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    1.788709] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    2.440216] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    3.731704] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    6.303216] tpm tpm0: A TPM error (2314) occurred continue selftest
> > [    6.303242] tpm tpm0: TPM self test failed
> > ```
> >
> > To be clear, this issue is not reproducible during every start. (But
> > that was the same before.)
> 
> Thanks for testing. Now you are in the unlucky situation that your TPM was
> probably always broken, but old kernels did not detect that and used it anyway.
> 
Something that Paul can consider is to upgrade the TPM firmware if it's not already
upgraded.  Since the launch of XPS 9360 there was at least one TPM firmware update
issued.  It has been posted to LVFS and can be upgraded using fwupd/fwupdate.
Note: If your TPM is currently owned you will need to go into BIOS setup to clear it
first before upgrading.

I don't have any insight into what changed between firmware versions.  It might not
change this at all.

> To add some more details to what the problem is: The PTP limits the maximum
> runtime of the TPM2_SelfTest command that we try to execute here to 2000ms
> (see https://trustedcomputinggroup.org/wp-
> content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_Specification_Family
> _2.0_Revision_1.3v22.pdf table 15, page 65 in the PDF, page 57 according to the
> printed page numbers). Technically, we have no evidence that your TPM is in
> violation of that specification, because it does reply to the command within
> 2000ms, it just has not completed the selftests within that timeframe. But clearly
> the intention of the specification authors was to have the selftests completed
> within that limit, there is no sense in allowing 2s just for the TPM to generate an
> answer without actually making any progress.
> 
> The TPM2_SelfTest command is special in that it is allowed to either execute all
> selftests and then return TPM_RC_SUCCESS or just schedule the selftest execution
> in the background and return TPM_RC_TESTING immediately (see
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-Rev-2.0-Part-3-
> Commands-01.38.pdf chapter 10.2.1, page 43/29). Your TPM apparently chooses
> the second option, but (sometimes?) fails to complete the selftests within the limit
> that we set (which is far longer than the 2s from the PTP).
> 
> I'm not sure what to do about that now. We could increase the timeout even
> further, but if your TPM does not abide by the specification, what would be the
> right limit? Maybe there is a bug in your TPM that sometimes causes it to end up in
> a state where it can never complete the selftests.

Are there any representatives from the other TPM vendors on the linux-integrrity 
mailing list?  Maybe someone from the vendor involved in this laptop can comment
if they know of limitations in the self tests on this particular model and can 
recommend a solution.

> 
> The only other idea I have would be to use a different variant of the TPM2_SelfTest
> command. Currently, we execute the selftest command with the parameter
> fullTest=NO, so that the TPM only has to execute the missing tests (which should be
> the fastest implementation for a spec-compliant TPM). Maybe instead of giving up,
> we can extend the current algorithm to try fullTest=YES once, which should reset
> the selftest state so that maybe then your TPM can complete them successfully. I'll
> try to implement a patch to that effect.
> 
> Alexander

If you're fairly certain it's a TPM bug, another possibility is to quirk to skip self tests
based on TPM model + TPM firmware version.
