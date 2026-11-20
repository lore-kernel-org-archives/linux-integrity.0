Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210196;
	b=J6MoVoxz1opCPa4QjRi/bzcEJFPByEvss4adruUSxNjxqGdSZ70r54PcUCAPoMplWDfn
	 KM8x0AAU97rkS2DtgSHt+SgOPeSPmb1Joqmcicqg/UASYF196zI4VNsEORh/35CKedF9B
	 9b7y6lAllH4UtUuYgSU5rWxs++e+NFff3Mn9Qkv39UQiLFJqmgyvhT5/MUXmbBN7XOx2/
	 CFyocL8WcpBF3MLMq5tRYIa9CU6RHELTCwORXKkAjrdI15aqfKE9HAPOrEplVk6FpbR97
	 OEGS189qhTf+ZtoYZW01qu1OQBC18RPExeEVIVBKOsvJwwaK72idxjIJyNRCVm026Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lhSR0apBYxaDdRO5x4C1La65TXwrCp9l7vJ8hgexTZA=;
	b=tEHWKZkRScJ/TFSFkHSVAJb/buplR3/H+SjJyYJEGi6wQGByzL+xgfkn7DX4SJvCQGxO
	 n7xz2kLFlunC+c+vIz5G8xbijQbb2n4bAPDz49PKLToVG9O5gLaza1LIte1FO/csxHgCP
	 wl0SIDB6YEUmEzDhIkGLsOmcJ7/My0L9aOC1RxoWDnKpu3fWuYwpXRy7dZhgNQBw8j+M+
	 TNdmMn/rgwlf35+zZXtnCaSOS09YacLN66yZU8eLRugkkahFPK4HJ7JVsIhzItAlA1k29
	 GVfMsb9VXignIuztvoCLh5LopNZnQ6r2YKEaLc+2I81y3CZUw/d01dYl5kl67Z6OsZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVDi5q98;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 75149606A682;
	Fri, 20 Nov 2026 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVDi5q98
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 74DC71F000C0;
	Fri, 20 Nov 2026 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210196;
	bh=lhSR0apBYxaDdRO5x4C1La65TXwrCp9l7vJ8hgexTZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVDi5q98nChvZ16uU9mCnv6eHSaRey7zbHWfno+wTWk1Zg8FaYYaLZOs9Giu4tAA2
	 JMWNuspf2YWlqcgfnWE639ruYGC7aocatERQ07v7fhUOFhJsLJLMo2jl28GclBqq4j
	 6LHF2kvpYNuQ2JyDIk/60A6yfY3vUGM+Bw6q2W5pJe/oU3YfmYItWbPXRV0kzFRimo
	 FxwMCC5N3s5cCQtbWmZwyQiZX4W3k0LzzBrzBN67cJyWTcxoriDIijnhCdsPUJ8KWj
	 W6m2jyIGbkwZ6IB4E/gfgiXfnAqFuklDaZ+95QRHZjOENIrCn/M2gI67N6XuDZ0Cza
	 GJT5KhpPWOyaQ==
Date: Fri, 20 Nov 2026 23:29:52 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/2] tpm: Stop retrying TPMs that have stopped working
Message-ID: <awC70MnZ4eXVQrdS@kernel.org>
References: <20261120-tpm_unresponsive-v4-0-b9043735ec1b@debian.org>
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
In-Reply-To: <20261120-tpm_unresponsive-v4-0-b9043735ec1b@debian.org>

On Fri, Nov 20, 2026 at 12:47:06PM -0800, Breno Leitao wrote:
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
> Other TPMs get reset under the running OS, and answer every command with
> TPM_RC_INITIALIZE (256) from then on, while the hwrng thread retries
> every 10 seconds:
> 
>   tpm tpm0: A TPM error (256) occurred attempting get random
> 
> The goal is to retire TPMs that are not properly working, similarly to
> what was done for EFI in commit 4b2c033b5bc971 ("efi/runtime-wrappers:
> retire the worker if a wedged call ever returns")
> 
> Patch 1 disables the chip once two commands in a row have timed out,
> instead of keeping it in this desolate state. Patch 2, from Jarkko,
> disables it once it answers TPM_RC_INITIALIZE to anything but
> TPM2_Startup.
> 
> Disabling the chip makes the failure explicit: every later command
> fails at once instead of timing out.
> 
> A health-check daemon, such as machine checker, can then detect
> the broken hardware and send the machine to repair.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v4:
> - Replace the count of timeouts and the tpm.max_missed_responses
>   parameter with TPM_CHIP_FLAG_MISSED_RESPONSE: one timeout is
>   tolerated, and a second one in a row disables the TPM (Jarkko)
> - Say in patch 1 when TPMs stop responding (Jarkko), and drop the
>   claim that some of them recover
> - Fix sashiko findings:
>   - A timeout while a signal is pending no longer counts, since some
>     drivers return -ETIME when a signal interrupts the wait
>   - tpm1_do_selftest() clears the flag on the timeouts it expects from
>     TPM 1.2 chips that block during the self test
> - Link to v3: https://patch.msgid.link/20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org
> 
> Changes in v3:
> - Rename tpm.max_unanswered to tpm.max_missed_responses and
>   nr_unanswered to nr_missed_responses, and drop a redundant comment
>   (Jarkko)
> - Document tpm.max_missed_responses in kernel-parameters.txt (Jarkko)
> - Check the limit with a modulo (Jarkko), guarded so that 0 still
>   means never
> - Link to v2: https://patch.msgid.link/20261112-tpm_unresponsive-v2-0-7454d2c899ef@debian.org
> 
> Changes in v2:
> - Disable the TPM after 60 commands in a row time out, instead of after
>   ten minutes of timeouts, and make the limit the tpm.max_unanswered
>   boot parameter (Jarkko)
> - Open-code the check in tpm_transmit() and drop the "timeout" field
>   names (Jarkko)
> - Replace the hwrng failure counter with Jarkko's patch, which disables
>   the TPM on TPM_RC_INITIALIZE
> - In that patch, move the check ahead of the RETRY/TESTING break, where
>   it never ran, and skip TPM2_Startup, which a TPM that is already
>   started fails with TPM_RC_INITIALIZE
> - Fix sashiko findings:
>   - Two timeouts ten minutes apart no longer disable an idle TPM
> - Link to v1: https://patch.msgid.link/20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org
> 
> ---
> Breno Leitao (1):
>       tpm: Disable a TPM that stops responding
> 
> Jarkko Sakkinen (1):
>       tpm: Disable TPM on TPM_RC_INITIALIZE
> 
>  drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++++++++
>  drivers/char/tpm/tpm1-cmd.c      |  1 +
>  drivers/char/tpm/tpm2-cmd.c      |  2 ++
>  include/linux/tpm.h              |  1 +
>  4 files changed, 24 insertions(+)
> ---
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> change-id: 20261110-tpm_unresponsive-a5f71c1db026
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
