Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:43035 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755153AbdLVCFE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 21:05:04 -0500
Received: by mail-wm0-f53.google.com with SMTP id n138so19229896wmg.2
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 18:05:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
From: Chris Chiu <chiu@endlessm.com>
Date: Fri, 22 Dec 2017 10:05:02 +0800
Message-ID: <CAB4CAwc7GiyyPt+yRcNnoO7sORVXCQ4tA=szyOW4vP11EX8vPA@mail.gmail.com>
Subject: Re: TPM driver breaks S3 suspend
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 6:19 PM,  <Alexander.Steffen@infineon.com> wrote:
>> Hi,
>>     We have a desktop which has S3 suspend (to RAM) problem due to
>> error messages as follows.
>> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
>> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns
>> 38
>> [  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 38
>> [  198.908298] PM: Device 00:0b failed to suspend: error 38
>>
>>     However, the first suspend after boot is working although it still
>> shows an interesting message during resume.
>> [  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest
>>
>>     The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
>> found some explanations which said this error code means that this
>> command was received in the wrong sequence relative to a TPM_Startup
>> command. Don't really know what happens here and how should I deal
>> with this? Any suggestions? Please let me know what else information
>> should I provide. Thanks
>>
>> Chris
>
> Just from looking at the code, this seems to be an issue in tpm_tis_resume.
>
> When the device is not a TPM 2.0, it tries to execute the selftests, but ignores the results. In your case the selftests fail during resume, but since the error is ignored, the TPM device is still present (though non-functional) and so breaks the subsequent suspend.
>
> In addition, from the error code we can tell that it is not actually a selftest failure. INVALID_POSTINIT for a command other than TPM_Startup means that no TPM_Startup has been executed for that power cycle yet, so the TPM has to reject all other commands. Usually, the platform sends the TPM_Startup command, but not in your case apparently.
>
> The correct solution should be something like tpm2_auto_startup (execute selftests, if they fail because of the missing startup command, execute that and retry the selftests). Interestingly, tpm1_auto_startup (same purpose as tpm2_auto_startup, but for TPM 1.2 instead) does not use the same sequence, the startup-retry part is missing. Is there any reason this is done differently for TPM 1.2? Otherwise I'd propose to make tpm1_auto_startup follow the same sequence as tpm2_auto_startup and then call both from tpm_tis_resume, similar to what tpm_chip_register does.
>
> Alexander

You mean do tpm1(or 2)_auto_startup when I fail selftest with error
code 38? Then it should retry until the TPM state back to correct
state?

Chris
