Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219577;
	b=LmQfn0Hcb7HfDh2Kp+0uO3bx6mtmeV15YQGrdzfSkc69Y0bgJOtE5C042tFOS3+yeRrU
	 uu2PuFZuuLMk43Hgswtx2srNngyz7d+K+lH/DIHMiZpMjryG21/OZpCichuOYjlm0dwCo
	 OteIP5Knr/nt3S/zLCK8v17UokzlMEW5o2fWz894kExS4DsiJq6r2Jg6zP/U2Sus3YFpZ
	 rPLNlhyn6cQgxdiEBgBITYNfs5rsqMknF5FDUk3XizvxMlLfNRCimmWJEbUtizIc7qtk3
	 09qvTZioj4myrUa+jZO0PXQm7wt65CPmQdol3Sy1nLHXC+78/ncbNGvYJCgUYkCYz7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219577;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9X+pCcekx/7Rlff7Kqi2J3DlR1/Mhd++k2xfF7L25Us=;
	b=gvuh9upJfM/ppVGQjVJxsIagZ4otjCX5jjOUAUCvSIMP8euVH6cH4gZaZhuEdCQBlBN1
	 sw19pfyqfG2cNs/AjbgM1NMj4adMzlfpQKVgq6xnhrykGmCfEBOIS42K7aimd8UWUTtH8
	 /aoY+L3G+86Ij6wXyLA9mmT9L1lStQwIJaaqB42wlittZdh/YrOWvxJ7LxiZDNXV/xlz0
	 CDNYGRTgBubPV12R6RcaPGjoCZtjp4kAzzEKpWKgF+iXPOmAStjHtXDDceuQfwxBDVhas
	 QI/Wp7Tdw5RkUf974ZC58zF+pkzRF70sGZ6ffy7cfMTFHbrvJ6gIGdBmGjSlpUwFM5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frjp0mtt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5D03A606A31A;
	Wed, 28 Oct 2026 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frjp0mtt
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9D15B1F01825;
	Wed, 28 Oct 2026 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793219577;
	bh=9X+pCcekx/7Rlff7Kqi2J3DlR1/Mhd++k2xfF7L25Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frjp0mttVjhyleq4vIqg5I5lH0FWbMuSjV49m5JhQi6ZEk5GIPFEcCqTrvSBLMGHy
	 Vx+CSxVP/hYgaVf8uyGn3L0iDDXS63YGyQ1kUPoxLXxN7L3Qu7T21IUDuWTwK4IpRS
	 gtqb+GsgxlUthwGHH7GsueH6QrZCcCugpXNVEHrHaC8T3LeUZ4pUs6j9SKLUbyYS+3
	 fvz/6WfSMefTcmy3XzxgJltDZdEHkTogcNZi7NtrIHeC3Bz3fFLI32cRGZQjfzZOUQ
	 dbS8bjQDyGE3QfpOEunAujtt54EN6mY6YACQSHUls/7efFo+AsPZ2kls8l3m8thvwx
	 blWyo0FlPuGSg==
Date: Wed, 28 Oct 2026 22:32:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: linux-kernel@vger.kernel.org, pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm: tis_i2c: Add reset delays for ST33KTPM2XI2C
Message-ID: <auJb8drL7rpvNMyK@kernel.org>
References: <20261028094504.4256-1-stefano.r@variscite.com>
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
In-Reply-To: <20261028094504.4256-1-stefano.r@variscite.com>

On Wed, Oct 28, 2026 at 10:45:04AM +0100, Stefano Radaelli wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> The optional reset control is deasserted without a delay, and probe then
> proceeds directly to the first I2C register access. Since reset-gpio
> initializes its line asserted, this provides no guaranteed minimum reset
> pulse width or recovery interval before communication starts.
> 
> Table 66 of the ST33KTPM-IDevID datasheet specifies a minimum reset pulse
> width of 1 ms and up to 50 ms from reset release before the first command.
> Choose a 2 ms assertion interval to provide margin above the minimum and
> wait 50 ms after deassertion, before initializing the I2C guard times.
> 
> Associate these timings with the existing st,st33ktpm2xi2c compatible using
> match data. Apply the delays only when a reset control is present. Preserve
> the existing deassert-only sequence and the behavior of devices without
> timing data or a reset control, without adding Device Tree properties.

"Pull the timings from the matched device entry. If they don't exist,
fall back to the legacy behavior without delays. Update of_tis_i2c_match
with the timings for st33ktpm2xi2c."

I.e. the last paragraph has the language of a white paper.

Br, Jarkko
