Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7556 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBH0G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:26:06 -0400
Date: Tue, 2 Oct 2018 03:45:23 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/21] tpm: factor out tpm 1.x pm suspend flow into
 tpm1-cmd.c
Message-ID: <20181002004523.GF23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-11-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928223035.14471-11-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:24AM +0300, Tomas Winkler wrote:
> Factor out TPM 1.x suspend flow from tpm-interface.c into a new function
> tpm1_pm_suspend() in tpm1-cmd.c
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
