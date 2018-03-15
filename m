Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:34766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932841AbeCOX3B (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 19:29:01 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
Date: Thu, 15 Mar 2018 23:28:55 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DEE@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-8-tomas.winkler@intel.com>
 <62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
In-Reply-To: <62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > Add tpm2_pcr_extend function to tpm2-cmd.c with signature required by
> > tpm-interface.c. It wraps the original open code implementation. The
> > original original tpm2_pcr_extend function is renamed and made static,
> > called only from new tpm2_pcr_extend.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This might concern some of the earlier patches too but please use exact
> names for functions in the short and long summary i.e.
> 
>   tpm: migrate all of the PCR extension code to tpm2_pcr_extend()
> 
> Check this also for your long descriptions and previous that I gave reviewed-
> by (I think they were otherwise fine). And you refer to a function in text use
> parentheses after the name. I don't like hastily written commit messages.


Yeah,  got little tired of describing the obvious. but you are right.
Tomas
