Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435390;
	b=jqSfhWDOvQSQrqIwE+SS7ZZlIjZnd8LyftxY08ja/HlfTx1g51xVgAvg2FlGvrN7YxOv
	 tRQfhYom1D045mNsoxiv1k8arQ8bZfKPbeBl34Zzz/lMyya7g5HQO/sopFQOJRfr5lbxj
	 AFFw9G1gJHr7/FwRHfLnq0vuvSl7pGrbmg7dj4s+JtiS+AXjr16os2rDIlpgipd/m9F64
	 BG/Q9lPHF26GamAH5LLqzSo16eXnisz/tc6h05Rz60rBs7tZjslNb3eJxKqYnLnwKNptX
	 ptyqeN1cj5u3RM/8gULuHn2IwKx/skrm2vVxEnYkteqZBi8byU/SmszMMfXOTfxWrBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q14zKYJa6IdwTqPdfMWJSXCiAQZZOn9IjAhkL3pwu+Q=;
	b=aCzzEQM3NjZcfjJTTVIKKpA1ZzT7WTML5Gw+K32+Ld4oxcEkW0FvJfyrc4wViKxeGM3l
	 Sa+CDsAodgx+2DCohm16yQhuQ6dnksnIahBnXzvsp7NE9JvGxiz3rnM2gHTVX8WHNE5RL
	 oLf1hcQnJYiMnmzHrY0lVsIqYqizsLYojrJmqHywEPzCNZiXdq/zrMNkytjexfweT5VSD
	 +5J4IFXjH2sZn/zEF0dmzX9wPyfYAiGmSASKOwqMg2SJ8jvpmvJ1IiTj8ALVy/uSZL5TC
	 KoDErIzg/UQM98WeWhGZTTBfTngJ3HDpIO5GZ+yn7vKwsJYzLJsedW2ODctf22d7q7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOGrNVhp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C59F0606A31C;
	Wed, 11 Nov 2026 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOGrNVhp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BD04E1F00A07;
	Wed, 11 Nov 2026 22:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435390;
	bh=Q14zKYJa6IdwTqPdfMWJSXCiAQZZOn9IjAhkL3pwu+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOGrNVhpCEZeHTBLp4XNM7iRa1uukzUGF0iE/a4WZ0R8ROzWZwPfLsWSb+tka4BLa
	 uhrllOOaPKEDsm93VdsjCA3Tuj0XFNRYnt2rEvtD9rX4YItqqEqaSL45TKQzRIyoby
	 HaUH+bJsSV+pwwG1ybwqJyNXRnTs562HaE1AtcMAZkDnOvByR2azFRjKovM3TmJJiz
	 GJ2XiGNl/8aFOuqHjVagbOjNH/HVlh0dZfuRzRLwPzDn/ixy4ZsHeu5k+jtuV+03ab
	 1DJCSTkVA433m5+tCLOEySPiMPaHyO3BZexml7zz+v9BMZMUEguI2erKMJK2bVT7iA
	 SB977wg+Nc+yw==
Date: Thu, 12 Nov 2026 00:16:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	surenkj@amazon.com, noodles@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 2/2] tpm: Disable a TPM whose hwrng reads keep failing
Message-ID: <avTpOlKixInIBmE6@kernel.org>
References: <20261111-tpm_unresponsive-v1-0-42ac1b965eb9@debian.org>
 <20261111-tpm_unresponsive-v1-2-42ac1b965eb9@debian.org>
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
In-Reply-To: <20261111-tpm_unresponsive-v1-2-42ac1b965eb9@debian.org>

On Wed, Nov 11, 2026 at 01:57:34AM -0800, Breno Leitao wrote:
> The hwrng core retries a failed read every 10 seconds, forever. When the
> TPM keeps answering GetRandom with an error, each retry logs a line:
> 
>   tpm tpm0: A TPM error (256) occurred attempting get random
>   tpm tpm0: A TPM error (256) occurred attempting get random
>   ...
> 
> Neither clears on its own, and the TPM does answer, so the timeout check
> in tpm_transmit() never fires.
> 
> After 60 failed reads in a row, ~ten minutes of retries on my system,
> set TPM_CHIP_FLAG_DISABLE as tpm_transmit() does for a TPM that stopped
> responding. Later reads then fail in tpm_try_get_ops() without sending
> the TPM a command. A successful read resets the count. A handful of
> failures is not enough, since some TPMs stall for half a minute and then
> recover.
> 
> This also takes the TPM away from userspace, which could otherwise
> still send TPM2_Startup or query the failure mode. Rebinding the driver
> brings it back.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 20 +++++++++++++++++++-
>  include/linux/tpm.h         |  1 +
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0be5dbfaa72ebf..d94ea462a5ef0c 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -466,11 +466,29 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
>  	return 0;
>  }
>  
> +#define TPM_HWRNG_MAX_FAILURES	60	/* ~10 minutes of retries */
> +
>  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
>  	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
> +	int rc;
> +
> +	rc = tpm_get_random(chip, data, max);
> +	if (rc > 0) {
> +		chip->hwrng_failures = 0;
> +		return rc;
> +	}
> +
> +	if (++chip->hwrng_failures == TPM_HWRNG_MAX_FAILURES &&
> +	    !(chip->flags & TPM_CHIP_FLAG_DISABLE)) {
> +		dev_err(&chip->dev, "hwrng: %u reads failed in a row, disabling the TPM\n",
> +			chip->hwrng_failures);
> +		mutex_lock(&chip->tpm_mutex);
> +		chip->flags |= TPM_CHIP_FLAG_DISABLE;
> +		mutex_unlock(&chip->tpm_mutex);
> +	}
>  
> -	return tpm_get_random(chip, data, max);
> +	return rc;
>  }
>  
>  static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4264c87a04d98c..402b5160db962c 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -129,6 +129,7 @@ struct tpm_chip {
>  
>  	char hwrng_name[64];
>  	struct hwrng hwrng;
> +	unsigned int hwrng_failures;	/* consecutive failed reads */
>  
>  	struct mutex tpm_mutex;	/* tpm is processing */
>  	unsigned int nr_timeouts;	/* consecutive command timeouts */
> 
> -- 
> 2.53.0-Meta
> 

I'm thinking here that why not disable on first failure?

Br, Jarkko
