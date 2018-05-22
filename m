Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEVJ1v (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 May 2018 05:27:51 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Date: Tue, 22 May 2018 09:27:46 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
In-Reply-To: <20180522091732.GA5228@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
> > streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is
> abused
> > to resolve tpm spaces recursive calls to tpm_transmit().
> 
> This looks good and all but I don't think we want to abuse anything in the
> driver code, do we?

It's not abuse just the flag UNLOCKED is not really named correctly 
I think this has to be backported so wanted to do less invasive change.
> 
> In other words, either
> 
> 1. New flag is to be added.
No
> 2. Rename the existing flag to something else than UNLOCKED (perhaps
>    SPACE).


Currently both TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW  servers the same purpose, to resolve
the recursion in tpm tranmit. 
What I believe should be done is to split the function into two to eliminate recursive call instead of using flags.
Please also there is clock_enable which is not protected from double call.
Thanks
Tomas
