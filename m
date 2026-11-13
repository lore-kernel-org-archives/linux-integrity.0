Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580945;
	b=1PNL1vX/0AzVnHoW13eWYn4bXh1ivB0RS+W0O0kXbAyKBIUcFWxyKdbbSBn6EpiFVv03
	 LrinqJzm6d8waGOUS1DogTCr5uK7hBAngdHnV4Kpc1ZtVfdzpBdy9zXujOg3rkDLRYJRS
	 zRjAWlC3QZJV1A0y1EOkZ9BSH24GdzO2FKykw4ZQGOi62UCyTKYLAWxOI5KszDFcmvMpH
	 8fxCDpAVyvjh+12rhglQlcHwex8jeFRQFyVN2d7gjiULBMXVo7uplV9wsT36XLKjKyZKG
	 jWOuXuVCcughTInxYl44SCeIcdLGyN2HhgAOr84xqEEXskJMBM3gIJalUMZY/rC7Wmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580945;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tw0RNCHx45b0sxvoNuphiQaKWihW8yBZX9bRA3H3IZQ=;
	b=pwfW06p0RkJI2zLO/6IncmGcG34bjlQ83GsGqZzywT1z6qfF/xuZ6w42VS+Zrg8urZ58
	 W1FShDV7PFWWu2f2vZWVSTHNKauGoQr4ft3BEBCtFqVWGKusnaGrQRyvosx1ZLncy8rTO
	 bIIJqSQJC3SBa6q8qauzB4HvkD+GjTO1rve9syF1E83JVNE1SOpGtHuRFPUxTzWgBKTg2
	 29DKQK8D0JDBcAZWBlK6q08IzNV+QexGOVV4euNd/RNUPA+4q/tzZgem1T15FN/7R7bbS
	 3EhwmcDuRmZekdohBRwyrKursgnKfJyqgJHW+TxcVGEK5O0QggIjesZzsWf5ZZxGxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ1S8rzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E16E7606A323;
	Fri, 13 Nov 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ1S8rzG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 073611F000C4;
	Fri, 13 Nov 2026 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580944;
	bh=tw0RNCHx45b0sxvoNuphiQaKWihW8yBZX9bRA3H3IZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZ1S8rzG7ljUrsJLih0vleRn5hAOMU/eQr9oeb8ub2PX25P6xFCKYC5ovF9P57fEz
	 pYZ7ApM+kxEPzH+d/ixDmnBcGxO/bdI+l4Etxa1XvDtlePeR4TW8GTY/w/80WUC9p6
	 8hlJx2IGq1UvWRiLX18CycTdamgWMUDJYVe/LALSXj0UMYVMAE/qI3rVi8ZMpIHhBg
	 Fy3CKQu7tovXdYly632+UV19l+5kyACeJSCK5k0oKe7ql+oTbuHeNPJWBNbndelIs1
	 XAatk8VSdyzhLqd2lq4uTRmNQYIwzvfWAxaajmVTCEpCSe0hgshqXJIKwsMi0VDsR4
	 HRezN2hQBdZdA==
Date: Fri, 13 Nov 2026 16:42:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] tpm: Disable a TPM that stops responding
Message-ID: <avchzL3uEXHbvNv_@kernel.org>
References: <20261113-tpm_unresponsive-v3-0-8138c8e283b8@debian.org>
 <20261113-tpm_unresponsive-v3-1-8138c8e283b8@debian.org>
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
In-Reply-To: <20261113-tpm_unresponsive-v3-1-8138c8e283b8@debian.org>

On Fri, Nov 13, 2026 at 02:38:58AM -0800, Breno Leitao wrote:
> A TPM that stops responding fails each command only after the transport
> timeout, and its callers keep sending more: the hwrng thread every 10
> seconds forever, and userspace through /dev/tpmrm0. Each attempt holds
> tpm_mutex for the whole timeout and logs an error:
> 
>   tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
>   tpm tpm0: tpm_try_transmit: send(): error -62
>   tpm tpm0: tpm_try_transmit: send(): error -62
>   ...
> 
> The core already stops using a TPM it cannot trust: tpm_try_get_ops()
> fails with -EIO once TPM_CHIP_FLAG_DISABLE is set, which
> tpm2_load_null() does when it cannot restore the null key. Set the same
> flag once 60 commands in a row have timed out.
> 
> A completed command, whatever its TPM return code, resets the count.
> Some TPMs stall for half a minute, time out a handful of commands, and
> then recover, so a short streak must not disable them.
> 
> With only the hwrng retrying every 10 seconds, 60 timeouts take more
> than ten minutes. A userspace poller gets there sooner, but each of its
> commands still waits out the transport timeout.
> 
> The limit is the tpm.max_missed_responses boot parameter, so that slow
> pre-production parts, such as FPGA prototypes, can raise it, or set it
> to 0 to never disable the TPM. A disabled TPM stays disabled until the
> driver is rebound or the machine reboots.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  drivers/char/tpm/tpm-interface.c                | 14 ++++++++++++++
>  include/linux/tpm.h                             |  1 +
>  3 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1e8317483844d9..cedea8bd468aba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7682,6 +7682,14 @@ Kernel parameters
>  			causing a major performance hit, and the space where
>  			machines are deployed is by other means guarded.
>  
> +	tpm.max_missed_responses= [HW,TPM]
> +			Number of commands in a row that may time out before
> +			the TPM is disabled. It stays disabled until the
> +			driver is rebound or the machine reboots. Set to 0
> +			to never disable the TPM.
> +			Format: <unsigned int>
> +			Default: 60
> +
>  	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
>  			Maximum time in milliseconds to retry sending a message
>  			to the TPM service before giving up. This parameter controls
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e0385b16616b46..977e205807033d 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -40,6 +40,11 @@ module_param_named(suspend_pcr, tpm_suspend_pcr, uint, 0644);
>  MODULE_PARM_DESC(suspend_pcr,
>  		 "PCR to use for dummy writes to facilitate flush on suspend.");
>  
> +static unsigned int tpm_max_missed_responses = 60;

This looks good but I started to think this number. I guess it is high
because there's never reset-to-zero for chip->nr_missed_responses.

I think three or four trials at most should be enough, and when there 
is a successful transmission chip->nr_missed_responses should reset.

One thing that bothers me in the commit message is a piece of
information that is missing: when does it start to return error?
From the get go?

I mean based on provided information one could presume that this
could be also fixed at driver init by doing a few smoke tests
and don't let it fully ever initialize.

"A TPM that stops responding fails" is not very locked in scenario.

Br, Jarkko
