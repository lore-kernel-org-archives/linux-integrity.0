Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177139;
	b=n4xMaI1TeTMQQ/gA6CgLbi8A6qcZ6C3os4rkuCOPX5tC/UZ4ANGWVcLRpquSkAULPgdi
	 1poxjqSFs1serf3KOEPfACK5Owf62KSXRiFZPMbdFe09CHP3dWnnww5q1s8ITzCPRBfWc
	 18/MaBKpjuIZJ9ODldCsc7gd6QOktBO7wVLzUqaKbiF5Rh8dFA0nQ+614l2zIpLHUgzSs
	 3T8ndmAlf5Pf+/cdlXHYwuHhAcwa+z64LiXieV2HYfJIWYIlyBIMUsO/6mn/Q2LNwjN8G
	 jHncwfxqSoAmLeVQtAh3ENdq0QOpocmGKgXteWRgAJCQX52Gr4ofrFfMam1Bjt0gCpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177139;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q1JQ6i1Sex5INvd09SnU0cwn0W//05u4L2jv/B3ojtI=;
	b=vv9vm3lc0U5a6tni1Gw2ZiXrV9NV6VSpUB3Hpx/9ugBvfwQAYJlbqdvXXO4QOjJnRVq7
	 aG9BSlDwVBa29c9rQKXEKmOJp1XajEeSgo05Rmx8FqVB5PfdG75gIVx+aehKrJMbEQodP
	 slsZyiPsS9fpQqJi/Eabo0aiFNG7/mbSehKLfzcfTk7Ey148frD1y1oEyW7QIhpRHGdXK
	 adJ9tRHxiqVa8cewg3qet8w6VDb3k6PxexjudGyoUgbeTwaAL79LA5bLSaESXr0+KGzIz
	 G8DOKsLXjfa2yXcI4vSLBEUTGSfqcFAMfgDkkfQAzrleyxq20blv7tuVDriQ9Ufgcag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZBzRH/j/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4D1D6606A320;
	Sun,  8 Nov 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZBzRH/j/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 627FC1F0089F;
	Sun,  8 Nov 2026 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794177138;
	bh=q1JQ6i1Sex5INvd09SnU0cwn0W//05u4L2jv/B3ojtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZBzRH/j/sGefqIVkBAocr8ooJkaFQeWtcRTFJzlytF+Mshwhs7+visiSh5EufiE9i
	 Bea/BtZ3hHCYNuAEMflegmBX/p3kah1CcFnEfLig9PA2l+Wpa9BoEn4TLCiv1zXjeh
	 zrs6Otp4QSfRSMzcXQQm4VdABPdo62FSw+yGs+K9OMgetTvEddWJJtUNdk7oChKUa5
	 oEyyfAPSGgZ1WRXGPEwugv0YTrOP8Pd3s7i6DsSKm8ullniLwRzHh2C3KMDwh03U0R
	 LCCJG4KLdB4nAvA9NpxVU4iX8tyihSlnRu/ykTJXv1eHdmv8OtT5voj0YuI0Q5bX6c
	 rhdNnmMfT330Q==
Date: Mon, 9 Nov 2026 00:32:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: alban.kernel@gmail.com
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Remove enum tpm2_session_types
Message-ID: <avD4b1i8rfvEuY34@kernel.org>
References: <20261108-tpm-se-trial-v2-1-92c2090351d7@gmail.com>
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
In-Reply-To: <20261108-tpm-se-trial-v2-1-92c2090351d7@gmail.com>

On Sun, Nov 08, 2026 at 08:05:12PM +0000, Alban Munari via B4 Relay wrote:
> From: Alban Munari <alban.kernel@gmail.com>
> 
> TPM2_SE_TRIAL is defined as 0x02, while the TPM 2.0 Library
> specification, Part 2: Structures, revision 01.83, section 6.11, Table
> 21, defines TPM_SE_TRIAL as 0x03.
> 
> The only user of enum tpm2_session_types is tpm2_start_auth_session(),
> which starts an HMAC session. Remove the enum and pass the session type
> there as a literal, rather than fix a constant that nothing uses.
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Alban Munari <alban.kernel@gmail.com>
> ---
> Changes in v2:
> - Remove the enum instead of fixing TPM2_SE_TRIAL (Jarkko).
> - Refer to the section of the TCG specification.
> - Drop the Fixes tag: no code used the wrong value.
> - Link to v1: https://patch.msgid.link/20261108-tpm-se-trial-v1-1-492218f9de41@gmail.com
> 
> To: Peter Huewe <peterhuewe@gmx.de>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/char/tpm/tpm2-sessions.c | 2 +-
>  include/linux/tpm_command.h      | 6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index ca1e2bf424e1..63e1dd596bc5 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1043,7 +1043,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  		return rc;
>  	}
>  	/* session type (HMAC, audit or policy) */
> -	tpm_buf_append_u8(buf, TPM2_SE_HMAC);
> +	tpm_buf_append_u8(buf, 0x00 /* HMAC */);
>  
>  	/* symmetric encryption parameters */
>  	/* symmetric algorithm */
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index fc446a1282e2..c9988fcff916 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -168,12 +168,6 @@ struct tpm1_get_random_out {
>  /* TPM2 specific constants. */
>  #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
>  
> -enum tpm2_session_types {
> -	TPM2_SE_HMAC	= 0x00,
> -	TPM2_SE_POLICY	= 0x01,
> -	TPM2_SE_TRIAL	= 0x02,
> -};
> -
>  enum tpm2_timeouts {
>  	TPM2_TIMEOUT_A		= 750,
>  	TPM2_TIMEOUT_B		= 4000,
> 
> ---
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> change-id: 20261108-tpm-se-trial-580bef9b4f17
> 
> Best regards,
> --  
> Alban Munari <alban.kernel@gmail.com>
> 
> 

Thank you.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I mean think about it:

1. V1: Fixes a thing that does not cause any issues.
2. V2: Removes essentially a dead type definition.

There's a factor of a difference in the value of the change.

Br, Jarkko
