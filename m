Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46675 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965296AbeF2Pbo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 11:31:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so1332607pfl.13
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 08:31:43 -0700 (PDT)
Date: Fri, 29 Jun 2018 09:31:41 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629153141.GE379@ziepe.ca>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Jun 29, 2018 at 06:10:02PM +0300, Jarkko Sakkinen wrote:
> Do not allow to compile TPM core as a module. TPM defines a root of
> trust for integrity and keyring subsystems and should be always
> available and not be loaded from the user space. There is no a
> reasonable use case for a loadable module existing.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  include/linux/tpm.h      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

This doesn't really make sense..

The kconfig method is that if IMA requires TPM it should declare so
and TPM will become non-modular because IMA is non-modular.

There are lots of legitimate use cases for TPM that don't involve IMA
or keyring.

> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 18c81cbe4704..9728771aecbd 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig TCG_TPM
> -	tristate "TPM Hardware Support"
> +	bool "TPM Hardware Support"
>  	depends on HAS_IOMEM
>  	select SECURITYFS
>  	select CRYPTO
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4609b94142d4..cefa61b12891 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -50,8 +50,7 @@ struct tpm_class_ops {
>  	void (*clk_enable)(struct tpm_chip *chip, bool value);
>  };
>  
> -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> -
> +#if defined(CONFIG_TCG_TPM)

Huh. This new version is certainly right

Jason
