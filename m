Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:15509 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeEMIvk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 May 2018 04:51:40 -0400
Date: Sun, 13 May 2018 11:51:36 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "David R. Bild" <david.bild@xaptum.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        philip.b.tricca@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
Message-ID: <20180513085136.GC19023@linux.intel.com>
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com>
 <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com>
 <1525793785.3672.12.camel@HansenPartnership.com>
 <20180510015938.GN6190@linux.intel.com>
 <CAAi9uDtj=nFnk2=oqhJj_c8vEenDvT5eHKaFEDGSh+u-fxg9vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAi9uDtj=nFnk2=oqhJj_c8vEenDvT5eHKaFEDGSh+u-fxg9vw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 10, 2018 at 09:31:07AM -0500, David R. Bild wrote:
> On Wed, May 9, 2018 at 8:59 PM, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Tue, May 08, 2018 at 08:36:25AM -0700, James Bottomley wrote:
> >> Early boot means userspace. for a hot pluggable device, this would
> >> probably be something in udev if you follow the no-daemon model and the
> >> daemon could do it if you do follow the daemon model.
> >>
> >
> > Could this be implemented as a first priority to daemon. If it turns out
> > to be bad approach we can reconsider kernel. If we land it to kernel it
> > is harder to take steps back.
> 
> Is the daemon an implementation of the TCG resource manager spec?
> 
> Best,
> David

Philip and James would be the right people to answer this. Ping? :-)

/Jarkko
