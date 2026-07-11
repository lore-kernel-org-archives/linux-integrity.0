Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1912989B5;
	Sat, 11 Jul 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783789688; cv=none; b=l5BZRkQ/qVZumMwFmEusFMB7zFSbt/8lDYVth4uWLlxAgGN2u02mmxOwayaAPNVec52ryyPR2Sd4VP502j1PW8j1d6todvCKK8U6kvlA5IZr89inu9/zwrJjdl5w1igrUqebSoS3MnoKYlHbeQvSZ9NZC6qnwMLQA2EK/7wu+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783789688; c=relaxed/simple;
	bh=OIwonjqMp7dWIWG4PnfKQhhJY1pDQ8rSAUWl0CuxTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjy4nE5B+KA0sn6b4VFgXNyk+Yxo6jzKYdvxVHfxkvuCfUZEP+549/bg41ofWGrjPupR8WH1eOh8EUmCi1JbdnRtbqxj8/PjK5/FHscAPS2CCbCqjhpnL6dFoe9g7ZSROOQrd5SnCTa1ddbhXVvdYGkEu3509r92PJapz4REYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC7Tp3Mz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC7Tp3Mz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C5D81F000E9;
	Sat, 11 Jul 2026 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783789686;
	bh=BeSfnYUcBZ1zKJRBXQYVLE4gncL2fS5F7g22PTtI1rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lC7Tp3MzHmkUDLjUV0zucSip8zEnFMTaXA/NSH6U9uCSBXlqAA2Tk68mnF5Q2JcxO
	 1mDjxDQ80Ev9b7TPMOaQ1sfOW/0ydNaMrywZGPy/SPt0kDCeKwIboDvjbRlAdomr6b
	 mDCH28KwQuU45TZ2P+vw5+N3FmXvzMHOzZzwB0SMFAvddFhnj1HpVNiNZtKJGTwpoP
	 +AGT5rd6UCj5xXi6MjDMipkGNBeSw8P/E9PckhQhzxHaIL4D7bDheKSvCLlfHUfl4e
	 dVfvkkgXX8Xl6cnVDhJ+TxaN4XuVUzU4S9w5iKYk/Nb9uQiZYtzwkFAKfE8g3bO1+F
	 moGLSv8OR+YLA==
Date: Sat, 11 Jul 2026 20:08:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jaewon Yang <yong010301@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH] tpm: Reject reads outside the response buffer
Message-ID: <alJ4cg_lWo1mdLl8@kernel.org>
References: <20260710090217.191289-1-yong010301@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710090217.191289-1-yong010301@gmail.com>

On Fri, Jul 10, 2026 at 06:02:17PM +0900, Jaewon Yang wrote:
> tpm_common_read() clamps the transfer length to priv->response_length but
> does not validate the file offset (*off) before using it to index the
> fixed TPM_BUFSIZE-byte priv->data_buffer:
> 
> 	ret_size = min_t(ssize_t, size, priv->response_length);
> 	copy_to_user(buf, priv->data_buffer + *off, ret_size);
> 	memset(priv->data_buffer + *off, 0, ret_size);
> 
> Sequential read() keeps *off in range, but the fops use the legacy .read
> callback and neither tpm_open() nor tpmrm_open() calls nonseekable_open(),
> so FMODE_PREAD stays set and pread(2) passes an arbitrary offset straight
> into *off. An out-of-range offset then accesses memory beyond data_buffer,
> causing an out-of-bounds read through copy_to_user() and, when the copy
> succeeds, an out-of-bounds zero-write through memset().
> 
> Reject any read whose offset and length leave the response buffer.
> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaewon Yang <yong010301@gmail.com>
> ---
> Notes for reviewers (not part of the commit):
> 
> Reproduced on a KASAN 6.12 build with a swtpm TPM2 device. After a command
> leaves a response pending, pread(fd, buf, 16, 0x1400) triggers two
> slab-out-of-bounds reports, one for the copy_to_user() read and one for the
> memset() write; on that x86-64 build the faulting access was 962 bytes past
> a 4344-byte struct tpmrm_priv served from kmalloc-8k. With this patch,
> out-of-range preads (offset past the buffer, at the end, or an in-range
> offset whose length crosses the end) return -EINVAL with no KASAN report,
> while sequential partial reads still return the full response and a normal
> read after a rejected pread still works.
> 
> Reaching it needs a process that can open the TPM device and send a command.
> Access depends on the device-node permissions; the upstream tpm2-tss udev
> rules set tpmrm devices to mode 0660 with group tss. My reproduction ran as
> root, so I have not shown non-root reach on a specific distribution or built
> a privilege-escalation chain.
> 
> I searched public archives on 2026-07-10 and found no matching report, which
> does not rule out a private, very recent, or unindexed one. Found through
> AI-assisted source review; the code path and reproduction were verified by
> hand. A reproducer and full logs are available on request.

I will choose to skip reading most of the text as already commit
message had zero relevant information.

Thus, NAK.

Please don't delegate the work for me that  you should doing i.e.
looking at your reproducer and describing the scenario/sequence
that would lead to infeasible consequence.


> 
>  drivers/char/tpm/tpm-dev-common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f942c0c8e..dbf049028 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -145,6 +145,16 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  			goto out;
>  		}
>  
> +		/*
> +		 * Reject reads whose offset and length fall outside the fixed
> +		 * response buffer.
> +		 */
> +		if (*off < 0 || *off >= TPM_BUFSIZE ||
> +		    ret_size > TPM_BUFSIZE - *off) {
> +			ret_size = -EINVAL;
> +			goto out;
> +		}
> +
>  		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
>  		if (rc) {
>  			memset(priv->data_buffer, 0, TPM_BUFSIZE);
> -- 
> 2.43.0
> 

BR, Jarkko
