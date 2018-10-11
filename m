Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:21241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeJKUzO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 16:55:14 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Date: Thu, 11 Oct 2018 13:27:58 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9EEC12@hasmsx109.ger.corp.intel.com>
References: <20181010133817.GA11485@embeddedor.com>
 <20181010140638.GA3894@ziepe.ca> <20181011120140.GA15767@linux.intel.com>
In-Reply-To: <20181011120140.GA15767@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> On Wed, Oct 10, 2018 at 08:06:38AM -0600, Jason Gunthorpe wrote:
> > On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> > > Currently, there are some values assigned to variable *rc*, which
> > > are never actually used in any computation, because such variable is
> > > updated at line 550, before they can be used:
> > >
> > > 549out:
> > > 550        rc = tpm_go_idle(chip, flags);
> > > 551        if (rc)
> > > 552                goto out;
> > >
> > > Fix this by removing such assignments.
> >
> > Should this be done by not quashing rc during the error unwind rather
> > than dropping the errors?
> 
> Yeah.`
> 
> Wondering if tpm_go_idle() should simply be a void-function i.e. issue just a
> warning inside (disclaimer: did not revisit its code when writing this).

We did have rather a long discussion about it when it was merged.
There are two flows that may crash 
rc = tpm2_commit_space()

but you still can need to 

rc  = go_idle()  

which also may crash which may override the previous value. 

Frankly the second one is fatal, the stack will go out of sync.
We may do void here as the stack will crash in a subsequent command. 

The 'goto out' is quite a  bug, probably caused by code movement.


Thanks
Tomas
