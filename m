Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7279 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBHXU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 03:23:20 -0400
Date: Tue, 2 Oct 2018 03:42:48 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
Message-ID: <20181002004248.GC23753@linux.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180928223035.14471-7-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, Sep 29, 2018 at 01:30:20AM +0300, Tomas Winkler wrote:
> Move tpm1_pcr_extend to tpm1-cmd.c and remove
> unused pcrextend_header structure and
> EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
> defines.
> 
> Fixes warning:
> drivers/char/tpm/tpm-interface.c:609:38: warning: 'pcrextend_header' defined but not used [-Wunused-const-variable=]
>  static const struct tpm_input_header pcrextend_header = {
>                                       ^~~~~~~~~~~~~~~~
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Would need help with this from someone with a working IMA setup
on testing.

/Jarkko
