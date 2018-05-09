Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34428 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965436AbeEIVty (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 May 2018 17:49:54 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: 'Jason Gunthorpe' <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Date: Wed, 9 May 2018 21:49:49 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D895BA3@hasmsx109.ger.corp.intel.com>
References: <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B942627FD@hasmsx108.ger.corp.intel.com>
 <20180424160328.GA5119@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94272F33@hasmsx108.ger.corp.intel.com>
 <20180502133246.GA6091@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B083@hasmsx108.ger.corp.intel.com>
 <20180503063508.GA8702@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B9A6@hasmsx108.ger.corp.intel.com>
 <20180504081634.GB6373@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427D284@hasmsx108.ger.corp.intel.com>
 <20180509122621.GB8271@linux.intel.com>
In-Reply-To: <20180509122621.GB8271@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> On Sat, May 05, 2018 at 09:07:21PM +0000, Winkler, Tomas wrote:
> > There is already one 'out' label in that function, what would you prefer for
> this new label name?
> > Thanks
> > Tomas
> 
> Aah, of course. My bad that I did not notice it but please just point me if I
> miss something obvious like that :-) I'll apply the patch today..
> 
Thanks
Tomas
