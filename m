Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599117;
	b=P29H3kFf9e46iFxFAthpkNIx7gBpY+U7hVdlq2YpObowDAdg6rXUE2eLvFG0yh/VjrR3
	 lqgICjc3hGr1+HhK80GsxtfoC8jFq9P7NfAaK1v51EbQRmDZ684575OM2dG205Dm4B1Y/
	 RmFL962IQHNYYhPIJhgHqN5vF8srfeMbgouevhQiEwhj1C5YvehCEXmnwBXzFsCYcFvf5
	 UtpW+ocqBQj8GRzEmhHNwAo2/TOtpt1T/t4KGSNoKRN/V/TNTkyB6CKjtmP6wAvMVY2mf
	 J0DpjT+de3nkcb6XAOKMFTy/efEyGff9+lRnYov8WW+3OZATmV1VTPhcPO6R1kC9ZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599117;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wyLNsOH/NfmXDiIWwWvd8dNFPYU69yLrBJwif31FspI=;
	b=oBGazfwN3NS+lfy+6CHQbBEDbtyStrc2N/PcHtOlwSIfvcuM5MvSpunawJUeDz7R6abL
	 ofud0PRuGO57mlQ1zDERKazWVUjDTIMAGpekBw9DLWXq1/dAYWutoY1tZslDsZwlJnd1C
	 sniGBfSbtdIzy9vM61J8m46nwIwF6np/s0RyQNJRE8/NcmHMAYfyV9isSktXsmFwvXW9M
	 6tp0VFIjxeUb9GDQ6BKXI4h/w1eIgaxBklqq4NVmyTkBrc3eT72uqeFnY1GsVD4U7aMQ/
	 VixAf6xnXhE54eHNTiqi3zecbubhFnytHwsM8dkGIbJfKpjej9L4IKx9k7pmIR6NyYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baOZPiNs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7C007606A331;
	Fri, 13 Nov 2026 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baOZPiNs
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9559D1F000C4;
	Fri, 13 Nov 2026 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599117;
	bh=wyLNsOH/NfmXDiIWwWvd8dNFPYU69yLrBJwif31FspI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=baOZPiNsqTLTv798C7v6GBZsyDq1WtJnNEiYxCJ8ZNB1EwNZjksZY7aVnSXNXLILw
	 T8CeYhU3rZ8p223/YUIvtAa5Y6mN5a1kObMxPF99c0po6EMrrGrS4yfCvuL/FXSeWa
	 i0zugnAdWiFhb5X8wMfGIKt2mVf32uktgSlXIqV6eRPmG4ll2l20c5oOjNCdOvWhVU
	 z12ZHtSGrfgzzRYiMYFTyPpjFRl7KOxYgmXgS4gEunF9DplNC/hpMMTtSgrPjc+uQj
	 OHFLyy4JG7k1WWchHqgHX5T1tLHlDBEfsN57jZ2QHxvv0gnzecZvZ7DkFpvgXNwf3g
	 ACgfdafcg1t2g==
Date: Fri, 13 Nov 2026 21:45:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH v3 1/8] tpm: Add a single table for all TPM wait
 limits
Message-ID: <avdoybHEoRd0Fhie@kernel.org>
References: <20261112163846.97654-1-surenkj@amazon.com>
 <20261112163846.97654-2-surenkj@amazon.com>
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
In-Reply-To: <20261112163846.97654-2-surenkj@amazon.com>

