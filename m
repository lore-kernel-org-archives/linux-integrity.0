Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437039;
	b=dsN5LYINpC3xquYhHF+3vniU+Ed8HJoOmY8BKZXsHh8dgiVZjJ2Htv/inuzkUXC+OIKp
	 Ij242ekxZa6KxEyJc38Rv3RdkfHiC0c/wXTJkL2T9T7t3Sq1XvAkGtF75f2J5v7TuszkO
	 czjqtZNg6heiHUmuM7OYd18f9vIcm0xykFyIfxi+XoAywcRLHETyLjT7jPek4sQDx4X9e
	 yd+kzNAHlVbsgk1JZNna1ztBVnBUtp/9YT411qojw2s/UNAUXOgRvOg2zuN2UA5xeBexI
	 1Tmd8ZC0IhFuICITdZc7cNecXIB5kPWt2JF8fK9usJLs7E0EyxBNZ4iKbEHt31xGX8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437039;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cV0Z68L8/Ou2EanKKDEt9NBi0/dgx6N8W0Ly7e7d7sg=;
	b=Li/iBvYhGmHHOTDOPi/i8H3LH5X6NXDWiMu6IudF57awU+89X54Q2LUpBmwU4dI3rj7U
	 L6EyNG1PC2zsW1kIuaoo4zarU4jfdgCskE9BPOgeOdQP+8D37TOvHwgcFVHWFj2tynKuR
	 svbXNPOt8C0brpm2st4D2NPayIHCnNLSdsuYxYttz+owLq+4r7sewyHVR5NM0c6aKes9f
	 D4Zx7OwylyAGkKGT7nxn21N5EEmLgmew4suHNlUJJfVcw1cUDVwfZV1LnNr2Dlbugk1W7
	 0zAbd2iSinQB5cvxUBOyUOcDDxqr70ZXvI1MazoiunLCqEWxuig5fbo/bme/ph9gacA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt6zJGQq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0B567606A321;
	Wed, 11 Nov 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt6zJGQq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5A77D1F00A05;
	Wed, 11 Nov 2026 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437038;
	bh=cV0Z68L8/Ou2EanKKDEt9NBi0/dgx6N8W0Ly7e7d7sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kt6zJGQqRZWR+JDbEHaVAS39C1qa7psyLty8slFwY5xu+w8msN7rv3Zd1JgZZ4b3T
	 gx3tnN+ObTolRXrWIc5im8R1vZo66rsoY83tHiwBEouQq50SKutWbMjNirHOF+zBNr
	 w6B8/OxcUH6auS4AoJP3Rvrmem2PIp72xjWnq4SyFi7N0OCQMVQ8zygyMW1VaSZKTD
	 GLxcmM6yRYOdnH0hEetQKVVlKM4Er2YfzUl05UKSYx8r5YcBuGWAE8TMofcgVk9m74
	 R7VMh2qxxyW4GkiJdNgOsANN+EdDb9Ga91BhMIv6igpTlLoQR9vAyXcgvzIIwQ3xz+
	 9U1BQ/MWtRi9g==
Date: Thu, 12 Nov 2026 00:43:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <avTvq4VaYbxMnZl9@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <avTsh6pCI-sRGAJp@kernel.org>
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
In-Reply-To: <avTsh6pCI-sRGAJp@kernel.org>

On Thu, Nov 12, 2026 at 12:30:35AM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 11, 2026 at 01:57:32AM -0800, Breno Leitao wrote:
> > On Meta's datacenter, given the size, TPMs that stop working write about
> > 54 million lines a day to the kernel log, because nothing in the kernel
> > gives up on them.
> > 
> > Two cases make up nearly all of it.
> > 
> > Some TPMs stop responding. Every command then fails only after the
> > transport timeout, while the hwrng thread and userspace keep sending
> > more.
> > 
> > The goal is to retire TPM that are not properly working, similarly to
> > what was done for EFI in commit 4b2c033b5bc971 ("efi/runtime-wrappers:
> > retire the worker if a wedged call ever returns")
> > 
> > This feature aim to disable the chip once its commands have kept timing,
> > instead of keeping it in this desolate state.
> > 
> > Disabling the chip makes the failure explicit: the log gets one line
> > saying the TPM is disabled, and every later command fails at once
> > instead of timing out. 
> > 
> > A health-check daemon, such as machine checker, can then detect
> > the broken hardware and send the machine to repair.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Breno Leitao (2):
> >       tpm: Disable a TPM that stops responding
> >       tpm: Disable a TPM whose hwrng reads keep failing
> > 
> >  drivers/char/tpm/tpm-chip.c      | 20 +++++++++++++++++++-
> >  drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++++
> >  include/linux/tpm.h              |  3 +++
> >  3 files changed, 51 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> > change-id: 20261110-tpm_unresponsive-a5f71c1db026
> > 
> > Best regards,
> > --  
> > Breno Leitao <leitao@debian.org>
> > 
> 
> I think this good stuff so existential condition for having some changes
> to address these issues is fulfilled.
> 
> I.e. debating the details through will likely lead to productive results
> :-)

$ tpm2sh return-code 256
TPM_RC_INITIALIZE

I.e. TPM has not been properly initialized by TPM2_Startup().

I.e. TPM is also saying that it is *disabled*.

So acting on this proven fact  makes most sense to me.

Br, Jarkko
