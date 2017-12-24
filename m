Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdLXUdj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 15:33:39 -0500
Date: Sun, 24 Dec 2017 22:33:35 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Chris Chiu <chiu@endlessm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: TPM driver breaks S3 suspend
Message-ID: <20171224203335.su56j5qs6rt6wd4v@linux.intel.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 21, 2017 at 04:04:56PM +0800, Chris Chiu wrote:
> Hi,
>     We have a desktop which has S3 suspend (to RAM) problem due to
> error messages as follows.
> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns 38
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

The sequences for initializing TPM 1.x devices has been fairly static
for a long time. Has this occured after a kernel update? Is there a
kernel version where it used to work and a version where it doesn't?
Thanks.

/Jarkko
