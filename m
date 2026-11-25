Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633506;
	b=TNlYV0zo0ifHKbrs80zEh5WqlzcOtf9w0CMUEp1R+NeIZuYZetMtW0cS9dwqBXOdk9iA
	 pldXCTq7UJV73ws/V59+Pb5q37CyAjAsGGkJGzhJ2FBd/APauHgh6TI5YccGZ6wmXA4W+
	 OYUwmnFfBUFZurcJN6+P4UIG33orGuxqG3YsEG7asKFoF/kdgXdPGgSum3rsgWHUWrZQG
	 GuQudXb4w3CqGa2aEVbL/nP7qPd3EEkGsfOVG9nqUjuH8tKtX/T3+TJ2Z981C+gGDSJly
	 FAiL5Feno1xf+gd5/4reGB9orVlS3eQMG+AJcgLJrTYdgNW5SIfbdQyW4Ovv/AE376Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633506;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fEwhwhVRUf5o2AYTrWuvwkskWBT1xDOfq9VSZ0+a7SY=;
	b=WB2Z7Z8ZqTauEkkxxRhFJYa7jFBTvbjP93G+VVb3GxtCxzv5bCAcxnfeAhLOBX5OKrb5
	 cTuSl5YweRYVYmF4Mgox53rjGr9dUlExCaKZuKTK9WuWyrBimVsyfY49jYCFUg/Xv/5l8
	 gRA5+jgStUDGWD65cR3CcTp3NW6iGqfB1SQG83ywMAgg6hb+mS6ufmpfKQs9MRMeEXnTK
	 /lO1FOD5Frq9HIZJoV3AyFIS1bvOHtawI8UUCbVkN2lwXuRIfHU80WQaMmcrVVHzQFiS3
	 +L5acRPYcYt0fr7MVyDoNghGACyzdsq6Z4Aej8YdWs0GQjgAekRrtuPKemuIY5YjFXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnCn9ZyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8D4FB606A31E;
	Wed, 25 Nov 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnCn9ZyR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3EF21F000C4;
	Wed, 25 Nov 2026 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633506;
	bh=fEwhwhVRUf5o2AYTrWuvwkskWBT1xDOfq9VSZ0+a7SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NnCn9ZyRzICvPw0LKxbz/+Lo1oXCw1l0KlpykWbQjPhifQH1tqZQLl1a6JM7HSzKP
	 GJzAm//VMBnFebX+e1i6mOYJw7M7QHz8Fe3JJaHM3R12TR3KpVbVJyjSjIdrEpUATX
	 NI9ojulxysbu2r6Xh/CtS4zk5QOWM7SeCJMB8bNdvCMmji+oLvTxMKjafrsUEqB8Pa
	 W8934BKLWJ/2ZX3nX8XjL6Tajew1NUI+R1Iihpv8Cup9GEqwyB8Im9MBcamHCwETvD
	 8OGp5hI2NHgb7jIaB62NyVe0EYpTxklMOwB7x6cXfkkswgqyg/5KBV1SOyDED8G28p
	 m75h69bXyhrDA==
Date: Wed, 25 Nov 2026 21:05:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH] tpm: Raise the TPM2_SelfTest duration to 4000 ms
Message-ID: <awcxXkPRPv3CDlcq@kernel.org>
References: <20261125182251.19360-1-surenkj@amazon.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125182251.19360-1-surenkj@amazon.com>

On Wed, Nov 25, 2026 at 06:22:51PM +0000, Surendran Kanagaraj wrote:
> TPM2_SelfTest duration is currently 3000 ms, following PTP version 1.06.
> Version 1.07 [1] has since raised the full self-test timeout from
> 3000 ms to 4000 ms (Table 26, Command Timing). Raise the TPM2_SelfTest
> duration to 4000 ms to match PTP version 1.07.
> 
> [1] https://medias.cdn.trustedcomputinggroup.org/production/PC_Client_Specific_Platform_TPM_Profile_for_TPM_2p0_v1p07_Pub_5643562943.pdf
> 
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
> Found while working on the RFC series "tpm: Rework timeout and
> duration handling":
> https://lore.kernel.org/linux-integrity/20261118073852.81107-1-surenkj@amazon.com/
> 
>  drivers/char/tpm/tpm2-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 65928ae85b49..d58c306f7d93 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -59,7 +59,7 @@ static const struct {
>  	unsigned long duration;
>  } tpm2_ordinal_duration_map[] = {
>  	{TPM2_CC_STARTUP, 750},
> -	{TPM2_CC_SELF_TEST, 3000},
> +	{TPM2_CC_SELF_TEST, 4000},
>  	{TPM2_CC_GET_RANDOM, 2000},
>  	{TPM2_CC_SEQUENCE_UPDATE, 750},
>  	{TPM2_CC_SEQUENCE_COMPLETE, 750},
> 
> base-commit: 003906ddd61cac2b89aefaf001fc19a6cb5d541a
> -- 
> 2.47.3
> 

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
