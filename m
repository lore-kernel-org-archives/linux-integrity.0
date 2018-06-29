Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17882 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932999AbeF2Rnf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 13:43:35 -0400
Date: Fri, 29 Jun 2018 20:43:28 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629174328.GA4060@linux.intel.com>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629153141.GE379@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> On Fri, Jun 29, 2018 at 06:10:02PM +0300, Jarkko Sakkinen wrote:
> > Do not allow to compile TPM core as a module. TPM defines a root of
> > trust for integrity and keyring subsystems and should be always
> > available and not be loaded from the user space. There is no a
> > reasonable use case for a loadable module existing.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/tpm/Kconfig | 2 +-
> >  include/linux/tpm.h      | 3 +--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> This doesn't really make sense..
> 
> The kconfig method is that if IMA requires TPM it should declare so
> and TPM will become non-modular because IMA is non-modular.
> 
> There are lots of legitimate use cases for TPM that don't involve IMA
> or keyring.

In what context would it make sense to have TPM core as a module? I
forgot to add RFC tag this patch. Did not meant to push it to
mainline but more to rise up the discussion.

/Jarkko
