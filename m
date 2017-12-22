Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35343 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755940AbdLVQGK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 11:06:10 -0500
Received: by mail-it0-f65.google.com with SMTP id f143so15147372itb.0
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 08:06:09 -0800 (PST)
Date: Fri, 22 Dec 2017 09:06:07 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: remove unused data fields from I2C and OF device ID
 tables
Message-ID: <20171222160607.GA30884@ziepe.ca>
References: <20171222102636.12530-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171222102636.12530-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 22, 2017 at 11:26:36AM +0100, Javier Martinez Canillas wrote:
> The data field for the entries in the device tables are set but not used.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
>  drivers/char/tpm/tpm_i2c_infineon.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index 005c38879b2e..19fbd6a3a8e9 100644
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -665,9 +665,9 @@ static int tpm_tis_i2c_init(struct device *dev)
>  }
>  
>  static const struct i2c_device_id tpm_tis_i2c_table[] = {
> -	{"tpm_i2c_infineon", 0},
> -	{"slb9635tt", 0},
> -	{"slb9645tt", 1},
> +	{"tpm_i2c_infineon" },
> +	{"slb9635tt" },
> +	{"slb9645tt" },

                   ^^^

The space should go too..

Jason
