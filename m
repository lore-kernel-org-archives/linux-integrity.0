Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602458;
	b=3poqeVEETi6/rWxvyUCTnmwRHhVyZnbK8EubTWPla+qrmJbu399piMP3hbVd9BVgM7mQ
	 T9GoTBrrNFzvplUfSnU0zYL1wM97GdNRQPTEzTAM1Lc+qqWeZS1i3xM2/3sgGJYxGAIGs
	 BTSasmOCuaafxVKKg6yNxwyTz1kGcz7a2Cp1QhuF3JXtFdZ2YT6PfXjZiXf4pBnEhgpQg
	 FPCvGaWot/Sl783gD/1V1Xgh7Auoiy4OhlEykKVqSaqgBXrDbUtLGd5HshyFHeRJ2QRuY
	 aTOuSjPm9Bhi8RBLYw2qozKmbT1dNzIwQtGt+vReQxMlQC4RDKXVPMK/rAm4ZfY76Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602458;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ea5KFloGLmwCr3wNtuqWNwPXkNSNR8taKlAPgbDtCCk=;
	b=Cr0Kha6BmwUagDQSoDAh49JgVWtUhtSZAgZZGvPUtP23+3yZ5EIjA1f5CW0ijJWqBbAT
	 u5MooFD1sy0GZAj13zK1qNWG9wBsSp37bIz4+FaEa+RBAFvU9eBtrspl1tTvqHaebms8D
	 ZFHU0X2fvf/K3BoMnQ8a69u4+VEMkTVvTiMBf5oHhLFaAKVkc6KvnebJ1yOqz4nHbkt8j
	 f6K1BiP/7RB+ry+juCTNU581C9yq8Ut+0OreUfHfIvYEwwR44o5b5zM7uYoRiYC/PbjQv
	 WCkKrgiyHfZF0DCpiRlubZn1bvEnRwSKjT3hrEQUJnK5aH5ImEpivNoDL2Fc8AHxbow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duKyPUKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 26AAD606A32E;
	Fri, 13 Nov 2026 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duKyPUKo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4E2BC1F000C4;
	Fri, 13 Nov 2026 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602457;
	bh=ea5KFloGLmwCr3wNtuqWNwPXkNSNR8taKlAPgbDtCCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=duKyPUKoeiYrTcGW3J/zFa0uqtozSEfUbooJcxwG+xHUFAgTZOewYKes1Wv9GvduK
	 ukm0hcJ3LzpXQPiDGTgAHgoIXyTxmUOPfWaEInJNwNz8ANYwQbpmhyzWKvvAp1/jHI
	 oukZA1YnX+2uECJpXEfx1KZq2nnjkVfiHewcQlRWTs3hFy10+b7UADKoqBfowejHgz
	 L6ewzrkftKDtgvQfqA0uH8XR/JUIs31K/IWzmSmNUvHLXFBORYNq9hKg851F4gKace
	 jTIXHOlLvCCqI2ZbgNEh6+7c/IU2pvtP1GpeJpHnaRWS+ZDbZNKlsTpnVFl2v+ibgG
	 /LG2JCWkPfckw==
Date: Fri, 13 Nov 2026 22:40:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] tpm: OP-TEE transport core for discrete and
 firmware TPMs
Message-ID: <avd11s2EgUH9Yz6k@kernel.org>
References: <20261113193639.4020859-1-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20261113193639.4020859-1-jorge.ramirez@oss.qualcomm.com>

On Fri, Nov 13, 2026 at 08:36:32PM +0100, Jorge Ramirez-Ortiz wrote:
> This adds a driver for a discrete TPM that OP-TEE owns and the normal
> world cannot reach directly, and factors the shared OP-TEE TEE transport
> into a small core so the existing fTPM driver uses it too:
> 
>   - a transport core shared by the OP-TEE TPM front-ends;
>   - a new discrete TPM front-end;
>   - the fTPM driver converted onto the core, keeping its name, its
>     platform/OF binding and its shutdown path.
> 
> Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
> core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
> shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
> TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
> PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
> tpm_ftpm_tee platforms use.
> 
> This is the normal-world half. The secure-world OP-TEE support it binds
> to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
> relays commands to it -- is under review separately:
> 
>   OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
>   locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
>                   (design follow-up: the secure world policing
>                   normal-world locality access to the shared chip)
> 
> Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
> SPI, owned by OP-TEE):
> 
>   https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html
> 
> v1: https://lore.kernel.org/linux-integrity/20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com/
> v2: https://lore.kernel.org/linux-integrity/20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com/
> v3: https://lore.kernel.org/linux-integrity/20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com/
> 
> Changes since v3:
>  - rebased onto the tpmdd tree, which already carries the treewide
>    devm_kmalloc_obj() conversion; the series now applies cleanly without
>    the merge fixups that were needed when v3 was picked up.
>  - tpm_optee: allocate the private data with devm_kzalloc_obj() instead of
>    devm_kzalloc() with an explicit sizeof(), matching the type-based
>    convention now used across the tree (and already used by the converted
>    tpm_ftpm_tee front-end). No functional change.
> 
> Changes since v2:
>  - tpm_optee_dtpm: give the discrete-TPM front-end a .shutdown callback so
>    it releases its TEE session and dynamic shared memory on shutdown/kexec,
>    as the fTPM front-end already did; without it the session and the
>    normal-world pages stayed registered in OP-TEE across a kexec, which can
>    stop the next kernel opening a session to the chip.
>  - move the shared tpm_optee_shutdown() helper into the core patch so that
>    patch builds on its own; the dTPM front-end no longer forward-references
>    a symbol that was added in patch 2.
> 
> Changes since v1:
>  - split the shared TEE transport into a core; the discrete chip is now a
>    thin front-end, the tpm_tis_core-style solution that was asked for.
>  - convert the fTPM driver onto the same core instead of duplicating it.
>  - use an optee-prefixed name for the new modules; the fTPM driver keeps
>    its name, no module rename.
>  - rewrite the commit message with a plain description of the components
>    and the rationale for a separate front-end.
>  - drop the explicit zeroing in favour of initialisers, and reword the
>    module description.
> 
> Jorge Ramirez-Ortiz (2):
>   tpm: add OP-TEE transport core and a discrete TPM driver
>   tpm_ftpm_tee: use the tpm_optee transport core
> 
>  MAINTAINERS                       |   8 +
>  drivers/char/tpm/Kconfig          |  28 +++
>  drivers/char/tpm/Makefile         |   2 +
>  drivers/char/tpm/tpm_ftpm_tee.c   | 294 ++----------------------------
>  drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
>  drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
>  drivers/char/tpm/tpm_optee.h      |  32 ++++
>  drivers/char/tpm/tpm_optee_dtpm.c |  73 ++++++++
>  8 files changed, 414 insertions(+), 311 deletions(-)
>  delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
>  create mode 100644 drivers/char/tpm/tpm_optee.c
>  create mode 100644 drivers/char/tpm/tpm_optee.h
>  create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c
> 
> 
> base-commit: c3d9e7297e8d1934c8f2aaa0b9d82018ab15376e
> -- 
> 2.55.0
> 

Thanks, applied cleanly.

Br, Jarkko
