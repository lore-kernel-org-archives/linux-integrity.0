Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932629AbeCFMXb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Mar 2018 07:23:31 -0500
Message-ID: <1520339005.3779.3.camel@linux.intel.com>
Subject: Re: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 14:23:25 +0200
In-Reply-To: <20180306092503.11568-4-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
         <20180306092503.11568-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-03-06 at 11:25 +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> Rather than increasing default timeout a new constant is
> added, to not stall for too long on regular commands failures.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Why are you radically chaging the default timeout? The commit
message does not tell anything about that change.

Why couldn't we just have two timeouts: one default and one long that
would be at least as long as the longest timeout defined in the spec?
Then we would not have to ever update LAST_CC constant, we could
actually remove it completely.

/Jarkko
