Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3F2931D2;
	Mon,  5 Oct 2026 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173994; cv=pass; b=ULb/2MJgwLr65SbijsFeTMLI/3QztVSnKryJpn3wgWjIaXoFyjMEwg6Dfbl0IDDqHqoscilECYiEOWgfAUTd/ZYoTSN5MRcpHnK+DlOUA2HMk4OXTnKmvJbVGxmj1Fz0vJOr+UtzbiwCfpQK8EcV4fDxIzKnN/D72Q+jYimYjBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173994; c=relaxed/simple;
	bh=NYbntC7ghfyGjk5NqdI6csreb2zS7l36kn44jBQaKd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef45w+lhW+SYDyj9SDn1+uQFblkq0UKmdaM0z9y0QI+cRkm/Gmg+jW+9PoOuXUBQSDXLSFjwxuHCMtQRZ9x0gz4qPnEkfSEJ2zqheg+XEM2sPbfuuA09J8yhcAm8jTGOlM0OkilAoV24LpdK8Todj6Ea/QiNoYHa5CFTZ7V4lpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=J7xbmKEb; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="J7xbmKEb"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hymPf5r4qzyPr;
	Mon, 05 Oct 2026 07:19:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791173990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSigDsQd4p17seU09AsvORzHXste2S9b00XNFovq5NI=;
	b=J7xbmKEb8QJ0pbijF/r10FRFDBvy0zVOBelozmDkjf0+WxUhY1z6KJ/qAPrX0mb4L6a6L0
	oS2Z+S8vmh4Nbg3e5kI4xidYrr/eR8fZ3FYMaK1zs/qGnHrVNycYZI76xzAucuDwytAY00
	YAGvt3Cj3Dmh6Vvc59f/Msl95gwhxRE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791173990;
	b=qfxNPBTRqFWd06ib7cDcqJ2K1nMCTcKzV/z5CHN64zLjlpfCCK2x0yhzDkL98y+0B1a4nA
	FUfb3yveykBHpwNWCpO3kWDEcmFj+h8vc7Lh/56Y8xrPmWCNq3WDAieERVg/dC0hy1SJiB
	/47G949pRmNvV3XqtQBo27EizX8ToY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791173990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSigDsQd4p17seU09AsvORzHXste2S9b00XNFovq5NI=;
	b=E0ws7TTKGN2HnmSbZakENyxVSej+4eEJqY41sJioS8OHP8TrQ1Myuncbojp9kZUN+wVBct
	1/efcDRjVHM8hd3V0ROInHlrDaw40l+Dcu6b5KaBMP+9VajkVKk4651rIAV0+gA+ajh+g2
	nG7A+ka5P9CA0p5LLmloOEPDCFDX1n4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 07:19:49 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] tpm: tpm_nsc: stop using the cleanup callback as
 dev.release
Message-ID: <asMlZYQFjDgCn6IE@iki.fi>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <a6155310e6772f708b47291cc959e02c05b90eb7.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6155310e6772f708b47291cc959e02c05b90eb7.1791015549.git.xiaopei01@kylinos.cn>

On Sat, Oct 03, 2026 at 04:27:53PM +0800, Pei Xiao wrote:
> tpm_nsc_remove() is called explicitly from cleanup_nsc() and also
> runs as the platform device release callback on the final
> platform_device_put(), so the cleanup executes twice on module
> exit; the second invocation operates on a chip that has already
> been freed by the devm cleanup, and the I/O region is released
> twice.
> 
> Overwriting the release callback installed by
> platform_device_alloc() also keeps platform_device_release() from
> running, leaking the platform object allocation.
> 
> Leave the default release callback in place; the explicit call in
> cleanup_nsc() remains the single cleanup point.
> 
> Fixes: 570302a31149 ("[PATCH] tpm: move nsc driver off pci_dev")
> Assisted-by: GLM-5.3
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm_nsc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
> index 46a52dc99b14..bcfa2a1a208a 100644
> --- a/drivers/char/tpm/tpm_nsc.c
> +++ b/drivers/char/tpm/tpm_nsc.c
> @@ -327,7 +327,6 @@ static int __init init_nsc(void)
>  
>  	pdev->num_resources = 0;
>  	pdev->dev.driver = &nsc_drv.driver;
> -	pdev->dev.release = tpm_nsc_remove;
>  
>  	if ((rc = platform_device_add(pdev)) < 0)
>  		goto err_put_dev;
> -- 
> 2.25.1
> 

This is fine too, thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
