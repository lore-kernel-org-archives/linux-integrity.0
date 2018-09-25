Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:27643 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbeIYUqy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Sep 2018 16:46:54 -0400
Message-ID: <bf9342175181934b1324d3cf118dca3d41268685.camel@linux.intel.com>
Subject: Re: [PATCH v4 14/21] tpm: tpm-interface.c drop unused macros
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Sep 2018 17:39:01 +0300
In-Reply-To: <20180921135820.20549-15-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
         <20180921135820.20549-15-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> The commit:
> "tpm_tis: further simplify calculation of ordinal duration"
> left unused macros, we can drop them now.
> 
> Fixes compilation warnings:
> tpm-interface.c:37:0: warning: macro "TPM_PROTECTED_COMMAND" is not used [-
> Wunused-macros]
> tpm-interface.c:36:0: warning: macro "TSC_MAX_ORDINAL" is not used [-Wunused-
> macros]
> tpm-interface.c:38:0: warning: macro "TPM_CONNECTION_COMMAND" is not used [-
> Wunused-macros]
> 
> Fixes: f72864300139 ("tpm_tis: further simplify calculation of ordinal
> duration")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V3: New in the series.
> V4: Fix the commit message.
> 
>  drivers/char/tpm/tpm-interface.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 6cd3aed1e190..d7059fc72c51 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -33,10 +33,6 @@
>  
>  #include "tpm.h"
>  
> -#define TSC_MAX_ORDINAL 12
> -#define TPM_PROTECTED_COMMAND 0x00
> -#define TPM_CONNECTION_COMMAND 0x40
> -
>  /*
>   * Bug workaround - some TPM's don't flush the most
>   * recently changed pcr on suspend, so force the flush

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
