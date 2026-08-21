Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333A313E31;
	Fri, 21 Aug 2026 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274755; cv=none; b=Ce73K8iZkpSEjysYgKgJAsdc0bWy6UEnxV2FHuh1tiDQ1u2WoPwuBN8BdnxRTv2odvTzre34g5Mg7CbW8vAZkVXyDTRreLz+7kYD75ZWzZi+rvs6WIJKCSnDeXVnOddmU6BuK+ng+h9Y0Le3ZaL283qGxLsq4rMmiaNUMZD5nEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274755; c=relaxed/simple;
	bh=HndPdJNsV2EzpFdQPGWhdN7/G9OEntM/Bj1iWidshR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlobGmP9VWY/YfvLuDJNsYygaDh+cFs2NxBGUXaE/HAhRsCFfZQdqBS4E3cxneRRwFQZxdQQVbQPOUBbGtdS73IYjQ1IFBPYXkqUrDY+084FZhhrLQm65EjZdg18LJH35dF9Pv8afZwSrflMZlkn7rMv9o7jwQPWtkRAZWaV21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgqqQJ9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgqqQJ9g"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 28E701F000E9;
	Fri, 21 Aug 2026 01:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787274752;
	bh=aCXnL2XLs32f7/g4C4aQzxdoXLJDyRETKh7aXZ9MJoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kgqqQJ9ggmqvgWq9utwDOo66PFsrHqzOKfcsClQr8XuKOXlkxN6cGmeOlgtPsr/pB
	 zjBeOisH4YwWVaBi5Oahh81d2B+zOVD+ICn4DVwrpJmmMa/q+DD05BkkTDkFlR3ase
	 fuBws9wMlYCylZYTAOL+UqpzUF2tWlksZuuKyhXcxmTv90mlAdsmpEAu/AAyKZwDZo
	 7iUFXY6fqzAFSEu+1m37DeAaat49LTIwaWbWWP4FIfDVulIQIrAx3rv9DHfHokZItH
	 TCY+73ZuuodPsKVCddOx+oBHU8X2B/2t7YuB33OiUEh2y2y+pXNHRkDZKYwZblXQGO
	 mcuYtRH/nkKMg==
Date: Fri, 21 Aug 2026 04:12:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: st33zp24: Validate locality read result
Message-ID: <aoel_e5R2AP8ocOI@kernel.org>
References: <20260813153032.3951878-1-ruoyuw560@gmail.com>
 <20260813153032.3951878-2-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153032.3951878-2-ruoyuw560@gmail.com>

On Thu, Aug 13, 2026 at 11:30:32PM +0800, Ruoyu Wang wrote:
> check_locality() treats every nonzero transport return as success. SPI
> errors remain negative, while the I2C path can convert a negative write
> error through its byte-sized status variable. Either result is nonzero
> even though the TPM_ACCESS byte can remain unwritten, so indeterminate
> ACTIVE_LOCALITY and VALID bits can falsely report an active locality.
> 
> Require recv() to return exactly the requested byte before examining
> TPM_ACCESS. Transport errors and short reads now report an inactive
> locality, while successful reads retain the existing behavior.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: 251a7b08213a ("TPM: STMicroelectronics ST33 I2C KERNEL 3.x")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index 898e8d01d26698..0e2deff94c3672 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -106,10 +106,10 @@ static bool check_locality(struct tpm_chip *chip)
>  {
>  	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
>  	u8 data;
> -	u8 status;
> +	int status;
>  
>  	status = tpm_dev->ops->recv(tpm_dev->phy_id, TPM_ACCESS, &data, 1);
> -	if (status && (data &
> +	if (status == 1 && (data &
>  		(TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
>  		(TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID))
>  		return true;
> -- 
> 2.51.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
