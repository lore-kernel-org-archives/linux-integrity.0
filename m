Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625942;
	b=ZpJ/9Z7/o6fUWR1NdIMi10bZHgzkRSezyk+VmOWqTSR1ri5Jba3YiuXFioq5/GSNkIw5
	 czQOsCHz1TpSJfElFgXUVdmXKvZbDa6choQglph4Z4RcDscKoNBnxmTNLENg/FeQ0gDMS
	 W8L2k6PzRz/0OLwDFbk6srghR02+MKXttYEUUlyAyes+txjWwNEhVCspYFg51QwrVZezV
	 rd6elEabbhDChZcqgR1X/i6clPwgpv18QlJi88+Pj30sGPvrdrYgbr6z13OoBzMBqPzkq
	 +oPVg4N/i16e4zeb7cCbLe6VUTlAQoZHoGPjq7xljYn8SPPIGaZv0u3Xd/YZHJX3kWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625942;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2+o1EBv4JQsHaK2LddYpkv6BdTI9JvYGTu/rpoBC/Cs=;
	b=zSE2iHcjshe2TdjdC4xoxH+5+iLrWqv18c/HMfcB/emo18fRB1lYnd+5gblzeG2mlz9S
	 s78T7ltdYISIt8XMb5yh8X5hyrHIVFmCz1Trp/OfRN5XtL0o5BDuGqf7NSPuOuGfkjCXI
	 vpO5wCigzjTS5dCVLEvih2ctH3XHtv8EOSqjOppC1aVrCOyHopAvKnFULiacR8Fip/rWW
	 Id9zXBqLCYoR5TLwZUrt2AEpHvbZZERNo5MfUL3SuVw0MS1pSRhpPq0+cQDu9i53J95Kw
	 HHqpACouGXwAJ0bR6Ex0NuM8Qgm03PK50g1cESMj09j+r+atHUXCZikTOAlmVvoAGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clqpZet5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6C385606A321;
	Wed, 25 Nov 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clqpZet5
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5DD3F1F000D0;
	Wed, 25 Nov 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625942;
	bh=2+o1EBv4JQsHaK2LddYpkv6BdTI9JvYGTu/rpoBC/Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=clqpZet5kuT2xHFaB0UMl0LNlxmAnU4YFAvwqaEgB3G6pg3ceVz7xhi0UQwg9UaAy
	 RcCdlIo/tmid6MqiWs6MvHmXwxV0eDwmoqyp3HKdevSYSjcy3CXCQR1seq9gnK3Vjq
	 Qv1IxnOwYvAedQAXgqQfBKeMP3GXsd8JU4CXp/tvd0zh1o4cweXDoKnq//jUFhaFE/
	 L37vdpDN7cgo5mvJx17iP5EzgCZs5VUju2zDwTI01nzTPR/4MECExpVVm2tW3etSt7
	 zV130NvFsbbOyY4rq7rbgco8ZA0TOVqK6QboNwd0biWgWe2lMBleVkTX3lsqsllw6F
	 tEPEEbP1SCkxw==
Date: Wed, 25 Nov 2026 18:58:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and
 /dev/tpmrm0
Message-ID: <awcT0WnnJ-fyovnn@kernel.org>
References: <awXHzblUfp05jZSQ@kernel.org>
 <20261125065429.1483868-1-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261125065429.1483868-1-rmustafin@cloudlinux.com>

On Wed, Nov 25, 2026 at 01:54:28PM +0700, Rustam Mustafin wrote:
> io_uring passes its own file offset to the TPM character devices, although
> they are opened with nonseekable_open(): IORING_OP_READ copies sqe->off
> into ki_pos without checking FMODE_PREAD. The devices also keep a single
> command and response per open file, which does not fit asynchronous
> requests.
> 
> Add tpm_common_read_iter() and tpm_common_write_iter(), which fail io_uring
> and AIO requests with -EIO. A multishot read uses a synchronous kiocb, so
> also reject IOCB_NOWAIT and io-wq workers. The callbacks call
> tpm_common_read() and tpm_common_write() once per iovec, so readv() can
> still split a response into the header and the body.
> 
> Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>

Checkpatch with strict afaik already complains about assisted-by and
it is not a discussion topic for me. I make people do enough effort
to the patches so that they can call them of their own :-)

Br, Jarkko
