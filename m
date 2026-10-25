Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965567;
	b=5gIZHBPgJChrToDTZ+7/LrknhxTxQbQNsTwGDUIeQK9DF3Y84HtVXxNEt9WhRBzFEL5b
	 cWIQ4MmPmVtO+H2vHqHL5YTm4Vc4cVHsBxBrKzT1yKOsq54i0Xf5yhvnqrj6tmiTmZIi7
	 WBx7MMiVUsOz80f/U6TZ/UMf9beaOh/n32wpdktwExrL5260y7uG2eP67oA1Bl0lCY9Dh
	 VhVzi6a4nUMYFZotPiHZ7NbAeKpSIoYjJm1f9PoeM6LJTAnguQkTJNeN8nCZieraBN5rp
	 ojiO8GbNX+k3zl+e9cTbdvBYJ5MuQvDvarsb+RxY5mFwl8kDDnn/yMMM6y/pdJVnUVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L6llbm+oNfvBGS6FCd0EIi5+B2QOOFsvT1ALKJG2C6Y=;
	b=Nkvw84HcgcBYDcf/AsAhbcDJZAHQW78cBSVQRJ7ttXvYvryz+NjdyBUW/wO8XI036cUg
	 +U2PEzmAN02nUG9Vomt/sCosN6mxvIoGPb4U8/kPReC+xKV5rIrvo37zdIRPbnk9lscuU
	 aIvGf17XRwEALMqVGW/hYEJILMghKJS4xU5+rlEwvmYBiu1HAgRuquZA/Gdgof1NlzWPe
	 E5j0R/afH5F3O7+aTKJm1AJDGWfRupQjkkpFns8QTz2SlYEu+cMVdIjDAC9jvk1x9nHBu
	 LfgVggESgNvNF9dtve6Zu/p1inlaRZt9WjtqGRJcft0asmzLeRyklpvjIrR5o4AG5Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXgL0sad;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1B9EE606A31A;
	Sun, 25 Oct 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXgL0sad
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6B36C1F01825;
	Sun, 25 Oct 2026 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792965566;
	bh=L6llbm+oNfvBGS6FCd0EIi5+B2QOOFsvT1ALKJG2C6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CXgL0sadDWkJJ/OJOGt+D6u9Buqh33+06JXgLddFxU7WbWUzn7HU/p/LwuXg5cp7q
	 puQvsgZBmA03RIxd3ya6xWU+tscsZXl9xmm6N1mG5WkDn8k48dloQ70Qj/ciCW/uvM
	 fly068bD3L4GQ9eJw0zd5c5TpRA9nDhT92nw7P4b9Hlj/XJ9ngMLfoYHe4vJXCnx6T
	 ictlwhaEwzArjAF+YS+n4SW8XbJfDZTJmnOhElyDJkSzqtZHwgEEhAQqZmMiXJMiTh
	 sTa2o7esLgP1whJY2WLvT3inO3VVblMb+99RTJhz/iD9gG//5ARUxBRMJsYUKpAiaI
	 bajtNWa92/hGw==
Date: Sun, 25 Oct 2026 23:59:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 6/6] tpm_crb: Implement command and response chunking
 logic
Message-ID: <at57uzLtUZ4z97LL@kernel.org>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-7-armenon@redhat.com>
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
In-Reply-To: <20261025201859.221991-7-armenon@redhat.com>

On Mon, Oct 26, 2026 at 01:48:58AM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> With the introduction of support for Post Quantum Cryptography
> algorithms in TPM, the commands and responses will grow in size.
> Some TPMs have a physical hardware memory window (MMIO) that is
> smaller than the commands we need to send.

That is too loose scope, and its truth value will be degrading as time
moves forward.

Here's what I think about the topic and would look up:

1. TCG has defined this in a spec. I would point out the spec and
   section(s), and optionally also date when it was published (like
   "09/2025" or "Spring of 2024", nothing more granular than this).
2. PQC will be probably a thing across the whole chip industry.
   This is why we need to support it not because of some random
   buffer shenanigans, right?
3. "Some TPMs" is inaccurate statement in a wrong way. I would be
   inaccurate too but how I would simplify the topic  would come
   from an utilitirian angle.

   Regardless what future holds i.e., I would represent the set
   of PQC enabled TPMs and the set of chunking enabled TPMs as they
   were the same set. This type of self-deception is what engineering
   really is all about, overall ;-)

