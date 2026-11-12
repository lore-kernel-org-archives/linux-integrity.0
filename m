Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526273;
	b=QddYBtu1lTmCGrEeDSYAlR66xEoY0G+A67xAEOBq/q8QzB9CAys33mt9ECjjabkfDaCu
	 mtf3mLDd7wrHQ7O+j9cFs9yxFtYWEfA8UHnEtDQf6fsw7LPQkMYYGjDkHH88zrRd7DCB8
	 Cf65FRMExbSzc1gONi86Yvs/rtt2rlSOCCUtmz7tgYqtvNp/0ccM2Ve/YW2HfECpFLgJ2
	 PzAXik0O8ZHCa2GPL24hLQLdR9ZWikxDDgUMXunhKi2JKMZULVTO9fCO0g0IxnVU07L2b
	 kTAwyGgKq6Y9BJIBngDp5Qf7KebtBf0p3vEUQC/U4CVZhRoDLjliRx6B49omrCZIisQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526273;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+0H5nqA9FPkNpm4ZXd8CxyY3btbp+7ityOW01dJJzTk=;
	b=AouiyDEGP+FfQKGKuJQTLjRMIQXOhYoF8PMa7PRe/nlERWiEj0DRSozidfIuxR3qvFi7
	 O8WRjCS0TIB254RDg8nYmZQ1Jus+k7U7w0YDrqgG5/ZC99YMSAptMaQqev5pEyGJP2hIc
	 Izxlx9ofybEbom95d/XJzaDtWZizfiLWoIaGdiANlc16Zb5yYcCQrVujQlEHRdPNdtEXG
	 OzwW6KvTdHFiCzBD345EMsuIupypcTYDiyw69nwvPad5BeBOZZEvzYdNYNY8gdxxS+NHu
	 VYsk4h7pz6NK+AjvoVmPPXBvYHOsWCvPl8FrNdXbNuK443XSVZ0u3ftkmVpPaq991fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBrynbS+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9D9F8606A31C;
	Thu, 12 Nov 2026 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBrynbS+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AC7411F000C4;
	Thu, 12 Nov 2026 23:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794526273;
	bh=+0H5nqA9FPkNpm4ZXd8CxyY3btbp+7ityOW01dJJzTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBrynbS+pV/JyrJtPByyasRPCdJ4X8LL0EhErKaZkMBEtlL4mSKJDMuX2HvORPAMD
	 KOh99B0HrlKJEjgtBgsQQiid7RKZUN+tgAiP7i2aaa56CF9TqcPa/ZRxycCruHbO44
	 o7uYrEs+NLEyhylSifb09Czch5Cz6FhjAS8+FmDdqYDyMEXcTAfk7TV4+MAaijmQs4
	 2nQZMM1wmHxHGIiU/RHK4OHXi2RnZRcCJKccHLRIWi35YABMSyGbor8o2EzQfcnw4H
	 ZR9gtXGELO0nGYK3FWQPjeB5vS/zuVhpABa8ul5pQ7uFNA5gkU4GkcdgpE2yNf1nmK
	 bGwxpvZ1qro+w==
Date: Fri, 13 Nov 2026 01:31:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, surenkj@amazon.com, noodles@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] tpm: Disable TPM on TPM_RC_INITIALIZE
Message-ID: <avZMPeUtzV3JyAX0@kernel.org>
References: <20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org>
 <20261112-tpm_unresponsive-v2-2-7454d2c899ef@debian.org>
 <20261112225759.67730166@pumpkin>
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
In-Reply-To: <20261112225759.67730166@pumpkin>

On Thu, Nov 12, 2026 at 10:57:59PM +0000, David Laight wrote:
> On Thu, 12 Nov 2026 04:30:18 -0800
> Breno Leitao <leitao@debian.org> wrote:
> 
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > If the TPM has been spuriously disabled, the game is over. Let's reflect
> > this truth with TPM_CHIP_FLAG_DISABLE.
> 
> Shouldn't it be completely 'game over'?
> (aka panic time...)

There's nothing pointing to that direction. Nothing is really broken
except likely firmware bug or similar situation. We don't want to brick
the machine because of that. Neither security is endangered as
anything that  was sealed with TPM, it is inaccessible.

It's also useful for us that any possible user has a chance to run e.g.,
acpidump without kernel pulling the carpet.


> 
> David

Br, Jarkko
