Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4079181334;
	Fri,  2 Oct 2026 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983896; cv=none; b=Qx+QSSSRzM2yKwIE/FCoeD9QTi4GEC7ftonj5YSl0xojpThEQDoHWu25A8ftceesNEeu2+H8Io0+4D9sN3qItjIkKF0cmkWQDgZvLA6AhZZp98DmYw9Kyzt49PLMQm9OfTGMl9ky52sTgdP/n+sz5AmMDxQaoXbZkZN4gjnjbS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983896; c=relaxed/simple;
	bh=eAbusuodcyhTP4rVYnOSif1IQzsA7CSgMULjexslPM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+k0WhmkrQeO4oIGohkX92vot43bcWCy0/2Z8sFV420S72rXD102tumFOcY6Csbn33fVmQckvlJeyQwFf5ojkJT0sDvp1AXiYSaISF35CmhPVske0TxmWMEmPbO9YQSOinTUK0emBlCdZXqLv+SiSVBoX+9lsQhEB3mqpYUv2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXowBgmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXowBgmg"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 14BE21F000FF;
	Fri,  2 Oct 2026 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790983895;
	bh=tq68ouErOQEUpBuo9XIbgiAt1DmuxKiHs9qdkr0PMy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lXowBgmgV9dMMxjjhzR/a70qlUP6OT4mIb7/4uxLqCkk1kQ2dLDN2cLhHVbPSpnsN
	 4gS5qMhPRg0fzSliDwH+QKuaRKIuiaz7HAr00kDvIQOf44+/rVVJFSFw89Wjzapr5o
	 4Di5b9OWE9v82DLmYZ3YAqTyLkC+nl78hVdGEmuvqPkY9O0nYma/2qBNIKyqbmdy2T
	 7jyIyETc6X5tnktUFnN+hcf6pXPQvSP8HNe9T2qVOgVdAy+gBymW6gfErsjnZ29fB1
	 8WwBAioYU8wbNRrBB6OD/bsHPQoL5cfWx8Ujb+Ib7TMUVtjaubObJRWMSefPAqdXKI
	 8QDa+erutBTTw==
Date: Sat, 3 Oct 2026 02:31:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm: clean up error checking in setup_ring()
Message-ID: <asA-08_MhyYKIvjH@kernel.org>
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

Looks good to me. Isn't this a bug by definition? 

Br, Jarkko
