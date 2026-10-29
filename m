Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302115;
	b=Awo9LHNuIW1A8SxCv3s4yJy7C43/QZTATHJuBgRyckZYfFybgdS1EmJVkAp42MYqvVbD
	 0aR+GJWoCWlVtpdgjcBpCm/yU+3BjOb32/qDqnZNCcxGvSjUAwciWXKRuHzTCvWtVRXHO
	 05awD0kfTBXZ9ycvLcHnsHHLe8U0t1lSkiqp4RDX8oHzhsULdgWSUHlx++J1SxwXT+Pal
	 djM4Ij66IgH5APBLJSIqwkLvgVuYNKLtxhiHlUDV4D/2sAFTHXBB13wietlZF9+01OurP
	 nRYzoirgiupGwz/blISalo8UIwzTp8J3Zxrl0imEv51mgXChEvxPpkekNOe17GZHfPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302115;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t2JYG2rzukbruha0yazPbFIGLvQK6TgqCWqbchzcmUI=;
	b=VLmRBGiql492vwiDcqyJk53bxjKzmw80/BdsZ0JwDCxrUvL6uCLbr6w8Br1xOZ2GTfsz
	 5bY4r+lCBwcRssrx7LmhoMl0XaYr20ijk3MiPRWyW318AFBRdtgispTJH3mi2T79OPAMg
	 a6ARzvTwSNuHBFOIuV5nbcVTLVF8nur6ygcA5zOX952ZrQ9xwM/SWsrM7bqMd9K+og3EC
	 IRZwn5UdsvcCnsA4wDnolE5E3OFPpEhHuy1PLLkIajM6CFlMrA9gET8Q4fgEUmxF0kGcs
	 UGvulN48k66iDbqwkmngBVW5nJX3GgeYZ8byAt57fEBkkePYHDarRt9fHpmbfAg1lDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5MBzNXG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0CCDA606A31D;
	Thu, 29 Oct 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5MBzNXG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F02891F01816;
	Thu, 29 Oct 2026 19:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302114;
	bh=t2JYG2rzukbruha0yazPbFIGLvQK6TgqCWqbchzcmUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B5MBzNXGnW5cAUk/GD8P71vqK44V9x3PLhXBsY1pBlpK4dlNZg6V24hVZp5NApH8u
	 MyKEwuL77IgO0mPAi+Qc28AFcMeap8BUlbNUd5qpHjawEtbOxtero813ZXZaTW92Z2
	 +QUCUmI8faS3Z0xFh7rKeEdP2kPFoWGK3C5uRHqZCZD440GFuOvfgnZxiSS3UDX9hO
	 gfSX3GqhrTvkjA/AEGNuJP6gm5jh/NMiHso/omww+/lzIzPRCBsz7L0af4IF8o7rWZ
	 RLT6vCQMAuZKgMSdy5XCaQaHIxfWiK+FeBD+XcRPWLlJlUv7Hb/3vS6c1bwLEomFxF
	 vzYh5dTU3IAiw==
Date: Thu, 29 Oct 2026 21:28:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 7/7] tpm_crb: Implement command and response chunking
 logic
Message-ID: <auOeXwRQpdLqeapz@kernel.org>
References: <20261029181541.99505-1-armenon@redhat.com>
 <20261029181541.99505-8-armenon@redhat.com>
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
In-Reply-To: <20261029181541.99505-8-armenon@redhat.com>

