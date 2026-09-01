Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78326472530
	for <linux-integrity@vger.kernel.org>; Tue,  1 Sep 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303356; cv=none; b=s4ABjxk3mNipoXhV+EmraYMB3/X1vbJ0FyDHfuDeRnRkaiZ8YGjZIKlJygW8z+n+hxJnPLxs5IFORg3RCi96yC61QBJV6Q0WK+vkFipqXnPU5AR94fN9rw+x8Qyv4r1cVSe3FyzNMrKexAUHEAWqGkxiApWrUG4jJ8Gie8El7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303356; c=relaxed/simple;
	bh=8yMAkfd6O9FSo4wk5et7dzDMhpvYCNnjRQlef9xglNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQcAXBCEt6XhVyf0enL5CI58R9ER5Dbqkk1V2QcnFsg7rU+Tg40tULLOfqU+V2rs4R2jp/iaWiOEGeYIHYNM+LDSDU1Ptls4swiEpV6z4nRsrwcIvCdzasX+Be+qaIJSLYl+oUCu0cPQ4cyAml15F0o98VtmuzgFa8COOx5sraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhH1Hv2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhH1Hv2i"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8233B1F000E9;
	Tue,  1 Sep 2026 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303355;
	bh=SXwQ0YELhoEd2akMVBcSYla+uQBOWnYMZkPlJcLVTeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DhH1Hv2idsugNRIgtL3ty90HtVnqfqULLOm0dREqAPsbJjn9c6F0cSeGm9y+sv09N
	 3CUQvWm0SQjMgjpWzwBIdnjUkA9AjN3IrIP2KR1u21kJraFmfDLzqfWGNJ7RTuuDFE
	 aQSxNWoFY6reHmpLlpupaIzFvI0gHlE5oL2rwhMag0MWRlQzr1JGeQtz7q3/ojSGq3
	 HNsNGL+EqugA7CMJVe3vvVIrnkJcgy3xf3zfcJq/VMzZxycgJNQ7XTOups2Aurb5Hq
	 QOXAc2jYqbszymma3bR5kKbyB/PQ1IjuwCrNyaQSRLeXc/RwRZL4AMrtmc9UPbOMUf
	 3/pOjT0PJniVA==
Date: Wed, 2 Sep 2026 01:55:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Call cmd_ready/go_idle for each command
 transmission
Message-ID: <apdX965qlXd3M-5i@kernel.org>
References: <20260901213723.3017371-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901213723.3017371-1-mario.limonciello@amd.com>

On Tue, Sep 01, 2026 at 04:37:22PM -0500, Mario Limonciello wrote:
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
> v3:
>  * Use __free() to clean up
> v2:
>  * Drop redundant calls
>  * Update commit message
> ---
>  drivers/char/tpm/tpm-chip.c      | 24 ------------------------
>  drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 24 deletions(-)
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
> index f745a098908b3..8d434d7fa5bab 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -19,6 +19,7 @@
>   * calls to msleep.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> @@ -89,8 +90,16 @@ static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
>  	return status_masked == chip->ops->req_complete_val;
>  }
>  
> +static void tpm_go_idle(struct tpm_chip *chip)
> +{
> +	if (chip->ops->go_idle)
> +		chip->ops->go_idle(chip);
> +}
> +DEFINE_FREE(tpm_go_idle, struct tpm_chip *, if (_T) tpm_go_idle(_T))
> +
>  static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  {
> +	struct tpm_chip *chip_idle __free(tpm_go_idle) = NULL;
>  	struct tpm_header *header = buf;
>  	int rc;
>  	ssize_t len = 0;
> @@ -113,6 +122,18 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
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
> +	/* Ensure go_idle() is called on every exit path from here on. */
> +	chip_idle = chip;
> +
>  	rc = chip->ops->send(chip, buf, bufsiz, count);
>  	if (rc < 0) {
>  		if (rc != -EPIPE)
> -- 
> 2.43.0
> 

This is now much better as it addition adds better guarantees that
resources always get released after use no matter how this function
is modified later on.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
