Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581037;
	b=R9goSRFNZBqix4MPGd8PAy0UpEEAUhZE1ie+/AGrXogztRiHTjsMrQ0WPEaWoHnXrV2L
	 vb8yBhyyRgd+K/6HYMp5Nw3xeKpz7OxDTCRV5OlZ+fMIV82yEPZLI8SY4EUPv0r/1m8E+
	 uJvncjT/skWLY0xbD7Dn29xUVLpWaU8rDwI7pl3XtqbLOqU73cDRK3JgZ/gJlhpXTMXH0
	 Oe3fy8q6DhGfilTsFCfy932PmolEYk2DrvsjRQ8AjTRiPZti5OHE8SUXqviSlNvqa7d/r
	 3Aj3X/sni3TgqeeS2KOVw6+fVlMC7zZjBb5LAwu74qwjgyuZe5+9kjqWvO89YZxl4Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581037;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s8F7tAs56qrutuDF7FDi0BwR+XXWLFTe5r16oqFJB8c=;
	b=rOPPF8kKVYqQO6l9WnS+DSAzL7patPbxflCakmhBbMFWD0mrdA2rp+XYBg7Ffh6dUOEu
	 2zG/A0as626L6WH/r79tBUS9e1xTLOgJMuTZEK4OBHpvJ2iQqRkCxyxr2ucxxPlDyBkG9
	 xxnYk8zg3aSk+pYKpwWQThHfDKbuNgdOsF1aO3VZaLYbpFO0z8S+solj+TvFUrQftXrNJ
	 iosf82s1EuKu5EN73baLiwMjlQHbcMQWKmGc4ATJoYxXFx0P5IgaVpr7OJIWoCWKGJsNA
	 coK9Wpfs14KVzpz9gphee612HwDFHxAfqnNGpApSwZB4txnavTZZx23Wu/YnSCHt67w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJKNdsU3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 00B7D606A880;
	Fri, 13 Nov 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJKNdsU3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0C7CA1F000C8;
	Fri, 13 Nov 2026 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581036;
	bh=s8F7tAs56qrutuDF7FDi0BwR+XXWLFTe5r16oqFJB8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oJKNdsU3Rrcv5Lw9CxvGmPGPXFEx5M8EtSOcFhdsA27yYnCb4oIYtpk7TPTiNQH4c
	 Ha2403PuQTemqWkYgd2frzHy5Crg9u7HAQ7BzcmmZhjTDMrsTE0mQkSZDlXwxmCiPe
	 No+W6fLMt7+AzmlC/mF010DGU+xKb3YKz12jUgdB5wvtrL6dtoFAupLdmdv+QZOqFg
	 4Gjfn/Oy4hjHTijHoEdFJ97Tx6cHgOas+GtFSRUlQv2F9TXiNSYu0E42rgiA+7pQcx
	 qBl6Q6lHWXnvLM0DDQSicrH8deMqYqEYMTy3erAmcdX2PQbu32GIapAtPgw4Aay5rX
	 i+VxH7LnPOWpw==
Date: Fri, 13 Nov 2026 16:43:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tpm: OP-TEE transport core for discrete and
 firmware TPMs
Message-ID: <avciKM_pGW6hs_so@kernel.org>
References: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>

On Wed, Nov 11, 2026 at 10:59:33PM +0100, Jorge Ramirez-Ortiz wrote:
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
>  drivers/char/tpm/tpm_ftpm_tee.c   | 295 ++----------------------------
>  drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
>  drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
>  drivers/char/tpm/tpm_optee.h      |  32 ++++
>  drivers/char/tpm/tpm_optee_dtpm.c |  73 ++++++++
>  8 files changed, 414 insertions(+), 312 deletions(-)
>  delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
>  create mode 100644 drivers/char/tpm/tpm_optee.c
>  create mode 100644 drivers/char/tpm/tpm_optee.h
>  create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c
> 
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> -- 
> 2.55.0
> 

I applied but had to fix some merge conflicts so check up my tree.

Br, Jarkko