On Thu, Oct 29, 2026 at 11:45:41PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> TPMs implemented with the CRB address map in the TCG PC-Client
> Platform TPM Profile (PTP) for TPM 2.0 are limited to a 3968-byte
> command/response buffer (v1.07, March 2026, Table 36 and section
> 6.5.3.9) in [2]. This is smaller than the 7.7KB ML-DSA-87 TPM2_Load from
> the previous patch. PTP 1.07 adds a chunking mode for exactly this case
> (sections 6.4.2.2, 6.5.3.9, 6.5.3.10 in [2]), usable by any CRB TPM that
> implements it.
> 
> Send and receive the command/response split into pieces no larger than
> priv->cmd_size/priv->rsp_size. Write CRB_START_NEXT_CHUNK to
> ctrl_start after each piece but the last, and wait for the TPM to clear
> it before sending the next; use CRB_START_INVOKE on the last piece, same
> as the non-chunked path. Read a response back the same way, in reverse.
> 
> On top of the previous patch's tpm_crb_send_no_chunks()/
> tpm_crb_recv_no_chunks() split, add:
> - rsp_size: response-direction counterpart of cmd_size.
> - intf_id: interface ID register, read once at probe time.
> - CRB_INTF_CAP_CRB_CHUNK: capability bit in intf_id; crb_send()/
>   crb_recv() only reject an oversized payload when it is clear.
> - tpm_crb_send_chunks()/tpm_crb_recv_chunks(): drive the chunked
>   transfer described above.
> 
> This corresponds to the backend implementation in QEMU [1], which
> reassembles the chunks before handing the command to the TPM emulator.
> 
> [1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/
> [2] https://medias.cdn.trustedcomputinggroup.org/production/PC_Client_Specific_Platform_TPM_Profile_for_TPM_2p0_v1p07_Pub_5643562943.pdf
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 119 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index f0bac9e1f1e8..e14b1feb3fea 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -105,11 +105,13 @@ struct crb_priv {
>  	u8 __iomem *cmd;
>  	u8 __iomem *rsp;
>  	u32 cmd_size;
> +	u32 rsp_size;
>  	u32 smc_func_id;
>  	u32 __iomem *pluton_start_addr;
>  	u32 __iomem *pluton_reply_addr;
>  	u8 ffa_flags;
>  	u8 ffa_attributes;
> +	u32 intf_id;
>  };
>  
>  struct tpm2_crb_smc {
> @@ -369,6 +371,13 @@ static u8 crb_status(struct tpm_chip *chip)
>  	return sts;
>  }
>  
> +/*
> + * tpm_crb_recv_chunks() below needs to drive CRB_START_NEXT_CHUNK through
> + * tpm_crb_start(), which is defined later in this file next to the other
> + * platform-specific start methods it dispatches to.
> + */
> +static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd);
> +
>  static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -388,12 +397,54 @@ static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
>  	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
>  
>  	return expected;
> +}
> +
> +static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
> +				unsigned int expected)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	bool expired;
> +	int rc;
> +
> +	if (expected > count || expected < TPM_HEADER_SIZE)
> +		return -EIO;
> +	/*
> +	 * Without this, a bogus zero-sized MMIO window would never make
> +	 * forward progress below.
> +	 */
> +	if (priv->rsp_size == 0)
> +		return -EIO;
> +
> +	while (offset < expected) {
> +		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
> +		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
> +		offset += chunk_size;
>  
> +		if (offset == expected)
> +			break;
> +
> +		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> +		if (rc)
> +			return rc;
> +
> +		expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +						CRB_START_NEXT_CHUNK, 0,
> +						TPM2_TIMEOUT_C);
> +		if (expired) {
> +			dev_err(&chip->dev,
> +				"Timeout waiting for backend response\n");
> +			return -ETIME;
> +		}
> +	}
> +	return expected;
>  }
>  
>  static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
>  
>  	/*
>  	 * A sanity check that the upper layer wants to get at least the header
> @@ -409,7 +460,17 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
>  		return -EIO;
>  
> -	return tpm_crb_recv_no_chunks(chip, buf, count);
> +	/* Peek at the first 8 bytes to determine the response size */
> +	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
> +
> +	if (expected <= priv->rsp_size)
> +		return tpm_crb_recv_no_chunks(chip, buf, count);
> +	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
> +		dev_err(&chip->dev,
> +			"Response larger than MMIO and chunking not supported\n");
> +		return -EIO;
> +	}
> +	return tpm_crb_recv_chunks(chip, buf, count, expected);
>  }
>  
>  static int crb_do_acpi_start(struct tpm_chip *chip)
> @@ -502,6 +563,46 @@ static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
>  	return crb_try_pluton_doorbell(priv, false);
>  }
>  
> +static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t chunk_size;
> +	size_t offset = 0;
> +	int rc;
> +	bool expired;
> +
> +	while (offset < len) {
> +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> +		if (chunk_size == 0)
> +			break;
> +
> +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> +		offset += chunk_size;
> +
> +		/* Make sure that cmd is populated before issuing start. */
> +		wmb();
> +
> +		if (offset < len) {
> +			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> +			if (rc)
> +				return rc;
> +			expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +							CRB_START_NEXT_CHUNK, 0,
> +							TPM2_TIMEOUT_C);
> +			if (expired) {
> +				dev_err(&chip->dev,
> +					"Timeout waiting for backend to consume chunk\n");
> +				return -ETIME;
> +			}
> +		} else {
> +			rc = tpm_crb_start(chip, CRB_START_INVOKE);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +	return crb_try_pluton_doorbell(priv, false);
> +}
> +
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -512,7 +613,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	 */
>  	iowrite32(0, &priv->regs_t->ctrl_cancel);
>  
> -	if (len > priv->cmd_size) {
> +	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
>  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
>  			len, priv->cmd_size);
>  		return -E2BIG;
> @@ -522,7 +623,10 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
> -	return tpm_crb_send_no_chunks(chip, buf, len);
> +	if (len <= priv->cmd_size)
> +		return tpm_crb_send_no_chunks(chip, buf, len);
> +
> +	return tpm_crb_send_chunks(chip, buf, len);
>  }
>  
>  static void crb_cancel(struct tpm_chip *chip)
> @@ -748,6 +852,11 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
>  		ret = PTR_ERR(priv->cmd);
>  		goto out;
>  	}
> +	if (priv->regs_h)
> +		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> +
> +	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
> +		dev_info(dev, "CRB Chunking is supported by backend\n");
>  
>  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
>  	rsp_pa = le64_to_cpu(__rsp_pa);
> @@ -786,8 +895,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
>  	priv->rsp = priv->cmd;
>  
>  out:
> -	if (!ret)
> +	if (!ret) {
>  		priv->cmd_size = cmd_size;
> +		priv->rsp_size = rsp_size;
> +	}
>  
>  	__crb_go_idle(dev, priv, 0);
>  
> -- 
> 2.56.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
