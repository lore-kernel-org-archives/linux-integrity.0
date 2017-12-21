Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:37396 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdLUKTL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 05:19:11 -0500
From: <Alexander.Steffen@infineon.com>
To: <chiu@endlessm.com>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@endlessm.com>
Subject: RE: TPM driver breaks S3 suspend
Date: Thu, 21 Dec 2017 10:19:09 +0000
Message-ID: <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
In-Reply-To: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> Hi,
>     We have a desktop which has S3 suspend (to RAM) problem due to
> error messages as follows.
> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns
> 38
> [  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 38
> [  198.908298] PM: Device 00:0b failed to suspend: error 38
> 
>     However, the first suspend after boot is working although it still
> shows an interesting message during resume.
> [  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest
> 
>     The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
> found some explanations which said this error code means that this
> command was received in the wrong sequence relative to a TPM_Startup
> command. Don't really know what happens here and how should I deal
> with this? Any suggestions? Please let me know what else information
> should I provide. Thanks
> 
> Chris

Just from looking at the code, this seems to be an issue in tpm_tis_resume.

When the device is not a TPM 2.0, it tries to execute the selftests, but ignores the results. In your case the selftests fail during resume, but since the error is ignored, the TPM device is still present (though non-functional) and so breaks the subsequent suspend.

In addition, from the error code we can tell that it is not actually a selftest failure. INVALID_POSTINIT for a command other than TPM_Startup means that no TPM_Startup has been executed for that power cycle yet, so the TPM has to reject all other commands. Usually, the platform sends the TPM_Startup command, but not in your case apparently.

The correct solution should be something like tpm2_auto_startup (execute selftests, if they fail because of the missing startup command, execute that and retry the selftests). Interestingly, tpm1_auto_startup (same purpose as tpm2_auto_startup, but for TPM 1.2 instead) does not use the same sequence, the startup-retry part is missing. Is there any reason this is done differently for TPM 1.2? Otherwise I'd propose to make tpm1_auto_startup follow the same sequence as tpm2_auto_startup and then call both from tpm_tis_resume, similar to what tpm_chip_register does.

Alexander
