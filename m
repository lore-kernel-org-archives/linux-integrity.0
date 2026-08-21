Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B51AF0BB;
	Fri, 21 Aug 2026 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274470; cv=none; b=SPtGDHfMrBkvEMaYlclvSf/CfLftXYvKEwWL6bTMhE4Bh2wJyi8q7QPcFjx10xcLzKa86zbQHrBsNBnc9cuBr8LD9lvWtr5oot0JvH39mWmTQXKqrLeOIjKV4zGr2asPOqPbqzayEvS1YIoBAWILnyIlN19Japi1+sG91vrHe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274470; c=relaxed/simple;
	bh=Qe/hLCLYVsNekNUW0rTbmhzhv2y6kmoRK6z3G/vnB+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuW87M+V6lNRTZVp9yWSlAU/OyvnMUTDTp/E/R79Tz5FLjSrwWP5T5TMGrEWIJU0JQuTJDTpugXmjZIfVPa+5CJaFPdrHeTPb7mrmj3qt/sIWkzFlXlhlU9QdgmlSdfdr0CsFnCfHAVx6LbUZv44ibDI/gOKRoXaRjSxG9cmNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaZGx4Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaZGx4Et"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D05D61F000E9;
	Fri, 21 Aug 2026 01:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274469;
	bh=5ixlCRupb3RSD4KscFNJPtgLQAVPkqF4+DHdRz/PTYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SaZGx4EtkcsZjVuMIFbZiVSPKvMCPdR4un73a5Zj2uR5GD3bG/gp4C7FjxUSGt1u3
	 Hm419rV4V8lIrmsa3sxpT5olQPDBLDOvFv9Dn3cWW5GRITjYdlVOcn25+3v3BrWTLA
	 XU6tY3rNzSrHftimVZjyhd2gLPY9/QQ5bTBkbXk1ahWd9KvPc19s++/1T1WhfKHOH4
	 tcV8uEdWsdub3Loynlsusg7AnQT7Xn7sLMUXBiknQHLqPD1L2/vibYM2yIR+gQBEdx
	 KfeWZ36UkqPPAbyHZwv7eoSncJG9z0W/V4YmpH5HxXtjAVh8iNLT97bBMlNOP8MoXY
	 SRvuG0mrPnXWw==
Date: Fri, 21 Aug 2026 04:07:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: st33zp24: Return zero on status read failure
Message-ID: <aoek4RzTzKQeswUd@kernel.org>
References: <20260813153032.3951878-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153032.3951878-1-ruoyuw560@gmail.com>

On Thu, Aug 13, 2026 at 11:30:31PM +0800, Ruoyu Wang wrote:
> st33zp24_status() ignores the result of the transport read and returns
> data even when no byte was received. The I2C transport, for example,
> skips i2c_master_recv() when the register-select write is short or fails,
> leaving data uninitialized. The resulting stack value can be interpreted
> as TPM_STS flags and let status checks complete spuriously.
> 
> The status callback cannot propagate a transport error. Return zero
> unless recv() reports exactly one byte. With no status bits set, callers
> retry or take their existing timeout or error path instead of acting on
> an invalid status value.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: 251a7b08213a ("TPM: STMicroelectronics ST33 I2C KERNEL 3.x")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/char/tpm/st33zp24/st33zp24.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index e2b7451ea7ccd3..898e8d01d26698 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -93,7 +93,9 @@ static u8 st33zp24_status(struct tpm_chip *chip)
>  	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
>  	u8 data;
>  
> -	tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS, &data, 1);
> +	if (tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS, &data, 1) != 1)
> +		return 0;
> +
>  	return data;
>  }
>  
> -- 
> 2.51.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

thanks

BR, Jarkko
