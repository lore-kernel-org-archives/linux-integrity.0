Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53C78F2B;
	Sat,  9 May 2026 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353374; cv=none; b=iZM78Lq6hVUXGeFEIKDS/qntvi/xodFM2eIQAflnUO5hCxUhsN11hJb1zGjb+MprIQv2rWJ9/HT9K3O6GH6BVc33KSF7gqsN/Dm72dkddIkNwV2Nqqy47g9CNNIhgIyEGzZwcWtKuT252Z/dogNmXSMmiKlV9tOGw5EJLC8mVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353374; c=relaxed/simple;
	bh=3L5MGmAY4K7yVhPbWt+iykzQHgmJT3cO9wISvo86ih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw353/89wgBzWbF5HntfqW2P61EUBSLQuQN31OKUBz+y9U7dsjDZ4o8PwVYCv+3RrmqwxiBuHj3nVsr0Fsf2AkHP53K8rJYaz+uB+7LLkj+IZmpA7/sgsqgcMiRdcBBysyACZ1dJO0WHPMj2j+WfWx1UpGO+COgJ7kf7/ZsmM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F929bkZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F929bkZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72693C2BCB2;
	Sat,  9 May 2026 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778353373;
	bh=3L5MGmAY4K7yVhPbWt+iykzQHgmJT3cO9wISvo86ih0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F929bkZj/KQNErTx2YN8zFhEeb92XpjTpU9o0yk/8bxuz5oz859uh0hMoHNaE/Mqs
	 Hs6seTCZRIe8xbqEhKM7pcI/fsB43G3vuFdTb8kdcqM47887xJckIuc88qPfaf/+KJ
	 RbDAxsrjnsIycMCHNUvx1DJLjz+/r6zC+C2oSBXGa0j5fFm5F3W4So5EDpy9j8dWrN
	 uw4lQCd0qS2Rg2JLhZZ1kdmEgNjTSf+UrpME2bU6Nx5uGpu+Ai7fdIO7v4olPkJJvq
	 6tOKU+jL+EAUaswsMiGAnASh4QOBE9Qj7y3VzAIQJ5rwmSGO8obvhjf1f0n0oIfRPv
	 QFKvw3XZGrHyQ==
Date: Sat, 9 May 2026 22:02:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Windsor <dwindsor@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: svsm: constify tpm_chip_ops
Message-ID: <af-E2d_jlowRk0ta@kernel.org>
References: <20260505202738.145800-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505202738.145800-1-dwindsor@gmail.com>

On Tue, May 05, 2026 at 04:27:38PM -0400, David Windsor wrote:
> Constify the SVSM vTPM ops. It is statically initialized and never
> written to, so let's store it in .rodata.
> 
> Every other tpm_class_ops instance in drivers/char/tpm/ is already
> const.
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  drivers/char/tpm/tpm_svsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> index f5ba0f64850b..b74d60f687d5 100644
> --- a/drivers/char/tpm/tpm_svsm.c
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -49,7 +49,7 @@ static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
>  }
>  
> -static struct tpm_class_ops tpm_chip_ops = {
> +static const struct tpm_class_ops tpm_chip_ops = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
>  	.send = tpm_svsm_send,
>  };
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.53.0
> 

Thanks, applied.

BR, Jarkko
