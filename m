Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437218;
	b=hUPFjGYimZ3S7EiQeYnCqNxijMYzto8H1QBS3YOh98fYytgxlvB/ZWsb718Pgp6uJuJw
	 0Fg7yfViJJkFWfpeTITNGoX/oqW/+IgBS/fGEUlIjSPE6sMhH6EY2taW3A/bFKDkwvQJU
	 jjOygkew1KLbgPqe6de/rTXodQwfZLqPmlXdEB/D0XkkpKOMAtiuN2Mm3WbvCoOrNnFxf
	 cW1AIk70CItQLtEUmLCJP4Z0jU+sSwZ2OkObm+KW9HGVSNPTJxeiKyJAIB2exre3TmAnz
	 UkEMF1S6es61LJReK9TKUy4O51yBft5pJueOv1o6eYnzsMOJB6X1NkM11C1+d0oNtbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GuRlW5xp5Hyxk81DN6+nWBE+HjAJayAHupacnd1278M=;
	b=k3nSzez46U2aP/oqNMRL6XhPjaVBJJbcpnPcwF8BjpuIQSmUeFHh6g8409dzqGuuJxnx
	 6csg4aHD8BaHFELa7SZfi78ValqFNQEtRHm1oJKIRC3bbXHp6EoNIr9aMI4XJBtwEu8mx
	 SIvJlONiNgEaE342bTIZc35C7aXE+lVOrQJFoZwRHh405+aUgQieLgdVOeuodVc3QDUIu
	 kT3s0cwbUfgI3PmLUKjQRfthFrUzcW+uCIz6FiDSBe3qtJjnyv1vy1T/koJfmKDiA7fFz
	 FnBvo03FmaYaDAx0JbL81k7RvC7ZobUjDGmyl7+GqSE2OtEC4QmAw1K9r1uRzqSy30g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6kjyk3d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1AE34606A326;
	Wed, 11 Nov 2026 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6kjyk3d
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1BD7A1F00A0B;
	Wed, 11 Nov 2026 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437217;
	bh=GuRlW5xp5Hyxk81DN6+nWBE+HjAJayAHupacnd1278M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I6kjyk3dY2FoAnlVfqI3Ul3cvgv9t0vZ/tAlj2tk4LbNS63QRR2z+qsC40qMxMmvK
	 ZpPtN/TdGCcGl3Ngf52vsrisRJKoiCBAyUIgu7mXRO9qqi2hpMDOFAHIB7u8zhi1QZ
	 5ISBT0ZUTeOBKx4yoUVaJ3EZT7SCdfFNk9ZfMnDxSV9W+eN03zcQjeRlKXLDewBVuL
	 mVNR8VijncUI7S5znS6Ha8C3vBZ1mVbng9vkplI0h51rAqiqlG7SYkXuHllrACO/q/
	 GeGm2Y378DtP/EXLYToKcGPaOf6ZfGes21k+QYN1mcRMrsNQ9Va+p4HXPJL9FeOkYN
	 QJuo+eL2hvlNA==
Date: Thu, 12 Nov 2026 00:46:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <avTwXhEGwVj71VmH@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <avTsh6pCI-sRGAJp@kernel.org>
 <avTvq4VaYbxMnZl9@kernel.org>
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
In-Reply-To: <avTvq4VaYbxMnZl9@kernel.org>

On Thu, Nov 12, 2026 at 12:43:59AM +0200, Jarkko Sakkinen wrote:
> $ tpm2sh return-code 256
> TPM_RC_INITIALIZE
> 
> I.e. TPM has not been properly initialized by TPM2_Startup().
> 
> I.e. TPM is also saying that it is *disabled*.
> 
> So acting on this proven fact  makes most sense to me.


Actually, should we even disable TPM if it returns this error code
already at the level of tpm_transmit(). It is a guaranteed dead-end
to any possible TPM operation.

I.e. while this fixes hwrng issue I think it might be addressing the
issue at a wrong level.

Br, Jarkko
