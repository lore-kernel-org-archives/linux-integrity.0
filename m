Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58620 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeISTlE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Sep 2018 15:41:04 -0400
Date: Wed, 19 Sep 2018 17:02:54 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/20] tpm: add tpm_calc_ordinal_duration wrapper
Message-ID: <20180919140254.GG26571@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-5-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918093459.19165-5-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 18, 2018 at 12:34:43PM +0300, Tomas Winkler wrote:
> Add convenient wrapper for ordinal duration computation
> to remove boiler plate if else statement over TPM2.
> 
> if (chip->flags & TPM_CHIP_FLAG_TPM2)
> 	tpm2_calc_ordinal_duration(chip, ordinal);
> else
> 	tpm1_calc_ordinal_duration(chip, ordinal);
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
