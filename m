Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98B19BB3;
	Sat, 17 Oct 2026 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195931; cv=none; b=uJQoZrOMnk1N00bOk8hHxj1d6CGPwmk9nDImr6PRIOjuUJOaNTXnC2lHsRm1RLWAukXJFsxsqzkT9RVi1jziAtvTblIRN2dtY5ARa5whBL5k7tJ3wON/qah5rl2Swd06TIb6yb5D1SHDtQO00AgCdh1hKOhuynK4YEue+qx8h40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195931; c=relaxed/simple;
	bh=TEVwM4FT5GDC5tjWYnQteEFlka8WvgOJlzqit87ywvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc1C+SK4xmmhrvTRBdb5H5z8e5cQTT+Ntk9tN2nLqcphgCyMBv6ft4MaPi2UX//CXd/UPy/KsciYctx2SIIgYV2xF0VqC76uZ+Zy0jcJowCG1+VgEPMRlE6OKyfnwhr77gGWFy62LmXYERLzAF4pvvDM7vs6+47Zklfk8SrJa88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5/sQTb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5/sQTb7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 515391F000C4;
	Sat, 17 Oct 2026 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195929;
	bh=z4B0/BVxa7BYOHWw/PxuTHEe6BWSabn7jQcNpDQWD5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O5/sQTb79y/CL660wMl91nPaEe4C90BkesbFnNow6krj6UOeWd3VeLroCR/zVuuUD
	 q+HS0ikG9SSmiqXtbX+tSQogmQGEWdBNgeG9FgPmPp7bxazFCGhFUhsbfDtvg6vyzo
	 8Cxg50xF3QslLEtCnXnWpUz9DVBY+ULP5OhMGfZ8RF2cxVZko70LyYRrnubjqBWzc9
	 WBJ6jQZCsK6e4fbzlsjHuJEASGZTTTbClfe6sr9XWOihgb9Sk3w4nFBelLbRBSFCGH
	 TAPyKlBOXVeRTYmPT2IfxTjLOyLUeClYZUs63noHhpYxPucRi3L35cbliziV3nFu28
	 jpdmcB69MkOsQ==
Date: Sat, 17 Oct 2026 03:12:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [PATCH v2 1/2] tpm: Add support for updating TPM2 durations
Message-ID: <atK9VuMmeD3njBsz@kernel.org>
References: <20261016043733.30589-1-surenkj@amazon.com>
 <20261016043733.30589-2-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016043733.30589-2-surenkj@amazon.com>

On Fri, Oct 16, 2026 at 04:37:32AM +0000, Surendran Kanagaraj wrote:
> TPM commands need to complete within the command duration defined
> in the TPM2 spec or keep answering TPM2_RC_RETRY for at most
> TPM2_DURATION_LONG (2s).
> 
> Devices that have different timeout requirements than the TPM2 spec
> could exhaust the retry budget or exceed the command duration. These
> failures disable the device during an auth session, failing all
> subsequent TPM requests. Worse, when a TPM2_CC_FLUSH_CONTEXT command
> fails, it leaks the TPM's transient memory:
> 
>     tpm tpm0: in retry loop
>     tpm tpm0: tpm2_load_context: failed with a TPM error 0x0922
>     ...
>     tpm tpm0: A TPM error (2338) occurred flushing context
> 
> Fix this by overriding the command durations and retry budget
> based on chip->duration and letting the driver modify the durations
> during tpm2_get_timeouts() as TPM 1.x does. Chips without
> the override keep the current durations.
> 
> Tested in QEMU with swtpm on tpm_crb, tpm_tis, tpm_tis_i2c, tpm_ibmvtpm
> and tpm_vtpm_proxy.
> 
> Assisted-by: LLM
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
> V1 -> V2:
> - Drop chip->busy_timeout_ms. TPM2 durations and the TPM2_RC_RETRY
>   budget now come from chip->duration, which drivers adjust through
>   ->update_durations() as TPM 1.x does.
> - Map TPM2_CC_SELF_TEST and TPM2_CC_VERIFY_SIGNATURE to TPM_LONG with
>   floors of 3s and 30s since their durations do not fit SHORT, MEDIUM,
>   LONG durations.
> - Keep the TPM2 defaults for commands sent before tpm2_get_timeouts()
>   has run such as the one in tpm2_probe() and keep the 2s retry
>   budget for TPM 1.x chips.
> - Keep the first TPM2_RC_RETRY wait at TPM2_DURATION_SHORT instead of
>   chip->duration[TPM_SHORT].
> - Return early from tpm_tis_update_durations() for TPM2 chips, since
>   its overrides are for TPM 1.x.
> - Rename from "tpm: Add per-chip timeout for transient unavailability".
> 
> v1: https://lore.kernel.org/linux-integrity/20260923142834.16786-2-surenkj@amazon.com/

