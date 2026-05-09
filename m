Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4A23D2A4;
	Sat,  9 May 2026 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778326089; cv=none; b=dIwkORpRmne5+pe3An4H24x11bSwxDhQdi6yYPlp4CGyPrYAjfFimZd5DNumc8YY8nz6ZEh86q7EXpN9jxtE+dcaVVEP35EA5GpuyaqprcL+EvmEFyHsAkPfFUWjR/1WBhpFHOj2/1mmK3Zlg62YVFRHRUaruA+DM2F8RATA+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778326089; c=relaxed/simple;
	bh=jvyvfEdpWAp1SaDBw3/zHXckcaEbqIogZKzdz5mqfic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YovIVUHnYpNiG/EVGp3R60wrAlrx9+R742foEMRxpT0wIuQe7Z1rnoW+awZ1SpcGGVL7AJ65CyCJEvzuQrnL1NZE3qluB4CzegwqZynMpFJDgsdKAOQGGE9vkI0DQS8yL0G9snQ4fSGCmqgbi+WlT9MaijObsuxBclshOfe3p1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHdCgwP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHdCgwP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E2CC2BCB2;
	Sat,  9 May 2026 11:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778326088;
	bh=jvyvfEdpWAp1SaDBw3/zHXckcaEbqIogZKzdz5mqfic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHdCgwP93anw56yZRBqRXMvTUNgBxLEAKq5MimZk1Ti8sq8y3Ehxsq6gvbx6bfq1Y
	 F9K6zXo3ySDjJSwqBbfGBGgY8DisvZ0pVigbAyi9/9NPK3Xdk1C7cZnX+6IoOnZ4pw
	 1AkSDMvzwIFJRIUewYIBdIHo0LCUmtv6O85VEFnLhhvugrP9XGWJpzOzFsmaovLuvH
	 je5JNqEWi3aPgxhqqynEh/Fhkt/cN9p6LhQ80r06XVdDvGJ3kHaWXTwIDYTHbmig5Z
	 QUj8YDLfrM2cEa75UGo3qJTK82sfvIgW8aFDt4tK+whckDqaEoXoPcLsxcAtAmLZ71
	 B8h2pcEunFznA==
Date: Sat, 9 May 2026 14:28:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, noodles@meta.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Message-ID: <af8aRHUDDho2orTW@kernel.org>
References: <20260427163238.20230-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427163238.20230-1-gunnarku@amazon.com>

On Mon, Apr 27, 2026 at 04:32:26PM +0000, Gunnar Kudrjavets wrote:
> The 'space' pointer in tpm2_flush_space() is assigned from
> &chip->work_space, which is the address of an embedded struct member
> within struct tpm_chip. This address can never be NULL, making the
> NULL check dead code. The new code follows the existing pattern
> established by the other callers in tpm2-space.c which also assign
> from &chip->work_space without a NULL check. Remove the dead code
> to avoid confusion.
> 
> Fixes: e3aaebcbb7c6 ("tpm: Clean up TPM space after command failure")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Assisted-by: Kiro:claude-opus-4.6

Just for sake of understanding:

What is "kiro" and is assisted-by the tag supposed to be used here?

> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>  drivers/char/tpm/tpm2-space.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 60354cd53b5c..1eec72eb8208 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -169,9 +169,6 @@ void tpm2_flush_space(struct tpm_chip *chip)
>  	struct tpm_space *space = &chip->work_space;
>  	int i;
>  
> -	if (!space)
> -		return;
> -
>  	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
>  		if (space->context_tbl[i] && ~space->context_tbl[i])
>  			tpm2_flush_context(chip, space->context_tbl[i]);
> 
> base-commit: 949692da7211572fac419b2986b6abc0cd1aeb76
> -- 
> 2.47.3
> 

It's all good otherwise, just need clarification as we are learning
how to deal with these patches :-)

BR, Jarkko
