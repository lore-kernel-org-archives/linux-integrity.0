Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889732F12A1;
	Sat, 18 Jul 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784398658; cv=none; b=qpi7q59s5aiGPwWJ89Fth1nGF9t2KxGHiGhnW0bMgKT4nbWSXOb2LePCJ2a1ftu8YoHUKmsT3ezO9NUoaKkpzK4JKwotnQvRJEx7VeDx6XoODlPUTbuxHLLvpVylJjoptlwOyv8KhTgZaZveBeiQ1n2TurRYi0Niw5Rsyks2JRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784398658; c=relaxed/simple;
	bh=eZ54TkyOII1ds4Cksqg/0osnXGFMWEFqLtVZwcOGoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm2vEw8jVuxGpydqXOj1JNCgjPbayctYSOkw7CsY0ZShIi9h5RyaY7vxalx0sAquorPTZEwn+icMNm5FmjLLxmBoENbvelm7u4aTLON1/dpe9QeDiShelv2EbRzplgG9lbI9w6h/nB79jRGEORzizbHjRxn84Vpmk5BklV1MUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7cMT6Fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7cMT6Fe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B22EF1F000E9;
	Sat, 18 Jul 2026 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784398657;
	bh=PQU3Kn+cVuAalL2oPliVVXkMMgbX9Y61tB8owBWMPSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G7cMT6Fe7ffFYq8ccOgbMDHcJkZJVhgFy+9sFFU87GAHkNNh33TzXI66VYe/VyH35
	 nvze/UBlPyiwo8iIWAUGTN9aUmndHJ3XJs52rR26nBtH67RcwuNQAjYD1osJYzP+gK
	 YkNH+JQE1VYswWHwz2D7GbUXwv9ntEiLfWqphEtrQbaEXX1qh5brsvbJhHilyzk8YA
	 Eyn3Hqa2RatR+7rl9ZrOPSTmgBn/Jqg/aDa9HXIEq9T2NnJSJM7MNSKc8Oe2lYN8dF
	 sk3sG5Ich5gAXoz5hlHAFmbxfn1IoQnMrliWIpeK5dESgVzJwJNlDbamZ4J/Z8WYfM
	 V2lX5k9qYwHdQ==
Date: Sat, 18 Jul 2026 21:17:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Jaewon Yang <yong010301@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] tpm: Reject reads outside the response buffer
Message-ID: <alvDPToN5hXa3vXd@kernel.org>
References: <20260710090217.191289-1-yong010301@gmail.com>
 <alJ4cg_lWo1mdLl8@kernel.org>
 <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>

On Sat, Jul 11, 2026 at 11:58:14AM -0700, Linus Torvalds wrote:
> On Sat, 11 Jul 2026 at 10:09, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Please don't delegate the work for me that  you should doing i.e.
> > looking at your reproducer and describing the scenario/sequence
> > that would lead to infeasible consequence.
> 
> I don't understand this reply.
> 
> The original email had all the relevant information: how to trigger
> the condition, what the bug is, and what's going on.
> 
> The bug seems straightforward: the tpm code appears to blindly use a
> user-supplied 'loff_t' that is simply not checked. The email you
> responded to seems very clear on the issue:
> 
>   Sequential read() keeps *off in range, but the fops use the legacy .read
>   callback and neither tpm_open() nor tpmrm_open() calls nonseekable_open(),
>   so FMODE_PREAD stays set and pread(2) passes an arbitrary offset straight
>   into *off.
> 
> So what's the problem here?
> 
> Now, honestly, I think this tpm code is badly written to begin with,
> and the patch doesn't fix that fundamental issue.
> 
> The code simply shouldn't change response_length by how much have been
> read, it should just use the fixed size of the buffer and compare it
> to the offset.
> 
> And once the buffer has been fully used, we clean it up.
> 
> Something ENTIRELY UNTESTED like the attached patch. But I do want to
> point out that this patch is
> 
>  (a) UNTESTED
> 
>  (b) bigger and more invasive than the simple "just check the offset"
> 
> That said, I really don't like how the original patch by Jaewon
> depends on TPM_BUFSIZE when the real limit is that "response_length",
> but that's a direct result of the tpm code being disgustign and
> changing response_length as a response to partial reads.
> 
> So the attached patch tries to fix that fundamental mistake, and in
> the process I think it makes the code more readable, but whatever. I
> probably think that primarily because I wrote the patch.
> 
> Comments? But this "dismiss a patch based on bogus reasons" seems like
> a huge mistake.
> 
> Again. The attached patch is UNTESTED.
> 
>                   Linus

I hear you. I was probably too quick draw with this one.

>  drivers/char/tpm/tpm-dev-common.c | 67 ++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f942c0c8e402..f1c17fdea74d 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -127,44 +127,53 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
>  	file->private_data = priv;
>  }
>  
> +static inline ssize_t tpm_common_read_cleanup(struct file_priv *priv, loff_t *off, ssize_t ret)
> +{
> +	*off = 0;
> +	timer_delete_sync(&priv->user_read_timer);
> +	flush_work(&priv->timeout_work);
> +	return ret;
> +}
> +
>  ssize_t tpm_common_read(struct file *file, char __user *buf,
>  			size_t size, loff_t *off)
>  {
>  	struct file_priv *priv = file->private_data;
> -	ssize_t ret_size = 0;
> -	int rc;
> +	ssize_t response_length;
> +	u64 offset;
>  
> -	mutex_lock(&priv->buffer_mutex);
> +	if (!size)
> +		return 0;
>  
> -	if (priv->response_length) {
> -		priv->response_read = true;
> +	guard(mutex)(&priv->buffer_mutex);
> +	response_length = priv->response_length;
>  
> -		ret_size = min_t(ssize_t, size, priv->response_length);
> -		if (ret_size <= 0) {
> -			priv->response_length = 0;
> -			goto out;
> -		}
> +	// Error or nothing to read?
> +	if (response_length <= 0)
> +		return tpm_common_read_cleanup(priv, off, response_length);
>  
> -		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
> -		if (rc) {
> -			memset(priv->data_buffer, 0, TPM_BUFSIZE);
> -			priv->response_length = 0;
> -			ret_size = -EFAULT;
> -		} else {
> -			memset(priv->data_buffer + *off, 0, ret_size);
> -			priv->response_length -= ret_size;
> -			*off += ret_size;
> -		}
> -	}
> +	offset = *off;
>  
> -out:
> -	if (!priv->response_length) {
> -		*off = 0;
> -		timer_delete_sync(&priv->user_read_timer);
> -		flush_work(&priv->timeout_work);
> -	}
> -	mutex_unlock(&priv->buffer_mutex);
> -	return ret_size;
> +	// Have we already read everything? Return EOF
> +	if (offset >= response_length)
> +		return tpm_common_read_cleanup(priv, off, 0);
> +
> +	// Do the potentially partial read
> +	size = min_t(size_t, size, response_length - offset);
> +	size -= copy_to_user(buf, priv->data_buffer + offset, size);
> +	if (!size)
> +		return -EFAULT;
> +	offset += size;
> +
> +	// Are we all done with the response?
> +	if (offset >= response_length)
> +		return tpm_common_read_cleanup(priv, off, size);
> +
> +	// We still have some data left, update the offset
> +	// and be ready to read the rest later - don't do
> +	// the cleanup.
> +	*off = offset;
> +	return size;
>  }
>  
>  ssize_t tpm_common_write(struct file *file, const char __user *buf,


BR, Jarkko
