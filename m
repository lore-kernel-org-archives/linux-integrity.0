Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50510 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964881AbeF2SLG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 14:11:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so2084703wmc.0
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 11:11:06 -0700 (PDT)
Date: Fri, 29 Jun 2018 12:11:00 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629181100.GH379@ziepe.ca>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
 <20180629174328.GA4060@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629174328.GA4060@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 08:43:28PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > On Fri, Jun 29, 2018 at 06:10:02PM +0300, Jarkko Sakkinen wrote:
> > > Do not allow to compile TPM core as a module. TPM defines a root of
> > > trust for integrity and keyring subsystems and should be always
> > > available and not be loaded from the user space. There is no a
> > > reasonable use case for a loadable module existing.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > >  drivers/char/tpm/Kconfig | 2 +-
> > >  include/linux/tpm.h      | 3 +--
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > This doesn't really make sense..
> > 
> > The kconfig method is that if IMA requires TPM it should declare so
> > and TPM will become non-modular because IMA is non-modular.
> > 
> > There are lots of legitimate use cases for TPM that don't involve IMA
> > or keyring.
> 
> In what context would it make sense to have TPM core as a module? I
> forgot to add RFC tag this patch. Did not meant to push it to
> mainline but more to rise up the discussion.

The usual reasons for modules, embedded that wants minimize kernel
image size to minimize boot time - load modules after the system has
started.. Developers that wish to use module-reload to test the code
they are working on, etc.

Jason
