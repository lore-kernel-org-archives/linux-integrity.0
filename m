Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177378;
	b=tJJKxyD/ipMk1Hefp1ews8NrswwU0XprPS/c37NiZLgCNeaKlMQ2GmEHaGnEvZ77g5qy
	 g0Dy41mco1uXD+bshGmKHeCBWF7H/JoZHKDki7hhwaI5VMrJHyED5S9CoyqhqhyNoVwSq
	 VUAihF+Y8x8k15ZaFAXGWbV+Nx0kJsQp9/1HFQgTmtO96JgJlsqYe9exuIFiNMawUtYbT
	 OHkjiuDXnwKHKYiVDo2ZH+Dvgvy0DjbkJwHjaSiJZGsq6jceF/nfuoGQ3yw/diKHefZ66
	 1EilYtj61iRtkNs+/BUmhLr0XzvTQ7fugPnN+XmYMU79UnNAr97KICtH/NHW8sRW1fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177378;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XHI6wTW3ZRcibK5juO3ERVGrPX9Er8XYCuFzLH2tt9E=;
	b=cnsdHvOTMikgafkNXpQtooC06BbVqgzpsVy3GhDifjcvWjZ27LDwreMjN8fvpwo+c8MV
	 dhMsN+gvupQkwGwmhwP4UPeeaRkeynq+NVcTjEuGBTf4sjcjQKOq+QQ0H49OUyPj0aZlq
	 Z/ccvn5H4Qp9IWL/i4f6MNaT5LHUEX9Yd/AXFO2bOpSvLtmXCuS/xWUrZCsw1A//q0XVU
	 YUpPEMfvHCi+Gy2Idwi9wV+hXj0UJ709FMcQPSpl1g/S0yOKbOM04QOBJMl0uveAMp1fY
	 2bTBGW2dz3iX7/9nG+kts+SJgqObtKXxGmtwwYgXTy0wW3P02+nx0it51MdaXevzgyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNw6IfTG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 812A0606A320;
	Fri, 20 Nov 2026 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNw6IfTG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C64651F000EB;
	Fri, 20 Nov 2026 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177378;
	bh=XHI6wTW3ZRcibK5juO3ERVGrPX9Er8XYCuFzLH2tt9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eNw6IfTG/6lgEqw/QAU6eFNjfkAjaqFVJn0/jrlOeLjLwKIJFJx2WF4r3MAWztmk5
	 a4ySE6mpraVfcEaxaIBU46uNGWPETnSXhuMbVWTPHAUeHA3tw7DU0RmDnLCbsqkxvD
	 k2yaFSjH+7+oLQNEa/U1i7p/1+p5eQxD46Knx7kpnxuH6HxCZNw+kWplSEEA+3sLPI
	 pW6yaPIBpTsM5j3S95n7oBSwu1khQRlWduHQKlz8M3hKoEbQE//TvL/SOQ6AlaBjY7
	 Ud/nvDU9wHF5iKkdvj4HMZMO/VJooylcPJmKH+U77eOaK7JJTCzNrfpqopOm5Z/46k
	 KUO80W7cNIU6w==
Date: Fri, 20 Nov 2026 14:22:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Breno Leitao <leitao@debian.org>, nh-open-source@amazon.com,
	Alexander Graf <graf@amazon.de>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH v4 4/8] tpm: Bound core and CRB waits by the limits
 table
Message-ID: <awA7ns3kfuOBanxW@kernel.org>
References: <20261118073852.81107-1-surenkj@amazon.com>
 <20261118073852.81107-5-surenkj@amazon.com>
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
In-Reply-To: <20261118073852.81107-5-surenkj@amazon.com>

