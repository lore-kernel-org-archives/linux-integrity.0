Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55557 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeIEP6l (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Sep 2018 11:58:41 -0400
Date: Wed, 5 Sep 2018 14:28:47 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: Make SECURITYFS a weak dependency
Message-ID: <20180905112847.GC9696@linux.intel.com>
References: <20180903195151.7576-1-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903195151.7576-1-peterhuewe@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Sep 03, 2018 at 09:51:51PM +0200, Peter Huewe wrote:
> While having SECURITYFS enabled for the tpm subsystem is beneficial in
> most cases, it is not strictly necessary to have it enabled at all.
> Especially on platforms without any boot firmware integration of the TPM
> (e.g. raspberry pi) it does not add any value for the tpm subsystem,
> as there is no eventlog present.
> 
> By turning it from 'select' to 'imply' it still gets selected per
> default, but enables users who want to save some kb of ram by turning
> SECURITYFS off.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 18c81cbe4704..536e55d3919f 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -5,7 +5,7 @@
>  menuconfig TCG_TPM
>  	tristate "TPM Hardware Support"
>  	depends on HAS_IOMEM
> -	select SECURITYFS
> +	imply SECURITYFS
>  	select CRYPTO
>  	select CRYPTO_HASH_INFO
>  	---help---
> -- 
> 2.16.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
