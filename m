Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF032ED866;
	Sat, 18 Jul 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399976; cv=none; b=jPdYJWTTLlTFzL/hreqY1CQEF+tYfrmFpMIhSC9hVYS+ovjJ3rUKlm8/IfQ7e1gl1K0Z/Xvy7CdMh6/iDJZbRkcZUGJ3T2VLxrxFzWmVS57dKXIx3sJLB/br+xUcq1u/L0S79smAFOqvo2Wn5oT42ljIK/43Lz9nY1CYbjd4dNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399976; c=relaxed/simple;
	bh=USW8WubYUuNxWPPjTdq86B+Q17MZOU49JCJRjHnDvoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnb0nAnx/ViFAsTU/Mwifz8BRpJSbcpype/mYIVBUcnth+U7OLbIfT7tAuYDXsLEjXQe4gDjktBvUd6RWMWBbtfACA6qjfstLvGg1NpFCXK6Yc0f6BGsNIfL4f561jZm0uCJhlz9Io6Fgzku1TtiXC1eYJpE0BLzksjrR9op2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZwlnowK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZwlnowK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 52F741F000E9;
	Sat, 18 Jul 2026 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399974;
	bh=sa4TICoI7a/OeKYySzbygqE3U6o7WbcWhoupsQ2JV+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IZwlnowK9+Bz8s7dc552rsgIMPetXRkJVmSB0rZGa1X7wjua+5V5NCFRuQBuvdQxT
	 VrypG9nvwd5aG5wUNpsAgpOnGAEkLkHAFKlLtcETtLXRp3iroBDHnkLY1RLih3F6VQ
	 FicbPr1riDYFV6HkIwyZrGH6J1kT3cBzggsy4LKCs+0UMj5qapi9QodPWbAsrS9dlj
	 8QivRYjSeDBWqDJikgC8vti18NJil7bdaXfzTs2SQmXsZr2Pa1nPkdfFfiBeC2WWbT
	 xgHLV+rliTOezxcGD3eL3KnCu+LesvC7Awyl4rw7QhSiSkUwPvs6DmVos0/mFSg38M
	 /v3nwQFMCWngA==
Date: Sat, 18 Jul 2026 21:39:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: use kfree_sensitive() for context and session
 buffers
Message-ID: <alvIY-6-NtgH0pzR@kernel.org>
References: <20260716000355.13825-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716000355.13825-1-skunkolee@gmail.com>

On Wed, Jul 15, 2026 at 06:03:55PM -0600, Ivy Lopez wrote:
> The context_buf and session_buf fields in struct tpm_space contain
> TPM context blobs which may include sensitive cryptographic material.
> Use kfree_sensitive() instead of kfree() to ensure the memory is
> zeroed before being freed, consistent with how chip->auth is handled
> in the same tpm_dev_release() function since commit c424d2664f08
> ("tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()")
> 
> Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
> ---
>  drivers/char/tpm/tpm-chip.c   | 4 ++--
>  drivers/char/tpm/tpm2-space.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 12b7394b34bd..6f16fc358175 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -244,8 +244,8 @@ static void tpm_dev_release(struct device *dev)
>  	idr_remove(&dev_nums_idr, chip->dev_num);
>  	mutex_unlock(&idr_lock);
>  
> -	kfree(chip->work_space.context_buf);
> -	kfree(chip->work_space.session_buf);
> +	kfree_sensitive(chip->work_space.context_buf);
> +	kfree_sensitive(chip->work_space.session_buf);
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	kfree_sensitive(chip->auth);
>  #endif
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 60354cd53b5c..a7200e6dc462 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -46,7 +46,7 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  
>  	space->session_buf = kzalloc(buf_size, GFP_KERNEL);
>  	if (space->session_buf == NULL) {
> -		kfree(space->context_buf);
> +		kfree_sensitive(space->context_buf);
>  		/* Prevent caller getting a dangling pointer. */
>  		space->context_buf = NULL;
>  		return -ENOMEM;
> @@ -64,8 +64,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  		tpm_put_ops(chip);
>  	}
>  
> -	kfree(space->context_buf);
> -	kfree(space->session_buf);
> +	kfree_sensitive(space->context_buf);
> +	kfree_sensitive(space->session_buf);
>  }
>  
>  int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> -- 
> 2.55.0
> 

Yep, as James said, there's no plain text to uncover.

BR, Jarkko
