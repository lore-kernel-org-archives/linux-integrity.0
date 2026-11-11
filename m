Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438270;
	b=g8spiFELEgPOgb7iMKTycESXXJULbqul9G6//rs21TJDhTZ4wXN5he0eZ0+T/0i7yDuS
	 QJk0JLGjBluz9DcEhpnOc53QuhpSGXj1vlzBUmyjs64GqhQ3EFE408fGtorp9+HFleyU6
	 Z14FphNsEZHZPq+HLYu7pzDtVMCp93OmGXhf4+jsiz/eXGZvHeD5Y3mzUT8UZVCM9c731
	 mIZYBZI9T5A5bEH6AyV7sVF+xleVuxP5lO/NZlOkufxIASiYH/HAccKNA1ib76CyRkYY+
	 9fTD9pTYYod4j6fVPz8t2lFy+h4ixLpKrzVDugTBsgQc0nyIgpdo2z0HxZ2DiFQwZEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H4+6iq4oG5piZB3CDrOZwNGLSq2p3bJ2aHCLdJKAPCc=;
	b=qCfjm9uNHtHZocjqHscdMqTov0Hm/Mu8t4HLesfuEDY2v6L8PpyG32s5w9FuQ9rG2Ale
	 9NiSNq1KBqUQLpQGMiHgvpqKxZec9QKSBNr+IBNti8icKDYrW4hHQmx6XErPP+Xe1E3ma
	 JxkY7fHhDfo0sVpL57zkorEmLRWYth9NU1xBuHBk+UlWBpPg2MPJS+NeiP41yl4A6fdrh
	 AEi0Hg4eM1T91PdQMlEsnE/hvCiyIJZN7iFtSH1ZASbKL+H6+YOQ93UHcAxtj33TsjJeQ
	 oq49i88wC+3DL9/XzKECMzxm9PEQPjyevOgZCeMOU04chBanY4g9kzeOVMcBUL0o05Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqav7QFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B61DA606A898;
	Wed, 11 Nov 2026 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqav7QFL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AF98C1F00A07;
	Wed, 11 Nov 2026 23:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438270;
	bh=H4+6iq4oG5piZB3CDrOZwNGLSq2p3bJ2aHCLdJKAPCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqav7QFLe4KXOmYRccgIEQ5Z7NEbMJsPPEcdgpjMhqr2QqGEivY/1qbtpg/3U9AEa
	 IQciYpnnTbRPG5zxCm5UJdn4T9GEg3KdeYlzGBvzTX4L35VnnB00XbFPYXopvOLpxZ
	 FXAoYB/QObGxAv6As9Ml95RxS27PL8N6qjp3guWGB3ulpcFmOmJduCLxGLixojv9Gc
	 X/VHDFdVcKN6fw9wX6sKQ0XXcg2PpZ4Ap5oAXuVMjdOpaWG+NeVFcxKIYc6frx6pbi
	 stCUIsPDq/KuO00KtDzGD9ESBIg5CWAb+Siw+JMAiMWuuo/ONF/IucQs+PJYDQnt3o
	 K3ZTW3OCTM+FA==
Date: Thu, 12 Nov 2026 01:04:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tpm: OP-TEE transport core for discrete and
 firmware TPMs
Message-ID: <avT0ekb6KxFX7D4h@kernel.org>
References: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
 <avTmEXZzyyjxA2dy@trex>
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
In-Reply-To: <avTmEXZzyyjxA2dy@trex>

On Wed, Nov 11, 2026 at 11:02:57PM +0100, Jorge Ramirez wrote:
> On 11/11/26 22:59:33, Jorge Ramirez-Ortiz wrote:
> > This adds a driver for a discrete TPM that OP-TEE owns and the normal
> > world cannot reach directly, and factors the shared OP-TEE TEE transport
> > into a small core so the existing fTPM driver uses it too:
> > 
> >   - a transport core shared by the OP-TEE TPM front-ends;
> >   - a new discrete TPM front-end;
> >   - the fTPM driver converted onto the core, keeping its name, its
> >     platform/OF binding and its shutdown path.
> > 
> > Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
> > core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
> > shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
> > TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
> > PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
> > tpm_ftpm_tee platforms use.
> > 
> > This is the normal-world half. The secure-world OP-TEE support it binds
> > to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
> > relays commands to it -- is under review separately:
> > 
> >   OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
> >   locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
> >                   (design follow-up: the secure world policing
> >                   normal-world locality access to the shared chip)
> > 
> > Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
> > SPI, owned by OP-TEE):
> > 
> >   https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html
> 
> The above was the wrong link, please use this one:
> 
> https://qualcomm-linux.github.io/qcom-buildroot/lemans/devel_lemans_security_dtpm.html

Patches look good and further also have zero Sashiko detected
regressions:

https://sashiko.dev/#/patchset/20261111215940.3503287-1-jorge.ramirez%40oss.qualcomm.com

So I guess, we're good. Thank you for the effort and patience.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
