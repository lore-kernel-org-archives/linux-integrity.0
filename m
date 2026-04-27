Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3D38E100;
	Mon, 27 Apr 2026 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323019; cv=none; b=HJ1Vu3UtIznL5R8rSF72313ge+eSnNgqvnVzWbTCyCLpIN9maDZU5IXqgIL+Ng3j7UL8MA5xgHwrxvoJaMwZrDHYf44wCV3PQ9QLvptCDf8a/s9ZKet3Zjy6wGtO0WTCb37EuR9PVgmpYafK38US+m1fIiOIU2CWQky4LsCFqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323019; c=relaxed/simple;
	bh=W2I5YdPFvukKgWgaKuJxye5XvNygFFBeDBRT4mDXiGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6WFiREsARTALQz91x7Xtk2VbVHv4M8pJBKaHdDr6TO1k7JwPqdUUwd0igHQzrv0vZZB4cPK9G4x9+p7CyxskFN7OtRg7IXCI5DnaYHqq0v6mBGIX4yVe9y9YzNligluHETJguUM8EqswXe0nru66/o/EgkYwwJoQvXCGf6hUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (unknown [95.90.240.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1D20C4C1513243;
	Mon, 27 Apr 2026 22:49:53 +0200 (CEST)
Message-ID: <e71c6d95-6c83-4fb4-8cd5-f66067fb68c5@molgen.mpg.de>
Date: Mon, 27 Apr 2026 22:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, noodles@meta.com,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Justinien Bouron <jbouron@amazon.com>
References: <20260427163238.20230-1-gunnarku@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260427163238.20230-1-gunnarku@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Gunnar,


Thank you for your patch.

Am 27.04.26 um 18:32 schrieb Gunnar Kudrjavets:
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
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>   drivers/char/tpm/tpm2-space.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 60354cd53b5c..1eec72eb8208 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -169,9 +169,6 @@ void tpm2_flush_space(struct tpm_chip *chip)
>   	struct tpm_space *space = &chip->work_space;
>   	int i;
>   
> -	if (!space)
> -		return;
> -
>   	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
>   		if (space->context_tbl[i] && ~space->context_tbl[i])
>   			tpm2_flush_context(chip, space->context_tbl[i]);

gemini/gemini-3.1-pro-preview made a comment [1]. No idea, if it’s valid.


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260427163238.20230-1-gunnarku%40amazon.com
