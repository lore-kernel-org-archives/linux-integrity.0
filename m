Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38007 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbdLUJnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 04:43:37 -0500
Received: by mail-wm0-f54.google.com with SMTP id 64so14541177wme.3
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 01:43:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <116abe3f-f51a-197d-6669-53fa4cec01e0@molgen.mpg.de>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <116abe3f-f51a-197d-6669-53fa4cec01e0@molgen.mpg.de>
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 21 Dec 2017 17:43:35 +0800
Message-ID: <CAB4CAwdreurhxYz82PN_1guRK67=PvZxGa3zVhQ_opN8+guH0A@mail.gmail.com>
Subject: Re: TPM driver breaks S3 suspend
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 5:22 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Dear Chris,
>
>
> Thank you for bringin gup the issue.
>
>>      We have a desktop which has S3 suspend (to RAM) problem due to
>> error messages as follows.
>> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
>> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns 38
>> [  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 38
>> [  198.908298] PM: Device 00:0b failed to suspend: error 38
>>
>>      However, the first suspend after boot is working although it still
>> shows an interesting message during resume.
>> [  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest
>>
>>      The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
>> found some explanations which said this error code means that this
>> command was received in the wrong sequence relative to a TPM_Startup
>> command. Don't really know what happens here and how should I deal
>> with this? Any suggestions? Please let me know what else information
>> should I provide.
>
>
> Please provide more information. Tell us your Linux version, attach your
> config and tell us the system name and if you know it the TPM version.

Sorry for the missing information. This is reproducible in kernel 4.14
and latest
4.15-rc2 with all TPM drivers selected. What system name do you need? It's
Acer Desktop Veriton 4410G. The TPM version shows in dmesg is
[    0.640244] tpm_tis 00:0b: 1.2 TPM (device-id 0xFE, rev-id 71)

Chris
