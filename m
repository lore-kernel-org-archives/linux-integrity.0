Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:30290 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754923AbeCSJhp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 05:37:45 -0400
Date: Mon, 19 Mar 2018 11:37:35 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5 V3] tpm2: add longer timeouts for creation commands.
Message-ID: <20180319093735.GA4587@linux.intel.com>
References: <20180310151545.22237-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180310151545.22237-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Mar 10, 2018 at 05:15:45PM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> Rather than increasing default timeout a new constant is
> added, to not stall for too long on regular commands failures.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

PS. Please format the long description properly. Now the lines cut from
weird places. I use gq command in Vim to get that done. The description
itself is nice and concise.

/Jarkko
