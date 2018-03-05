Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbeCEXLm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 18:11:42 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] tpm: sort objects in the Makefile
Date: Mon, 5 Mar 2018 23:11:37 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422E8E0@hasmsx108.ger.corp.intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
 <20180305202017.24008-2-tomas.winkler@intel.com>
 <20180305211206.GB9335@ziepe.ca>
 <5B8DA87D05A7694D9FA63FD143655C1B9422E7F3@hasmsx108.ger.corp.intel.com>
 <20180305220828.GC9335@ziepe.ca>
In-Reply-To: <20180305220828.GC9335@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


> On Mon, Mar 05, 2018 at 09:21:37PM +0000, Winkler, Tomas wrote:
> > > On Mon, Mar 05, 2018 at 10:20:12PM +0200, Tomas Winkler wrote:
> > > > Make the tpm Makefile a bit more in order by putting objects in
> > > > one column and group together tpm2 modules
> > > >
> > > > Prefer tpm-objs += instead of tpm-y += notation.
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > drivers/char/tpm/Makefile | 14 +++++++++++---
> > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > > > index acd758381c58..2fc0e9a73cd6 100644
> > > > +++ b/drivers/char/tpm/Makefile
> > > > @@ -3,9 +3,17 @@
> > > >  # Makefile for the kernel tpm device drivers.
> > > >  #
> > > >  obj-$(CONFIG_TCG_TPM) += tpm.o
> > > > -tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-
> cmd.o \
> > > > -	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o
> > > \
> > > > -         tpm2-space.o
> > > > +tpm-objs := tpm-interface.o
> > > > +tpm-objs += tpm-dev.o
> > > > +tpm-objs += tpm-chip.o
> > > > +tpm-objs += tpm-dev-common.o
> > > > +tpm-objs += tpmrm-dev.o
> > > > +tpm-objs += tpm-sysfs.o
> > > > +tpm-objs += tpm1_eventlog.o
> > > > +tpm-objs += tpm2-cmd.o
> > > > +tpm-objs += tpm2-space.o
> > > > +tpm-objs += tpm2_eventlog.o
> > >
> > > If you are going to do this then sort the list please
> >
> > I've sorted in that way that in the future will probably will compile
> > tpm1- out, you probably mean to alphabetically.
> 
> Yes alphabetically.. helps avoid merge conflicts
Yep, maybe something to sync on.
> 
> If you wan to make TPM1 optional then the original pattern was right..
> 
> tpm-y += \
>    tpm-dev.o \
> tpm-$(CONFIG_TPM1) += \
>    tpm1_eventlog.o
> tpm-$(CONFIG_TPM2) += \
>    tpm2_eventlog.o

This will work also with tpm-objs, you can check it.

Thanks
Tomas
