Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61655 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeISTrM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Sep 2018 15:47:12 -0400
Date: Wed, 19 Sep 2018 17:09:02 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/20] tpm: move tpm_getcap to tpm1-cmd.c
Message-ID: <20180919140902.GB27854@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-8-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180918093459.19165-8-tomas.winkler@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Sep 18, 2018 at 12:34:46PM +0300, Tomas Winkler wrote:
> 1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
> 2. Remove unused tpm_getcap_header with unused constant
> as this functionality is already implemented using tpm_buf construct.
> 
> Fixes warning:
> drivers/char/tpm/tpm-interface.c:452:38: warning: 'tpm_getcap_header' defined but not used [-Wunused-const-variable=]
>  static const struct tpm_input_header tpm_getcap_header = {
>                                       ^~~~~~~~~~~~~~~~~
> 3. Drop unused TPM_DIGEST_SIZE. It's already defined in
> include/linux/tpm.h

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
