Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627112;
	b=fU6vwLS3n7PP99XLAe0q15mYP4MY/w0EZCoWXLludw5AJDL0PLKT6r+WHe3MokMN91XH
	 k693sT+x85co2BjnmkHpMW82EO1Sem926UPiDzeuqGwZQYBSK9wPD7CFXmuN32iCFnsNd
	 RS+7dKRf7Y2q1i84x9zeZ6w7w/ZSNLNtKslGFAomaICOtq60z8tR2c5X+k/PumYc4+uXs
	 nBdDcKLTdO+QD4TmgNtki7FZqy82IykTKdHbBJUh4L7qBLLjFVaQzeqJkasz08CkI/VBK
	 GCyxHcZQv1W+3viDH/0EUC3iLoXFCrxVW/Dw9qNTOqGYqkDGAC2XoBdtM9ZbLDfdiXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=qjLgvVyKhNbuxvI8FqttETSqCaTWwN9m226voxoucsw=;
	b=ddEBgpkyLTazeuHrJxVQqi9sOU6QwEbGmrdF5hIfp0S6PYegeIQT40jQ9DiYx1N0IEvm
	 LtOxxlUD2MqnmUbDXYibMrs5d3A+bovEiABgBydo8YIC6Rt5ttjcOcUjgtifM31WzcZ3/
	 KWsHtZjDqfVLKAaRvYqIoq42mAik4+sNd/bqJEt5pnnLYcyCukyJkZWAT4wvo6fuAgPmT
	 CS3gZgowwaJfy2OiwD3Cfkm/SK3rXk4YlghV2aySYlYkYa+0Z5kbzGlt7KbfSvHY+3Brj
	 4v4BQKlVh1Gjs0+aAcjm88yuDFtpHwqUpYovA8WbkWyfMe2DJUybJJrKAp+yjV6CEdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NeWvkwH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 83AC9606A31E;
	Wed, 25 Nov 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeWvkwH/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 96A701F000C0;
	Wed, 25 Nov 2026 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627112;
	bh=qjLgvVyKhNbuxvI8FqttETSqCaTWwN9m226voxoucsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NeWvkwH/Io9yCo3X++Sh/mv3tG0i83t862jdWjQj5F/JtCNusidC1bvHbYFsyfpvx
	 sQj7pxpQLHlwgZkKAnwFhCLadpFdLmchaJ6IAN7bfYkaMi+h2pdhj2lZIUDZb+Ng6t
	 lcv0jhWbWK2UrDp8SAmE0mQRdmFh8zyNAyr06Z1/EKUyx2U88rWPQKkAkqFnuz08Ol
	 FpgrYZiCMxQFb82HkqrMeaa5F1KB9mGtyF0yy+divxenLRtdbU+jibXv1RSEafjp15
	 vtE2b6He/fNyirZ/BxGdLwwwu3qW39r8R+C2jjCtJk7BhsC6+3bVWLzz88KycyqYMR
	 O2url12Yd1eCw==
Date: Wed, 25 Nov 2026 19:18:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and
 /dev/tpmrm0
Message-ID: <awcYZNG9f2YSIz49@kernel.org>
References: <awXHzblUfp05jZSQ@kernel.org>
 <20261125065429.1483868-1-rmustafin@cloudlinux.com>
 <awcT0WnnJ-fyovnn@kernel.org>
 <awcW90qZvOim7dbh@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awcW90qZvOim7dbh@kernel.org>

On Wed, Nov 25, 2026 at 07:12:28PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 25, 2026 at 06:59:02PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Nov 25, 2026 at 01:54:28PM +0700, Rustam Mustafin wrote:
> > > io_uring passes its own file offset to the TPM character devices, although
> > > they are opened with nonseekable_open(): IORING_OP_READ copies sqe->off
> > > into ki_pos without checking FMODE_PREAD. The devices also keep a single
> > > command and response per open file, which does not fit asynchronous
> > > requests.
> > > 
> > > Add tpm_common_read_iter() and tpm_common_write_iter(), which fail io_uring
> > > and AIO requests with -EIO. A multishot read uses a synchronous kiocb, so
> > > also reject IOCB_NOWAIT and io-wq workers. The callbacks call
> > > tpm_common_read() and tpm_common_write() once per iovec, so readv() can
> > > still split a response into the header and the body.
> > > 
> > > Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> > 
> > Checkpatch with strict afaik already complains about assisted-by and
> > it is not a discussion topic for me. I make people do enough effort
> > to the patches so that they can call them of their own :-)
> > 
> > Br, Jarkko
> 
> b4 shazam for the message-id:
> 
>  mutt -e "source ~/.mutt/muttrc.kernel"
> Grabbing thread from lore.kernel.org/all/20261125065429.1483868-1-rmustafin@cloudlinux.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 8 messages in the thread
> WARNING: duplicate messages found at index 1
>    Subject 1: tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
>    Subject 2: tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
>   2 is not a reply... assume additional patch
> WARNING: duplicate messages found at index 2
>    Subject 1: selftests: tpm2: test that io_uring reads are rejected
>    Subject 2: tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
>   2 is not a reply... assume additional patch
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
>     ✓ Signed: DKIM/cloudlinux.com
>     + Link: https://lore.kernel.org/r/20261124142432.368943-2-rmustafin@cloudlinux.com
>     + Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>   ✓ [PATCH v3 2/2] selftests: tpm2: test that io_uring reads are rejected
>     ✓ Signed: DKIM/cloudlinux.com
>     + Link: https://lore.kernel.org/r/20261124142432.368943-3-rmustafin@cloudlinux.com
>     + Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>   ✓ [PATCH v3 1/2] tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
>     ✓ Signed: DKIM/cloudlinux.com
>     + Link: https://lore.kernel.org/r/20261125065429.1483868-1-rmustafin@cloudlinux.com
>     + Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>   ERROR: missing [4/2]!
> ---
> Total patches: 3
> ---
> WARNING: Thread incomplete!
> Applying: tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
> Applying: selftests: tpm2: test that io_uring reads are rejected
> Applying: tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
> Patch failed at 0003 tpm: Do not allow io_uring for /dev/tpm0 and /dev/tpmrm0
> error: patch failed: drivers/char/tpm/tpm-dev-common.c:13
> error: drivers/char/tpm/tpm-dev-common.c: patch does not apply
> error: patch failed: drivers/char/tpm/tpm-dev.c:62
> error: drivers/char/tpm/tpm-dev.c: patch does not apply
> error: patch failed: drivers/char/tpm/tpm-dev.h:28
> error: drivers/char/tpm/tpm-dev.h: patch does not apply
> error: patch failed: drivers/char/tpm/tpmrm-dev.c:49
> error: drivers/char/tpm/tpmrm-dev.c: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> Press any key to continue...

I got them applied with git am. It's better to use separate threads per
patch set version.

They are in  my master branch now.

Br, Jarkko
