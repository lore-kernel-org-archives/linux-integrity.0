Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364F3D994
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269905; cv=none; b=ar7TpRMk3oNRDX7vRmLPzKIFiDp/mD7dt9sEtyFh9ljnhOSmRMiHo7ESGlmLeTR7zefWumrayGqS7sT886gezVdvL6dV0ql14qgCbdjInYypkWBI1woULKGImEK9toL/H3/5bNG7DMYlN16dJoZFJ0taTBUl7jT6JnUmbsZYLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269905; c=relaxed/simple;
	bh=IsbeiqYC96k4BvzqX/ywyaco1At9OpVh4Dc2RHEc+DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjgfk0HDOsNXzkpPYH/1mvh+PQ1wAzVjqrSHa+m/48Kd7cpHy+8sxqU5ZxWySB5GipioidY3VkRPtgZpRC79wboO+h+tva7IsOTa1mi1qEi5h1g7XXDY/gKroifE3UOpl8DPeh5Riu/wIdE0bVqVpKIykhXSbRz2g26rrqm6/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0w0pPov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0w0pPov"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9479F1F00ACA;
	Tue,  1 Sep 2026 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269904;
	bh=hIGYm4q9sQ222/RYml/qgumYhppgoFcEIqrSK6oimXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M0w0pPovFST06P4o5wXHu+WPFpvLqQeEHPY5aOdDdm+p4U9x8FYiikWQGN9s+RClb
	 orp3KVRZOCvLkLDXxSLNmuVB/BCop8H0F175L338dFdBNdYLgDxxjPsxDhiokAar9t
	 IOSQWbFVv686RfMjgLuwoIVjvNPWXq6VFofpjWSYs9kzATDKIOVDQs58yh3711lyQk
	 03JpPAKJqwd/5DUTeEH/ty9pyFBsC65JvdNe82c7J9Jc+bCryp0yqYmGrV4aupdcPH
	 n8PZi7Fm0GNDTWhCxJQZDCiWnluq81fF4kg4ZOjBf7lYzQNzikPVj/e/oVbFUJ74Oy
	 82ceanpq1fahw==
Date: Tue, 1 Sep 2026 16:38:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Call cmd_ready/go_idle for each command transmission
Message-ID: <apbVTDC11ubDhuhK@kernel.org>
References: <20260831053722.1879772-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053722.1879772-1-mario.limonciello@amd.com>

On Mon, Aug 31, 2026 at 12:37:21AM -0500, Mario Limonciello wrote:
> Some TPM implementations, particularly fTPM using the CRB interface,
> require the TPM to transition through idle and ready states for each
> command rather than once per session.
> 
> According to the TCG PC Client Platform TPM Profile (PTP) specification,
> the CRB interface includes an idle/ready handshake for power management.
> Software should set cmdReady to transition the TPM from idle to ready
> state before sending a command, and set goIdle when finished to allow
> the TPM to enter a low-power state.
> 
> The current implementation calls cmd_ready once during tpm_chip_start()
> and go_idle once during tpm_chip_stop(). During the startup sequence,
> multiple commands are sent between these calls (self-test, get
> capabilities, session init). For fTPM, when subsequent commands are sent
> without transitioning to idle after the previous command completes, those
> commands timeout as the TPM is waiting for the idle transition.
> 
> Fix this by calling cmd_ready before each command transmission and
> go_idle after receiving each response in tpm_try_transmit(). For TPM
> implementations that don't require per-command transitions, the callbacks
> can return immediately (as many already do based on the start method).
> 
> This resolves timeout errors during TPM initialization on systems where
> BIOS has already performed TPM startup, as the kernel can now properly
> communicate with the fTPM during auto-startup.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index f745a098908b3..a98ddca876152 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -113,6 +113,15 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  		return -E2BIG;
>  	}
>  
> +	if (chip->ops->cmd_ready) {
> +		rc = chip->ops->cmd_ready(chip);
> +		if (rc) {
> +			dev_err(&chip->dev,
> +				"%s: cmd_ready(): error %d\n", __func__, rc);
> +			return rc;
> +		}
> +	}
> +
>  	rc = chip->ops->send(chip, buf, bufsiz, count);
>  	if (rc < 0) {
>  		if (rc != -EPIPE)
> @@ -181,6 +190,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>  		rc = -EFAULT;
>  
> +	if (chip->ops->go_idle) {
> +		int idle_rc = chip->ops->go_idle(chip);
> +		if (idle_rc && !rc)
> +			rc = idle_rc;
> +	}
> +
>  	return rc ? rc : len;
>  }
>  
> -- 
> 2.43.0
> 

I think this should remove also redundant calls to cmd_ready and
go_idle.

BR, Jarkko
