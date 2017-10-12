Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:58779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755880AbdJLLSl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2017 07:18:41 -0400
Date: Thu, 12 Oct 2017 14:18:35 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v3 4/5] tpm: reduce tpm_msleep() time in get_burstcount()
Message-ID: <20171012111835.g7uulven4whnpf5d@linux.intel.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
 <20171004102924.12355-5-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004102924.12355-5-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 04, 2017 at 06:29:23AM -0400, Nayna Jain wrote:
> Currently, get_burstcount() function sleeps for 5msec in a loop
> before retrying for next query to burstcount. However, if it takes
> lesser time for TPM to return, this 5msec delay is longer
> than necessary.
> 
> This patch replaces the tpm_msleep time from 5msec to 1msec.
> 
> After this change, performance on a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~10sec to ~9sec.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 224842e06105..826a0b9c9201 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -226,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
>  		burstcnt = (value >> 8) & 0xFFFF;
>  		if (burstcnt)
>  			return burstcnt;
> -		tpm_msleep(TPM_TIMEOUT);
> +		tpm_msleep(TPM_POLL_SLEEP);
>  	} while (time_before(jiffies, stop));
>  	return -EBUSY;
>  }
> -- 
> 2.13.3
> 

Would it make sense to squash this to 3/5 and merge the commit
messages?

/Jarkko
