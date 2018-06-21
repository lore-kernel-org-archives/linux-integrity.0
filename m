Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:34411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933287AbeFUQVO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 12:21:14 -0400
Date: Thu, 21 Jun 2018 19:21:01 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Louis Collard <louiscollard@chromium.org>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
Message-ID: <20180621162101.GB11859@linux.intel.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com>
 <20180618193306.GF6805@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180618193306.GF6805@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jun 18, 2018 at 01:33:06PM -0600, Jason Gunthorpe wrote:
> > > +module_param(override_rng_quality, short, 0644);
> > 
> > Should this be 600 i.e. not to leak this information?
> 
> There is a real push these days against adding module parameters, and
> apparently, IMA can't function with TPM as a module.
> 
> Are you sure this shouldn't be done in some other way?

Maybe a sysfs file would be a better choice for this?

/Jarkko
