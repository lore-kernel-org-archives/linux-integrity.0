Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4E1DFFB;
	Mon,  5 Oct 2026 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173913; cv=pass; b=IDPsLPZKRpzLlCOOg98fTrAJa1d5qObY5Lezge9ClufI7VD4nM1U+3HdWQ+eSvKm0U2mbCOEAvohYCv125A9mzfv/WoTGifFcEx3TMg58NaEkyvi2TFj7rRpjvIzJjt5hH9eVpizxzcGAkcSXt/ZCPFUn20ziwpqvrAj3K4kDds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173913; c=relaxed/simple;
	bh=82vYIoNbZ4IvoCbAwoaptGVzXgk2V8GlSvyak0NLMIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvnpAHH297txiih6FR0ybBmF806d3ZtAzm6HValJAELcwKw9Rtz2gr+ekEKbjICVLppzcz53CcFnZNBk3rgB4xtp2pDkegjfIweU4BYr5plgGmZUgGxjZ8pBELpRE/PjMPs3aDJOMaiXdciZNEyfp83LGukIfn2w4AqxbU+cOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=amfcurJv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="amfcurJv"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hymN56pVJzyTf;
	Mon, 05 Oct 2026 07:18:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791173910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdvT07Xbi9LY/W/pvEARkOuQZZHrn1VxWmBv2DsKlsQ=;
	b=amfcurJvE+Xw9qpMP6C0Mlq5BZzHN0pAhVpvQ9ZwhkyMkx0mMJ63ZFXGMEt8M/DyEkZoco
	Vb9tT/qdHCbLJlPbYzWoUH95fa367xg3DSLg63BXAH4Ih3V4g58H049olYv+E1kYuBnfTX
	edP9UrRXGWPa9MO14ENugqQBwyCjYzc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791173910;
	b=LuxUiAvbfsylt/eZq7KM7OJYYK1Z6Q/SZouBBo63HhCf6uJmGr7SfuPDS5oFR6pVZj/Brb
	2SXEuUkH4FcnA933LsRqfG160pMSCFXTAneNqWG4vPENB9CyVmcRlcWp2/8e3VZInSJhmd
	zRKR5gOeOfI3MXp6g1JmplRGrSwl67s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791173910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdvT07Xbi9LY/W/pvEARkOuQZZHrn1VxWmBv2DsKlsQ=;
	b=lzEeGm+a+KmdTMDtixKSXz8p0740ArOpLTi4S3TTwg9d4Xy4KbLgIjeuWgMP/YND/J/G4Z
	BnKSTYptYdA3uSTs/tBOyMCaEYyHIYXeOSBFVU26ok+r2LOdP9zJkbESDycHMnm9ylRulk
	YmkmHi2iBqU4ozUJ7aU3pcSyGGz3M4c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 07:18:28 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tpm: tpm_nsc: fix NULL pointer dereference on init
 failure
Message-ID: <asMlFHPxPuR7IlXL@iki.fi>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <d5f0b38d6d6c17c01519c879d26448dbae388b0e.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f0b38d6d6c17c01519c879d26448dbae388b0e.1791015549.git.xiaopei01@kylinos.cn>

On Sat, Oct 03, 2026 at 04:27:52PM +0800, Pei Xiao wrote:
> tpm_nsc_remove() is used as the release callback of the hand-created
> platform device and dereferences the chip drvdata unconditionally.
> If init fails before tpmm_chip_alloc() (e.g. request_region() cannot
> claim the ports), the error path drops the last device reference and
> the release callback runs with chip == NULL, crashing module init.
> 
> Return early when the chip has not been created yet.
> 
> Fixes: afb5abc262e9 ("tpm: two-phase chip management functions")
> Assisted-by: GLM-5.3
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_nsc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
> index 879ac88f5783..46a52dc99b14 100644
> --- a/drivers/char/tpm/tpm_nsc.c
> +++ b/drivers/char/tpm/tpm_nsc.c
> @@ -259,7 +259,12 @@ static struct platform_device *pdev = NULL;
>  static void tpm_nsc_remove(struct device *dev)
>  {
>  	struct tpm_chip *chip = dev_get_drvdata(dev);
> -	struct tpm_nsc_priv *priv = dev_get_drvdata(&chip->dev);
> +	struct tpm_nsc_priv *priv;
> +
> +	if (!chip)
> +		return;
> +
> +	priv = dev_get_drvdata(&chip->dev);
>  
>  	tpm_chip_unregister(chip);
>  	release_region(priv->base, 2);
> -- 
> 2.25.1
> 

I can apply this, thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
