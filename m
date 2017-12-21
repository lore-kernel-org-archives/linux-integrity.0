Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49306 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751739AbdLUJWq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 04:22:46 -0500
Subject: Re: TPM driver breaks S3 suspend
To: Chris Chiu <chiu@endlessm.com>, linux-kernel@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
Cc: Peter Huewe <PeterHuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <116abe3f-f51a-197d-6669-53fa4cec01e0@molgen.mpg.de>
Date: Thu, 21 Dec 2017 10:22:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070806040501040000020208"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Dear Chris,


Thank you for bringin gup the issue.

>      We have a desktop which has S3 suspend (to RAM) problem due to
> error messages as follows.
> [  198.908282] tpm tpm0: Error (38) sending savestate before suspend
> [  198.908289] __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x160 returns 38
> [  198.908293] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns 38
> [  198.908298] PM: Device 00:0b failed to suspend: error 38
> 
>      However, the first suspend after boot is working although it still
> shows an interesting message during resume.
> [  155.789945] tpm tpm0: A TPM error (38) occurred continue selftest
> 
>      The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I
> found some explanations which said this error code means that this
> command was received in the wrong sequence relative to a TPM_Startup
> command. Don't really know what happens here and how should I deal
> with this? Any suggestions? Please let me know what else information
> should I provide.

Please provide more information. Tell us your Linux version, attach your 
config and tell us the system name and if you know it the TPM version.


Kind regards,

Paul



    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 5.3 KB. ]
    [ Unable to print this part. ]
