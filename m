Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436235;
	b=pl9i4Y+D8GiOpcxrU5CcMN2TH3lgTzfe8/2stqoWNKX4H0uJH0J6bN+FWO7C0T/cowtM
	 POyWDxsO05mcSMcH2W4VIBP4kpiCjuQ7gAoaB6KLjjog1dAEmN8NtbPJmq0YhClegKmt/
	 uDUHzhYXX0ul7KwxeMCsxABTTL3wnp5J2jFTqKeg+1M1Fyqv2RXSir8+PdQoQ3wX2/HtJ
	 PeGNFf8RmAoeVaugMOAa5Y/iD6cof3UKL2tEaiU3XJ9VKk/aX1g/L+pliDmAfFmtEOMfH
	 ms3VE10gHhDM/U9t5c7zJvolYHxEHXXFoVFYcpGo8HBTGIQzJTx4QWHm03uK+r1sIjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436235;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=srInJ1lFttHBxQxY+VpLS4HIIUibvm9Rc8ekjajKEn0=;
	b=T8YYgmf6xreiBcp5eeMJwS4Oen6ULGsUyw6z2T3t1/axxc6k0hLEWDICWBX6c1o0xZGZ
	 BwkaH9iuW0KNzjM14L5h9HCm2gRE/5UH9TVWx6tCWx9/+uPryd4rACCHX73t3wAUmBMzm
	 NjLVIQdKCjk7fWAYbT70U2g9xYQZQ4ZqC1AJNSfYIgJYPhA7waWXBQAlQ2LdXYdvvsw1H
	 r1RacUQ4BXBP00AWEG8Kl8Bkxt1ba1VnBD1xOfebsnFfDTwWv55EhBsdcA1RnRiNXx7Al
	 2VE5FAt5lc4kXq2mR/w6OLJsYGfGV7i2hAABq4Paw9honf/ZyWiTFlYJHkp+HGQ3NRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7ZH5nzw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A2B66606A333;
	Wed, 11 Nov 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7ZH5nzw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 034FB1F00A06;
	Wed, 11 Nov 2026 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436235;
	bh=srInJ1lFttHBxQxY+VpLS4HIIUibvm9Rc8ekjajKEn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k7ZH5nzwqYIfvrDQEzyyLu6+KZ3xKazppHoXM5EP339KqOV6fG/GxYeoiSphdvnBJ
	 QG8RMzqybUTQxPnGBF2ztZpbjCcUCe7qq8dOmQgU27HS3UgNRPX2D2MGsXDiGnh6ca
	 pMY7McUMDUOjOQnwaOKXwgrUNO2iX+H+7lznG+U8Cx4Z4zTWWOqYCddhywwOPZcO00
	 2xMOGVbhW1vh+MpxavKOdgHKyHmSBfnBwSISFRUVip+wJHMWhk3UfFIC0SQ+8gM+zj
	 a/5T1jytDV+KncNF7PMkardjaGSlhFyrixbpRFiYwZRPnJeeUpThnKPri/Z7o1WfjK
	 Nwf/dPxih4cvQ==
Date: Thu, 12 Nov 2026 00:30:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <avTsh6pCI-sRGAJp@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
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
In-Reply-To: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>

On Wed, Nov 11, 2026 at 01:57:32AM -0800, Breno Leitao wrote:
> On Meta's datacenter, given the size, TPMs that stop working write about
> 54 million lines a day to the kernel log, because nothing in the kernel
> gives up on them.
> 
> Two cases make up nearly all of it.
> 
> Some TPMs stop responding. Every command then fails only after the
> transport timeout, while the hwrng thread and userspace keep sending
> more.
> 
> The goal is to retire TPM that are not properly working, similarly to
> what was done for EFI in commit 4b2c033b5bc971 ("efi/runtime-wrappers:
> retire the worker if a wedged call ever returns")
> 
> This feature aim to disable the chip once its commands have kept timing,
> instead of keeping it in this desolate state.
> 
> Disabling the chip makes the failure explicit: the log gets one line
> saying the TPM is disabled, and every later command fails at once
> instead of timing out. 
> 
> A health-check daemon, such as machine checker, can then detect
> the broken hardware and send the machine to repair.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Breno Leitao (2):
>       tpm: Disable a TPM that stops responding
>       tpm: Disable a TPM whose hwrng reads keep failing
> 
>  drivers/char/tpm/tpm-chip.c      | 20 +++++++++++++++++++-
>  drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  3 +++
>  3 files changed, 51 insertions(+), 1 deletion(-)
> ---
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> change-id: 20261110-tpm_unresponsive-a5f71c1db026
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

I think this good stuff so existential condition for having some changes
to address these issues is fulfilled.

I.e. debating the details through will likely lead to productive results
:-)

Br, Jarkko
