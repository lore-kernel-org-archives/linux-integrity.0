Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:51787 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754212AbdLVNek (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 08:34:40 -0500
From: <Alexander.Steffen@infineon.com>
To: <chiu@endlessm.com>
CC: <peterhuewe@gmx.de>, <jarkko.sakkinen@linux.intel.com>,
        <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@endlessm.com>
Subject: RE: TPM driver breaks S3 suspend
Date: Fri, 22 Dec 2017 13:34:37 +0000
Message-ID: <4f6219a55e3d4baa8bd90c7a4866a40a@infineon.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
 <CAB4CAwc7GiyyPt+yRcNnoO7sORVXCQ4tA=szyOW4vP11EX8vPA@mail.gmail.com>
In-Reply-To: <CAB4CAwc7GiyyPt+yRcNnoO7sORVXCQ4tA=szyOW4vP11EX8vPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Thu, Dec 21, 2017 at 6:19 PM,  <Alexander.Steffen@infineon.com> wrote:
> >> Hi,
> >>     We have a desktop which has S3 suspend (to RAM) problem due to
> >> error messages as follows.
> >> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
> >> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160
> returns
> >> 38
> >> [  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns
> 38
> >> [  198.908298] PM: Device 00:0b failed to suspend: error 38
> >>
> >>     However, the first suspend after boot is working although it still
> >> shows an interesting message during resume.
> >> [  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest
> >>
> >>     The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
> >> found some explanations which said this error code means that this
> >> command was received in the wrong sequence relative to a TPM_Startup
> >> command. Don't really know what happens here and how should I deal
> >> with this? Any suggestions? Please let me know what else information
> >> should I provide. Thanks
> >>
> >> Chris
> >
> > Just from looking at the code, this seems to be an issue in tpm_tis_resume.
> >
> > When the device is not a TPM 2.0, it tries to execute the selftests, but
> ignores the results. In your case the selftests fail during resume, but since
> the error is ignored, the TPM device is still present (though non-functional)
> and so breaks the subsequent suspend.
> >
> > In addition, from the error code we can tell that it is not actually a selftest
> failure. INVALID_POSTINIT for a command other than TPM_Startup means
> that no TPM_Startup has been executed for that power cycle yet, so the
> TPM has to reject all other commands. Usually, the platform sends the
> TPM_Startup command, but not in your case apparently.
> >
> > The correct solution should be something like tpm2_auto_startup (execute
> selftests, if they fail because of the missing startup command, execute that
> and retry the selftests). Interestingly, tpm1_auto_startup (same purpose as
> tpm2_auto_startup, but for TPM 1.2 instead) does not use the same
> sequence, the startup-retry part is missing. Is there any reason this is done
> differently for TPM 1.2? Otherwise I'd propose to make tpm1_auto_startup
> follow the same sequence as tpm2_auto_startup and then call both from
> tpm_tis_resume, similar to what tpm_chip_register does.
> >
> > Alexander
> 
> You mean do tpm1(or 2)_auto_startup when I fail selftest with error
> code 38? Then it should retry until the TPM state back to correct
> state?

Yes, but that will only help once we've taught tpm1_auto_startup to handle error code 38 similar to tpm2_auto_startup.

But you can try whether that approach solves your problem without rebuilding the kernel, by sending the TPM_Startup command from user space:

python3 -c 'f=open("/dev/tpm0", "r+b", buffering=0); f.write(b"\x00\xc1\x00\x00\x00\x0c\x00\x00\x00\x99\x00\x01"
); print(f.readall())'

Could you try the following sequence?
1. Boot your system.
2. Suspend and resume your system. 
3. Send TPM_Startup manually.
4. Go to step 2.

If my theory is correct, the TPM should no longer fail during suspend, though you'll still get the same error message when resuming.

Alexander
