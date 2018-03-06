Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51915 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932078AbeCFPT2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 10:19:28 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
Date: Tue, 6 Mar 2018 15:19:23 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F4C1@hasmsx108.ger.corp.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
         <20180306092503.11568-4-tomas.winkler@intel.com>
 <1520339005.3779.3.camel@linux.intel.com>
In-Reply-To: <1520339005.3779.3.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> On Tue, 2018-03-06 at 11:25 +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> > Rather than increasing default timeout a new constant is added, to not
> > stall for too long on regular commands failures.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Why are you radically chaging the default timeout? The commit message
> does not tell anything about that change.
>
Let me, recheck but it should be same value just converted to msecs.
 
> Why couldn't we just have two timeouts: one default and one long that
> would be at least as long as the longest timeout defined in the spec?

I've tried to explain it in the commit message but apparently has failed. 

We have a default or undefined which should be the same as it was unless I did some silly mistake in conversion to msecs (will check), ass all others are in msecs.
It was 2 min = 2 * 60 * HZ (in jiffies) which would be msecs_to_jiffies(2 * 60 * 1000 = 120000) 
TPM2_DURATION_DEFAULT   = 120000

Then we have a new one which is 3 min just for key generation (Prime number generation is heavy liffting) 

> Then we would not have to ever update LAST_CC constant, we could actually
> remove it completely.

I believe I've removed it next patch, I didn't want do too much in this one.

Thanks
Tomas