On Wed, Nov 18, 2026 at 07:38:48AM +0000, Surendran Kanagaraj wrote:
> Polls in tpm_try_transmit() still use fixed 1 ms sleeps and
> tpm_transmit() stops retrying once the next backoff would pass
> TPM2_DURATION_LONG and tpm_crb always waits TPM2_TIMEOUT_C.
> A value set through ->adjust_limits() reaches neither the retry
> loop nor the crb waits.
> 
> Poll for completion with tpm_poll_timeout(). Its sleeps start at 100 us
> and double up to 1 ms. It checks the condition once more after the
> deadline and an expired wait logs the limit and where its value came
> from. Bound the total sleep of the retry loop  by the LONG duration,
> whose 3 s TPM 2.0 default keeps the current seven retries. Until the
> timing query sets the family, LONG holds the 120 s TPM 1.x default,
> so the loop uses the TPM 2.0 one instead. tpm_crb waits on TIMEOUT_C
> through tpm_poll_timeout(). The Pluton doorbell's completion wait,
> which no spec names keeps its 200 ms through tpm_poll_timeout_us().
> 
> Two waits behave differently. Completion polling first sleeps at most
> 100 us instead of 1 ms. Until tpm2_get_timeouts() runs, tpm_crb waits
> up to 750 ms for TIMEOUT_C, the larger of the two families' defaults,
> instead of 200 ms. From then on it waits 200 ms as before.
> 
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 57 +++++++++++++-------------
>  drivers/char/tpm/tpm-limits.c    | 19 +++++++++
>  drivers/char/tpm/tpm.h           |  2 +-
>  drivers/char/tpm/tpm_crb.c       | 70 +++++++++++++++++---------------
>  4 files changed, 87 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8cb4cbc9e2a6..abd16e71f79c 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -103,6 +103,16 @@ static void tpm_go_idle(struct tpm_chip *chip)
>  		chip->ops->go_idle(chip);
>  }
>  
> +/* Poll condition: the command completed or was canceled. */
> +static bool tpm_cmd_done(struct tpm_chip *chip, void *arg)
> +{
> +	u8 *status = arg;
> +
> +	*status = tpm_chip_status(chip);
> +	return tpm_transmit_completed(*status, chip) ||
> +	       tpm_chip_req_canceled(chip, *status);
> +}
> +
>  DEFINE_FREE(tpm_go_idle, struct tpm_chip *, if (_T) tpm_go_idle(_T))
>  
>  static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> @@ -112,7 +122,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	int rc;
>  	ssize_t len = 0;
>  	u32 count, ordinal;
> -	unsigned long stop;
> +	u8 status;
>  
>  	if (bufsiz < TPM_HEADER_SIZE)
>  		return -EINVAL;
> @@ -173,31 +183,19 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	if (chip->flags & TPM_CHIP_FLAG_IRQ)
>  		goto out_recv;
>  
> -	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> -	do {
> -		u8 status = tpm_chip_status(chip);
> -		if (tpm_transmit_completed(status, chip))
> -			goto out_recv;
> -
> -		if (tpm_chip_req_canceled(chip, status)) {
> -			dev_err(&chip->dev, "Operation Canceled\n");
> -			return -ECANCELED;
> -		}
> -
> -		tpm_msleep(TPM_TIMEOUT_POLL);
> -		rmb();
> -	} while (time_before(jiffies, stop));
> -
> -	/*
> -	 * Check for completion one more time, just in case the device reported
> -	 * it while the driver was sleeping in the busy loop above.
> -	 */
> -	if (tpm_transmit_completed(tpm_chip_status(chip), chip))
> -		goto out_recv;
> +	if (tpm_poll_timeout(chip, tpm_duration_limit(chip, ordinal),
> +			     tpm_cmd_done, &status)) {
> +		tpm_chip_cancel(chip);
> +		dev_err(&chip->dev, "Operation Timed out\n");
> +		return -ETIME;
> +	}
> +	/* Read the response only after the status reported completion. */
> +	rmb();
>  
> -	tpm_chip_cancel(chip);
> -	dev_err(&chip->dev, "Operation Timed out\n");
> -	return -ETIME;
> +	if (!tpm_transmit_completed(status, chip)) {
> +		dev_err(&chip->dev, "Operation Canceled\n");
> +		return -ECANCELED;
> +	}
>  
>  out_recv:
>  	len = chip->ops->recv(chip, buf, bufsiz);
> @@ -220,8 +218,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>   * @bufsiz:	length of the TPM command buffer
>   *
>   * A wrapper around tpm_try_transmit() that handles TPM2_RC_RETRY returns from
> - * the TPM and retransmits the command after a delay up to a maximum wait of
> - * TPM2_DURATION_LONG.
> + * the TPM and retransmits the command after a doubling delay, for as long as
> + * the sleeps fit in the chip's LONG duration limit.
>   *
>   * Note that TPM 1.x never returns TPM2_RC_RETRY so the retry logic is TPM 2.0
>   * only.
> @@ -236,6 +234,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  	/* space for header and handles */
>  	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
>  	unsigned int delay_msec = TPM2_DURATION_SHORT;
> +	unsigned int slept_msec = 0;
>  	u32 rc = 0;
>  	ssize_t ret;
>  	const size_t save_size = min(sizeof(save), bufsiz);
> @@ -263,7 +262,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>  			break;
>  
> -		if (delay_msec > TPM2_DURATION_LONG) {
> +		if ((slept_msec + delay_msec) * USEC_PER_MSEC >
> +		    tpm_limits_retry_us(chip)) {
>  			if (rc == TPM2_RC_RETRY)
>  				dev_err(&chip->dev, "in retry loop\n");
>  			else
> @@ -272,6 +272,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz)
>  			break;
>  		}
>  		tpm_msleep(delay_msec);
> +		slept_msec += delay_msec;
>  		delay_msec *= 2;
>  		memcpy(buf, save, save_size);
>  	}
> diff --git a/drivers/char/tpm/tpm-limits.c b/drivers/char/tpm/tpm-limits.c
> index 5b984cb636f0..bdaa0339195e 100644
> --- a/drivers/char/tpm/tpm-limits.c
> +++ b/drivers/char/tpm/tpm-limits.c
> @@ -259,6 +259,25 @@ void tpm_limits_driver_set(struct tpm_limits *p, enum tpm_limit limit, u32 us)
>  }
>  EXPORT_SYMBOL_GPL(tpm_limits_driver_set);
>  
> +/**
> + * tpm_limits_retry_us() - the total sleep allowed between resubmissions
> + * @chip:	the TPM chip
> + *
> + * The LONG duration bounds how long tpm_transmit() keeps resubmitting a
> + * command the TPM asked to retry. Until the timing query sets the family,
> + * LONG holds the larger TPM 1.x default, so use the TPM 2.0 one: only a
> + * TPM 2.0 chip asks for a retry.
> + *
> + * Return: the bound in microseconds.
> + */
> +u32 tpm_limits_retry_us(struct tpm_chip *chip)
> +{
> +	if (chip->limits.family == TPM_FAMILY_UNKNOWN)
> +		return tpm2_defaults[TPM_LIMIT_LONG];
> +
> +	return chip->limits.entry[TPM_LIMIT_LONG].time_us;
> +}
> +
>  /**
>   * tpm_limits_us() - the value of a limit
>   * @chip:	the TPM chip, or NULL before tpm_chip_alloc()
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 223998f99386..b3dc5c7161cf 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -40,7 +40,6 @@ enum tpm_timeout {
>  	TPM_TIMEOUT = 5,	/* msecs */
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
> -	TPM_TIMEOUT_POLL = 1,	/* msecs */
>  	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
>  	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
>  };
> @@ -79,6 +78,7 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  void tpm_limits_init(struct tpm_chip *chip);
>  void tpm_limits_update(struct tpm_chip *chip, const u32 *reported);
>  void tpm_limits_driver_set(struct tpm_limits *p, enum tpm_limit limit, u32 us);
> +u32 tpm_limits_retry_us(struct tpm_chip *chip);
>  u32 tpm_limits_us(struct tpm_chip *chip, enum tpm_limit limit);
>  int __tpm_poll(struct tpm_chip *chip, u32 timeout_us, enum tpm_limit limit,
>  	       bool (*cond)(struct tpm_chip *chip, void *arg), void *arg);
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 8585c73fb25b..5f29eabf2413 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -111,6 +111,7 @@ struct crb_priv {
>  	u8 ffa_flags;
>  	u8 ffa_attributes;
>  	u32 intf_id;
> +	struct tpm_chip *chip;	/* NULL until tpmm_chip_alloc() */
>  };
>  
>  struct tpm2_crb_smc {
> @@ -134,6 +135,12 @@ struct tpm2_crb_pluton {
>  	u64 reply_addr;
>  };
>  
> +struct crb_reg_wait {
> +	u32 __iomem *reg;
> +	u32 mask;
> +	u32 value;
> +};
> +
>  /*
>   * Returns true if the start method supports idle.
>   */
> @@ -144,39 +151,40 @@ static inline bool tpm_crb_has_idle(void)
>  		 tpm2_acpi_start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
>  }
>  
> -static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
> -				unsigned long timeout)
> +static bool crb_reg_matches(struct tpm_chip *chip, void *arg)
>  {
> -	ktime_t start;
> -	ktime_t stop;
> +	struct crb_reg_wait *w = arg;
>  
> -	start = ktime_get();
> -	stop = ktime_add(start, ms_to_ktime(timeout));
> -
> -	do {
> -		if ((ioread32(reg) & mask) == value)
> -			return true;
> +	return (ioread32(w->reg) & w->mask) == w->value;
> +}
>  
> -		usleep_range(50, 100);
> -	} while (ktime_before(ktime_get(), stop));
> +/* Wait up to TIMEOUT_C for the @mask bits of @reg to read as @value. */
> +static bool crb_wait_for_reg_32(struct crb_priv *priv, u32 __iomem *reg,
> +				u32 mask, u32 value)
> +{
> +	struct crb_reg_wait w = { .reg = reg, .mask = mask, .value = value };
>  
> -	return ((ioread32(reg) & mask) == value);
> +	return !tpm_poll_timeout(priv->chip, TPM_LIMIT_C, crb_reg_matches, &w);
>  }
>  
>  static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete)
>  {
> +	struct crb_reg_wait w = {
> +		.reg = priv->pluton_start_addr, .mask = 0xffffffff, .value = 0,
> +	};
> +
>  	if (tpm2_acpi_start_method != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		return 0;
>  
> -	if (!crb_wait_for_reg_32(priv->pluton_reply_addr, ~0, 1, TPM2_TIMEOUT_C))
> +	if (!crb_wait_for_reg_32(priv, priv->pluton_reply_addr, ~0, 1))
>  		return -ETIME;
>  
>  	iowrite32(1, priv->pluton_start_addr);
>  	if (wait_for_complete == false)
>  		return 0;
>  
> -	if (!crb_wait_for_reg_32(priv->pluton_start_addr,
> -				 0xffffffff, 0, 200))
> +	if (tpm_poll_timeout_us(priv->chip, 200 * USEC_PER_MSEC,
> +				crb_reg_matches, &w))
>  		return -ETIME;
>  
>  	return 0;
> @@ -218,10 +226,9 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv, int loc)
>  	if (rc)
>  		return rc;
>  
> -	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
> +	if (!crb_wait_for_reg_32(priv, &priv->regs_t->ctrl_req,
>  				 CRB_CTRL_REQ_GO_IDLE/* mask */,
> -				 0, /* value */
> -				 TPM2_TIMEOUT_C)) {
> +				 0 /* value */)) {
>  		dev_warn(dev, "goIdle timed out\n");
>  		return -ETIME;
>  	}
> @@ -272,10 +279,9 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv, int loc)
>  	if (rc)
>  		return rc;
>  
> -	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
> +	if (!crb_wait_for_reg_32(priv, &priv->regs_t->ctrl_req,
>  				 CRB_CTRL_REQ_CMD_READY /* mask */,
> -				 0, /* value */
> -				 TPM2_TIMEOUT_C)) {
> +				 0 /* value */)) {
>  		dev_warn(dev, "cmdReady timed out\n");
>  		return -ETIME;
>  	}
> @@ -308,8 +314,8 @@ static int __crb_request_locality(struct device *dev,
>  			return rc;
>  	}
>  
> -	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
> -				 TPM2_TIMEOUT_C)) {
> +	if (!crb_wait_for_reg_32(priv, &priv->regs_h->loc_state, value,
> +				 value)) {
>  		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
>  		return -ETIME;
>  	}
> @@ -342,8 +348,8 @@ static int __crb_relinquish_locality(struct device *dev,
>  			return rc;
>  	}
>  
> -	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
> -				 TPM2_TIMEOUT_C)) {
> +	if (!crb_wait_for_reg_32(priv, &priv->regs_h->loc_state, mask,
> +				 value)) {
>  		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
>  		return -ETIME;
>  	}
> @@ -428,9 +434,8 @@ static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
>  		if (rc)
>  			return rc;
>  
> -		expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> -						CRB_START_NEXT_CHUNK, 0,
> -						TPM2_TIMEOUT_C);
> +		expired = !crb_wait_for_reg_32(priv, &priv->regs_t->ctrl_start,
> +						CRB_START_NEXT_CHUNK, 0);
>  		if (expired) {
>  			dev_err(&chip->dev,
>  				"Timeout waiting for backend response\n");
> @@ -587,9 +592,9 @@ static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
>  			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
>  			if (rc)
>  				return rc;
> -			expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> -							CRB_START_NEXT_CHUNK, 0,
> -							TPM2_TIMEOUT_C);
> +			expired = !crb_wait_for_reg_32(priv,
> +							&priv->regs_t->ctrl_start,
> +							CRB_START_NEXT_CHUNK, 0);
>  			if (expired) {
>  				dev_err(&chip->dev,
>  					"Timeout waiting for backend to consume chunk\n");
> @@ -1021,6 +1026,7 @@ static int crb_acpi_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	priv->chip = chip;
>  	dev_set_drvdata(&chip->dev, priv);
>  	chip->acpi_dev_handle = device->handle;
>  	chip->flags = TPM_CHIP_FLAG_TPM2;
> -- 
> 2.47.3
> 

Is it possible to slice this to more intermediate steps, or not?

Br, Jarkko
