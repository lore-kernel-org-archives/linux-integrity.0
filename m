Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3C54654
	for <linux-integrity@vger.kernel.org>; Mon, 23 Mar 2026 05:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244197; cv=none; b=tGjLeuy5FEfpZpVeNIC4ua/Y3qWW2l3I4Hg2+7U+p4rMSUfi4KZEptaBMIu8/8qcCL1ogfIR/NgF4ucCLvY6H6vhtI4+7gFE8FoKd649aXdJPyFA7/oZGk9mgqAmzgL8QSOqHOKHL4jX5GsLDp1E5UlJghrfEnDto2hqLsPstlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244197; c=relaxed/simple;
	bh=GsRGi4dMfvFm2OogfnAIHrjF/ce9nsNU4hi56amasJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+XdsQnyqyo4WLKHnvpa3dP4mBcI2UrqLh6aLvD1YigUonXJHdLcn71q3X/PGCcKNgIJnx1N3TUGZF8U0i3XdUYvajegnJXLk1J35lqG8+8KDixtkatwOCZlRvm0QyPoSGZPmOSGdhvvgBRfghKg1zcrb0ejYm8Nt646uT/NmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvQqDBa3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvQqDBa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506D6C4CEF7;
	Mon, 23 Mar 2026 05:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244196;
	bh=GsRGi4dMfvFm2OogfnAIHrjF/ce9nsNU4hi56amasJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvQqDBa3lv/JTxzS79/N6rZR3nTVoeGemxw1+rbLH7Y+3NARcyYpup1xLwWHiFfcw
	 4PIUEw0K4oQCtQEhNT/RmQPRi2aHW/Z0MkIKIvGBniG1G4rev75HMd+KL+pb4J/MNu
	 Wzo9htba473mMIOhXcGLZzhdz52SbgMkEjfSWuwB5iXbBNgT9ZUKCgzT3TMXygVLuJ
	 fJttfekAy5zpBYLZ2xOhvMkKZmXbCxXzjg1MW2PbEjEitos3c0myzHocyihWo2rYzo
	 QCYoHv4+sT4u6Co4NOQT2gpLy6CZs3K91weCkImpg9USyvPK0TO6nyjIu08NwQNwO0
	 WCCHU6Fx0Msbg==
Date: Mon, 23 Mar 2026 07:36:32 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: fix tpm disabling if NULL name changes
Message-ID: <acDRYGH37TzlT23b@kernel.org>
References: <e12b2c091d85ae6bb1f54133c7d4727770f1ee9f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12b2c091d85ae6bb1f54133c7d4727770f1ee9f.camel@HansenPartnership.com>

On Fri, Mar 13, 2026 at 10:31:03AM -0400, James Bottomley wrote:
> There's a logic error in the earlier fix which means that if the NULL
> name comparison fails, the tpm isn't disabled because rc remains zero.
> Fix this by setting it to an error.
> 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: cc7d8594342a ("tpm: Rollback tpm2_load_null()")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
> 
> I didn't actually discover this problem until I was trying to do a
> reset attack demo with an updated kernel.
> 
>  drivers/char/tpm/tpm2-sessions.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-
> sessions.c
> index 3b1cf1ca0420..bd1c0456e775 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -961,6 +961,7 @@ static int tpm2_load_null(struct tpm_chip *chip,
> u32 *null_key)
>  	/* Deduce from the name change TPM interference: */
>  	dev_err(&chip->dev, "null key integrity check failed\n");
>  	tpm2_flush_context(chip, tmp_null_key);
> +	rc = -ENODEV;
>  
>  err:
>  	if (rc) {
> -- 
> 2.51.0
> 
> 

Possible to resend (fake ancestor)?

Other than that,

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
