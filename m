Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27032 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBH0g (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:26:36 -0400
Date: Tue, 2 Oct 2018 03:46:03 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/21] tpm: factor out tpm_startup function
Message-ID: <20181002004603.GG23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-12-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928223035.14471-12-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:25AM +0300, Tomas Winkler wrote:
> TPM manual startup is used only from within TPM 1.x or TPM 2.x
> code, hence remove tpm_startup() function from tpm-interface.c
> and add two static functions implementations tpm1_startup()
> and tpm2_startup() into to tpm1-cmd.c and tpm2-cmd.c respectively.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
