Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435633;
	b=cOnt2WUTjc4QsCejpAB5/jvyOVXDwHuRBsIKC5wYFad4MaRiDxXySIQ+pupExEOMA+Lj
	 dIz1iQyeuhewErmm3pBYe+HqyvplUVk6OVrKIGHrGJVt7sHAmM9s+5btD6Mchkm2uDy98
	 2ctgXe1wjsHeXDUQGL4fGoY1fAn/fNiDq+saRUA2et1Q7fADcaMdwqV8eYvOM6rhQnifK
	 1X/bNrAzSTOLQvsh204ZxJ+8q5wU8bPMskiYEb1E8yedGq6ysu4/NQEhVX4SukJfcsY1o
	 3ORF+/RzdcD4EN3EM/KW4s2VjHWVmTh1W/91UlmZwumniHw73HJEgzh3B1I8B5od6rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435633;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K4KdjqORRmEBTUM7t1u578GKcdnKKYKwwNZ9QN2PlGg=;
	b=t98C70ksipPFsDGk23E7qe/DV2oI0gJnBOsNFleOtOQqgcFGszijsGz9xTsKXQyJ7BTW
	 xf1LXxF67NWKPDpHUzG6QyyyIS19/Bb4GrJVNizdFEZoKx1R4hBtYryhOKUGT70uz5EpO
	 dforBb/GY9mv/QUj3bQ7tSjn6BYFZ7xUznAc28zNLTnPKxT2wz03st8qJQl9p1o/l5DcW
	 +CCLeGLbxFdpUkFhHUI4mzPQvV7XlcEiXEAWmZk1a+0vmDZpc0hmqbhcPVMdjSNaFNmNW
	 SDwSGopZl716vTOZqp0j9acdxLAr9ENRWkFHK7KlUMuwTpJmaHglk8oujlxRguKu3uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlwaUFls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3145D606A31C;
	Wed, 11 Nov 2026 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlwaUFls
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3944E1F00A05;
	Wed, 11 Nov 2026 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435632;
	bh=K4KdjqORRmEBTUM7t1u578GKcdnKKYKwwNZ9QN2PlGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LlwaUFlsfzgkM6AuRKez9QzQX0TEEOJxmHs4kOCmH5iQ4veaMq20Wa6hNzuOffLGU
	 /CEok1195hJxoq5ng6lcAX2NfMRl6Y7NtbD54nGZrSQjoaxja2xaIg2VNLgh19NZxw
	 g4h8eufMAMmLaXCkGW3wtuyQjSsM35T58/E/NhPApSqE9Zi4Us+7FfQ5iEVVS7Beho
	 ZyFj9YKTlYH1cSGmuYuKtXFVtgs80IeII4k8gN+O42gAxWmBAFUT+iE3lhdWkSbhFT
	 GHMIdU0M9B7ZOb4EuA65QCTXT78ShyX6D0mQ28EN8kJVv//deO46Dy8zNL1L8P0MRt
	 ZuBwc0lQ+ohyg==
Date: Thu, 12 Nov 2026 00:20:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 2/2] tpm: Disable a TPM whose hwrng reads keep failing
Message-ID: <avTqLMLZwKOb-Q_j@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <20261111-tpm_unresponsive-v1-2-42ac1b965eb9@debian.org>
 <avTpOlKixInIBmE6@kernel.org>
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
In-Reply-To: <avTpOlKixInIBmE6@kernel.org>

On Thu, Nov 12, 2026 at 12:16:30AM +0200, Jarkko Sakkinen wrote:
> I'm thinking here that why not disable on first failure?

It's a more intrusive change, yes, but then again having a count
would require assumption that there is high odds e.g., for the
following scenario:

1. TPM hwrng fails.
2. TPM hwrng succeeds.

I don't this is very likely to ever happen... So thus I'd drill
this even more than you did.

Br, Jarkko
