Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235855;
	b=iMGtyRYK/tLlxTrxt8XU33q9wBsVdgJoa66THhCOH5V/m/90LgqKOxpxEOD2c2asxSqj
	 Dygc+7cvh/fD3O+llWy5o0EwHkbK0AVVjlQNo/e8HKH9KoeKJGxJVhljQpYtjVvt5W5pl
	 hIFXsLP3kqe1O04RMT6pic96up6S3OSfdDBuDQnRmLO9L9+2l/zzKPpMGNfLM3gHF+0zm
	 pRWmLumkOXCEeTQPedycoCiDQGfSmnBs1ydcGPJKGDbu8AJM2IG4z4jlVt/kLzogGOVyc
	 /9w+fsRT2HKEqF6zf34MuHrwvRR+XRMSKGS2Pzjy3V69BZdKB3ubyMYWT7NoeuBeo0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235855;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H/+rCAuVYsfnrsVIMu7ttz7mGAAOgBsFhAj5CbRxTk4=;
	b=iRA1vLp76znAN5t2kaG0DfXjTZ7X93LDU9yHsNMO0QaLCWgM2H60+Csuq0laepCJrKLv
	 7MA22z8xTT1Qu/5yUFefy3np0Q61hNvDLONbsCwuqUuiGoFxyJZwh9Aj2swPmpWY3DDZZ
	 3TXLQNVyT5plSNtv4tEeX9xXyCCnVkxlY8tpd4fcLCJ629YU+g6xtrSQqALSgxaAx0h4v
	 0MKGXEoQUQtvoF1PSyshU14Q/fJt1izPEpR+bIdzopd8EK5HyQETyb0bPjEL2eiWwMXBZ
	 LEku4OTFx54BzWdqR60OS2cSAvlwweW92nM8mF4ZM2i3hMbhR6SZgSf0g+oQBqGv28Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVvVg9x+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E3D06606A322;
	Mon,  9 Nov 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AVvVg9x+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 09AB81F008A3;
	Mon,  9 Nov 2026 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235854;
	bh=H/+rCAuVYsfnrsVIMu7ttz7mGAAOgBsFhAj5CbRxTk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AVvVg9x+0RW/eCtxRJWfGPb1YeYocuDVL4MRfeeJgkFnYP8dXWkA9MVDWZjoKLEAA
	 dSUbZPvcneA2PEEhFWj4W/z3ZD6f3+0gnVoNTggB3UFJ0/u+BOTlNGffW/WJjzReuL
	 xDhHfd81JX/lxc11/yRxdCB9rOhxOlqaSqz+Uhk1JoOxCsHdTWWDSdi2ZwFQI60UiR
	 rMz5+jhe+E6d2XEIpSFFvCETYl1VlIQh3y6LeE3QbQ1GwWgsoIhhJ1Rwu0kXMZg2Zn
	 epPHZFHwvyl18wvn33vfDLcDw/65SdhUC6ZwYUww+BlpLG+I9pZzxvKdFwfo1wKBXu
	 D8TaO9Ddl+4uw==
Date: Mon, 9 Nov 2026 16:50:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: sessions: bound the primary public area by
 the response size
Message-ID: <avHdynG1rKStCVUO@kernel.org>
References: <au3waVnY6QA8TpPl@kernel.org>
 <20261109014955.2777635-1-guozh23@xiaopeng.com>
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
In-Reply-To: <20261109014955.2777635-1-guozh23@xiaopeng.com>

On Mon, Nov 09, 2026 at 09:49:54AM +0800, Guo Zihao wrote:
> tpm2_parse_create_primary() reads the size of the TPM2B_PUBLIC area
> from the response and hashes it to compute the object name:
> 
> 	len = tpm_buf_read_u16(buf, &offset_r);
> 	offset_t = offset_r;
> 	if (name) {
> 		/*
> 		 * now we have the public area, compute the name of
> 		 * the object
> 		 */
> 		put_unaligned_be16(TPM_ALG_SHA256, name);
> 		sha256(&buf->data[offset_r], len, name + 2);
> 	}
> 
> The length is only checked against the response later, after the
> hash has been taken. A TPM that reports a public area longer than
> what it actually sent makes the sha256() run past the end of the
> received data and hash whatever follows the response in the buffer.
> 
> Check that the public area fits in the response before hashing it.
> 
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
> ---
> 
> v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
> Sakkinen: a TPM reporting an oversized public area is not known
> to violate the TCG specification, so this is hardening rather
> than a bug fix. No code changes.
> 
>  drivers/char/tpm/tpm2-sessions.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index cf8f1fd6790b..e140079dbc13 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1125,6 +1125,8 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
>  		return -EINVAL;
>  	len = tpm_buf_read_u16(buf, &offset_r);
>  	offset_t = offset_r;
> +	if (offset_r + len > tpm_buf_length(buf))
> +		return -EINVAL;
>  	if (name) {
>  		/*
>  		 * now we have the public area, compute the name of
> -- 
> 2.50.1
> 

Thanks this change itself is great and well described.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
