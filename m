Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86B137923;
	Mon,  5 Oct 2026 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791177097; cv=pass; b=poRWQi5+TJceJ0mk4hcXCjB5scS4tJvtyDzuBzo1oQ8H1Mj6hOY6i64p10V7y36zjbonwlTG7yArNXgBWhQ6Q7nvjbS+UkzxWe/Zatl73VVrRWZ4ebdo+avWFL0XkFrjIQUwunwoYgHbw+ssidefHSB8ncpeaWAtZoPnvJ+4Jwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791177097; c=relaxed/simple;
	bh=xzKwoU4eSdqPHFvD6YTdxCELHA/rAUlEwDpDdXHPnNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foo13LMJM9dYAF2qVpZGVrzWj05OISSBLalbQ18x2GAK+OD/4GjstfzSNXAOZarQERS0S6RO1HkVhw9gUD8WAmz/waVwfsbS1SWTAtuM/V738GsM7feLvjgav9dX4/nsk3+wfMHrmg9xZmDBGPFVAhiA+HfJzDWdYPKWN1NO/v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EwbnjnFP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EwbnjnFP"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hynYJ6WK5zyTf;
	Mon, 05 Oct 2026 08:11:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791177093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwhwCnXCEOsEaber9WU629wTGUvOcN7Fww6xJiWaeBE=;
	b=EwbnjnFPowMxLTVn89fllvZuzI6CT9ZDlIC9Iu6+04UKaN6XOlvBlXP9UBv2jhY1lX27fD
	aoqExCtI5Ms8o319iBe555J87OHVAAxffRt/ZLNqHidTFIBAylmbTcEpR/B7fmek4PRzvK
	c2U5RQS5vydPXAekL1lae2gZj/vJh0Y=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791177093;
	b=XNK35Hp1U8Jzp0TNDnNi76223O5RNscCIyP4l1FT1XFvx5keZWcsgJnBIwHByVIJkjOnyE
	Onk6s1zf0lCkb13+oypFlOVcd8B+N81YSH6hf3HjnZvKRdKASnd797LO6E9LoTJwh74Enu
	v2xhJ1BKSTxn2bRYbOLkT7PeMepij+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791177093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwhwCnXCEOsEaber9WU629wTGUvOcN7Fww6xJiWaeBE=;
	b=ZjE40qiZaZFYLz/fcybvWxHw7XfLXJa/yEM4TxByJ1eFVGCd13d0ZiM031IC0wQe8aBxkR
	kfYFHDiHFe3zrxh0pKPAJE0v50XfUfCXpMskNkaOsQNzQBLtkVWNARXJurvc16mcg+Pzf2
	Kjemv0JXwFSh/zBNsjnQfL4AZ8cqB6o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Mon, 5 Oct 2026 08:11:31 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] tpm: fix zero-length read discarding the pending
 response
Message-ID: <asMxg-H6snoNSEiZ@iki.fi>
References: <cover.1791015549.git.xiaopei01@kylinos.cn>
 <3f15140ab3c26e98b49d6aceaaa826585d56960b.1791015549.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f15140ab3c26e98b49d6aceaaa826585d56960b.1791015549.git.xiaopei01@kylinos.cn>

On Sat, Oct 03, 2026 at 04:27:54PM +0800, Pei Xiao wrote:
> POSIX requires that a read() with a count of zero returns zero and
> has no other effects.  tpm_common_read() treats such a call as a
> consumed response: it marks the pending response as read and drops
> it, so the response can never be retrieved; subsequent reads return
> zero and the next write() is allowed to overwrite the response
> buffer, silently breaking the command/response pairing of the TPM
> character devices.
> 
> Return early when the caller passes a zero count, leaving any
> pending response untouched for the next read.  A zero-length read
> will not report a deferred asynchronous error; POSIX permits read()
> to skip error detection for a zero count.
> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Assisted-by: GLM-5.3
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/char/tpm/tpm-dev-common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f942c0c8e402..6569212dc6b8 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -134,6 +134,9 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  	ssize_t ret_size = 0;
>  	int rc;
>  
> +	if (!size)
> +		return 0;
> +
>  	mutex_lock(&priv->buffer_mutex);
>  
>  	if (priv->response_length) {
> -- 
> 2.25.1
> 

This look good to me,  thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
