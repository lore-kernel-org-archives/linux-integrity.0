Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448911;
	b=5nsDa/boC051+RkVP5ag2xZKicIy6nPlf6Oi8Q8btVfvbsb3Vjk4BaTlI1ndfrhUsO77
	 We4z6T+fcwmXR0z0y4HcacaOA0EAE8yH4tFZOAYGcTsWes+5nVBFOYLrhFqEb732hVkez
	 Ocm+WMvbr/EvooeCAHVflohZh5x9/mO4l6Y40k8YZYnhobtCnCVWeX9tZagtQlCrGWWAQ
	 dxE53U8pkTRA5EDI9RSVwmN+WwCfIWc3XVIqv2RyC2/cfSRLAZJSiFkuK2RZzwGbBiR7p
	 pVXNXU88dkhqGODjlL4jhVX+4gZBPCBkJwYVyGzMtBblO1w9alOPO5dPoiP7+qH3C8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448911;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EQCrnWrztx7M6qkgpjYNZdpuNPw7yX9pPuMUsoxbc3E=;
	b=bbfWcT8d14PdUdLi3K1cZoFpHxEC9J7muPz7Mz4BADVmqmcpa7fg1P/A0VrdPAq/oEH8
	 MOM+czENuzEjAzH1sLG8UJKTc4x5FymFTIKxsGkLoKuCK+Bd/9yHddkwfLWlmPbcfTsXM
	 9VaVoV5cRtxGJV/jvXL7af0f6Qxno0VlDh0rWVTxoyVTSzFEgUTJ3QK1SwQ5acE+nrhGL
	 Tn+76VDMZPSODVPJDnYSQZd0H3LJ5SizKREWtdo/EaOQHbNWJLAqfpbu1M+SgF8M5P95e
	 MY+Ny5Cw8IOcpUqF2NSSKCrhqQETA+DBn577krLDZxfEP9gp872KBpcpeHNmGJF8mpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hop8OjlS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 65C6B606A891;
	Thu, 12 Nov 2026 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hop8OjlS
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B9EE51F00A07;
	Thu, 12 Nov 2026 02:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448911;
	bh=EQCrnWrztx7M6qkgpjYNZdpuNPw7yX9pPuMUsoxbc3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hop8OjlSDa5HGwxFd6p+bJDspgAH/f+75jgaaS2qqLcb/mHDFLa4yvhCReNjKyG8w
	 wI4Hz0VXhvh94Ms4jDPHXHE8+pf7F1ECHCa2L4AXVx02x8cc943zoYdOnmR3yXaIuG
	 dZz7G12NRQvI4fQ/5VAGTS9imfmucBfgDdgcVplBByuAJz0qHZyGMLEDEkIDAmjm7Z
	 5RjJ5NR7gDjIzb4vloDd66N5vbwaKjsUlZRBftEM2pKKC3gi8yggFlC+AEP9Goj5l8
	 NdThipjk2oHgTr8pdWDyvAntRZuQ9YHLbzg62peDIYy6jLH3HEiIKW69yoY7pfBSGK
	 yCc575VnnnENA==
Date: Thu, 12 Nov 2026 04:01:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <avUeC_szxkCe5GtG@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <avTsh6pCI-sRGAJp@kernel.org>
 <avTvq4VaYbxMnZl9@kernel.org>
 <avTwXhEGwVj71VmH@kernel.org>
 <avUdBbvxxFgXkUJI@kernel.org>
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
In-Reply-To: <avUdBbvxxFgXkUJI@kernel.org>

On Thu, Nov 12, 2026 at 03:57:29AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 12, 2026 at 12:46:57AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 12, 2026 at 12:43:59AM +0200, Jarkko Sakkinen wrote:
> > > $ tpm2sh return-code 256
> > > TPM_RC_INITIALIZE
> > > 
> > > I.e. TPM has not been properly initialized by TPM2_Startup().
> > > 
> > > I.e. TPM is also saying that it is *disabled*.
> > > 
> > > So acting on this proven fact  makes most sense to me.
> > 
> > 
> > Actually, should we even disable TPM if it returns this error code
> > already at the level of tpm_transmit(). It is a guaranteed dead-end
> > to any possible TPM operation.
> > 
> > I.e. while this fixes hwrng issue I think it might be addressing the
> > issue at a wrong level.
> 
> I leave room for figuring out 1/2 but for the second issue I would just
> do what the attached patch does and call it a day.
> 
> Br, Jarkko

> From 093124e51a26de8191e21ce41988532ea7e0bc8a Mon Sep 17 00:00:00 2001
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Date: Thu, 12 Nov 2026 03:55:00 +0200
> Subject: [PATCH] tpm: Disable TPM on TPM_RC_INITIALIZE
> 
> If the TPM has been spuriously disabled, the game is over. Let's reflect
> this truth with TPM_CHIP_FLAG_DISABLE.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-interface.c | 5 +++++
>  drivers/char/tpm/tpm2-cmd.c      | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 470b2da3234e..1f1e22341155 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -256,6 +256,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>  			break;
>  
> +		if (rc == TPM_RC_INITIALIZE) {
> +			chip->flag |= TPM_CHIP_FLAG_DISABLE;
> +			break;
> +		}
> +

Sorry, should be TPM2_RC_INITIALIZE. 

Br, Jarkko

