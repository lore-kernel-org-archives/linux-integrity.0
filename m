Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025112;
	b=aQxCUgwUMDQieOQAOwk7k3UyEKfBkqPmWJ7o9bt3DW2SEveQfx8pQXWUcBAJ7B31K/zO
	 rP+ZViuMEpdEoSSfw8RFFNYDgkJWz2P7KzrHAB86gwFfaGXLMPHLs1aBVL30Nj0cLwW/X
	 l+Pa5/R2GeuXOQtWdcXC1QC1bBZMoIM8C5oMkm8kieuMDlFhMapQxemUiRrJXea70CGKa
	 MW/jed3b1XdZJtzLtxVtuFAvcZ/5LRKqhDuGKOanynOcS+1yKWX/zB8g0YglZ7sDQyYAE
	 LttW4xDloVCCmsAUVVS4ReSDn9t+cpSIXGLEveT78dYn72mrvzM0iMYUhKieMELB3PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025112;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZiX297agFJcw9x+1w1o4OJlEKr6G9EH8r3TllI028Gc=;
	b=jbRx/txLoxcLxyJTgKfPa6Dmj0T/MiIc0kc6baEAGcyFvral5mLk0Yg+RZWpRxIseGmh
	 aoC/kgkU0wk72zh0tzXlGlDVa6J8fb6nTE9eyyTCijWUH371V8F57ReLZT9aoeNs0H74l
	 h9TQQ60pNdkDCSxSczRSaPutPxjiuQZBw555V5ag5MoWoD72/yrDfIa9QyUnsES3lUlt3
	 pXk8qCyK34biW2iox8Cp1Y5BmvvO9EivBh274h9dp84ck3rs2qgoJm9fbnT9jVh7Bo+Pi
	 YIrvdfW5l+Z/MxNLyNaLGX7Xt1SP9PqRt3oghSf6CYUafoazvinDmv1LHIpbICIfi7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrzDrYhu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="OHk/qyZG";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FB606A31B
	for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 14:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KrzDrYhu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OHk/qyZG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793025110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiX297agFJcw9x+1w1o4OJlEKr6G9EH8r3TllI028Gc=;
	b=KrzDrYhumUvsKFXA8KTsj/cpnpPQ+uD+M29kL76fs47vjUyKTZ7NCIvKVvgYW+C8ky+3Yk
	gVXPyCi/3tbgrM94IIlVPo4xsdfv77dsSER/hjveqi0Ll+vs+EK2Zz4tsV1vApUBzu3SHE
	9g1NuRpQ4+hhr6g+IP4u4uLBK4VRMig=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-t8eAGqNMP0SB2cej3DrG3w-1; Mon, 26 Oct 2026 10:31:41 -0400
X-MC-Unique: t8eAGqNMP0SB2cej3DrG3w-1
X-Mimecast-MFC-AGG-ID: t8eAGqNMP0SB2cej3DrG3w_1793025101
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so5454877eec.0
        for <linux-integrity@vger.kernel.org>; Mon, 26 Oct 2026 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793025101; x=1793629901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZiX297agFJcw9x+1w1o4OJlEKr6G9EH8r3TllI028Gc=;
        b=OHk/qyZGbhWmWiTKMnnhGYhzRbbAYMv/wbR0IMrlOEIBbVBjT58PEXgRmx7VeZyMLE
         yQplNBZJZBL5xNRGBnlLSMdTnIDNOg9FrKbVZEPs4YX03b56W7LSlYQ1W7TK4TTFhVe8
         cau+KREuO4dRpYjRB9R466O5qxdYrAu9S6OldkFpvbe9AWgYNJlp/Hcn7Ho3RlrzxW5Y
         szAurzBh4eo8ozscSKt5R4cxYmijK+iSHI3khoNh7xQPlj//HYAusUFYcKPJxqsvZXk8
         o6C0qkmupAuBknOJF4IBgmfy5SzUf5Nsc/NvqHDYo6KYgNTBRlDTflQUFGonnnmvnVj+
         AJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025101; x=1793629901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiX297agFJcw9x+1w1o4OJlEKr6G9EH8r3TllI028Gc=;
        b=YOhnvSALULDQjvJNF+jJStkRZQKVnla1E8ArBNp0MfsZ5SDAKs0Jaayf7kr/8y2fTx
         zBrn1n2snkJ5GSwFmC4247aXS+OaEerCj5h8SWXdN2fBS1xKe2yX8f0o1/dQAySWzM6c
         iO3i9TCk+GtfMSBkiKOnHg4LJ9uJbWoeuveBNn8WOfvR/DXcEaD8QfB/IcYSts7qC1SE
         Ugnf3u+hIzVfFtWVgjeJlRIq9dkYMc1KkVBY9KFuVE1xcpBqS3SIl8qBSwqSWwL1C3rc
         Xc7VAznaKbdgkMxLNMTeYz4H79Jm/D2hrBkwmqd6zkq0lwi0bS/15EWGKDmw9Tvt2NnB
         Y6qA==
