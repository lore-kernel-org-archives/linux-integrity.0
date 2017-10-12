Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:43970 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752673AbdJLLRq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2017 07:17:46 -0400
Date: Thu, 12 Oct 2017 14:17:26 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v3 3/5] tpm: reduce polling delay in tpm_tis
 wait_for_tpm_stat()
Message-ID: <20171012111726.7dhos7bfgywqytbz@linux.intel.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
 <20171004102924.12355-4-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004102924.12355-4-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 04, 2017 at 06:29:22AM -0400, Nayna Jain wrote:
> The existing wait_for_tpm_stat() polls for the chip status after
> 5msec sleep. As per TCG ddwg input, it is expected that tpm might
> return status in few usec. So, reducing the delay in polling to
> 1msec.
> 
> After this change, performance on a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~14sec to ~10sec.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 8da425e1783f..224842e06105 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -31,6 +31,8 @@
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> +#define TPM_POLL_SLEEP	1

Should have a comment above that explains the choice.

> +
>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>  					bool check_cancel, bool *canceled)
>  {
> @@ -82,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			tpm_msleep(TPM_TIMEOUT);
> +			tpm_msleep(TPM_POLL_SLEEP);
>  			status = chip->ops->status(chip);
>  			if ((status & mask) == mask)
>  				return 0;
> -- 
> 2.13.3
> 

/Jarkko
