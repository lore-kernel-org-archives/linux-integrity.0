Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884662D0C94;
	Mon,  5 Oct 2026 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171839; cv=pass; b=OhKpspen+4l4rh6PIKyyv+uDHAYVo79EuDj5N7aDkRbYAz+IWDR98MeXvZn1JT1Ns97PxwQ2X1738F/IsHw7J5jYN1y7XGRATutgqAj9VgPRcHgRsiUe6g/pbCxNnQ8BsfEKLuKbjEICC40pYIdpSx7UsebdFN2CYQ+H1b9ZkoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171839; c=relaxed/simple;
	bh=k7YvKVJsnBBQEAxVmacVSqqxzq1klOqOwW96xWD9u+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO/K/jOE7zSCrP/FPtPI3TJbkUo0H/kaAJKFJ/OeycojU+BnHXyesjHqrOFVeeAfvtx0QuG+OFmrYRMcoC0paPN92rnnX8wFGG/OCB2lHJjg7in3t6oKuzup6XrSq2XYDcCCbeSl9BqTEFrsUeXJ6IodJwVbkuBdvWtY0UXiqWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dZA8uiEc; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dZA8uiEc"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hylcC01z7zyTf;
	Mon, 05 Oct 2026 06:43:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791171835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OW7c7aek1okA3uNdqyL455/oc736NnOHbUHGLvz1FM=;
	b=dZA8uiEcKn5Yq65YMe3jcmImPyaDedwEXuWD5IViAtpt/qAv112tXIdhdfMHJNI6ep5Nh2
	k466QCqLCH8AJwSIUHt5LQs3RjlXlOMckKKy9vQLIAlsjXJZnFCVjUBm4k1XBRI73nxhoX
	4jQfkEvafnJsJXMWOLkB7E7XeBIIzEk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791171835;
	b=BCAGmyFAwkJ+gfsPa0Bqy4TejaCMW8R/QhxVy00cziNtGy810e5DFHvJOWXPoCERmnN0Cs
	ol4XlOtEMq1+dMVKGA2AH87Mqa+VpIjIUhWFs07lJVd5WhqD0vtQdlqrM5WZAhgQXr3hv4
	z2rDh3VskrdPFSjfpPWOG0iZv1APly0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791171835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OW7c7aek1okA3uNdqyL455/oc736NnOHbUHGLvz1FM=;
	b=B0acy2kspeZO53rMPy2VatxfntCfJ/jn4QrMpvMeodZpxolQOFXU6s8Cg1BB8dR2qlWPYJ
	3UdrCdlLbc94IJvjMCXWGPoNSZv/pC8XP4I0eMJkyEe2j0pkB2Q4T4TkFTPH/IzmUUMaTR
	jnVuHt9tbxbIaJvvQaJxCkxO1d961qk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 06:43:52 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Dan Carpenter <error27@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm: clean up error checking in setup_ring()
Message-ID: <asMc-PweDb2x3nk1@iki.fi>
References: <ar_DUjuGv-9vPzga@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar_DUjuGv-9vPzga@stanley.mountain>

On Fri, Oct 02, 2026 at 05:44:34PM +0300, Dan Carpenter wrote:
> The bind_evtchn_to_irqhandler() function can never return 0.
> Historically, IRQ functions used to return zero on error, but then we
> added an architecture where that was a valid IRQ so it went from being
> an error to being success (but in a limitted way, just enough for that
> arch to boot, I guess).  Eventually we removed it and we will never
> allow zero to be a valid IRQ again.
> 
> The problem here is that if zero were an invalid IRQ then we should
> return a negative error code but the code returns zero/success.
> 
> Change the code to check for negative error codes so it's not question
> of how the zero should be handled.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> From static analysis.  Untested.
> 
>  drivers/char/tpm/xen-tpmfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 3c0cce57c4ae..731444eac5f2 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -266,7 +266,7 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
>  
>  	rv = bind_evtchn_to_irqhandler(priv->evtchn, tpmif_interrupt, 0,
>  				       "tpmif", priv);
> -	if (rv <= 0) {
> +	if (rv < 0) {
>  		xenbus_dev_fatal(dev, rv, "allocating TPM irq");
>  		return rv;
>  	}
> -- 
> 2.53.0
> 

Sorry if responded to this already. Mutt shows this responded but
cannot find it from lore.

Anyway,


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