X-Forwarded-Encrypted: i=1; AKwUvByKD29WMtBYimWPZFCaq3bIHKVSwWsQx7ib08tL5gd58k1aPR2835ayPDRoqwDDHZ4QxYZXuCsF+ugFYnsD8MQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLob+YuR96S7VGil68rbaWbmelV/y3CuESfphLEpQJOqzdXbpWL
	psHVEFJziXeKxI3arxHkXELhWC+L2hnBxownPVnFCDoX1BSc9yUK1fet+sa19Ql1W2IM3L2yere
	s7TD3cNj6PEb057Ng+vO3DvPoowC/dEamGCtSjZiTFcWH0nlL2f/H/sDlGGbmFWinRFJcLRso6+
	rYHA==
X-Gm-Gg: AYBFou3N/UO2L4xv+Od7rnerWn6SrJ6i9B2BpRbSQSKKxkxLr9n0i79vbmYnqqS7Otz
	Tr2yM6pW4hCn/vE58Ihf/5zv5MOSV/ASzEHukc6YEkaKpZc8c52+WvQteGEG1Qi02SYwI9TuBK5
	iI/r0tSVHCWztp7//4u2WwGfvvxNVm5FvXY0Tnql1BWRDfiBeQN/IKPql+VzaA1Cse2PtWyCj07
	odCmVcX4ETZoeULSQDG/Evv5X/e6ico+GS4Y9NBVK1MlpqRzFsy5V8hSzoUO16G+wZZ4hDTyXAH
	s2k6PB4jJNu1lhyHxapwmD8jbqWyM5/8v3ue6DNWAK/7xB3k2eXniqqd5ExZB51Svw==
X-Received: by 2002:a05:7300:d086:b0:34b:b410:9352 with SMTP id 5a478bee46e88-369e8319cadmr10005455eec.1.1793025100177;
        Mon, 26 Oct 2026 07:31:40 -0700 (PDT)
X-Received: by 2002:a05:7300:d086:b0:34b:b410:9352 with SMTP id 5a478bee46e88-369e8319cadmr10005425eec.1.1793025099273;
        Mon, 26 Oct 2026 07:31:39 -0700 (PDT)
Received: from fedora ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm48542277eec.23.2026.10.26.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:31:38 -0700 (PDT)
Date: Mon, 26 Oct 2026 20:01:32 +0530
From: Arun Menon <armenon@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 6/6] tpm_crb: Implement command and response chunking
 logic
Message-ID: <at9kRNac6oe_txwZ@fedora>
References: <20261025201859.221991-1-armenon@redhat.com>
 <20261025201859.221991-7-armenon@redhat.com>
 <at57uzLtUZ4z97LL@kernel.org>
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
In-Reply-To: <at57uzLtUZ4z97LL@kernel.org>

Hi Jarkko,
Thank you for the detailed feedback.