On Thu, Nov 12, 2026 at 04:38:39PM +0000, Surendran Kanagaraj wrote:
> Every TPM wait takes its limit from a different place. The interface
> timeouts live in four jiffies fields, the TPM 1.x durations in an
> array, the TPM 2.0 durations in a per-ordinal map and the retry bound
> in a constant. A driver cannot see or adjust these values in one
> place. Apart from few TPM1.x fixups, nothing bounds checks these values.
> Also a driver can send a command before any timeout is set,
> xen-tpmfront calls tpm_get_timeouts() from probe before anything has
> set a timeout, so its TPM 1.x timeout query waits on the vTPM with a
> TIMEOUT_C of zero.
> 
> Add struct tpm_limits with one entry per limit: the interface timeouts
> TIMEOUT_A to TIMEOUT_D and the duration classes SHORT, MEDIUM, LONG,
> LONG_LONG and DEFAULT. Each entry holds the value in microseconds, its
> source (the defaults, the TPM or the driver) and whether validation
> clamped it.
> 
> tpm_chip_alloc() fills the table with the larger of the TPM 1.x and
> TPM 2.0 defaults, so a wait has a usable limit before the TPM is
> queried. Once the family is known, tpm_limits_update() rebuilds the
> table (next patch calls it from timing query) in a fixed order:
> the family defaults, the values the TPM reported, the driver's new
> ->adjust_limits() hook, then validation. Validation applies a floor
> and a ceiling, keeps SHORT to LONG_LONG in increasing order and
> keeps DEFAULT no shorter than LONG.
> 
> The hook sets values with tpm_limits_driver_set() or from a quirk
> table through tpm_limits_apply_quirks(). tpm_poll_timeout() waits on

OK, but ...

I.e. I'm not fully following what is the diffence between these call
paths.

> a condition for a limit from the table. No limits are read from the
> table yet. The following patches move them to it.
> 
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
>  drivers/char/tpm/Makefile     |   1 +
>  drivers/char/tpm/tpm-chip.c   |   1 +
>  drivers/char/tpm/tpm-limits.c | 368 ++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm.h        |  13 ++
>  include/linux/tpm.h           |  54 +++++
>  5 files changed, 437 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm-limits.c
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 5b5cdc0d32e4..92f469218e15 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -12,6 +12,7 @@ tpm-y += tpm2-cmd.o
>  tpm-y += tpmrm-dev.o
>  tpm-y += tpm2-space.o
>  tpm-y += tpm-sysfs.o
> +tpm-y += tpm-limits.o
>  tpm-y += eventlog/common.o
>  tpm-y += eventlog/tpm1.o
>  tpm-y += eventlog/tpm2.o
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0be5dbfaa72e..11a050c43e10 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -319,6 +319,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	}
>  
>  	chip->locality = -1;
> +	tpm_limits_init(chip);
>  	return chip;
>  
>  out:
> diff --git a/drivers/char/tpm/tpm-limits.c b/drivers/char/tpm/tpm-limits.c
> new file mode 100644
> index 000000000000..3fe5affa1522
> --- /dev/null
> +++ b/drivers/char/tpm/tpm-limits.c
> @@ -0,0 +1,368 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Handles time limits for a TPM chip.

