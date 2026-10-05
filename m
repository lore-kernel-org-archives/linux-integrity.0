Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA022126C;
	Mon,  5 Oct 2026 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171967; cv=pass; b=IF+IJNK/rbpdjKbTfN1JzW8VfOSK1Bt7nlFltAqgaaBoKUlm+GwFldtkGGgLweHxsSPrBIe+LzOqixtTvt643P5tY77aXkDlfi+hntx8T7U0/YPi3hq8xsPYIlQbE6X0/9knssX8g6iiMi/5sbTJtJR2JPDq5DFNIgcRkjFGG2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171967; c=relaxed/simple;
	bh=cKi8qK0zvVbKP2WaWKOcDCHtEIe1+puVoZAfYpGO1BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZPMqLS0fjTnad5jYWbxTSkeK9ph6SjPzu6sjQ4JfsRPy4BJ5/DbQylSATN2ednWBr9Rc6sjH/pmuHXzNQyvDJ9AhFtSUnKlMPVmvXAn8S4yLcSyBU4grg0+fpX19T7IeP4dxI+84vBV3iatS0Cvczd5ATwK1LKi/ABqMWhpK3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gn29iYzd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gn29iYzd"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hylfh20c0zyTf;
	Mon, 05 Oct 2026 06:46:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791171964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a+Tj8ZkSotIruqlc/O41xvCLYYPHc1i1+XofHzlASI=;
	b=gn29iYzdTn6tG5KMY8rXEpLKNNBFVeCGkhRCys5Z7cSICjm5VkpKF0iwU0mmP7on5T18cH
	r53g93LjVLzFPsORvoryJRnjEjWS+Jd3tEgXRkGV1tS/Gkyh8uUkR9lx51lnqzm+sxnERm
	8LG7dx3fqxp2uSjErBrBNa78oCIUGhQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791171964;
	b=M0rclKg/6xvffOdFfZzyRmlI7L+5fjThb9xB9DXHaYw0ha7cFut2P9PEZSLQK49n5UrJsM
	uThZo156weUAwr/u5rixmEhiTHCxCzvsMPPrfgHRwipB0CM1/L33lCqbCsfulNQ7Tsrzpq
	cpSAPf64909eTGL3iTW9Bmt5u92ViPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791171964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a+Tj8ZkSotIruqlc/O41xvCLYYPHc1i1+XofHzlASI=;
	b=unFliTuuAsHoYzOBluLXPlzRmH684ySa+541Vy0SksBqDBJP1fqck5RRQCYfaylTu5Rt7M
	25jFI41296inPcznDrbmIGxp+TpzMmrk437zNuINvkaelKNy4jJNDXERSpsAfPYAEUEYEm
	q7joddm9NhzRv18KaNI/cFFWN/BrhaU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 06:46:02 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tpm: fix log messages in tpm_init()
Message-ID: <asMdetm05nGIBbyn@iki.fi>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <de8bafc78e84dc6abc6f11e8eaa1b91c17e0c368.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8bafc78e84dc6abc6f11e8eaa1b91c17e0c368.1791015549.git.xiaopei01@kylinos.cn>

On Sat, Oct 03, 2026 at 04:27:55PM +0800, Pei Xiao wrote:
> Make the error messages consistently prefixed with "tpm: ", and fix
> the tpm_dev_common_init() failure message which was wrongly copied
> from the previous step.
> 
> Assisted-by: GLM-5.3
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm-interface.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1ccdbde98b69..666a1c654c02 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -524,13 +524,13 @@ static int __init tpm_init(void)
>  
>  	rc = class_register(&tpm_class);
>  	if (rc) {
> -		pr_err("couldn't create tpm class\n");
> +		pr_err("tpm: couldn't create tpm class\n");
>  		return rc;
>  	}
>  
>  	rc = class_register(&tpmrm_class);
>  	if (rc) {
> -		pr_err("couldn't create tpmrm class\n");
> +		pr_err("tpm: couldn't create tpmrm class\n");
>  		goto out_destroy_tpm_class;
>  	}
>  
> @@ -542,7 +542,7 @@ static int __init tpm_init(void)
>  
>  	rc = tpm_dev_common_init();
>  	if (rc) {
> -		pr_err("tpm: failed to allocate char dev region\n");
> +		pr_err("tpm: failed to allocate TPM workqueue\n");
>  		goto out_unreg_chrdev;
>  	}
>  
> -- 
> 2.25.1
> 

I NAK this one. It is not fixing anything.

Br, Jarkko



