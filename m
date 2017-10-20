Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64960 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbdJTG4T (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 02:56:19 -0400
Date: Fri, 20 Oct 2017 09:56:14 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Guilherme Magalhaes <guilherme.magalhaes@hpe.com>
Cc: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ken Goldman <kgold@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm: adjust command response sleep time for vTPM
Message-ID: <20171020065614.4rvmyj3hkwrhabhq@linux.intel.com>
References: <20171003204640.62236-1-guilherme.magalhaes@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171003204640.62236-1-guilherme.magalhaes@hpe.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 03, 2017 at 05:46:40PM -0300, Guilherme Magalhaes wrote:
> Once vTPM is actually a software, it is able to respond the commands much
> quicker than physical TPMs. What we propose is to adjust the response
> polling time to a usec value when the chip is detected as a vTPM.
> With this change, the kernel TPM interface identifies whether the chip is
> vTPM and on this case sets the polling sleep time to an optimized value.
> 
> The performance result was 12x improvement when comparing PCR extends
> using vTPM with the current sleep time and with the adjusted sleep time.
> ---
>  drivers/char/tpm/tpm-interface.c | 6 +++++-
>  drivers/char/tpm/tpm.h           | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1d6729be4cd6..d213a3d4b305 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -455,7 +455,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  			goto out;
>  		}
>  
> -		tpm_msleep(TPM_TIMEOUT);
> +		if (chip->flags & TPM_CHIP_FLAG_VIRTUAL)
> +			usleep_range(TPM_TIMEOUT_VTPM_US, TPM_TIMEOUT_VTPM_RANGE_US);
> +		else
> +			tpm_msleep(TPM_TIMEOUT);
> +
>  		rmb();
>  	} while (time_before(jiffies, stop));
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2d5466a72e40..02d2dd761543 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -50,6 +50,8 @@ enum tpm_const {
>  
>  enum tpm_timeout {
>  	TPM_TIMEOUT = 5,	/* msecs */
> +	TPM_TIMEOUT_VTPM_US = 1,	/* usecs */
> +	TPM_TIMEOUT_VTPM_RANGE_US = 5,	/* usecs */
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
>  };
> -- 
> 2.11.0
> 

You should add me to to-field and CC this also to

linux-kernel@vger.kernel.org
linux-security-module@vger.kernel.org

http://kernsec.org/wiki/index.php?title=Linux_Kernel_Integrity

I managed to miss this patch and cannot accept it at this point because
at minimum linux-kernel should be in the CC-list.

I'm thinking what bad could happen if we shortened the timeout for
hardware TPMs.

/Jarkko