Those are my verbose remarks or how I model this situation, which
would synthesize into maybe 2-4 not that long sentences.

> Therefore this commit
> implements the core logic of sending/receiving data in chunks.

I would remove this sentence because it has no utilitirian use and
does not make anyone smarter, other than you get the feeling that
"I should probably pretend that I know what the chunks are".

Add a short paragrap tell us what the heck they are reference to
section is great but putting the concept in nutshell without having
to immediately peak at it would be great.

> 
> Instead of sending the whole command at once, the driver now sends it in
> small chunks. After each chunk, it signals the TPM using a nextChunk

This is a bit loose form of expression and I'm not fan of qualitative
size definitions.

Example: "Send the command split into chunks."

That's really all information content of the first sentence.

> signal, and waits for the TPM to consume the data. Once the final piece
> is delivered, the driver signals the TPM to begin execution by toggling
> the start invoke bit. We use the same logic in reverse to read large
> responses from the TPM.

This is abstracting and encapsulating the meat of the code change.

Remarks:

- The list of the added constants.
- Speak how the CRB registers are used.
- Stuff is heavily moved around but I don't see anything that would
  help me to understand the reorg part. This is important because
  that gives better map to navigate and check if this patch
  could be split (I don't know yet).
- Go through each location where use the word "signal". It's used
  like a solution encapsulator.

When asked this much details and stuff I personally can recommend
more imperative writing style (see the examples). It has friction
because you can move sentence forward only when you get.

> 
> This allows the driver to handle large payloads even when the hardware
> interface has limited memory. This kernel-side support corresponds to
> the backend implementation in QEMU [1]. QEMU reassembles the chunks
> before passing them to the TPM emulator.
> 
> [1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 215 +++++++++++++++++++++++++++++--------
>  1 file changed, 173 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 31f530744e90..8b2aaa109fc4 100644
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
> @@ -369,38 +371,6 @@ static u8 crb_status(struct tpm_chip *chip)
>  	return sts;
>  }
>  
> -static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> -{
> -	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> -	unsigned int expected;
> -
> -	/* A sanity check that the upper layer wants to get at least the header
> -	 * as that is the minimum size for any TPM response.
> -	 */
> -	if (count < TPM_HEADER_SIZE)
> -		return -EIO;
> -
> -	/* If this bit is set, according to the spec, the TPM is in
> -	 * unrecoverable condition.
> -	 */
> -	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> -		return -EIO;
> -
> -	/* Read the first 8 bytes in order to get the length of the response.
> -	 * We read exactly a quad word in order to make sure that the remaining
> -	 * reads will be aligned.
> -	 */
> -	memcpy_fromio(buf, priv->rsp, 8);
> -
> -	expected = be32_to_cpup((__be32 *)&buf[2]);
> -	if (expected > count || expected < TPM_HEADER_SIZE)
> -		return -EIO;
> -
> -	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> -
> -	return expected;
> -}
> -
>  static int crb_do_acpi_start(struct tpm_chip *chip)
>  {
>  	union acpi_object *obj;
> @@ -472,17 +442,71 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
>  	return rc;
>  }
>  
> +static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	int rc;
> +
> +	memcpy_toio(priv->cmd, buf, len);
> +
> +	/* Make sure that cmd is populated before issuing start. */
> +	wmb();
> +
> +	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> +	if (rc)
> +		return rc;
> +
> +	return crb_try_pluton_doorbell(priv, false);
> +}
> +
> +static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	int rc;
> +
> +	while (offset < len) {
> +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> +
> +		if (chunk_size == 0)
> +			break;
> +
> +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> +		offset += chunk_size;
> +
> +		/* Make sure that cmd is populated before issuing start. */
> +		wmb();
> +		if (offset < len) {
> +			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> +			if (rc)
> +				return rc;
> +			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +									 CRB_START_NEXT_CHUNK, 0,
> +									 TPM2_TIMEOUT_C)) {

I'd split these calls into two lines:

	expired = !crb_wait_for_reg_32( ... );
	if (expired) {



> +				dev_err(&chip->dev,
> +						"Timeout waiting for backend to consume chunk\n");
> +				return -ETIME;
> +			}
> +		} else {
> +			rc = tpm_crb_start(chip, CRB_START_INVOKE);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	return crb_try_pluton_doorbell(priv, false);
> +}
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> -	int rc = 0;
>  
>  	/* Zero the cancel register so that the next command will not get
>  	 * canceled.
>  	 */
>  	iowrite32(0, &priv->regs_t->ctrl_cancel);
>  
> -	if (len > priv->cmd_size) {
> +	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
>  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
>  			len, priv->cmd_size);
>  		return -E2BIG;
> @@ -492,16 +516,115 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
> -	memcpy_toio(priv->cmd, buf, len);
> +	if (len <= priv->cmd_size)
> +		return tpm_crb_send_no_chunks(chip, buf, len);
>  
> -	/* Make sure that cmd is populated before issuing start. */
> -	wmb();
> +	return tpm_crb_send_chunks(chip, buf, len);
> +}
>  
> -	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> -	if (rc)
> -		return rc;
> +static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
>  
> -	return crb_try_pluton_doorbell(priv, false);
> +	/* Read the first 8 bytes in order to get the length of the response.
> +	 * We read exactly a quad word in order to make sure that the remaining
> +	 * reads will be aligned.
> +	 */

