Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5C3019BA;
	Wed,  8 Apr 2026 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667786; cv=none; b=EdHD4TmClQZfECgB50jWSXnkPOHfesrlBus/mLP/m8iCNoi4247K3ZeIWgHf9wW9zXIgDFPpMAiCP6U9ntt4fLZUwTTHxQFbMXTh/wfClwRDbdXoLmC573bji+0GrFT8MAbA9tiBGuLXoD6J1agN/GtEYt5JLz27Oou38HwNicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667786; c=relaxed/simple;
	bh=AR4JtdPROSNpwS+BQxUFQby4m/GFYtIAygSGEB5eQas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPoQ8RnHg4W+iyVqh6mRrogq2pTBc6qNqwUU29YERI2DSwauBNbUuvmAqAIlxOXbDNaOLnF0ot/e3VtN1pYOSrvP3xfH4zB3WgcDY+/FZnmpsDQjHCx9BAT51bsYOA1SsFyQ4In7yNaWBqN08ZOrP/xtU/hZER6Gwwhq0+elS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 514804C2C37D60;
	Wed, 08 Apr 2026 19:01:33 +0200 (CEST)
Message-ID: <eac7096b-b398-4926-b0ff-82753cf8c73f@molgen.mpg.de>
Date: Wed, 8 Apr 2026 19:01:27 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm2-sessions: Fix missing tpm_buf_destroy() in
 tpm2_read_public()
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, noodles@meta.com,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Justinien Bouron <jbouron@amazon.com>
References: <20260408164359.24968-1-gunnarku@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260408164359.24968-1-gunnarku@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Gunnar,


Thank you for your patch.

Am 08.04.26 um 18:43 schrieb Gunnar Kudrjavets:
> tpm2_read_public() calls tpm_buf_init() but fails to call
> tpm_buf_destroy() on two exit paths, leaking a page allocation:
> 
> 1. When name_size() returns an error (unrecognized hash algorithm),
>     the function returns directly without destroying the buffer.
> 
> 2. On the success path, the buffer is never destroyed before
>     returning.
> 
> All other error paths in the function correctly call
> tpm_buf_destroy() before returning.
> 
> Fix both by adding the missing tpm_buf_destroy() calls.
> 
> Fixes: bda1cbf73c6e ("tpm2-sessions: Fix tpm2_read_public range checks")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>   drivers/char/tpm/tpm2-sessions.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 09df6353ef04..f7c6c043fef4 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -203,8 +203,10 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
>   	rc = tpm_buf_read_u16(&buf, &offset);
>   	name_size_alg = name_size(&buf.data[offset]);
>   
> -	if (name_size_alg < 0)
> +	if (name_size_alg < 0) {
> +		tpm_buf_destroy(&buf);
>   		return name_size_alg;
> +	}
>   
>   	if (rc != name_size_alg) {
>   		tpm_buf_destroy(&buf);
> @@ -217,6 +219,7 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
>   	}
>   
>   	memcpy(name, &buf.data[offset], rc);
> +	tpm_buf_destroy(&buf);
>   	return name_size_alg;
>   }
>   #endif /* CONFIG_TCG_TPM2_HMAC */
> 
> base-commit: 03e5553f5fb99cb47c315e167a604a9c69e6f724

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
