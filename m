Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42020 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755899AbeDYRxf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 13:53:35 -0400
Message-ID: <1524678812.4100.9.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/3] v4.16 tpmdd backports
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org, Azhar Shaikh <azhar.shaikh@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Date: Wed, 25 Apr 2018 10:53:32 -0700
In-Reply-To: <20180425110600.GA1996@kroah.com>
References: <20180425104425.5803-1-jarkko.sakkinen@linux.intel.com>
         <20180425110600.GA1996@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-04-25 at 13:06 +0200, Greg KH wrote:
> On Wed, Apr 25, 2018 at 01:44:20PM +0300, Jarkko Sakkinen wrote:
> > "tpm: add retry logic" caused merge conflicts so I picked couple of
> > other fixes in order to get it apply cleanly.
> 
> Are these only needed in 4.16.y?  Nothing earlier?

The retry one (tpm: add retry logic) could go back as far as you can,
but the bug it causes is rarely seen: mostly it's a failure of the
kernel trusted keys due to a tpm retry being interpreted as a fatal
error.  The number of users we have for kernel trusted keys seems to be
pretty small ...

I'd say if the backport works as is, go for it, but if we get a patch
apply failure, it's probably not worth trying to work out how to modify
the patch again until someone actually complains about the problem.

James