When moving code not heavy mods should be done but we can fix this
cosmetic glitch from the block comments at least.

> +	memcpy_fromio(buf, priv->rsp, 8);
> +
> +	expected = be32_to_cpup((__be32 *)&buf[2]);
> +	if (expected > count || expected < TPM_HEADER_SIZE)
> +		return -EIO;
> +
> +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> +
> +	return expected;
> +}
> +
> +static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
> +							   unsigned int expected)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	size_t first_read;
> +	int rc;
> +
> +	if (expected > count)
> +		return -EIO;
> +	/*
> +	 * Set chunk_size by comparing the size of the buffer that the upper
> +	 * layer has allocated (count) to the hardware tpm limit (priv->rsp_size).
> +	 * This is to prevent buffer overflow while writing to buf.
> +	 */
> +	chunk_size = min_t(size_t, count, priv->rsp_size);
> +	if (chunk_size < 8)
> +		return -EIO;
> +
> +	memcpy_fromio(buf, priv->rsp, 8);
> +
> +	/*
> +	 * Compare the actual size of the response we found in
> +	 * the header to the chunk size
> +	 */
> +	first_read = min_t(size_t, expected, chunk_size);
> +
> +	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
> +	offset = first_read;
> +
> +	while (offset < expected) {
> +		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> +		if (rc)
> +			return rc;
> +
> +		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +								 CRB_START_NEXT_CHUNK, 0,
> +								 TPM2_TIMEOUT_C)) {
> +			dev_err(&chip->dev, "Timeout waiting for backend response\n");
> +			return -ETIME;
> +		}
> +
> +		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
> +		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
> +		offset += chunk_size;
> +	}
> +
> +	return expected;
> +}
> +
> +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
> +
> +	/* A sanity check that the upper layer wants to get at least the header
> +	 * as that is the minimum size for any TPM response.
> +	 */
> +	if (count < TPM_HEADER_SIZE)
> +		return -EIO;
> +
> +	/* If this bit is set, according to the spec, the TPM is in
> +	 * unrecoverable condition.
> +	 */
> +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> +		return -EIO;
> +
> +	/*
> +	 * Peek at the first 8 bytes to determine the response size
> +	 */
> +	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
> +
> +	if (expected <= priv->rsp_size)
> +		return tpm_crb_recv_no_chunks(chip, buf, count);
> +
> +	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
> +		dev_err(&chip->dev,
> +			    "Response larger than MMIO and chunking not supported\n");
> +		return -EIO;
> +	}
> +
> +	return tpm_crb_recv_chunks(chip, buf, count, expected);
>  }
>  
>  static void crb_cancel(struct tpm_chip *chip)
> @@ -728,6 +851,12 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
>  		goto out;
>  	}
>  
> +	if (priv->regs_h)
> +		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> +
> +	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
> +		dev_info(dev, "CRB Chunking is supported by backend\n");
> +
>  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
>  	rsp_pa = le64_to_cpu(__rsp_pa);
>  	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
> @@ -765,8 +894,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
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
> 2.54.0
> 

Let's take this easy as it can land earliest v7.5. It would be hard
to miss that deadline so polishing all the details is the best way
to go.

Br, Jarkko