On Sun, Oct 25, 2026 at 11:59:23PM +0200, Jarkko Sakkinen wrote:
> On Mon, Oct 26, 2026 at 01:48:58AM +0530, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > With the introduction of support for Post Quantum Cryptography
> > algorithms in TPM, the commands and responses will grow in size.
> > Some TPMs have a physical hardware memory window (MMIO) that is
> > smaller than the commands we need to send.
> 
> That is too loose scope, and its truth value will be degrading as time
> moves forward.
> 
> Here's what I think about the topic and would look up:
> 
> 1. TCG has defined this in a spec. I would point out the spec and
>    section(s), and optionally also date when it was published (like
>    "09/2025" or "Spring of 2024", nothing more granular than this).

Sure, I will add the spec detail, citing the TPM PC Client PTP (Platform
TPM Profile) with section number and date.

> 2. PQC will be probably a thing across the whole chip industry.
>    This is why we need to support it not because of some random
>    buffer shenanigans, right?
> 3. "Some TPMs" is inaccurate statement in a wrong way. I would be
>    inaccurate too but how I would simplify the topic  would come
>    from an utilitirian angle.

yes, I understand. Any CRB TPM that gets the updated PQC-sized payloads
will hit the same MMIO-window limit.

> 
>    Regardless what future holds i.e., I would represent the set
>    of PQC enabled TPMs and the set of chunking enabled TPMs as they
>    were the same set. This type of self-deception is what engineering
>    really is all about, overall ;-)

yes, its a PQC transition generally. I will mention that.

> 
> Those are my verbose remarks or how I model this situation, which
> would synthesize into maybe 2-4 not that long sentences.
> 
> > Therefore this commit
> > implements the core logic of sending/receiving data in chunks.
> 
> I would remove this sentence because it has no utilitirian use and
> does not make anyone smarter, other than you get the feeling that
> "I should probably pretend that I know what the chunks are".

yes, will remove this line.

