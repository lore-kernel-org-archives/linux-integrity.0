Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26350 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbeBFUwI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Feb 2018 15:52:08 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tpm: add longer timeouts for creation commands.
Date: Tue, 6 Feb 2018 20:51:48 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9421881D@hasmsx108.ger.corp.intel.com>
References: <20180128081739.8066-1-tomas.winkler@intel.com>
 <20180206200650.ozcwsv3uks6eyah3@linux.intel.com>
In-Reply-To: <20180206200650.ozcwsv3uks6eyah3@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> On Sun, Jan 28, 2018 at 10:17:39AM +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This is still NAK because we need some kind of reference for the new value.
> Is that also right value for ARM64/TrustZone based TPMs?

The SPEC itself, doesn't define the timeout,  except for specific commands, 
also the current 'undefined' number is born in air, I wonder if you  can provide the reference as well.
If I would suggest to shorten the number that would maybe a problem for other implementation, 
but I don't see how the increase in timeout is adverse another implementations.
Key generation is computational intensive task because of generation of a prime number, so this is really 
dependent on device capabilities, so there is no better source of definition that HW itself.

Thanks
Tomas
