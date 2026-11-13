Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594781;
	b=aSIGsUnEqtZa7p6LLYRhFYthCwnSTKHaym8+xURBJbHwmQDUgv9RNM6usST1GK/IWpG4
	 hMX9MtzBk/7NKEpypR8Aw+yGHuDRpKuwXBVTt+t9D3VFzlVmGfFGQzzSN1PZztjiEqbqh
	 B9eLWME/Equ+x0yYtU/mwojPWCoyN92lqV1Za+Bys0rOXLHuQVKGUDacALFnuVZvxa0zU
	 Zjg71Q0kRcaJDJ38o+mZ7i9P/c4V3OxETme5QE5cqih0Xk6UJys+Cxxf6KNned1bWrnx4
	 XruLBn83eRh7PnSxREtE0Hljb4V1VfOqMVdOxzPcd9LZL7Lyl+rmZmXw/Q00tQnWs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594781;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h1TQwAva+6rWjq4w3LgMg/aX6VXSZI3zzhkUPQ6ZpdU=;
	b=sgTFMz6Bk70P7OGyx5aGoKgiOFLtkHNDZ/1kSvoD6hgV89iVezznrqmK9QL1dQ2g9Yhl
	 SBog6Q2DehFjx7u/E5tu5ip4wfA8B0dAHNs5wNpFGUBFupwkJ1QuoP7/Itc5Uj6gDSRBf
	 wdF1kBjMJb27yfCqvwJSrNe303jb+FBNgbDrucrR8hE8TDyWAjZ9zcFbq9u7IrUDSoNRK
	 ivZfM0SZBknuSAWJQ52EjRjKUSvBCDm+nsNV5ELXGR5Putj6AHwttYz3JIr3502KDtJTa
	 i4/i7Z2Ca3k0WzJXYtNhxAYPstxrgmDo5IJcxwK4Qy6sEZAkXCAO/9fGk831pXlnz8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FW6Du0v9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E40DC606A32E;
	Fri, 13 Nov 2026 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FW6Du0v9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 078111F000C4;
	Fri, 13 Nov 2026 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594780;
	bh=h1TQwAva+6rWjq4w3LgMg/aX6VXSZI3zzhkUPQ6ZpdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FW6Du0v9d19yzM/y/Mn1MvIbCxnzlJ0Yf7zDN/WTnCdmCkuIqA+roMg0qL5X3Cdi9
	 sdJZOL/S6Rqyld8MhqbAe2A/c6lNCKAXf+B78kukvIstz3fc+cbH+SPVDTQsemducB
	 ZBRWYIbo990zuXQoHD8Y8XoKQaIb+y55jQeIn7Vq3AuhpQShOLlw+q5orN1d5sZNjw
	 ACJq7VKqMX1mbuiBqjthBP9sm6+o+RqUolI9yg753JfrkucHezlQcrNuvS4z99WXER
	 hCYPPiuXfn6l+ZL9mZg+StniMbS7hAPNh5lZJhqFNaHoFcaqZr/TO+XUlER/pkN5Ro
	 nlwu8jeHBsHRg==
Date: Fri, 13 Nov 2026 20:32:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tpm: OP-TEE transport core for discrete and
 firmware TPMs
Message-ID: <avdX2c4vCjlQQyM0@kernel.org>
References: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
 <avciKM_pGW6hs_so@kernel.org>
 <avdI5vZCobTmpIuM@trex>
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
In-Reply-To: <avdI5vZCobTmpIuM@trex>

