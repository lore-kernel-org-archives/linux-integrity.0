Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:26183 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeEHKzR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 06:55:17 -0400
Date: Tue, 8 May 2018 13:55:15 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "David R. Bild" <david.bild@xaptum.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        philip.b.tricca@intel.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180508105515.GB6132@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 04, 2018 at 02:56:25PM -0500, David R. Bild wrote:
> On Fri, May 4, 2018 at 2:06 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, May 04, 2018 at 08:00:22AM -0500, David R. Bild wrote:
> > > Normally the system platform (i.e., BIOS/UEFI for x86) is responsible
> > > for performing initialization of the TPM.  For these modules, the host
> > > kernel is the platform, so we perform the initialization in the driver
> > > before registering the TPM with the kernel TPM subsystem.
> >
> > The tpm driver already does most of this stuff automatically, why
> > duplicate it there and why is it coded in a way that doesn't use the
> > existing TPM services to do it?
> 
> I didn't want to have to duplicate all that functionality and was
> disappointed when that became the only option (due to the two reasons
> outlined below) for supporting existing kernels with an out-of-tree
> module.
> 
> Bringing the module in-tree opens the option of reworking some of the
> TPM subsystem to support this use case.  I'm open to concrete
> suggestions on how to do so.
> 
> 1) The first reason is that I don't think the necessary pieces are
> currently made available for reuse. I'd love to not repeat that code,
> but
> 
> - some required structs and functions are declared in private headers
> (drivers/char/tpm/*.h instead of include/linux/tpm.h).
> - many of the required functions are not exported.
> 
> If the TPM maintainers are open to more of the API being "public", I
> can look into preparing patches that export the necessary operations.
> 
> 2) The second reason is that the initialization done by the driver is
> work that should be done by platform, before the kernel ever sees the
> TPM.

This is too speculative to give any confirmitive promises. Do not fully
understand the reasoning. For example: why should I care about
out-of-tree modules? I can look code changes but the text above contains
too many words to nail anything down. I'm confused.

> In particular, it sets the credentials for the platform hierarchy.
> The platform hierarchy is essentially the "root" account of the TPM,
> so it's critical that those credentials be set before the TPM is
> exposed to user-space.  (The platform credentials aren't persisted in
> the TPM and must be set by the platform on every boot.)  If the driver
> registers the TPM before doing initialization, there's a chance that
> something else could access the TPM before the platform credentials
> get set.

Maybe. Not sure yet where to draw the line eg should TSS2 daemon to do
it for example.

James? Philip?

/Jarkko
