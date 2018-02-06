Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2815 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752465AbeBFUHP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Feb 2018 15:07:15 -0500
Date: Tue, 6 Feb 2018 22:06:50 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: add longer timeouts for creation commands.
Message-ID: <20180206200650.ozcwsv3uks6eyah3@linux.intel.com>
References: <20180128081739.8066-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180128081739.8066-1-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Jan 28, 2018 at 10:17:39AM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This is still NAK because we need some kind of reference for the new
value. Is that also right value for ARM64/TrustZone based TPMs?

/Jarkko
