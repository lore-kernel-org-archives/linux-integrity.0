Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315379;
	b=ddPaXGywx1eeyCDebilLQ8xzZoVCV5Nt/Uc/B6hEyPTR2kwTbF5cZOFE07wiJvLsOnjI
	 OaToRy3Jur4Nw4Tbzaupbd8OqheBVk70Sf6nChY83dcf7HHKX4ZZ+hvpzvnhEthRNl41J
	 NLdmiLRLbbOOO1whtho3yOIkoO6Bg9NSkQhYN8Gi1totJeOi29ge15FNihZVrZScg2JQr
	 ibY4ZzkRm2vzBg2T0/W93PFYrawb1kq0bgIAYEK1V6rOHBsf3nYf0iQwS1EYC8Uq3OblO
	 Mod1BHLFXWafj616Rv6qMJASFen9hTJhVMSWnsAaEQOL86mxabjBh4ybYUINTVDTvuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315379;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=S0iZDpAtb4CJMbbRNM3v2yo/BoGutJ8Lqq14LpztKj0=;
	b=QcaFOwfuo/q0G8BotvuCdNh1OP8hgOVGWJk/b+ByFiTcp4J9mH56Vsn8nS4qSb/CjbDd
	 xySh7KTNde3BWgDTAtPFV5ahr0J2LRtMvoqRzidf/SccG3Y+Q2wv5qE5rsgWpohlpVbVC
	 8ZABd01l1sMoIREfi/4ktpTgb5/7g4zy2h4yiKD8cXETG1o22MMrXcOL3vjH0Mrp3Ug4h
	 Quab1CIeIutxa4H7OTXq3vaQXX5RHO3+fFoyxaTqCpRDk98DkKkpEQDazQ7ubOZnhB6qC
	 AO6cPbE++HIjW+UYfOtkFDWt/BRmQpMchWmUJsG/9ICQUSC9KU/4Y9ZJxL34V/voAJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBDIY4Rg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EB43B60A5BC7;
	Tue, 10 Nov 2026 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBDIY4Rg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 214951F0089F;
	Tue, 10 Nov 2026 12:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315378;
	bh=S0iZDpAtb4CJMbbRNM3v2yo/BoGutJ8Lqq14LpztKj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VBDIY4Rg6sfLkekeEVeMC9HdCbbe/AUjsm7IUBgcs97hB4v9P6UsrhWwt182tAZAW
	 Bp/VCnCrjDCog95+VNDXnNNyBYAhOFoQiSeJkwkEcXJGLXYS7uc/uW/MU9+kyGWGpi
	 QHFj+fX4N9QqhOCG25yguqMC3faYQ0UH0j28+BJO/vYu1bz5vZ1XgGY+5sMubR04Rn
	 Ui+JExzaMPc4kmwUZNVolDCSZrUBgrDKI2NvOmFh4dd60G5bvWlat5IY+wm0vj1mfa
	 ZiyXoODOepzGxweNP2p2oi8gOSgoXwKMl39AgUK5o/MUZtQYct5550xvo0+4FCE3Ts
	 cJrXWQIpt4kSQ==
Date: Tue, 10 Nov 2026 14:56:14 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Takashi Iwai <tiwai@suse.de>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: acpi: Fix memory leak at tpm_read_log_acpi()
 error path
Message-ID: <avMUbkRuq8FiThe-@kernel.org>
References: <20261109173756.742248-1-tiwai@suse.de>
 <4674faa5-47a6-4486-815e-a5a3a5275d69@molgen.mpg.de>
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
In-Reply-To: <4674faa5-47a6-4486-815e-a5a3a5275d69@molgen.mpg.de>

On Tue, Nov 10, 2026 at 11:43:31AM +0100, Paul Menzel wrote:
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks, I added it:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=for-next-keys

Br, Jarkko
