Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23450 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755541AbeEJBnG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 21:43:06 -0400
Date: Thu, 10 May 2018 04:42:59 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "David R. Bild" <david.bild@xaptum.com>, philip.b.tricca@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180510014259.GL6190@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com>
 <1525793148.3672.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1525793148.3672.8.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 08, 2018 at 08:25:48AM -0700, James Bottomley wrote:
> On Tue, 2018-05-08 at 13:55 +0300, Jarkko Sakkinen wrote:
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
> > 
> > Maybe. Not sure yet where to draw the line eg should TSS2 daemon to
> > do it for example.
> > 
> > James? Philip?
> 
> I don't see any reason to set an unreachable password for the platform
> hierarchy if the UEFI didn't.  If the desire is to disable the platform
> hierarchy, then it should be disabled, not have a random password set. 
> I'd also say this is probably the job of early boot based on policy.
> 
> James

A valid point.

/Jarkko