While the issue does get addressed the patch also makes the code
base worse. What would be more feasible would be to address the
architectural issue.

We absolutely do not want a new special to tpm_transmit().


> ---
>  drivers/char/tpm/tpm-interface.c | 11 ++--
>  drivers/char/tpm/tpm.h           |  2 +-
>  drivers/char/tpm/tpm2-cmd.c      | 90 ++++++++++++++++++++++++--------
>  drivers/char/tpm/tpm_tis_core.c  |  4 ++
>  4 files changed, 81 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index e0385b16616b..747e20ab421b 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -53,7 +53,7 @@ MODULE_PARM_DESC(suspend_pcr,
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  {
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		return tpm2_calc_ordinal_duration(ordinal);
> +		return tpm2_calc_ordinal_duration(chip, ordinal);
>  	else
>  		return tpm1_calc_ordinal_duration(chip, ordinal);
>  }
> @@ -214,7 +214,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>   *
>   * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
>   * the TPM and retransmits the command after a delay up to a maximum wait of
> - * TPM2_DURATION_LONG.
> + * chip->duration[TPM_LONG] (TPM2_DURATION_LONG until the durations are set).
>   *
>   * Note that TPM 1.x never returns TPM2_RC_RETRY so the retry logic is TPM 2.0
>   * only.
> @@ -229,12 +229,17 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  	/* space for header and handles */
>  	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
>  	unsigned int delay_msec = TPM2_DURATION_SHORT;
> +	unsigned int max_delay_msec = TPM2_DURATION_LONG;
>  	u32 rc = 0;
>  	ssize_t ret;
>  	const size_t save_size = min(sizeof(save), bufsiz);
>  	/* the command code is where the return code will be */
>  	u32 cc = be32_to_cpu(header->return_code);
>  
> +	if ((chip->flags & TPM_CHIP_FLAG_TPM2) &&
> +	    (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS))
> +		max_delay_msec = jiffies_to_msecs(chip->duration[TPM_LONG]);
> +
>  	/*
>  	 * Subtlety here: if we have a space, the handles will be
>  	 * transformed, so when we restore the header we also have to
> @@ -256,7 +261,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>  			break;
>  
> -		if (delay_msec > TPM2_DURATION_LONG) {
> +		if (delay_msec > max_delay_msec) {
>  			if (rc == TPM2_RC_RETRY)
>  				dev_err(&chip->dev, "in retry loop\n");
>  			else
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index fa554c5ad80b..457eba8d03dd 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -119,7 +119,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>  ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
>  int tpm2_auto_startup(struct tpm_chip *chip);
>  void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> -unsigned long tpm2_calc_ordinal_duration(u32 ordinal);
> +unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm2_probe(struct tpm_chip *chip);
>  int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
>  int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 4b2bb2ddc321..83a9e78ac843 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -41,55 +41,101 @@ int tpm2_find_hash_alg(unsigned int crypto_id)
>  }
>  EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
>  
> +/*
> + * The TPM2 defaults of chip->duration[] in milliseconds, indexed by
> + * enum tpm_duration.
> + */
> +static const unsigned int tpm2_durations_ms[TPM_NUM_DURATIONS] = {
> +	[TPM_SHORT] = TPM2_DURATION_SHORT,
> +	[TPM_MEDIUM] = TPM2_DURATION_MEDIUM,
> +	[TPM_LONG] = TPM2_DURATION_LONG,
> +	[TPM_LONG_LONG] = TPM2_DURATION_LONG_LONG,
> +};
> +
>  int tpm2_get_timeouts(struct tpm_chip *chip)
>  {
> +	unsigned long durations[3];
> +	int i;
> +
>  	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
>  	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
>  	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
>  	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
> +
> +	for (i = 0; i < TPM_NUM_DURATIONS; i++)
> +		chip->duration[i] = msecs_to_jiffies(tpm2_durations_ms[i]);
> +
> +	/* Provide the ability for vendor overrides of duration values. */
> +	if (chip->ops->update_durations)
> +		chip->ops->update_durations(chip, durations);
> +
> +	if (chip->duration_adjusted) {
> +		chip->duration[TPM_SHORT] = durations[0];
> +		chip->duration[TPM_MEDIUM] = durations[1];
> +		chip->duration[TPM_LONG] = durations[2];
> +	}
> +
>  	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
>  	return 0;
>  }
>  
>  /*
> - * Contains the maximum durations in milliseconds for TPM2 commands.
> + * Maps each TPM2 command to the chip->duration[] entry that holds its
> + * maximum duration. min_ms, when set, is a lower bound in milliseconds.
>   */
>  static const struct {
>  	unsigned long ordinal;
> -	unsigned long duration;
> +	enum tpm_duration index;
> +	unsigned int min_ms;
>  } tpm2_ordinal_duration_map[] = {
> -	{TPM2_CC_STARTUP, 750},
> -	{TPM2_CC_SELF_TEST, 3000},
> -	{TPM2_CC_GET_RANDOM, 2000},
> -	{TPM2_CC_SEQUENCE_UPDATE, 750},
> -	{TPM2_CC_SEQUENCE_COMPLETE, 750},
> -	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, 750},
> -	{TPM2_CC_HASH_SEQUENCE_START, 750},
> -	{TPM2_CC_VERIFY_SIGNATURE, 30000},
> -	{TPM2_CC_PCR_EXTEND, 750},
> -	{TPM2_CC_HIERARCHY_CONTROL, 2000},
> -	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
> -	{TPM2_CC_GET_CAPABILITY, 750},
> -	{TPM2_CC_NV_READ, 2000},
> -	{TPM2_CC_CREATE_PRIMARY, 300000},
> -	{TPM2_CC_CREATE, 300000},
> -	{TPM2_CC_CREATE_LOADED, 300000},
> +	{TPM2_CC_STARTUP, TPM_MEDIUM},
> +	{TPM2_CC_SELF_TEST, TPM_LONG, 3000},
> +	{TPM2_CC_GET_RANDOM, TPM_LONG},
> +	{TPM2_CC_SEQUENCE_UPDATE, TPM_MEDIUM},
> +	{TPM2_CC_SEQUENCE_COMPLETE, TPM_MEDIUM},
> +	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, TPM_MEDIUM},
> +	{TPM2_CC_HASH_SEQUENCE_START, TPM_MEDIUM},
> +	{TPM2_CC_VERIFY_SIGNATURE, TPM_LONG, 30000},
> +	{TPM2_CC_PCR_EXTEND, TPM_MEDIUM},
> +	{TPM2_CC_HIERARCHY_CONTROL, TPM_LONG},
> +	{TPM2_CC_HIERARCHY_CHANGE_AUTH, TPM_LONG},
> +	{TPM2_CC_GET_CAPABILITY, TPM_MEDIUM},
> +	{TPM2_CC_NV_READ, TPM_LONG},
> +	{TPM2_CC_CREATE_PRIMARY, TPM_LONG_LONG},
> +	{TPM2_CC_CREATE, TPM_LONG_LONG},
> +	{TPM2_CC_CREATE_LOADED, TPM_LONG_LONG},
>  };
>  
>  /**
>   * tpm2_calc_ordinal_duration() - Calculate the maximum command duration
> + * @chip: TPM chip to use.
>   * @ordinal: TPM command ordinal.
>   *
>   * Returns the maximum amount of time the chip is expected by kernel to
>   * take in jiffies.
>   */
> -unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
> +unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  {
> +	enum tpm_duration index;
> +	unsigned long duration;
> +	unsigned int min_ms;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
> -		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
> -			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
> +	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++) {
> +		if (ordinal != tpm2_ordinal_duration_map[i].ordinal)
> +			continue;
> +
> +		index = tpm2_ordinal_duration_map[i].index;
> +		min_ms = tpm2_ordinal_duration_map[i].min_ms;
> +
> +		/* chip->duration[] is unset until tpm2_get_timeouts() runs. */
> +		if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
> +			duration = chip->duration[index];
> +		else
> +			duration = msecs_to_jiffies(tpm2_durations_ms[index]);
> +
> +		return max(duration, msecs_to_jiffies(min_ms));
> +	}
>  
>  	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
>  }
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 143ef160820e..3738a5dd33e9 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -645,6 +645,10 @@ static void tpm_tis_update_durations(struct tpm_chip *chip,
>  	int i, rc;
>  	cap_t cap;
>  
> +	/* The vendor overrides below are for TPM 1.x chips only. */
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		return;
> +
>  	chip->duration_adjusted = false;
>  
>  	if (chip->ops->clk_enable != NULL)
> -- 
> 2.47.3
> 

Br, Jarkko
