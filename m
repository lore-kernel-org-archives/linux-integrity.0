Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21007 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753871AbdJSOWQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 10:22:16 -0400
Date: Thu, 19 Oct 2017 17:22:07 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v4 4/4] tpm: use tpm_msleep() value as max delay
Message-ID: <20171019142207.fviqxmpfwsvmd3rw@linux.intel.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
 <20171017203232.2262-5-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171017203232.2262-5-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 17, 2017 at 04:32:32PM -0400, Nayna Jain wrote:
> Currently, tpm_msleep() uses delay_msec as the minimum value in
> usleep_range. However, that is the maximum time we want to wait.
> The function is modified to use the delay_msec as the maximum
> value, not the minimum value.
> 
> After this change, performance on a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~9sec to ~8sec.
> 
> Fixes: 3b9af007869("tpm: replace msleep() with usleep_range() in TPM 1.2/
> 2.0 generic drivers")
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/tpm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 4fc83ac7abeb..644de70de2cc 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -528,8 +528,8 @@ int tpm_pm_resume(struct device *dev);
>  
>  static inline void tpm_msleep(unsigned int delay_msec)
>  {
> -	usleep_range(delay_msec * 1000,
> -		     (delay_msec * 1000) + TPM_TIMEOUT_RANGE_US);
> +	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> +		     delay_msec * 1000);
>  };
>  
>  struct tpm_chip *tpm_chip_find_get(int chip_num);
> -- 
> 2.13.3
> 

Tested-by: Jarkko Sakkinen <jarkkko.sakkinen@linux.intel.com>

/Jarkko
