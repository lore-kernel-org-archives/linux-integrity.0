Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35283 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935667AbeEJOZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 10:25:05 -0400
Received: by mail-wm0-f47.google.com with SMTP id o78-v6so4763324wmg.0
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 07:25:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525793785.3672.12.camel@HansenPartnership.com>
References: <20180430125418.31344-1-david.bild@xaptum.com> <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca> <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com> <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com> <1525793785.3672.12.camel@HansenPartnership.com>
From: "David R. Bild" <david.bild@xaptum.com>
Date: Thu, 10 May 2018 09:25:03 -0500
Message-ID: <CAAi9uDsLmW3K=1UYsmJKOc6hsXqcJXFHyO_scMan5u8d94D9=Q@mail.gmail.com>
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

On Tue, May 8, 2018 at 10:36 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2018-05-08 at 10:29 -0500, David R. Bild wrote:
> > On Tue, May 8, 2018 at 10:25 AM, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > I don't see any reason to set an unreachable password for the
> > > platform
> > > hierarchy if the UEFI didn't.  If the desire is to disable the
> > > platform
> > > hierarchy, then it should be disabled, not have a random password
> > > set.
> >
> > "Set random password and throw away the key" was my way of disabling
> > the platform hierarchy.  Is there a better way of doing that?
>
> Well, yes, use TPM2_HierarchyControl to set phEnable to CLEAR.


I'm not sure that will work for us.  Let me give a little more detail
about this card.

The TPM holds access credentials for connecting to the Xaptum network.
This approach enables secure, zero-touch provisioning for IoT devices:
 Xaptum pre-provisions the TPMs *before* they are assembled onto a
device PCB. The device is shipped directly from factory to end
customer. The first time it turns on, the TPM is used to authenticate
the Xaptum network. Using a TPM protects the credentials from being
copied or duplicated by someone in the manufacturing chain.

These cards are designed for existing devices, like IoT gateways. You
can't add a TPM to an existing PCB, but you can plug in a mini PCI-e
card.

We provision the credentials (the DAA secret key, specifically) under
the platform hierarchy. The key can be used without platform
authorization, but not removed.  If we disable the platform hierarchy
entirely, I think the credentials will no longer be available for use.

> > > I'd also say this is probably the job of early boot based on
> > > policy.
> >
> > Agreed.  And since this card has no "early boot", the driver/kernel
> > need to do it.
>
> Early boot means userspace. for a hot pluggable device, this would
> probably be something in udev if you follow the no-daemon model and the
> daemon could do it if you do follow the daemon model.

Could you expand on the udev approach?  I might not understand enough
about udev (or the coming TPM resource manager changes) to follow the
suggestion.

This seems unsafe to me.  There's a race between a malicious userspace
program and the daemon to set the platform authorization.  If the
malicious program wins, it can reset the TPM, removing the
credentials, and the device won't be able to connect to the Xaptum
network. (This is a liveness concern, not safety.  A denial-of-service
attack, essentially.)

Best,
David
