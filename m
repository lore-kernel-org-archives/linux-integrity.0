Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14366 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdLXVAn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 16:00:43 -0500
Date: Sun, 24 Dec 2017 23:00:38 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: remove unused data fields from I2C and OF device
 ID tables
Message-ID: <20171224210038.ydotqvyb4cet4h6l@linux.intel.com>
References: <20171222174741.21534-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222174741.21534-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 22, 2017 at 06:47:41PM +0100, Javier Martinez Canillas wrote:
> The data field for the entries in the device tables are set but not used.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> 
> Changes in v2:
> - Also empty spaces (suggested by Jason Gunthorpe).
> 
>  drivers/char/tpm/tpm_i2c_infineon.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index 005c38879b2e..c1dd39eaaeeb 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -665,9 +665,9 @@ static int tpm_tis_i2c_init(struct device *dev)
>  }
>  
>  static const struct i2c_device_id tpm_tis_i2c_table[] = {
> -	{"tpm_i2c_infineon", 0},
> -	{"slb9635tt", 0},
> -	{"slb9645tt", 1},
> +	{"tpm_i2c_infineon"},
> +	{"slb9635tt"},
> +	{"slb9645tt"},
>  	{},
>  };
>  
> @@ -675,9 +675,9 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_table);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id tpm_tis_i2c_of_match[] = {
> -	{ .compatible = "infineon,tpm_i2c_infineon", .data = (void *)0 },
> -	{ .compatible = "infineon,slb9635tt", .data = (void *)0 },
> -	{ .compatible = "infineon,slb9645tt", .data = (void *)1 },
> +	{.compatible = "infineon,tpm_i2c_infineon"},
> +	{.compatible = "infineon,slb9635tt"},
> +	{.compatible = "infineon,slb9645tt"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, tpm_tis_i2c_of_match);
> -- 
> 2.14.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
