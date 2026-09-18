Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D23612F8;
	Fri, 18 Sep 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693072; cv=none; b=sUk8dgKU35PVuSoO4Tm3/gD1UjTfGQ7RvFy3++QyLVL96GQSAFqqQASBvSIzhM1ArNF1TIfulFnPegAvqfnW9k7825DutadVnTPlN7IOMR2F2roibuy67AZYL072PPOTVvbTfeifuy2pOIhlPzGfE2xQjofDhifrF5D/X2hNosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693072; c=relaxed/simple;
	bh=5ZQ/rIS22LUyfJdNJToyqw2Qn+up+Z7AaZnviWvtPf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOZqK+g7WG8No2O1tvHExnkLkgk1pECDTzKxcZTzcKXFaIJddd398DcxBljxbX3XqudABsW9W3cUKalojVLAQ9RpnzQf6qOUzjPt6gQhxHqgScjmgYW/dNoM5Z0/cQkrDpcl82U1T+RE9U473nJH7TYTe7XuIEOf8JtXHYH6gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLiOGAyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLiOGAyV"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6B3841F000FF;
	Fri, 18 Sep 2026 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693068;
	bh=zztJ635oLO6fTId0v5/DAx5Fb814zVq7QSUStl4q4hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lLiOGAyVoC4hhza1eP0sbWBSbkRl+/+bE14xIwb5b36n3AUeHL7gAQWO5mxw7gzP2
	 ukTS82G0sz4XdezExT1XAEI6uZWIvog9EYjdEIosNQZcFwOsIxvkPszJAwl7Dw0lWQ
	 ebDbtSrYjXai9BwX8QahTzfxvgO07dFpSHfvxW8VGvlczNv/Gle3Q9RBODwotJPIFT
	 BWKX5RUIvRAEi7jtYB/71+h9YZInU9yHIqgHrUipLTrPD7BWfPYEoe8iIwRCo0A+TK
	 Qvkw/LjcyR/Qi7ANROWJ+2djWWuuHGLQ9G5+iz2duHVrOqosaUPxYZPpQXyQDQ2wBB
	 KuyZRR6MB51Fw==
Date: Fri, 18 Sep 2026 03:57:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Li Jun <lijun01@kylinos.cn>,
	Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jim Broadus <jbroadus@gmail.com>,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix build regression for tpm_tis_resume
Message-ID: <aqyMiLECnrzfGdwQ@kernel.org>
References: <20260915201239.3529332-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915201239.3529332-1-arnd@kernel.org>

On Tue, Sep 15, 2026 at 10:12:29PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using DEFINE_SIMPLE_DEV_PM_OPS means that there is no a code reference
> to the unused tpm_tis_resume, but that fails here since the declaration
> is hidden:
> 
> drivers/char/tpm/tpm_tis_i2c.c:322:61: error: 'tpm_tis_resume' undeclared here (not in a function); did you mean 'tpm_tis_remove'?
>   322 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>       |                                                             ^~~~~~~~~~~~~~
> 
> Remove the incorrect #ifdef.
> 
> Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/tpm/tpm_tis_core.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index d737b3d67411..741130056876 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -161,8 +161,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		      const struct tpm_tis_phy_ops *phy_ops,
>  		      acpi_handle acpi_dev_handle);
>  
> -#ifdef CONFIG_PM_SLEEP
>  int tpm_tis_resume(struct device *dev);
> -#endif
>  
>  #endif
> -- 
> 2.53.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
