Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235899;
	b=FK5dgXXsihF/n/E6HeZhDfhlCMRdh52C6jNcJ3cLkSr/c4Xwyyz/ORQFWrYtm2tk8t59
	 88lC5/zsdkp4z0q7LKU3mNvBsDPgmUxKJJanfUkDxe4FE8ltfc/MyYMm809mpjz9AK77H
	 MlM6wuyWMUbp+xBvRmFsFd93SaPYpB2Po3ftqa1tIrda30FF0vsQqhQ0mXMM9D5h8EzXD
	 oclXWWISSCDMtj8YzSoF+/kmRXOYGiWZdK2SSto4bglrIH/hqy0U+CpKipyhHMzUCYvx/
	 QlLQAv0zzBC3FtX+QryMuFeE/DAZsSAZgH0WpKzyLTeZ2liPLtt2em6hNsrDmhM2kKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235899;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=huhYkHkMLKUOnx9UUm0gQsNSNgIkNEluGxiIbh/+VXk=;
	b=02fURrU6zu5r11704ckLnPxf0qWA4mANmOnOhcy9I+RQaphfYgarAvMAlbcxT8keboNf
	 SHTb6UaKNdh/ofFN8SN0DICxuZwptYuG9tUTOKXMdwKouq07qSHFK8TVmL/PDxynsyXD1
	 sU5o6UDmbxsxUYMcg0Yr0o3S5G4b8doX9t9v+K6GfuzX5U/o1p6geNnB4UM/igQXOxxMu
	 Ubg6s0VrS6V7xL+2WzEVgFCbxQRpyra1E0vjZDshcmtEvZOWXJJnKTqh85h+Xd1Z2YW3I
	 M001yecavjZe/u6UNXgnCnoaxLoM+32LVZoYwo71ErqH+RbuWI4i66Lxugk17l1P7PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjee9h8b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EBEC3606A31C;
	Mon,  9 Nov 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjee9h8b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A8341F0089F;
	Mon,  9 Nov 2026 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235898;
	bh=huhYkHkMLKUOnx9UUm0gQsNSNgIkNEluGxiIbh/+VXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kjee9h8b/noqtxGbLb2nKy3V8qHpCiVR4VHXIXX2uBOQZAb8UpSNLB8TD85ihhZ67
	 VykrfRMbzTy4snd3pgPnbvYebfBzngs2iBn/HBpJwF9Kcfcsz8rTZgH7uVdaXD2UA3
	 hTM+m2Fn6VKFUw//qV/MWeJ/MKy53vo5tBd4/rvzTMWA5gJgqyqAuI+UAHzuFLvY30
	 5aikNH4DVqKyBaSYq0ge7pnxn6L5gJgY1vywponajgoNZ+3HlJabQT1zWwDX8Uul9g
	 5ameZnKYNqePHDVNmnN/2Qc03juGXGFOuo6KC1jHQek1D6haJrkHvMsAAEB5AmJHEq
	 DRqm4J73JbaCQ==
Date: Mon, 9 Nov 2026 16:51:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tpm: sessions: bound the parameter decryption by
 the response size
Message-ID: <avHd9w2d_nS6pdml@kernel.org>
References: <au3waVnY6QA8TpPl@kernel.org>
 <20261109014955.2777635-1-guozh23@xiaopeng.com>
 <20261109014955.2777635-2-guozh23@xiaopeng.com>
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
In-Reply-To: <20261109014955.2777635-2-guozh23@xiaopeng.com>

On Mon, Nov 09, 2026 at 09:49:55AM +0800, Guo Zihao wrote:
> tpm_buf_check_hmac_response() decrypts the parameter area of a
> response for sessions with TPM2_SA_ENCRYPT set:
> 
> 	len = tpm_buf_read_u16(buf, &offset_p);
> 	aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
> 	aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
> 		       &buf->data[offset_p], len,
> 		       auth->scratch + AES_KEY_BYTES);
> 
> The length is read from the response itself and never checked
> against the buffer: every other size taken from a session response
> is compared to tpm_buf_length(), but not this one. A TPM that
> reports an oversized parameter area makes aescfb_decrypt() walk
> past the end of the buffer, and since the decryption is done in
> place, this both reads and writes whatever follows the received
> data.
> 
> Check that the encrypted parameters fit in the response before
> decrypting them.
> 
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
> ---
> 
> v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
> Sakkinen: a TPM reporting an oversized parameter area is not known
> to violate the TCG specification, so this is hardening rather
> than a bug fix. No code changes.
> 
>  drivers/char/tpm/tpm2-sessions.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index e140079dbc13..59c7fdc0c88e 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -872,6 +872,10 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
>  			  auth->scratch);
>  
>  		len = tpm_buf_read_u16(buf, &offset_p);
> +		if (offset_p + len > tpm_buf_length(buf)) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
>  		aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
>  		aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
>  			       &buf->data[offset_p], len,
> -- 
> 2.50.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
