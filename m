Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210F48A2A0
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284248; cv=none; b=EUzatSxnHeLoAkp/dDKH3WqUT9xcGP4CQ7YZEgnGdM4Mrtbo/nVrCPqXIgG7O4mPR/BSny6nV29Yq5vgKgXsCsTZ5OZHN7ZEwnz5oEHi9EDoMQ9zuch1pJmwtTOauNjhkcf/9E4pYKsRWseJILGnub52PT82ZrO6FQ3ywP8iJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284248; c=relaxed/simple;
	bh=Cy6t6J8lkhoY3/HBNsVCY7wSHsUX149eKvstU6pdJd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEpb7PzWqaR2303DEueoQ6FvZ5cJi6KtC0LY/Ddlax0Qkf6txbwWhTndgTYo/QmtCApMHb1HscmoOikd2p7lwUx1VRgQq+sgeMrVTXdadtE3uyDt7dq/Khb7udDW/ksxNd4mzatiyQTIJtdteZ3gE7TdIPpW/u+h410qCzWx5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGWwNdjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGWwNdjJ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2B0DB1F000E9;
	Tue,  1 Sep 2026 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284246;
	bh=w7O8lAztOvckktDyzYzjf9sI9zFmeN7Ls4i7Qms3SNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FGWwNdjJRIeHTlWd6mq9M9+KOIyTOrkSLDEunuqTbqosL3/DeyHX4NSXzfKaYEUJ7
	 TWT3fXLzzftP8nP7od/9eqrGEFlOPVlNxgDlF8R+WAQkotVmNBm0uVZl9EMvBJReS6
	 eU/eQJJyGbSLikNVmbtGPwJtzn7dwXFUrUKVY3jRDqCAgpr6PlwdKFxebVQwlZAwxk
	 dpSXRjq0miqrnTlW6I27s/sPZs6Mj8WE7pafpbPPTVgx3TZNN3BDAZE0YqvEVxqd3z
	 OgMHEOOvjqzrqlOBGrLDz6Vv2gvzvhdlUK04mNoCC98ZLLdX2GmK7agj+ndA9XOqjC
	 l0jmoGQcIfC9g==
Date: Tue, 1 Sep 2026 20:37:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Call cmd_ready/go_idle for each command
 transmission
Message-ID: <apcNU_RLDkrfZraq@kernel.org>
References: <20260901163217.2749911-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901163217.2749911-1-mario.limonciello@amd.com>

On Tue, Sep 01, 2026 at 11:32:15AM -0500, Mario Limonciello wrote:
> Some TPM implementations, particularly fTPM using the CRB interface,
> require the TPM to transition through idle and ready states for each
> command rather than once per session.
> 
> The current implementation calls cmd_ready once during tpm_chip_start()
> and go_idle once during tpm_chip_stop(). For fTPM, when multiple commands
> are sent without per-command idle transitions, subsequent commands timeout
> as the TPM is waiting for the transition.
> 
> Fix this by calling cmd_ready before each command and go_idle on all exit
> paths in tpm_try_transmit(). For TPM implementations that don't require
> per-command transitions, the callbacks return immediately based on the
> start method.
> 
> Remove the now-redundant per-session calls from tpm_chip_start() and
> tpm_chip_stop() along with their helpers.
> 
> This resolves timeout errors during TPM initialization on systems where
> BIOS has already performed TPM startup.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Drop redundant calls
>  * Update commit message
> ---
>  drivers/char/tpm/tpm-chip.c      | 24 ------------------------
>  drivers/char/tpm/tpm-interface.c | 26 ++++++++++++++++++++++----
>  2 files changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 12b7394b34bdc..0be5dbfaa72eb 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -66,22 +66,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
>  	chip->locality = -1;
>  }
>  
> -static int tpm_cmd_ready(struct tpm_chip *chip)
> -{
> -	if (!chip->ops->cmd_ready)
> -		return 0;
> -
> -	return chip->ops->cmd_ready(chip);
> -}
> -
> -static int tpm_go_idle(struct tpm_chip *chip)
> -{
> -	if (!chip->ops->go_idle)
> -		return 0;
> -
> -	return chip->ops->go_idle(chip);
> -}
> -
>  static void tpm_clk_enable(struct tpm_chip *chip)
>  {
>  	if (chip->ops->clk_enable)
> @@ -116,13 +100,6 @@ int tpm_chip_start(struct tpm_chip *chip)
>  		}
>  	}
>  
> -	ret = tpm_cmd_ready(chip);
> -	if (ret) {
> -		tpm_relinquish_locality(chip);
> -		tpm_clk_disable(chip);
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_start);
> @@ -137,7 +114,6 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
>   */
>  void tpm_chip_stop(struct tpm_chip *chip)
>  {
> -	tpm_go_idle(chip);
>  	tpm_relinquish_locality(chip);
>  	tpm_clk_disable(chip);
>  }
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index f745a098908b3..c5b5b5ba41821 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -113,12 +113,21 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
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

I'd consider retaining tpm_go_idle and do this after arming the command:

	chip = chip __free(tpm_go_idle);

> +
>  	rc = chip->ops->send(chip, buf, bufsiz, count);
>  	if (rc < 0) {
>  		if (rc != -EPIPE)
>  			dev_err(&chip->dev,
>  				"%s: send(): error %d\n", __func__, rc);
> -		return rc;
> +		goto out;
>  	}
>  
>  	/*
> @@ -152,7 +161,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  
>  		if (tpm_chip_req_canceled(chip, status)) {
>  			dev_err(&chip->dev, "Operation Canceled\n");
> -			return -ECANCELED;
> +			rc = -ECANCELED;
> +			goto out;
>  		}
>  
>  		tpm_msleep(TPM_TIMEOUT_POLL);
> @@ -168,19 +178,27 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  
>  	tpm_chip_cancel(chip);
>  	dev_err(&chip->dev, "Operation Timed out\n");
> -	return -ETIME;
> +	rc = -ETIME;
> +	goto out;
>  
>  out_recv:
>  	len = chip->ops->recv(chip, buf, bufsiz);
>  	if (len < 0) {
>  		rc = len;
>  		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
> -		return rc;
> +		goto out;
>  	}
>  out_sync:
>  	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>  		rc = -EFAULT;
>  
> +out:
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

BR, Jarkko
