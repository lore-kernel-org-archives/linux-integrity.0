Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755998AbeDZRtd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Apr 2018 13:49:33 -0400
Date: Thu, 26 Apr 2018 19:49:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH 0/3] v4.16 tpmdd backports
Message-ID: <20180426174924.GD28091@kroah.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
 <20180425110600.GA1996@kroah.com>
 <1524678812.4100.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1524678812.4100.9.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:53:32AM -0700, James Bottomley wrote:
> On Wed, 2018-04-25 at 13:06 +0200, Greg KH wrote:
> > On Wed, Apr 25, 2018 at 01:44:20PM +0300, Jarkko Sakkinen wrote:
> > > "tpm: add retry logic" caused merge conflicts so I picked couple of
> > > other fixes in order to get it apply cleanly.
> > 
> > Are these only needed in 4.16.y?  Nothing earlier?
> 
> The retry one (tpm: add retry logic) could go back as far as you can,
> but the bug it causes is rarely seen: mostly it's a failure of the
> kernel trusted keys due to a tpm retry being interpreted as a fatal
> error.  The number of users we have for kernel trusted keys seems to be
> pretty small ...
> 
> I'd say if the backport works as is, go for it, but if we get a patch
> apply failure, it's probably not worth trying to work out how to modify
> the patch again until someone actually complains about the problem.

They seem to all work for 4.14.y and 4.16.y, so now queued up, thanks.

greg k-h
