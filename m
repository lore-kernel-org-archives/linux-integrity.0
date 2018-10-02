Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14679 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBHYX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:24:23 -0400
Date: Tue, 2 Oct 2018 03:43:50 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/21] tpm: factor out tpm1_get_random into tpm1-cmd.c
Message-ID: <20181002004350.GD23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-9-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928223035.14471-9-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:22AM +0300, Tomas Winkler wrote:
> Factor out get random implementation from tpm-interface.c
> into tpm1_get_random function in tpm1-cmd.c.
> No functional changes.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
