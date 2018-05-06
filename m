Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55800 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeEFPCe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 May 2018 11:02:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8so10323616wmg.5
        for <linux-integrity@vger.kernel.org>; Sun, 06 May 2018 08:02:33 -0700 (PDT)
Date: Sun, 6 May 2018 09:02:29 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180506150229.jvbkvq7hlxbgmsgn@ziepe.ca>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <CAAi9uDuMyUt1sROZ--_QHM5rUjTMo2F7PHyCoEtuD=y35ezgtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAi9uDuMyUt1sROZ--_QHM5rUjTMo2F7PHyCoEtuD=y35ezgtA@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, May 04, 2018 at 03:19:21PM -0500, David R. Bild wrote:
> On Fri, May 4, 2018 at 2:56 PM, David R. Bild <david.bild@xaptum.com> wrote:
> > 2) The second reason is that the initialization done by the driver is
> > work that should be done by platform, before the kernel ever sees the
> > TPM.
> >
> > In particular, it sets the credentials for the platform hierarchy.
> > The platform hierarchy is essentially the "root" account of the TPM,
> > so it's critical that those credentials be set before the TPM is
> > exposed to user-space.  (The platform credentials aren't persisted in
> > the TPM and must be set by the platform on every boot.)  If the driver
> > registers the TPM before doing initialization, there's a chance that
> > something else could access the TPM before the platform credentials
> > get set.
> 
> Setting the platform hierarchy password to a random discarded value
> (and the dictionary lockout reset) is really the only special work
> done here. The other steps (startup, self test, etc.) are done by the
> TPM subsystem if needed.
> 
> So easy option would be for the TPM subsystem to set the platform
> hierarchy password to a random value during device registration, if
> needed.  It could either

This would probably make more sense, I'm not opposed at least

> This wouldn't require a significant change to the TPM subsystem
> internals and would let me drop nearly the entire second patch from
> this series.  (I think the dictionary lockout reset can be done via
> the already exported "tpm_send(...)" function.)

Sounds like a much better approach to me.

Jason