> 
> Add a short paragrap tell us what the heck they are reference to
> section is great but putting the concept in nutshell without having
> to immediately peak at it would be great.
> 
> > 
> > Instead of sending the whole command at once, the driver now sends it in
> > small chunks. After each chunk, it signals the TPM using a nextChunk
> 
> This is a bit loose form of expression and I'm not fan of qualitative
> size definitions.
> 
> Example: "Send the command split into chunks."
> 
> That's really all information content of the first sentence.
> 
> > signal, and waits for the TPM to consume the data. Once the final piece
> > is delivered, the driver signals the TPM to begin execution by toggling
> > the start invoke bit. We use the same logic in reverse to read large
> > responses from the TPM.
> 
> This is abstracting and encapsulating the meat of the code change.
> 
> Remarks:
> 
> - The list of the added constants.
yes, will add them
> - Speak how the CRB registers are used.
yes.
> - Stuff is heavily moved around but I don't see anything that would
>   help me to understand the reorg part. This is important because
>   that gives better map to navigate and check if this patch
>   could be split (I don't know yet).

I will split the 6th patch in to 2. The preparation patch will put the
existing crb_send()/crb_recv() into
tpm_crb_send_no_chunks()/tpm_crb_recv_no_chunks().

Also, I will forward declare tpm_crb_start() (required by 
tpm_crb_recv_chunks()) so that the diff is clean.

> - Go through each location where use the word "signal". It's used
>   like a solution encapsulator.

I will explain the use of registers briefly. The registers were
introduced in a former patch.

> 
> When asked this much details and stuff I personally can recommend
> more imperative writing style (see the examples). It has friction
> because you can move sentence forward only when you get.
> 
> > 
> > This allows the driver to handle large payloads even when the hardware
> > interface has limited memory. This kernel-side support corresponds to
> > the backend implementation in QEMU [1]. QEMU reassembles the chunks
> > before passing them to the TPM emulator.
> > 
> > [1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 215 +++++++++++++++++++++++++++++--------
> >  1 file changed, 173 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 31f530744e90..8b2aaa109fc4 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -105,11 +105,13 @@ struct crb_priv {
> >  	u8 __iomem *cmd;
> >  	u8 __iomem *rsp;
> >  	u32 cmd_size;
> > +	u32 rsp_size;
> >  	u32 smc_func_id;
> >  	u32 __iomem *pluton_start_addr;
> >  	u32 __iomem *pluton_reply_addr;
> >  	u8 ffa_flags;
> >  	u8 ffa_attributes;
> > +	u32 intf_id;
> >  };
> >  
> >  struct tpm2_crb_smc {
> > @@ -369,38 +371,6 @@ static u8 crb_status(struct tpm_chip *chip)
> >  	return sts;
> >  }
> >  
> > -static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > -{
> > -	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > -	unsigned int expected;
> > -
> > -	/* A sanity check that the upper layer wants to get at least the header
> > -	 * as that is the minimum size for any TPM response.
> > -	 */
> > -	if (count < TPM_HEADER_SIZE)
> > -		return -EIO;
> > -
> > -	/* If this bit is set, according to the spec, the TPM is in
> > -	 * unrecoverable condition.
> > -	 */
> > -	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> > -		return -EIO;
> > -
> > -	/* Read the first 8 bytes in order to get the length of the response.
> > -	 * We read exactly a quad word in order to make sure that the remaining
> > -	 * reads will be aligned.
> > -	 */
> > -	memcpy_fromio(buf, priv->rsp, 8);
> > -
> > -	expected = be32_to_cpup((__be32 *)&buf[2]);
> > -	if (expected > count || expected < TPM_HEADER_SIZE)
> > -		return -EIO;
> > -
> > -	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > -
> > -	return expected;
> > -}
> > -
> >  static int crb_do_acpi_start(struct tpm_chip *chip)
> >  {
> >  	union acpi_object *obj;
> > @@ -472,17 +442,71 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
> >  	return rc;
> >  }
> >  
> > +static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	int rc;
> > +
> > +	memcpy_toio(priv->cmd, buf, len);
> > +
> > +	/* Make sure that cmd is populated before issuing start. */
> > +	wmb();
> > +
> > +	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return crb_try_pluton_doorbell(priv, false);
> > +}
> > +
> > +static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	size_t offset = 0;
> > +	size_t chunk_size;
> > +	int rc;
> > +
> > +	while (offset < len) {
> > +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> > +
> > +		if (chunk_size == 0)
> > +			break;
> > +
> > +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> > +		offset += chunk_size;
> > +
> > +		/* Make sure that cmd is populated before issuing start. */
> > +		wmb();
> > +		if (offset < len) {
> > +			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> > +			if (rc)
> > +				return rc;
> > +			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> > +									 CRB_START_NEXT_CHUNK, 0,
> > +									 TPM2_TIMEOUT_C)) {
> 
> I'd split these calls into two lines:
> 
> 	expired = !crb_wait_for_reg_32( ... );
> 	if (expired) {
> 
> 
> 

yes will do it.

> > +				dev_err(&chip->dev,
> > +						"Timeout waiting for backend to consume chunk\n");
> > +				return -ETIME;
> > +			}
> > +		} else {
> > +			rc = tpm_crb_start(chip, CRB_START_INVOKE);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +	}
> > +
> > +	return crb_try_pluton_doorbell(priv, false);
> > +}
> >  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  {
> >  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > -	int rc = 0;
> >  
> >  	/* Zero the cancel register so that the next command will not get
> >  	 * canceled.
> >  	 */
> >  	iowrite32(0, &priv->regs_t->ctrl_cancel);
> >  
> > -	if (len > priv->cmd_size) {
> > +	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
> >  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
> >  			len, priv->cmd_size);
> >  		return -E2BIG;
> > @@ -492,16 +516,115 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
> >  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> >  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
> >  
> > -	memcpy_toio(priv->cmd, buf, len);
> > +	if (len <= priv->cmd_size)
> > +		return tpm_crb_send_no_chunks(chip, buf, len);
> >  
> > -	/* Make sure that cmd is populated before issuing start. */
> > -	wmb();
> > +	return tpm_crb_send_chunks(chip, buf, len);
> > +}
> >  
> > -	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> > -	if (rc)
> > -		return rc;
> > +static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	unsigned int expected;
> >  
> > -	return crb_try_pluton_doorbell(priv, false);
> > +	/* Read the first 8 bytes in order to get the length of the response.
> > +	 * We read exactly a quad word in order to make sure that the remaining
> > +	 * reads will be aligned.
> > +	 */
> 
> When moving code not heavy mods should be done but we can fix this
> cosmetic glitch from the block comments at least.
> 
> > +	memcpy_fromio(buf, priv->rsp, 8);
> > +
> > +	expected = be32_to_cpup((__be32 *)&buf[2]);
> > +	if (expected > count || expected < TPM_HEADER_SIZE)
> > +		return -EIO;
> > +
> > +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> > +
> > +	return expected;
> > +}
> > +
> > +static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
> > +							   unsigned int expected)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	size_t offset = 0;
> > +	size_t chunk_size;
> > +	size_t first_read;
> > +	int rc;
> > +
> > +	if (expected > count)
> > +		return -EIO;
> > +	/*
> > +	 * Set chunk_size by comparing the size of the buffer that the upper
> > +	 * layer has allocated (count) to the hardware tpm limit (priv->rsp_size).
> > +	 * This is to prevent buffer overflow while writing to buf.
> > +	 */
> > +	chunk_size = min_t(size_t, count, priv->rsp_size);
> > +	if (chunk_size < 8)
> > +		return -EIO;
> > +
> > +	memcpy_fromio(buf, priv->rsp, 8);
> > +
> > +	/*
> > +	 * Compare the actual size of the response we found in
> > +	 * the header to the chunk size
> > +	 */
> > +	first_read = min_t(size_t, expected, chunk_size);
> > +
> > +	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
> > +	offset = first_read;
> > +
> > +	while (offset < expected) {
> > +		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> > +								 CRB_START_NEXT_CHUNK, 0,
> > +								 TPM2_TIMEOUT_C)) {
> > +			dev_err(&chip->dev, "Timeout waiting for backend response\n");
> > +			return -ETIME;
> > +		}
> > +
> > +		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
> > +		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
> > +		offset += chunk_size;
> > +	}
> > +
> > +	return expected;
> > +}
> > +
> > +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> > +	unsigned int expected;
> > +
> > +	/* A sanity check that the upper layer wants to get at least the header
> > +	 * as that is the minimum size for any TPM response.
> > +	 */
> > +	if (count < TPM_HEADER_SIZE)
> > +		return -EIO;
> > +
> > +	/* If this bit is set, according to the spec, the TPM is in
> > +	 * unrecoverable condition.
> > +	 */
> > +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> > +		return -EIO;
> > +
> > +	/*
> > +	 * Peek at the first 8 bytes to determine the response size
> > +	 */
> > +	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
> > +
> > +	if (expected <= priv->rsp_size)
> > +		return tpm_crb_recv_no_chunks(chip, buf, count);
> > +
> > +	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
> > +		dev_err(&chip->dev,
> > +			    "Response larger than MMIO and chunking not supported\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return tpm_crb_recv_chunks(chip, buf, count, expected);
> >  }
> >  
> >  static void crb_cancel(struct tpm_chip *chip)
> > @@ -728,6 +851,12 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
> >  		goto out;
> >  	}
> >  
> > +	if (priv->regs_h)
> > +		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> > +
> > +	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
> > +		dev_info(dev, "CRB Chunking is supported by backend\n");
> > +
> >  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
> >  	rsp_pa = le64_to_cpu(__rsp_pa);
> >  	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
> > @@ -765,8 +894,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
> >  	priv->rsp = priv->cmd;
> >  
> >  out:
> > -	if (!ret)
> > +	if (!ret) {
> >  		priv->cmd_size = cmd_size;
> > +		priv->rsp_size = rsp_size;
> > +	}
> >  
> >  	__crb_go_idle(dev, priv, 0);
> >  
> > -- 
> > 2.54.0
> > 
> 
> Let's take this easy as it can land earliest v7.5. It would be hard
> to miss that deadline so polishing all the details is the best way
> to go.

I agree. Thanks again.

> 
> Br, Jarkko
> 

Regards,
Arun Menon

