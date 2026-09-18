Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BF352027;
	Fri, 18 Sep 2026 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699117; cv=none; b=Mo58/P9/aq+mJVbSsNSAZIbV+V9k2h9S8VVbOyTbuzmIhxi8E+3/KBhn1gN9SR4bhBEweprws3Vzbikn4po+2KqjyPEKyKZtkvzZWgzBXIp3gy004sjUWnG/oNkHN9BvA8OIqWzuGdMGQesSrlMvuhaeEP4WDjMPDcxPAREdx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699117; c=relaxed/simple;
	bh=vdcb4tc4Z9/qM3rw4ANpUWG+co9fFb46KL53RmRl7+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVkEdyixWNWDDlWd61ATTOVMY2TnrmmPgKaZyed75ZkB+HLdVFTyGuuU088bOLKxEoh3ofgY6AH5Taw+Mxk43KK8awBmEMO4s2mukzWf0+XJmFWPcZdmSPDQ/RyH+3oqJmKXKYT9Vmj9JwEg2ymjjwCAfVRYvLmgwxID70e3FUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxV1SviF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxV1SviF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A953A1F000FF;
	Fri, 18 Sep 2026 02:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699107;
	bh=9VafOi167L1/jBOfa2VZges6TFhdXkCddud9pCopUek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cxV1SviFamlCdFFMHYGlaOVQB3oyP7LrPuGwgqPmYYkDYt6c4D8iw2p/paPme2xkK
	 MhCDQT666FJ5bPIV3jZDS8p0iEoDF21pEVjWkjRKg7ynTPWXqar5lGFqxEISz5ONLe
	 PuIoMspOVFhS+Nj4hqqv+N2nxclPUxLo9NXst1gxpsdW92tVaru5gNzWjL/KfWSQiw
	 2ajzEsDCEffAME66G2RFTRL79lfTBC29dE2ZtDyUBJHFA+CxM5tlwpz/j3RvKZazhP
	 XeAEtP1PbHabV0WXfkysBao+5kQmPljaN8BXNVqyer+KeSull1jyzJCADKjUQYhEWl
	 nhVHkZTjpkfIw==
Date: Fri, 18 Sep 2026 05:38:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm: tis_i2c: Deassert optional reset line before
 probing
Message-ID: <aqykH7j_Gp5FmIPA@kernel.org>
References: <20260917124211.136221-1-stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917124211.136221-1-stefano.r@variscite.com>

On Thu, Sep 17, 2026 at 02:42:11PM +0200, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> The common TPM Device Tree binding already documents resets and
> reset-gpios, but the TIS I2C driver never requests a reset control.
> As a result, an I2C TPM held in reset by board wiring remains
> inaccessible and the first register access during probe fails.
> 
> Request the optional reset control and deassert it before
> communicating with the TPM. This keeps existing boards without a reset
> line unchanged while allowing platforms using resets or reset-gpios to
> release the TPM before probe continues.
> 
> Tested on a Variscite DART-MX95 with an ST33KTPM2XI2C TPM using
> reset-gpios.
> 
> Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index d55f30fef00a..cde0b093ed58 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/i2c.h>
>  #include <linux/crc-ccitt.h>
> +#include <linux/reset.h>
>  #include "tpm_tis_core.h"
>  
>  /* TPM registers */
> @@ -330,6 +331,7 @@ static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
>  static int tpm_tis_i2c_probe(struct i2c_client *dev)
>  {
>  	struct tpm_tis_i2c_phy *phy;
> +	struct reset_control *reset;
>  	const u8 crc_enable = 1;
>  	const u8 locality = 0;
>  	int ret;
> @@ -346,6 +348,16 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
>  	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
>  	phy->i2c_client = dev;
>  
> +	reset = devm_reset_control_get_optional_exclusive(&dev->dev, NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(&dev->dev, PTR_ERR(reset),
> +				     "failed to get reset control\n");
> +
> +	ret = reset_control_deassert(reset);
> +	if (ret)
> +		return dev_err_probe(&dev->dev, ret,
> +				     "failed to deassert reset\n");
> +
>  	/* must precede all communication with the tpm */
>  	ret = tpm_tis_i2c_init_guard_time(phy);
>  	if (ret)
> -- 
> 2.47.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