On Fri, Nov 13, 2026 at 06:29:10PM +0100, Jorge Ramirez wrote:
> On 13/11/26 16:43:52, Jarkko Sakkinen wrote:
> > On Wed, Nov 11, 2026 at 10:59:33PM +0100, Jorge Ramirez-Ortiz wrote:
> > > This adds a driver for a discrete TPM that OP-TEE owns and the normal
> > > world cannot reach directly, and factors the shared OP-TEE TEE transport
> > > into a small core so the existing fTPM driver uses it too:
> > > 
> > >   - a transport core shared by the OP-TEE TPM front-ends;
> > >   - a new discrete TPM front-end;
> > >   - the fTPM driver converted onto the core, keeping its name, its
> > >     platform/OF binding and its shutdown path.
> > > 
> > > Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
> > > core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
> > > shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
> > > TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
> > > PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
> > > tpm_ftpm_tee platforms use.
> > > 
> > > This is the normal-world half. The secure-world OP-TEE support it binds
> > > to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
> > > relays commands to it -- is under review separately:
> > > 
> > >   OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
> > >   locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
> > >                   (design follow-up: the secure world policing
> > >                   normal-world locality access to the shared chip)
> > > 
> > > Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
> > > SPI, owned by OP-TEE):
> > > 
> > >   https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html
> > > 
> > > v1: https://lore.kernel.org/linux-integrity/20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com/
> > > v2: https://lore.kernel.org/linux-integrity/20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com/
> > > 
> > > Changes since v2:
> > >  - tpm_optee_dtpm: give the discrete-TPM front-end a .shutdown callback so
> > >    it releases its TEE session and dynamic shared memory on shutdown/kexec,
> > >    as the fTPM front-end already did; without it the session and the
> > >    normal-world pages stayed registered in OP-TEE across a kexec, which can
> > >    stop the next kernel opening a session to the chip.
> > >  - move the shared tpm_optee_shutdown() helper into the core patch so that
> > >    patch builds on its own; the dTPM front-end no longer forward-references
> > >    a symbol that was added in patch 2.
> > > 
> > > Changes since v1:
> > >  - split the shared TEE transport into a core; the discrete chip is now a
> > >    thin front-end, the tpm_tis_core-style solution that was asked for.
> > >  - convert the fTPM driver onto the same core instead of duplicating it.
> > >  - use an optee-prefixed name for the new modules; the fTPM driver keeps
> > >    its name, no module rename.
> > >  - rewrite the commit message with a plain description of the components
> > >    and the rationale for a separate front-end.
> > >  - drop the explicit zeroing in favour of initialisers, and reword the
> > >    module description.
> > > 
> > > Jorge Ramirez-Ortiz (2):
> > >   tpm: add OP-TEE transport core and a discrete TPM driver
> > >   tpm_ftpm_tee: use the tpm_optee transport core
> > > 
> > >  MAINTAINERS                       |   8 +
> > >  drivers/char/tpm/Kconfig          |  28 +++
> > >  drivers/char/tpm/Makefile         |   2 +
> > >  drivers/char/tpm/tpm_ftpm_tee.c   | 295 ++----------------------------
> > >  drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
> > >  drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
> > >  drivers/char/tpm/tpm_optee.h      |  32 ++++
> > >  drivers/char/tpm/tpm_optee_dtpm.c |  73 ++++++++
> > >  8 files changed, 414 insertions(+), 312 deletions(-)
> > >  delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
> > >  create mode 100644 drivers/char/tpm/tpm_optee.c
> > >  create mode 100644 drivers/char/tpm/tpm_optee.h
> > >  create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c
> > > 
> > > 
> > > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > > -- 
> > > 2.55.0
> > > 
> > 
> > I applied but had to fix some merge conflicts so check up my tree.
> > 
> > Br, Jarkko
> 
> thanks and sorry about it.
> 
> I had a look to your tree and it looks good. But I think we could
> perhaps add the following to the new file (see the patch below)
> 
> Not sure how to do it thought- shall I send it standalone?
> 
>  drivers/char/tpm/tpm_optee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_optee.c b/drivers/char/tpm/tpm_optee.c
> index e2223242327e..3c17de1306a1 100644
> --- a/drivers/char/tpm/tpm_optee.c
> +++ b/drivers/char/tpm/tpm_optee.c
> @@ -166,7 +166,7 @@ int tpm_optee_probe(struct device *dev, const struct tpm_optee_config *cfg)
>         struct tpm_chip *chip;
>         int rc;
>  
> -       pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
> +       pvt_data = devm_kzalloc_obj(dev, struct tpm_optee_private);
>         if (!pvt_data)
>                 return -ENOMEM;
>  
> -- 

Send a new version of the full patch set and I'll just replace the
current version.

Br, Jarkko