I'd extend this to just have brief description how this works. Just a
high-level overview.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/string.h>
> +#include <linux/tpm_ptp.h>
> +#include "tpm.h"
> +
> +/* Bounds for the limits */
> +#define TPM_LIMIT_FLOOR_US	        (2 * TPM_POLL_DURATION_MAX_US)
> +#define TPM_LIMIT_INTF_CEILING_US	(60 * USEC_PER_SEC)
> +#define TPM_LIMIT_DURATION_CEILING_US	(30 * 60 * USEC_PER_SEC)
> +
> +#define TPM_POLL_START_US		100
> +#define TPM_POLL_INTF_MAX_US		100
> +#define TPM_POLL_DURATION_MAX_US	1000
> +
> +static const u32 tpm1_defaults[TPM_NR_LIMITS] = {
> +	[TPM_LIMIT_A]		= TIS_SHORT_TIMEOUT * USEC_PER_MSEC,
> +	[TPM_LIMIT_B]		= TIS_LONG_TIMEOUT * USEC_PER_MSEC,
> +	[TPM_LIMIT_C]		= TIS_SHORT_TIMEOUT * USEC_PER_MSEC,
> +	[TPM_LIMIT_D]		= TIS_SHORT_TIMEOUT * USEC_PER_MSEC,
> +
> +	[TPM_LIMIT_SHORT]	= 120 * USEC_PER_SEC,
> +	[TPM_LIMIT_MEDIUM]	= 120 * USEC_PER_SEC,
> +	[TPM_LIMIT_LONG]	= 120 * USEC_PER_SEC,
> +	[TPM_LIMIT_LONG_LONG]	= 120 * USEC_PER_SEC,
> +	[TPM_LIMIT_DEFAULT]	= 120 * USEC_PER_SEC,
> +};
> +
> +static const u32 tpm2_defaults[TPM_NR_LIMITS] = {
> +	[TPM_LIMIT_A]		= TPM2_TIMEOUT_A * USEC_PER_MSEC,
> +	[TPM_LIMIT_B]		= TPM2_TIMEOUT_B * USEC_PER_MSEC,
> +	[TPM_LIMIT_C]		= TPM2_TIMEOUT_C * USEC_PER_MSEC,
> +	[TPM_LIMIT_D]		= TPM2_TIMEOUT_D * USEC_PER_MSEC,
> +
> +	[TPM_LIMIT_SHORT]	= 750 * USEC_PER_MSEC,
> +	[TPM_LIMIT_MEDIUM]	= 2000 * USEC_PER_MSEC,
> +	[TPM_LIMIT_LONG]	= 3000 * USEC_PER_MSEC,
> +	[TPM_LIMIT_LONG_LONG]	= TPM2_DURATION_LONG_LONG * USEC_PER_MSEC,
> +	[TPM_LIMIT_DEFAULT]	= TPM2_DURATION_DEFAULT * USEC_PER_MSEC,
> +};
> +
> +static const char * const tpm_limit_names[TPM_NR_LIMITS] = {
> +	[TPM_LIMIT_A]		= "timeout_a",
> +	[TPM_LIMIT_B]		= "timeout_b",
> +	[TPM_LIMIT_C]		= "timeout_c",
> +	[TPM_LIMIT_D]		= "timeout_d",
> +	[TPM_LIMIT_SHORT]	= "short",
> +	[TPM_LIMIT_MEDIUM]	= "medium",
> +	[TPM_LIMIT_LONG]	= "long",
> +	[TPM_LIMIT_LONG_LONG]	= "long_long",
> +	[TPM_LIMIT_DEFAULT]	= "default",
> +};
> +
> +static const char * const tpm_limit_labels[TPM_NR_LIMITS] = {
> +	[TPM_LIMIT_A]		= "TIMEOUT_A",
> +	[TPM_LIMIT_B]		= "TIMEOUT_B",
> +	[TPM_LIMIT_C]		= "TIMEOUT_C",
> +	[TPM_LIMIT_D]		= "TIMEOUT_D",
> +	[TPM_LIMIT_SHORT]	= "SHORT",
> +	[TPM_LIMIT_MEDIUM]	= "MEDIUM",
> +	[TPM_LIMIT_LONG]	= "LONG",
> +	[TPM_LIMIT_LONG_LONG]	= "LONG_LONG",
> +	[TPM_LIMIT_DEFAULT]	= "DEFAULT",
> +};
> +
> +static const char * const tpm_limit_src_names[] = {
> +	[TPM_LSRC_DEFAULT]	= "DEFAULT",
> +	[TPM_LSRC_TPM]		= "TPM",
> +	[TPM_LSRC_DRIVER]	= "DRIVER",
> +};
> +
> +static u32 tpm_limits_default_us(enum tpm_family family, enum tpm_limit limit)
> +{
> +	switch (family) {
> +	case TPM_FAMILY_1:
> +		return tpm1_defaults[limit];
> +	case TPM_FAMILY_2:
> +		return tpm2_defaults[limit];
> +	default:
> +		return max(tpm1_defaults[limit], tpm2_defaults[limit]);
> +	}
> +}
> +
> +static u32 tpm_limits_ceiling_us(enum tpm_limit limit)
> +{
> +	if (TPM_LIMIT_INTF_MASK & BIT(limit))
> +		return TPM_LIMIT_INTF_CEILING_US;
> +
> +	return TPM_LIMIT_DURATION_CEILING_US;
> +}
> +
> +static void tpm_limits_store(struct tpm_limits *p, enum tpm_limit limit,
> +			     u32 us, enum tpm_limit_src src, u32 flags)
> +{
> +	p->entry[limit].time_us = us;
> +	p->entry[limit].src = src;
> +	p->entry[limit].flags = flags;
> +}
> +
> +static void tpm_limits_raise(struct tpm_limits *p, enum tpm_limit limit,
> +			     u32 us)
> +{
> +	if (p->entry[limit].time_us < us) {
> +		p->entry[limit].time_us = us;
> +		p->entry[limit].flags |= TPM_LF_CLAMPED;
> +	}
> +}
> +
> +static void tpm_limits_stage_defaults(struct tpm_limits *p,
> +				      enum tpm_family family)
> +{
> +	int limit;
> +
> +	memset(p, 0, sizeof(*p));
> +	p->family = family;
> +	for (limit = 0; limit < TPM_NR_LIMITS; limit++)
> +		tpm_limits_store(p, limit,
> +				 tpm_limits_default_us(family, limit),
> +				 TPM_LSRC_DEFAULT, 0);
> +}
> +
> +/* The values the TPM reported, in usecs; zero where it reported nothing. */
> +static void tpm_limits_stage_reported(struct tpm_limits *p,
> +				      const u32 *reported)
> +{
> +	int limit;
> +
> +	for (limit = 0; limit < TPM_NR_LIMITS; limit++) {
> +		if (reported[limit])
> +			tpm_limits_store(p, limit, reported[limit],
> +					 TPM_LSRC_TPM, 0);
> +	}
> +}
> +
> +static void tpm_limits_stage_validate(struct tpm_limits *p)
> +{
> +	int limit;
> +
> +	for (limit = 0; limit < TPM_NR_LIMITS; limit++) {
> +		struct tpm_limit_entry *e = &p->entry[limit];
> +		u32 lo = TPM_LIMIT_FLOOR_US;
> +		u32 hi = tpm_limits_ceiling_us(limit);
> +
> +		if (e->time_us < lo) {
> +			e->time_us = lo;
> +			e->flags |= TPM_LF_CLAMPED;
> +		} else if (e->time_us > hi) {
> +			e->time_us = hi;
> +			e->flags |= TPM_LF_CLAMPED;
> +		}
> +	}
> +
> +	/*
> +	 * Keep SHORT to LONG_LONG in increasing order, and DEFAULT no shorter
> +	 * than LONG.
> +	 */
> +	for (limit = TPM_LIMIT_MEDIUM; limit <= TPM_LIMIT_LONG_LONG; limit++)
> +		tpm_limits_raise(p, limit, p->entry[limit - 1].time_us);
> +
> +	tpm_limits_raise(p, TPM_LIMIT_DEFAULT,
> +			 p->entry[TPM_LIMIT_LONG].time_us);
> +}
> +
> +static void tpm_limits_commit(struct tpm_chip *chip,
> +			      const struct tpm_limits *p)
> +{
> +	const struct tpm_limit_entry *e = p->entry;
> +	int limit;
> +
> +	chip->limits = *p;
> +
> +	for (limit = 0; limit < TPM_NR_LIMITS; limit++)
> +		dev_dbg(&chip->dev, "limit %s = %u us (%s%s)\n",
> +			tpm_limit_names[limit], e[limit].time_us,
> +			tpm_limit_src_names[e[limit].src],
> +			e[limit].flags & TPM_LF_CLAMPED ? ", clamped" : "");
> +}
> +
> +/**
> + * tpm_limits_init() - set the boot limits of a new chip
> + * @chip: the chip tpm_chip_alloc() is setting up
> + *
> + * The family is not known yet, so each limit gets the larger of the two
> + * families' defaults before validation applies.
> + * The driver's data is not attached yet, so its ->adjust_limits() hook first
> + * runs from tpm_limits_update().
> + */
> +void tpm_limits_init(struct tpm_chip *chip)
> +{
> +	struct tpm_limits p;
> +
> +	tpm_limits_stage_defaults(&p, TPM_FAMILY_UNKNOWN);
> +	tpm_limits_stage_validate(&p);
> +	tpm_limits_commit(chip, &p);
> +}
> +
> +/**
> + * tpm_limits_update() - build the limits once the TPM family is known
> + * @chip:	the TPM chip, started, with TPM_CHIP_FLAG_TPM2 set on TPM 2.0
> + * @reported:	TPM_NR_LIMITS values in usecs, indexed by enum tpm_limit,
> + *		zero where the TPM reported nothing; or NULL
> + *
> + * Runs the stages in order: the family defaults, @reported, the driver's
> + * ->adjust_limits() hook, then validation. The hook may send commands, so
> + * the chip must be started. Call it before the chip is registered or with
> + * tpm_mutex held, so that no command sees half-built limits.
> + */
> +void tpm_limits_update(struct tpm_chip *chip, const u32 *reported)
> +{
> +	enum tpm_family family = chip->flags & TPM_CHIP_FLAG_TPM2 ?
> +				 TPM_FAMILY_2 : TPM_FAMILY_1;
> +	struct tpm_limits p;
> +
> +	tpm_limits_stage_defaults(&p, family);
> +	if (reported)
> +		tpm_limits_stage_reported(&p, reported);
> +	if (chip->ops->adjust_limits)
> +		chip->ops->adjust_limits(chip, &p);
> +	tpm_limits_stage_validate(&p);
> +	tpm_limits_commit(chip, &p);
> +}
> +
> +/**
> + * tpm_limits_driver_set() - set a limit from a driver's ->adjust_limits() hook
> + * @p:		the limits the hook received
> + * @limit:	the limit to set
> + * @us:		the new value in microseconds
> + *
> + * Marks the driver as the source of @limit. Validation runs after the hook,
> + * so the value can still be clamped.
> + */
> +void tpm_limits_driver_set(struct tpm_limits *p, enum tpm_limit limit, u32 us)
> +{
> +	if (WARN_ON_ONCE(limit >= TPM_NR_LIMITS))
> +		return;
> +
> +	tpm_limits_store(p, limit, us, TPM_LSRC_DRIVER, 0);
> +}
> +EXPORT_SYMBOL_GPL(tpm_limits_driver_set);
> +
> +/**
> + * tpm_limits_apply_quirks() - apply the first matching quirk entry
> + * @p:		the limits the ->adjust_limits() hook received
> + * @quirks:	the driver's quirk table
> + * @n:		the number of entries in @quirks
> + * @id:		the device identity to match, as the driver defines it
> + *
> + * Applies the first entry whose id is @id. Each non-zero value in the entry
> + * is set as tpm_limits_driver_set() does.
> + */
> +void tpm_limits_apply_quirks(struct tpm_limits *p,
> +			     const struct tpm_limits_quirk *quirks, size_t n,
> +			     u32 id)
> +{
> +	size_t i;
> +	int limit;
> +
> +	for (i = 0; i < n; i++) {
> +		if (quirks[i].id != id)
> +			continue;
> +
> +		for (limit = 0; limit < TPM_NR_LIMITS; limit++) {
> +			if (quirks[i].time_us[limit])
> +				tpm_limits_driver_set(p, limit,
> +						      quirks[i].time_us[limit]);
> +		}
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(tpm_limits_apply_quirks);
> +
> +static u32 tpm_limits_us(struct tpm_chip *chip, enum tpm_limit limit)
> +{
> +	if (!chip)
> +		return tpm_limits_default_us(TPM_FAMILY_UNKNOWN, limit);
> +
> +	return chip->limits.entry[limit].time_us;
> +}
> +
> +static int tpm_poll(struct tpm_chip *chip, u32 timeout_us,
> +		    enum tpm_limit limit,
> +		    bool (*cond)(struct tpm_chip *chip, void *arg), void *arg)
> +{
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
> +	unsigned int max_us = TPM_POLL_INTF_MAX_US;
> +	unsigned int delay = TPM_POLL_START_US;
> +	const char *label = "fixed timeout";
> +	const char *src = "CALLER";
> +
> +	might_sleep();
> +
> +	if (limit < TPM_NR_LIMITS && !(TPM_LIMIT_INTF_MASK & BIT(limit)))
> +		max_us = TPM_POLL_DURATION_MAX_US;
> +
> +	for (;;) {
> +		if (cond(chip, arg))
> +			return 0;
> +		if (ktime_after(ktime_get(), timeout))
> +			break;
> +
> +		usleep_range(delay / 2, delay);
> +		delay = min(delay * 2, max_us);
> +	}
> +
> +	if (cond(chip, arg))
> +		return 0;
> +	if (!chip)
> +		return -ETIME;
> +
> +	if (limit < TPM_NR_LIMITS) {
> +		label = tpm_limit_labels[limit];
> +		src = tpm_limit_src_names[chip->limits.entry[limit].src];
> +	}
> +	dev_warn_ratelimited(&chip->dev, "%s expired after %u us (source %s)\n",
> +			     label, timeout_us, src);
> +	return -ETIME;
> +}
> +
> +/**
> + * tpm_poll_timeout() - poll a condition until it holds or a limit passes
> + * @chip:	the TPM chip, or NULL before tpm_chip_alloc()
> + * @limit:	the limit that bounds the wait
> + * @cond:	returns true once the wait is over
> + * @arg:	passed to @cond
> + *
> + * Drivers pass an interface timeout, TPM_LIMIT_A to TPM_LIMIT_D, and the core
> + * passes a command's execution limit. Without a chip, the larger of the two
> + * families' defaults applies, @cond gets a NULL @chip and nothing is printed
> + * on expiry. @cond is checked once more after the deadline, so a TPM that
> + * finished while the caller was descheduled does not time out.
> + *
> + * Return: 0 once @cond holds, -ETIME if @limit passes first, or -EINVAL for
> + * a limit out of range.
> + */
> +int tpm_poll_timeout(struct tpm_chip *chip, enum tpm_limit limit,
> +		     bool (*cond)(struct tpm_chip *chip, void *arg), void *arg)
> +{
> +	if (WARN_ON_ONCE(limit >= TPM_NR_LIMITS))
> +		return -EINVAL;
> +
> +	return tpm_poll(chip, tpm_limits_us(chip, limit), limit, cond, arg);
> +}
> +EXPORT_SYMBOL_GPL(tpm_poll_timeout);
> +
> +/**
> + * tpm_poll_timeout_us() - poll a condition with a driver-chosen timeout
> + * @chip:	the TPM chip, or NULL before tpm_chip_alloc()
> + * @timeout_us:	the timeout in microseconds
> + * @cond:	returns true once the wait is over
> + * @arg:	passed to @cond
> + *
> + * For a wait no TCG spec names, such as a mailbox doorbell. Otherwise as
> + * tpm_poll_timeout().
> + *
> + * Return: 0 once @cond holds, or -ETIME if @timeout_us passes first.
> + */
> +int tpm_poll_timeout_us(struct tpm_chip *chip, u32 timeout_us,
> +			bool (*cond)(struct tpm_chip *chip, void *arg),
> +			void *arg)
> +{
> +	return tpm_poll(chip, timeout_us, TPM_NR_LIMITS, cond, arg);
> +}

I did not check all the details but could this be reorganized into:

1. __tpm_poll(): the same as tpm_poll() but exported and defined in
   drivers/char/tpm.h.
2. tpm_poll(): a single static inline function declared fully at
   drivers/char/tpm.h

__tpm_poll() would e.g., make a nicer trace point for a kprobe or
kretprobe.


> +EXPORT_SYMBOL_GPL(tpm_poll_timeout_us);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index fa554c5ad80b..be88011f9618 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -75,6 +75,19 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
>  int tpm1_get_pcr_allocation(struct tpm_chip *chip);
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> +
> +void tpm_limits_init(struct tpm_chip *chip);
> +void tpm_limits_update(struct tpm_chip *chip, const u32 *reported);
> +void tpm_limits_driver_set(struct tpm_limits *p, enum tpm_limit limit, u32 us);
> +void tpm_limits_apply_quirks(struct tpm_limits *p,
> +			     const struct tpm_limits_quirk *quirks, size_t n,
> +			     u32 id);
> +int tpm_poll_timeout(struct tpm_chip *chip, enum tpm_limit limit,
> +		     bool (*cond)(struct tpm_chip *chip, void *arg), void *arg);
> +int tpm_poll_timeout_us(struct tpm_chip *chip, u32 timeout_us,
> +			bool (*cond)(struct tpm_chip *chip, void *arg),
> +			void *arg);
> +
>  int tpm_pm_suspend(struct device *dev);
>  int tpm_pm_resume(struct device *dev);
>  int tpm_class_shutdown(struct device *dev);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 0db277af45c3..5454d87f43ba 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -29,6 +29,7 @@
>  #include <linux/tpm_buf.h>
>  
>  struct tpm_chip;
> +struct tpm_limits;
>  struct trusted_key_payload;
>  struct trusted_key_options;
>  /* opaque structure, holds auth session parameters like the session key */
> @@ -52,6 +53,7 @@ struct tpm_class_ops {
>  				unsigned long *timeout_cap);
>  	void (*update_durations)(struct tpm_chip *chip,
>  				 unsigned long *duration_cap);
> +	void (*adjust_limits)(struct tpm_chip *chip, struct tpm_limits *p);
>  	int (*go_idle)(struct tpm_chip *chip);
>  	int (*cmd_ready)(struct tpm_chip *chip);
>  	int (*request_locality)(struct tpm_chip *chip, int loc);
> @@ -71,6 +73,56 @@ enum tpm_duration {
>  	TPM_NUM_DURATIONS = TPM_UNDEFINED,
>  };
>  
> +enum tpm_limit {
> +	/* Interface handshake timeouts */
> +	TPM_LIMIT_A,
> +	TPM_LIMIT_B,
> +	TPM_LIMIT_C,
> +	TPM_LIMIT_D,
> +
> +	/* Command duration classes */
> +	TPM_LIMIT_SHORT,
> +	TPM_LIMIT_MEDIUM,
> +	TPM_LIMIT_LONG,
> +	TPM_LIMIT_LONG_LONG,
> +	TPM_LIMIT_DEFAULT,
> +
> +	TPM_NR_LIMITS,
> +};
> +
> +#define TPM_LIMIT_INTF_MASK		GENMASK(TPM_LIMIT_D, TPM_LIMIT_A)
> +
> +enum tpm_family {
> +	TPM_FAMILY_1,		/* TPM 1.1 and 1.2 */
> +	TPM_FAMILY_2,
> +	TPM_FAMILY_UNKNOWN,
> +};
> +
> +enum tpm_limit_src {
> +	TPM_LSRC_DEFAULT,	/* default values */
> +	TPM_LSRC_TPM,		/* reported by the TPM */
> +	TPM_LSRC_DRIVER,	/* set by the driver */
> +};
> +
> +#define TPM_LF_CLAMPED		BIT(0)	/* limit validation replaced the value */
> +
> +struct tpm_limit_entry {
> +	u32 time_us;
> +	enum tpm_limit_src src;
> +	u32 flags;		/* TPM_LF_* */
> +};
> +
> +struct tpm_limits {
> +	enum tpm_family family;
> +	struct tpm_limit_entry entry[TPM_NR_LIMITS];
> +};
> +
> +/* per-device overrides based on id the driver defines e.g. DID/VID */
> +struct tpm_limits_quirk {
> +	u32 id;				/* driver-defined device identity */
> +	u32 time_us[TPM_NR_LIMITS];	/* 0 leaves the limit alone */
> +};

I think it would make more sense to fully initialize the database per
device, if that is possible.

It is a non-concern if two TPM drivers do some redundant work, as it
is not a real-world production use case :-)

I'm just wondering if this quirk/entry division.

I.e. in my world view chip owns its limits (not e.g., tpm2_space).


> +
>  #define TPM_PPI_VERSION_LEN		3
>  
>  struct tpm_space {
> @@ -140,6 +192,8 @@ struct tpm_chip {
>  	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>  	bool duration_adjusted;
>  
> +	struct tpm_limits limits;
> +
>  	struct dentry *bios_dir;
>  
>  	const struct attribute_group *groups[3 + TPM_MAX_HASHES];
> -- 
> 2.47.3
> 

This is a great starting point.

Br, Jarkko.
