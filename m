Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35398 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeIYEkF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Sep 2018 00:40:05 -0400
Date: Tue, 25 Sep 2018 01:35:13 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/21] tpm: factor out tpm_startup function
Message-ID: <20180924223513.GB12088@linux.intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
 <20180921135820.20549-12-tomas.winkler@intel.com>
 <060a3dc0-046e-198c-f476-8c490140e9d6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <060a3dc0-046e-198c-f476-8c490140e9d6@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 24, 2018 at 08:21:10PM +0530, Nayna Jain wrote:
> On 09/21/2018 07:28 PM, Tomas Winkler wrote:
> > TPM manual startup is used only from within TPM 1.x or TPM 2.x
> > code, hence remove tpm_startup() function from tpm-interface.c
> > and add two static functions implementations tpm1_startup()
> > and tpm2_startup() into to tpm1-cmd.c and tpm2-cmd.c respectively.
> > 
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Tested-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

Probably my bad, had an unfortunate misconfiguration in my vim/git
setup. Sorry.

/Jarkko
