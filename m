Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282123;
	b=1V6++zcg73m1n04wTIV5GxbOgo8FdpU+jw/FNYivNF7GzHzorRVj1TckQDeVj6aYRPZM
	 7GlsnUPVXEcKwtAZhGvKaP7XOFurgu0m/vmTbGp4uwbWZKhc2/SmCSAc2YjOff2ZFAXHq
	 +1+7unIHUO2ZdNFNPfXtOKTSbyKHwnbFarxfo9ZQhegn8D+wB+f1b3kjpRFuqLZuo1G8R
	 jZOlTFOLbQ6XvzUQG6aYiX2ojNRzwbxBf1NmwiDsp+xhbe6U4/1S/kPo8MNf6D35XG8xs
	 Gg7kIOzeaLmbU/3h8uoirKCKdrkMShiboXMOSDErc3bBiCRuIT1fO6fwV1GXXZoy2eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282123;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BMa/V2u8DSOiKoMYsxsHe3HEm/inDMpyw+DHYrdgIMk=;
	b=lXOakUbRoM1KT5teaMM9CUgKfPsFvm7oyobOy1qWL1vW+6YN9RLbkHnQlzhaiNKUHpWZ
	 oqQdn15Yg9/y1aqOJGRL92OaIWh0JMHpZZ2VS9PtOSjcZSZG9SZ0XQUGvC9tWnWa0MvwD
	 8AsDkiV9atpwUDE4pynI8/5RGkrXD3O+SjcpyfrY47LQUZVylxcBx9Egazt0h1FKgonJb
	 R80v6SCHtBnqmMZOALeBeBkgGrMJ+X3xbpghJH7KNiXDHKllTHqbtRFes62zwLvuwkM6z
	 WSGpWXMaDOAAKCgALgsFoNUyOagdJM1BM4QsetvZNSsdo3jOhaqbGzo2jLQzk/X/F4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1bPYmGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8E092606A31C;
	Thu, 29 Oct 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1bPYmGA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9929F1F01825;
	Thu, 29 Oct 2026 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793282123;
	bh=BMa/V2u8DSOiKoMYsxsHe3HEm/inDMpyw+DHYrdgIMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1bPYmGA6AawuBvfPStSu7tDTsnOi3g2ZS6f3uyUOCrL0eqLiWFtNfPcA2oJjiBIG
	 ueLB0T8EPH5WhmmmtO78zAapcdSPF89M+l0oEj1HNvFDfIzAjpx67QCwLhH0TakPLD
	 vX6UmyBZZBtREJIcQ1uLtjHu5rnHrOHQlngsaGjOwE3syB6aYZLjWk7Uhvf8ED4Dt2
	 FrYG2QVD+tgpOPv6nE9e5CVpmrs2KhKBx6UEFxXV9XPotzX8GzYk6IODCWJET31J2G
	 TK0k0CxXihL2pm3G5xwdU/RmDjL0cQDRdxBPzR2X3AAH2jIm7xpMB6ibhJaKff8xtV
	 EZMCqjAO7O4uw==
Date: Thu, 29 Oct 2026 15:55:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: linux-kernel@vger.kernel.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tpm: tis_i2c: Add reset delays for ST33KTPM2XI2C
Message-ID: <auNQRzb8H9KsHVqR@kernel.org>
References: <20261029095528.8073-1-stefano.r@variscite.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029095528.8073-1-stefano.r@variscite.com>

On Thu, Oct 29, 2026 at 10:55:28AM +0100, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> The optional reset control is deasserted without a delay, and probe then
> proceeds directly to the first I2C register access. Since reset-gpio
> initializes its line asserted, this provides no guaranteed minimum reset
> pulse width or recovery interval before communication starts.
> 
> Table 66 of the ST33KTPM-IDevID datasheet specifies a minimum reset pulse
> width of 1 ms and up to 50 ms from reset release before the first command.
> Choose a 2 ms assertion interval to provide margin above the minimum and
> wait 50 ms after deassertion, before initializing the I2C guard times.
> 
> Pull the timings from the matched device entry. If they don't exist,
> fall back to the legacy behavior without delays. Update of_tis_i2c_match
> with the timings for st33ktpm2xi2c.
> 
> Link: https://www.st.com/resource/en/datasheet/st33ktpm-idevid.pdf
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
> v1->v2:
>  - Rewrite the last paragraph of the commit message
> 
>  drivers/char/tpm/tpm_tis_i2c.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index cde0b093ed58..8bcbc84815fd 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -12,6 +12,8 @@
>  
>  #include <linux/i2c.h>
>  #include <linux/crc-ccitt.h>
> +#include <linux/delay.h>
> +#include <linux/property.h>
>  #include <linux/reset.h>
>  #include "tpm_tis_core.h"
>  
> @@ -55,6 +57,11 @@
>  #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
>  #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
>  
> +struct tpm_tis_i2c_reset_timings {
> +	unsigned int assert_us;
> +	unsigned int deassert_us;
> +};
> +
>  struct tpm_tis_i2c_phy {
>  	struct tpm_tis_data priv;
>  	struct i2c_client *i2c_client;
> @@ -330,6 +337,7 @@ static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
>  
>  static int tpm_tis_i2c_probe(struct i2c_client *dev)
>  {
> +	const struct tpm_tis_i2c_reset_timings *timings;
>  	struct tpm_tis_i2c_phy *phy;
>  	struct reset_control *reset;
>  	const u8 crc_enable = 1;
> @@ -347,17 +355,25 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
>  
>  	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
>  	phy->i2c_client = dev;
> +	timings = device_get_match_data(&dev->dev);
>  
>  	reset = devm_reset_control_get_optional_exclusive(&dev->dev, NULL);
>  	if (IS_ERR(reset))
>  		return dev_err_probe(&dev->dev, PTR_ERR(reset),
>  				     "failed to get reset control\n");
>  
> +	/* Allow an already asserted reset to meet its minimum pulse width. */
> +	if (reset && timings)
> +		fsleep(timings->assert_us);
> +
>  	ret = reset_control_deassert(reset);
>  	if (ret)
>  		return dev_err_probe(&dev->dev, ret,
>  				     "failed to deassert reset\n");
>  
> +	if (reset && timings)
> +		fsleep(timings->deassert_us);
> +
>  	/* must precede all communication with the tpm */
>  	ret = tpm_tis_i2c_init_guard_time(phy);
>  	if (ret)
> @@ -393,9 +409,19 @@ static const struct i2c_device_id tpm_tis_i2c_id[] = {
>  MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  
>  #ifdef CONFIG_OF
> +/*
> + * ST33KTPM-IDevID datasheet DS15011, table 66: tWL >= 1 ms and
> + * tCMD <= 50 ms. Allow 2 ms for tWL to provide margin above the minimum.
> + */
> +static const struct tpm_tis_i2c_reset_timings st33ktpm2xi2c_reset_timings = {
> +	.assert_us = 2000,
> +	.deassert_us = 50000,
> +};
> +
>  static const struct of_device_id of_tis_i2c_match[] = {
>  	{ .compatible = "infineon,slb9673", },
>  	{ .compatible = "nuvoton,npct75x", },
> +	{ .compatible = "st,st33ktpm2xi2c", .data = &st33ktpm2xi2c_reset_timings },
>  	{ .compatible = "tcg,tpm-tis-i2c", },
>  	{}
>  };
> -- 
> 2.47.3
> 

Thanks, LGTM.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
