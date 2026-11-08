Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162513;
	b=QNNhGC7ExuoNzTStRK9CKByb9yvsV56CEgMpUp2VyevgqVxnKQG/8fQ91A9KDgeKve92
	 fQuTsBlHIoLbIblYLfZhsCiwxh1y1IhLRAM9VOu0T2RjGM+l7ZaRpIM4Bd9FXWaJOyBFq
	 XEnH1k5W37/y4rS5DgTSjS3ClnCBnZu8JjBRdwqQBVncWYKhtwzBQi7fjBPj/Rf0UpeVd
	 ceq8/igrc4vwYojGFc4WfVERiYGTylkOa5J8CMKgDCvEcNb/zbtZs/dc81l8K/y8MrvXo
	 cflIffPEGsfRvWHBvGeVqKrrhdvQeQzcLtpROxxEJHDfzNdrdmjQpIgP4CKhM6ei9+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162513;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GlXS3jV2BxjWkWKlIEkNKmp2DmCG35ZqeUOV+7IvtUM=;
	b=nlpD5jVbIi1GXnf3HZiPYAjXPhLfOkrNlGyildexF8sTxZed4Zk0dtt6yFudMQSS22hU
	 oX4GDWplu2rB9gHMTbETYsKg5FcAm+6+VMCWQTQl6fl2iedgKpm3DRDw4RzGaTl+n0R+/
	 FsK9IWwc67F9GS9huw/098Osny8Hi8lvylAcFAR/Czo401j7xcpPWYvg/O3QPwwpRiXXh
	 Ubxqsbi9l5SO3OSxAwXEtTU5PbvIpg/ge7Itu3RBpUxMmPvLpNzmlj2mPmSS10rXqCpfJ
	 HndccPem9ofTwbIDC1A2iH/CFG5Zl4EbeFRYoFQ4c6iZMn8HAAK/sTT1eeNyE/XYqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ADA/SoNN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E24FA606A31C;
	Sun,  8 Nov 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADA/SoNN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 79B111F008A1;
	Sun,  8 Nov 2026 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794162512;
	bh=GlXS3jV2BxjWkWKlIEkNKmp2DmCG35ZqeUOV+7IvtUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ADA/SoNN59OO6mKabMCOQCBF9Go+ZBuUayfV7fK/Smgms1Ar2pND3As2RP35jEDZm
	 X43o/NrgwHx2psCEz35tc6qQvLTUGUoUPmvDpugEI8W9sgcUv2Af4CdFJsQkNAI6Vp
	 fY6Ib/Az5r87vFo/I0rGwCZXI4k7KqLf3wQPDZ4Xf3eTxQMwLSjZ1HBxvq4skaAeRI
	 W7EYTEYFzJDd68odjQV7cdkJg9vS+8IcNelH/4/saYPOf33ZkmKGFK8EQHaPuKo2sz
	 ozma38xckoT8DmHPw9aX1z979Nt72qoBDbBmi1MtB4pf1rSdja8Jc2bqeBdsQ4u/Ll
	 aGoqXexbYuVPg==
Date: Sun, 8 Nov 2026 20:28:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: alban.kernel@gmail.com
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix the value of TPM2_SE_TRIAL
Message-ID: <avC_TEMjF8qbCAd8@kernel.org>
References: <20261108-tpm-se-trial-v1-1-492218f9de41@gmail.com>
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
In-Reply-To: <20261108-tpm-se-trial-v1-1-492218f9de41@gmail.com>

On Sun, Nov 08, 2026 at 06:05:39PM +0000, Alban Munari via B4 Relay wrote:
> From: Alban Munari <alban.kernel@gmail.com>
> 
> The TPM 2.0 Library specification, Part 2: Structures, defines the
> session types (TPM_SE) as TPM_SE_HMAC = 0x00, TPM_SE_POLICY = 0x01 and
> TPM_SE_TRIAL = 0x03. TPM2_SE_TRIAL is defined as 0x02, which is not a
> session type: TPM2_StartAuthSession with it fails with TPM_RC_VALUE on
> the sessionType parameter, as swtpm 0.11.0 shows.
> 
> No code in the kernel uses TPM2_SE_TRIAL, so nothing changes at run
> time. The TPM 2.0 selftests already define it as 0x03 in
> tools/testing/selftests/tpm2/tpm2.py.
> 
> This change was found and written with an AI coding assistant (Claude
> Opus 5.5, Anthropic), while building trial sessions on an AMD fTPM with
> the value 0x03.

Please delete this paragraph. It is your responsibility to do the
fact checking. I.e. refer to a section in appropriate TCG spec that
defines this instead.

> 
> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> Signed-off-by: Alban Munari <alban.kernel@gmail.com>

If no code uses it why fixes-tag?

> ---
>  include/linux/tpm_command.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
> index fc446a1282e2..076ee8ce816c 100644
> --- a/include/linux/tpm_command.h
> +++ b/include/linux/tpm_command.h
> @@ -171,7 +171,7 @@ struct tpm1_get_random_out {
>  enum tpm2_session_types {
>  	TPM2_SE_HMAC	= 0x00,
>  	TPM2_SE_POLICY	= 0x01,
> -	TPM2_SE_TRIAL	= 0x02,
> +	TPM2_SE_TRIAL	= 0x03,
>  };
>  
>  enum tpm2_timeouts {
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

I think better action would be delete the enum and change the single
site to  tpm_buf_append_u8(buf, 0x00 /* HMAC */);

Br, Jarkko
