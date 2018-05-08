Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40005 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932715AbeEHP3n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 11:29:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id j5-v6so22353095wme.5
        for <linux-integrity@vger.kernel.org>; Tue, 08 May 2018 08:29:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525793148.3672.8.camel@HansenPartnership.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <1525793148.3672.8.camel@HansenPartnership.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Tue, 8 May 2018 10:29:41 -0500
Message-ID: <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        philip.b.tricca@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 8, 2018 at 10:25 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> > On Fri, May 04, 2018 at 02:56:25PM -0500, David R. Bild wrote:
> [...]
> > > In particular, it sets the credentials for the platform hierarchy.
> > > The platform hierarchy is essentially the "root" account of the
> > > TPM, so it's critical that those credentials be set before the TPM
> > > is exposed to user-space.  (The platform credentials aren't
> > > persisted in the TPM and must be set by the platform on every
> > > boot.)  If the driver registers the TPM before doing
> > > initialization, there's a chance that something else could access
> > > the TPM before the platform credentials get set.
>
> I don't see any reason to set an unreachable password for the platform
> hierarchy if the UEFI didn't.  If the desire is to disable the platform
> hierarchy, then it should be disabled, not have a random password set.

"Set random password and throw away the key" was my way of disabling
the platform hierarchy.  Is there a better way of doing that?

> I'd also say this is probably the job of early boot based on policy.

Agreed.  And since this card has no "early boot", the driver/kernel
need to do it.

Best,
David
