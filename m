Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39898 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753940AbdLNTJB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 14:09:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so13369506wmf.4
        for <linux-integrity@vger.kernel.org>; Thu, 14 Dec 2017 11:09:01 -0800 (PST)
Subject: Re: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on
 Braswell system
To: James Ettle <james@ettle.org.uk>, linux-integrity@vger.kernel.org,
        azhar.shaikh@intel.com, jarkko.sakkinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, james.l.morris@oracle.com,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
 <34b361bf-cce7-a1ac-f8a3-76ef22f5b6b0@redhat.com>
 <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <011b4d29-9d93-4b7a-90dd-0c25cf184c3e@redhat.com>
Date: Thu, 14 Dec 2017 20:08:58 +0100
MIME-Version: 1.0
In-Reply-To: <5fb5de24-5a4c-4c01-1f72-49fc5844516c@ettle.org.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello James,

On 12/12/2017 10:17 PM, James Ettle wrote:
> OK, I built a kernel 4.14.5 from vanilla kernel.org sources using the Fedora .config (couldn't get the Fedora package to build).
> 
> I see no difference with both [0, 1] patches applied and the tpm modules loaded -- no keyboard or touchpad.
> 
> [Note: I'm not *consciously* using the TPM for anything, but /dev/tpm0 is present and have never initialised it. I don't know if anything in Fedora uses it by default if present.]
>

On a default Fedora install the TPM isn't used, but the CLKRUN_EN toggling
happens for all I/O operations with the TPM and the driver does access the
TPM on its probe function.

So even if you don't use it, the driver will mess with the CLKRUN signal.

Jarkko and Azhar,

I wonder what's the solution for this. I understand the quirk is needed for
some systems, but on the other hand breaks functionality for other devices.

I think that at the very least this should be disabled by default and have a
Kconfig option or module parameter to enable if needed. Since as James said,
it causes regressions even for people that are not using the TPM device.

Although probably reverting the offending commits is the right thing to do
until a proper solution is proposed.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
