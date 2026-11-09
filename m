Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236104;
	b=RK3+7v7TfHAGi+h6Ltjdt8OHbE8RX86gmlapAPllJREwhc8ARo/MarE1Eu0HEt9/Sdg8
	 jw0mx3vzUdveudSmUVYEn39rD8aTN0XYsUjxnHGsYUBpGqPKWBhr+iAQxkzfIQISBDAGr
	 NUJ1s9H8+9AJ9Cp0Xt0eGOzHD/862C+icJBs8Em2onfTzosE845MGJO23IlrSRGTm2EQL
	 7fsSXM8wasyyZp5yPTrvlidyu4TiZsXjsr+6w6TVWrYDXK1HkizEsRjxSojXNfhrWaZ0V
	 wJuT1E5L/RMv83GdPbQZljeC/TNV4yI5zz+z3+gAdSoTbSHAr8nm8CXphpT44Qatl4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236104;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kT8Z5Z2kEUrWcaYC02QsMolEzPrRweOdy0UnfYbn9q8=;
	b=vsAcHLS6r9xn84EatlCkbUJbBKbM1PUu19G4hKjDHWZZ2BfdulL6c9MqJ5OXEXGr+CBW
	 wAX23Q2OZeuX0e3R+G9H5A4FMfASvsW9QhHubghURp4rWxRLSB5Ob3zUqhtuv/PwwUSJL
	 23K+j/H7OL/jXrCMC2f2MmK8CqquwQCb1V4THjzG5rimyXi7FhbJze1/fG5IQxGE25U2E
	 VKbxZOnSM629rQlCm+npt6XfME2njoiipYGeS1t1/DhTk/+Sqz/ecq0UJYPhvr6zTMrDr
	 XnxFI7UCRJJxJTFg7Fb44mOkMMU/af4ZdYd+yvxEaakjlVfucX6uACUa9hh0OgcqKzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if5RIomV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 42506606A322;
	Mon,  9 Nov 2026 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if5RIomV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3AF0E1F0089F;
	Mon,  9 Nov 2026 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236103;
	bh=kT8Z5Z2kEUrWcaYC02QsMolEzPrRweOdy0UnfYbn9q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=if5RIomVFKJ/Q0ZjrIuubxQc5fTA4fT6J7xUoZLDmFxadcZVMAcycD72a/gWkTv97
	 pWUn/qMUzlxJhKEFfUEWqQVIoTMtcIbzIuPvESh+9pkLczuaI2RXKcHZEIcrv5T6E7
	 hejzBLWit392pSBkFx1HfIvtDfrL+mRy+4vsgAoF2ZiK2guxUITtPg5FUwAtays43v
	 jZdXtV6ZA6aIs7iqEpQJdSrLizoUw7kfePCVd2b45r3w8l2C6thzeqEuZR4DZ91xer
	 sqYRgDMpshTJDRTypF+xApaYTlApsALEzWQpm3cegJkdEKmhy6+sr9m+5RCHKTc7PH
	 xmniK/Cxf3w9Q==
Date: Mon, 9 Nov 2026 16:55:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: ibmvtpm: check the response size against the
 buffer size
Message-ID: <avHexCvi3-9Z8pgU@kernel.org>
References: <au3w4NDX1Uqz-iqd@kernel.org>
 <20261109014957.2777790-1-guozh23@xiaopeng.com>
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
In-Reply-To: <20261109014957.2777790-1-guozh23@xiaopeng.com>

On Mon, Nov 09, 2026 at 09:49:57AM +0800, Guo Zihao wrote:
> The send path validates the transfer size against the size of the
> RTCE buffer:
> 
> 	if (count > ibmvtpm->rtce_size) {
> 		dev_err(ibmvtpm->dev,
> 			"Invalid size in send: count=%zd, rtce_size=%d\n",
> 			count, ibmvtpm->rtce_size);
> 		return -EIO;
> 	}
> 
> The receive path has no such check: the response length is whatever
> the hypervisor reported in the completion CRQ, and it is only
> compared against the size the caller asked for before being used to
> copy and clear the RTCE buffer:
> 
> 	len = ibmvtpm->res_len;
> 
> 	if (count < len) {
> 		...
> 		return -EIO;
> 	}
> 
> 	spin_lock(&ibmvtpm->rtce_lock);
> 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
> 	memset(ibmvtpm->rtce_buf, 0, len);
> 
> A response length larger than the RTCE buffer makes the memcpy read
> past the buffer and the memset clear past it.
> 
> Reject a response that does not fit in the RTCE buffer, mirroring
> the check the send path already performs.
> 
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
> ---
> 
> v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
> Sakkinen: a hypervisor reporting an oversized response is not
> known to violate the architecture, so this is hardening rather
> than a bug fix. No code changes.
> 
>  drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 6fb4d30eb6f6..bfef4bc14767 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -121,6 +121,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  		return -EIO;
>  	}
>  
> +	if (len > ibmvtpm->rtce_size) {
> +		dev_err(ibmvtpm->dev,
> +			"Invalid size in recv: res_len=%d, rtce_size=%d\n",
> +			len, ibmvtpm->rtce_size);
> +		return -EIO;
> +	}
> +
>  	spin_lock(&ibmvtpm->rtce_lock);
>  	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
>  	memset(ibmvtpm->rtce_buf, 0, len);
> -- 
> 2.50.1
> 

Thank you.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
