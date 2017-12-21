Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34188 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdLUIE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 03:04:58 -0500
Received: by mail-wm0-f48.google.com with SMTP id y82so18931608wmg.1
        for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2017 00:04:58 -0800 (PST)
MIME-Version: 1.0
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 21 Dec 2017 16:04:56 +0800
Message-ID: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
Subject: TPM driver breaks S3 suspend
To: peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,
    We have a desktop which has S3 suspend (to RAM) problem due to
error messages as follows.
[  198.908282] tpm tpm0: Error (38) sending savestate before suspend
[  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns 38
[  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 38
[  198.908298] PM: Device 00:0b failed to suspend: error 38

    However, the first suspend after boot is working although it still
shows an interesting message during resume.
[  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest

    The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
found some explanations which said this error code means that this
command was received in the wrong sequence relative to a TPM_Startup
command. Don't really know what happens here and how should I deal
with this? Any suggestions? Please let me know what else information
should I provide. Thanks

Chris
