Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35234 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeEDT41 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 May 2018 15:56:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id i14-v6so19027714wre.2
        for <linux-integrity@vger.kernel.org>; Fri, 04 May 2018 12:56:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Fri, 4 May 2018 14:56:25 -0500
Message-ID: <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 4, 2018 at 2:06 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, May 04, 2018 at 08:00:22AM -0500, David R. Bild wrote:
> > Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
> > for performing initialization of the TPM.  For these modules, the host
> > kernel is the platform, so we perform the initialization in the driver
> > before registering the TPM with the kernel TPM subsystem.
>
> The tpm driver already does most of this stuff automatically, why
> duplicate it there and why is it coded in a way that doesn't use the
> existing TPM services to do it?

I didn't want to have to duplicate all that functionality and was
disappointed when that became the only option (due to the two reasons
outlined below) for supporting existing kernels with an out-of-tree
module.

Bringing the module in-tree opens the option of reworking some of the
TPM subsystem to support this use case.  I'm open to concrete
suggestions on how to do so.

1) The first reason is that I don't think the necessary pieces are
currently made available for reuse. I'd love to not repeat that code,
but

- some required structs and functions are declared in private headers
(drivers/char/tpm/*.h instead of include/linux/tpm.h).
- many of the required functions are not exported.

If the TPM maintainers are open to more of the API being "public", I
can look into preparing patches that export the necessary operations.

2) The second reason is that the initialization done by the driver is
work that should be done by platform, before the kernel ever sees the
TPM.

In particular, it sets the credentials for the platform hierarchy.
The platform hierarchy is essentially the "root" account of the TPM,
so it's critical that those credentials be set before the TPM is
exposed to user-space.  (The platform credentials aren't persisted in
the TPM and must be set by the platform on every boot.)  If the driver
registers the TPM before doing initialization, there's a chance that
something else could access the TPM before the platform credentials
get set.

The TPM system doesn't appear (to me; please correct me) to be
designed to support the following start-up sequence:

a) Driver registers the device with the TPM subsystem
b) Driver uses the TPM subsystem to perform platform initialization
(what the BIOS should have done...)
c) Driver tells the TPM subsystem to now perform the kernel
initialization of the TPM
d) TPM subsystem does its initialization of the TPM
e) TPM is exposed to userspace, added as hwrng, etc.

It would only support the sequence  [a, d, e, b] and we'd just have to
hope no one accesses the TPM between steps 'e' and 'b'.

Best,
David
