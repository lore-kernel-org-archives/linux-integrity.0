Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517636;
	b=Ih6t4BGpKAsOctIiB4L94zD0dtpHj42JaHMu72bXayWsFvh92pgOnqjz9nWqgLD/ch3C
	 3NGYXR0plOsWJEP8heaEQgTtCWF4F8zAZo1Fb53Fn3TkiD2IVrPmgl2l5LpGL+Me4bTgG
	 o7tgSfK+yW8IiS1qUUsO7ZiBcHyD21p2IycxtOgbRT9z9eyOi6v/K2aQZATSjNzQQVpgf
	 PdoiUVZmiU3nflAX+RWoFsG8nWex3izyPOk8Mq4znwRN0730QB6DPXVVUKGJykg76mIYd
	 vLV5VtikBLWouqtYHyns/rvKvllu0klfM3AZT2hRVSrAc+Jn7KF2xF1yNpPWgcZJXKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517636;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3GEZTyZOwDuoCiuhG/4FprPlWRmVhdr+8eAF/q4Z+7M=;
	b=FYrbTItxHu+pScTu9ORkEpXSR0hSzFmEioUAvV7QLWTNaYkD0rliwGIeXQ9sZD0DIaun
	 YgSBCNcuLNTMSwbc2tt981dDsCACTO3nAy+wZP09PNLlLIv9fGhSmXXYHz2jt7A1L+VjP
	 jFg59vWv2TKkR1ixu0AB9CuTjadx/MV8yCbc+hAMNoe8g/YI7W5CeCRlAuG9Mm2C/3Rv3
	 fKmpLb5Wf+FRyQsyQmFrALx9fJB9AqMmW5Bg3wRigsiO+C90vnYVJ+LWrN7eNtrovpdd3
	 qoq4ltyO8eLucSJpIwtuJy7iIwH3Je/S1fIkzVKBG43W44x5zxZ1kIJJg9t4yIQ1IKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekwxin7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BF25C606A31C;
	Thu, 12 Nov 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekwxin7L
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D200C1F000C4;
	Thu, 12 Nov 2026 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517636;
	bh=3GEZTyZOwDuoCiuhG/4FprPlWRmVhdr+8eAF/q4Z+7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ekwxin7LFqq1d7kjhY15HKFXnJrTsyV4SoNVZQtby+sl39cWT1X5VoGBI/yXkA2C3
	 tAMAtIkGw6sFwUVq03wK0DCjY96TB8Kg+wS4rxYSVNLxyt2TJv4kTWeJJBBnHGMKVL
	 z5+KBtLCHcldAU8TMgq6q+Rt3IgdVmKzqTcuHtvrLgv6jykRiBECR6C26g496q1iRz
	 tBJceiYhIhB9rdu6fMn/cNP3xpNr1RhKmPP4PxPEFC2yTQ9+ynrwItW6HBwlwyy9GN
	 Qc+OFUp04318da6aPLuY3vxOLXdHp7zM9qMulL5NjyfYRA7vMQ/L0hUENuYb4N6P1L
	 hPSMkumIHWv4g==
Date: Thu, 12 Nov 2026 23:07:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avYqgDjJYw-UjaZi@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-1-7454d2c899ef@debian.org>
 <avXGjiejK2ZlldKs@kernel.org>
 <avXHGmmdY-CVgxEf@kernel.org>
 <avYkGKXOP2-hhewz@gmail.com>
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
In-Reply-To: <avYkGKXOP2-hhewz@gmail.com>

On Thu, Nov 12, 2026 at 12:40:45PM -0800, Breno Leitao wrote:
> On Thu, Nov 12, 2026 at 04:03:06PM +0200, Jarkko Sakkinen wrote:
> > > 
> > > This would be then nr_lost_responses.
> > 
> > Oops sorry.
> > 
> > I mean nr_missed_responses (and I would prefer "missed" over "lost").
> 
> Would you hate if I go with max_missed_responses?

It's a great question. Here I think asymmetry defines things better,
and makes sense also few months from now.

So I think this would be most consistent:

1. kernel command-line: tpm_max_missed_responses
2. tpm_chip: nr_missed_responses.

The first defines the modulo and second counts up to that.

Can't recall (and too lazy to check) how it exactly was in your code
change but I would formalize all this along the lines of:

	if (!(++chip->nr_missed_responses % tpm_max_missed_responses)) {
		/* chip->flags |= TPM2_CHIP_FLAG_DISABLE etc. and of course bail out. */
	}

	/* continue doing things */

[those comments are not part of the proposal]

Br, Jarkko
