Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737ADF6C;
	Mon,  5 Oct 2026 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173824; cv=pass; b=bWjmzKUXCTylrG1874dYOevUyDfeRd/WYDUeo8TACSFXp5U+3GQlYPbupLSXVOgmsJGAj79L5BSloygRJ9LsoRlazh3iEORJ2On1sSlbhPKCHVXpI/W1rmPYUtUyW0QwJW0vrt6X0F7QOlQDrrayXgr8UlhBb/RlUSciWGOsqo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173824; c=relaxed/simple;
	bh=P+8MOYvcCg8+bSlHZFLfWgIQ14M+c/npPc8UMrGr7pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONpk1A/fI9lodJC6GQgxKD9eZ2tlMk10thGameTXDvW283T+FN6t9jBjL0W2qOZDjc5pnODY5FSU9tB8XK9+arO1/PdSQdUtNnJXdXpyjkYdHXMQxsZd7aZOidYp9PenqS0Qq+PuZuq2YD3GDGPp8QjsWgh2KpJ4vyNb9K+3Ybo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vE8Did+y; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vE8Did+y"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hymLM0ZcWzyTf;
	Mon, 05 Oct 2026 07:16:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791173819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRA0Fp1H+/1ySxA+sOiUOp+kF2dGKTeCnRsbRa/hwjI=;
	b=vE8Did+y7EdMipthP1xAKXeofLLfgBcBC+Mh4C3A1afPe6P7VjS0EoSRHdK0DbjQv3HhKq
	iCjr7GYtUGKu+cMchxJg/agFXyjBvq+0mQJsZoLc85VgjtQfmK/lG6gfMokacn+AF9ay2g
	Jtfl1DWtHlcTQJv9HRGUxeoQC/2bTOI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791173819;
	b=qaUBlu2+ar53Gd3jDYWzKvcT0Vh7i8xr1Ruf1QIVNDf+amT5Os8gfs3macb+dsIIkxSoSo
	JFdjiXy1J3jrXiZV1yGomWNUjWQrlb9kE5mCUp+oJCf8wBn26kD4RGyXMjcy+F0dYNXKn1
	xbfRXSX6YzGip4kMUx/Kx+bpaIg4IU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791173819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRA0Fp1H+/1ySxA+sOiUOp+kF2dGKTeCnRsbRa/hwjI=;
	b=lMygOYxWqLsYilZCP+uf/oKv4NrPBDni6QDM67F+aCl2lW5LhJzvCW+blPL67gcIbJWBIk
	VluMSqPdXCYR6risb2xbBPbAZw5difyS2EwnDkAPj0CpsBXRHjGUUc0/pmo5R246S8vC3d
	h82LcXnn9Rms1C9YBr32DYAyuUwyj5I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 07:16:57 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tpm: tpm_ppi: fix wrong error code returned to user
 space
Message-ID: <asMkuS55pG_q8RsT@iki.fi>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <16ff8f5a35246d5932068ce1b01438bc2895a46a.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ff8f5a35246d5932068ce1b01438bc2895a46a.1791015549.git.xiaopei01@kylinos.cn>

On Sat, Oct 03, 2026 at 04:27:51PM +0800, Pei Xiao wrote:
> tpm_show_ppi_response() stores its return value in an acpi_status,
> a typedef of u32.  Both error paths of the function (-EINVAL on a
> malformed _DSM package, -EFAULT on a non-zero operation return
> code) end up as huge positive values when returned as ssize_t, so
> user space cannot detect the failure with the usual "ret < 0"
> check.

I have no idea what you mean by huge value and why that would be
a problem, and overall this is disconnected from the code change.

Two's complement value is correctly stored in status up until the
ssize_t cast, which results the value to be zero-extended, and
as a result corrupt the negative values.

> 
> Declare the variable as ssize_t to match the show callback's
> return type.
> 
> Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
> Assisted-by: GLM-5.3
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_ppi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index c9793a3d986d..949fb7055bea 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -234,7 +234,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
>  {
> -	acpi_status status = -EINVAL;
> +	ssize_t status = -EINVAL;
>  	union acpi_object *obj, *ret_obj;
>  	u64 req, res;
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> -- 
> 2.25.1
> 

Br, Jarkko
