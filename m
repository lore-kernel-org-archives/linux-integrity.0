Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390852;
	b=dt4D+eW7emE5jQ0DfnIPAufCEgwpzeGoYHNCPQ0V5YvsIYcX7ED0DaEV3oqWm+Js1eDb
	 KNpiYP3DiNhYA888RNx0HnfqjAy100u2ocw1YOjzjYuRXN7itRrop/AMjGHfV0QQkuvb7
	 jkpSPNqovH8wX+TY5uX7uw/vygbXj2pRXLfr4b0tniDSpdQq4sHV4ecinH45VsiGubz9U
	 yLe1qnXF9iWrKHH/vMKLFHGeZr0ftqpEGZqz0UI9nt+JtRm7PUWT8vgSzdzBK1Fi9ZcA7
	 BwefabaJYHFJSdf9W1ITywpJG+tDQHLTC0o/y6IvKnAwjci6XRO52QCz9wepLY5CrAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390852;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FIyfL9uDvA5G877TsSUJf5DkfdA8JI9LDiyEiEfndPA=;
	b=MWrkqrb7tBTcKbI8SVJsXVsr3E8fMR2xnZ43fwWDxGV1mc9HzFdHWYSAKVg2UcpFlaAM
	 qVAOsvFkd3AZOygyQKUpjjbVHg1ZqGsD9GdDBUHT7UI++dhXcrAiLiPDD7+PVnkDz3GXw
	 txqRmSImnW9QOfY+hUJOTnLnOv0+/1Bi8whfLTsxukyCf3vyeS1DtVwijaVVvX5qCIbr5
	 BjOrN3gaQoRxV6H0RhKV58MjBPuv6qlvSuYOnAQr4lV4qLaqSgcGaa7YlubQXmPwyIyr/
	 MWEmub/ceNeK4QE/Y60ZdvJ0QW0MJlrrTsWq2psAWLR9Ngh7GDsIRXQe6fFR9tvbvjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1iM72A9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h73yL+5U;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FCF606A31A
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36FCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1iM72A9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h73yL+5U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIyfL9uDvA5G877TsSUJf5DkfdA8JI9LDiyEiEfndPA=;
	b=a1iM72A9S2QrFkaXl0h+f2XzEqlGUM4jUvO4tTyOjBiC6RSr21Nm6PXDwGZ72JM5KXEMeM
	3iyAFmCKhiOnlLDl7bx9QW1+2mfVVEzSubAQz+A0q4xD7PiS96N1dpY0y4jR3iXCrEEPwR
	kOR6ZaacGUjt+CWV5+iKJuej+KJqbD4=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-LHXI65QJOn-tRheUbBFpgQ-1; Fri, 30 Oct 2026 16:07:23 -0400
X-MC-Unique: LHXI65QJOn-tRheUbBFpgQ-1
X-Mimecast-MFC-AGG-ID: LHXI65QJOn-tRheUbBFpgQ_1793390842
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36637676140so1611716eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390842; x=1793995642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIyfL9uDvA5G877TsSUJf5DkfdA8JI9LDiyEiEfndPA=;
        b=h73yL+5U76mQsZP2K/+5fJ6sHJQwJdbxg5zD8+M8wAfYl5Mao9OPqwADr0D12sz8I2
         Sbh+OhzsZEylCJSV2hgU76j10exz+KjHUUkXN7z+Z6GPoI2cPvw5E1thAPGketavHCGG
         IO/sRvwkIhZGStg2vneC4JASsf2jnBajvDzRKq5T4vkgMSHabRLDO0+0NKlTLcCOQ3PF
         1bz6FLl3OteUk4ir2IF4Wc4vv3/6B+IQz8QAn77g92Uu0tsLkTOgmFwRta3+mVoViiuG
         yuSMVtdMSy5q90022FjHoj9VOiO1bXtr/raSUX8+qks8MIwo4GPsrLCwEXz86nzDfufv
         rj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390842; x=1793995642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIyfL9uDvA5G877TsSUJf5DkfdA8JI9LDiyEiEfndPA=;
        b=kck6eW00ntD2eZYOecaUfdBpcSNdxi5dWgOsRA7rF5VqqZAWMhwp12JJO0L6SAAn3g
         x2+J56SGM69SMBQBrG6KhrCsXttNlr01/srIaBuDyKARrukXsXQotEwYtQ984N3CrWwl
         evMgC5kNqVOpFr7k9IbPRV+oOILXYaoyfPXxNzGpquJTXZZEW1U8SOQqLspNNvyQrc6o
         RMleGeEtT3ONuUZnlR5MzEpGBmvcg1ZPvE/cStF0hfNAdvs1HPvOZC0nifzx+qZfbZfv
         B2xyUaai2S1K9tGhFB0HAtho10L3uMKfEHAZMoN1FlDp4GTelfarZwfy80nvQA6oOTev
         Fr6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzuoQ48E+EsPmFaNgrW9iCYFH0QxXm+us3jrDTOLSl0dVoH2acnVg0lDatmRHgMH75cBrsrOrLwfuuYWViW3yY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1obDxtOipvnqVDBa7vJuKQYc5wkePC2G9NQqYoLBhVhZvxNQQ
	WWS7aylUnDun+ZH0voi72diyBJPWVcJMNPMWG34YF+QMNrS8JMG6UZ8/MUuypoBfcYZr6aKjQ8R
	wPiA3bxJKlKDYHQ2qQTmQD5TRf5OUTN7PcSq37G7rGlXYK5hfLtqcrNXP3L8w3ln2UvHyZztfWY
	YD0Q==
X-Gm-Gg: AYBFou3WXa3Y4c44q7osSbDqi1MRDDZqBr2prOCr3TmOFaMRAXULQzlUNNBNxRL1Il6
	T7an+ydoE6D8SbOxZx2sDckxIzDDcNOaieKwbqjJdsco64KedUVyV0+6A+rJ9r70oVx+C54A+XN
	lIx9G5e0Y981HJXW4SlRe0/QND78yWuMBDaeO3IJ7Biz/5ZtUKJ2DpnVL5K5Sk56plQGvpSqdpD
	ezD9m64Hal7rRrnjxzJgBrSG4zDOy+SYRjnuDCDKD0jPrEdFmQkVD81ApLvzk6CzC8xqqCzQJ4H
	JpvRIMuMGBvvH4NnIMmjNCNXBJbeeFcbsPh+2FAftTNuQYef1IdpDbO1GyxOTI38OlrTd2joY78
	6LazAQ0qWp3jWzpC2LOUFgF7MJm9JauMnbSeyGei+GMjAAyDGsR1AjSv0G6UfUmTGjd/43yiKSQ
	4x5gDM2posMvxlcg==
X-Received: by 2002:a05:693c:87c6:10b0:351:4a80:d94c with SMTP id 5a478bee46e88-36a423e1f4cmr5460211eec.21.1793390841921;
        Fri, 30 Oct 2026 13:07:21 -0700 (PDT)
X-Received: by 2002:a05:693c:87c6:10b0:351:4a80:d94c with SMTP id 5a478bee46e88-36a423e1f4cmr5460147eec.21.1793390841207;
        Fri, 30 Oct 2026 13:07:21 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:07:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 7/7] tpm_crb: Implement command and response chunking logic
Date: Sat, 31 Oct 2026 01:36:49 +0530
Message-ID: <20261030200649.357508-8-armenon@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030200649.357508-1-armenon@redhat.com>
References: <20261030200649.357508-1-armenon@redhat.com>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Menon <armenon@redhat.com>

TPMs implemented with the CRB address map in the TCG PC-Client
Platform TPM Profile (PTP) for TPM 2.0 are limited to a 3968-byte
command/response buffer (v1.07, March 2026, Table 36 and section
6.5.3.9) in [2]. This is smaller than the 7.7KB ML-DSA-87 TPM2_Load from
the previous patch. PTP 1.07 adds a chunking mode for exactly this case
(sections 6.4.2.2, 6.5.3.9, 6.5.3.10 in [2]), usable by any CRB TPM that
implements it.

Send and receive the command/response split into pieces no larger than
priv->cmd_size/priv->rsp_size. Write CRB_START_NEXT_CHUNK to
ctrl_start after each piece but the last, and wait for the TPM to clear
it before sending the next; use CRB_START_INVOKE on the last piece, same
as the non-chunked path. Read a response back the same way, in reverse.

On top of the previous patch's tpm_crb_send_no_chunks()/
tpm_crb_recv_no_chunks() split, add:
- rsp_size: response-direction counterpart of cmd_size.
- intf_id: interface ID register, read once at probe time.
- CRB_INTF_CAP_CRB_CHUNK: capability bit in intf_id; crb_send()/
  crb_recv() only reject an oversized payload when it is clear.
- tpm_crb_send_chunks()/tpm_crb_recv_chunks(): drive the chunked
  transfer described above.

This corresponds to the backend implementation in QEMU [1], which
reassembles the chunks before handing the command to the TPM emulator.

[1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/
[2] https://medias.cdn.trustedcomputinggroup.org/production/PC_Client_Specific_Platform_TPM_Profile_for_TPM_2p0_v1p07_Pub_5643562943.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261029181541.99505-8-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 121 +++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index f0bac9e1f1e8..affca5e95067 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -105,11 +105,13 @@ struct crb_priv {
 	u8 __iomem *cmd;
 	u8 __iomem *rsp;
 	u32 cmd_size;
+	u32 rsp_size;
 	u32 smc_func_id;
 	u32 __iomem *pluton_start_addr;
 	u32 __iomem *pluton_reply_addr;
 	u8 ffa_flags;
 	u8 ffa_attributes;
+	u32 intf_id;
 };
 
 struct tpm2_crb_smc {
@@ -369,6 +371,13 @@ static u8 crb_status(struct tpm_chip *chip)
 	return sts;
 }
 
+/*
+ * tpm_crb_recv_chunks() below needs to drive CRB_START_NEXT_CHUNK through
+ * tpm_crb_start(), which is defined later in this file next to the other
+ * platform-specific start methods it dispatches to.
+ */
+static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd);
+
 static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -388,12 +397,55 @@ static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
 	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
 
 	return expected;
+}
+
+static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
+				unsigned int expected)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t offset = 0;
+	size_t chunk_size;
+	bool expired;
+	int rc;
+
+	if (expected > count || expected < TPM_HEADER_SIZE)
+		return -EIO;
+	/*
+	 * Without this, a bogus zero-sized MMIO window would never make
+	 * forward progress below.
+	 */
+	if (priv->rsp_size == 0)
+		return -EIO;
+
+	while (offset < expected) {
+		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
+		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
+		offset += chunk_size;
 
+		if (offset == expected)
+			break;
+
+		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
+		if (rc)
+			return rc;
+
+		expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+						CRB_START_NEXT_CHUNK, 0,
+						TPM2_TIMEOUT_C);
+		if (expired) {
+			dev_err(&chip->dev,
+				"Timeout waiting for backend response\n");
+			return -ETIME;
+		}
+	}
+	return expected;
 }
 
 static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
+	u8 header[8];
 
 	/*
 	 * A sanity check that the upper layer wants to get at least the header
@@ -409,7 +461,18 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
 		return -EIO;
 
-	return tpm_crb_recv_no_chunks(chip, buf, count);
+	/* Peek at the first 8 bytes to determine the response size */
+	memcpy_fromio(header, priv->rsp, sizeof(header));
+	expected = be32_to_cpup((__be32 *)&header[2]);
+
+	if (expected <= priv->rsp_size)
+		return tpm_crb_recv_no_chunks(chip, buf, count);
+	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
+		dev_err(&chip->dev,
+			"Response larger than MMIO and chunking not supported\n");
+		return -EIO;
+	}
+	return tpm_crb_recv_chunks(chip, buf, count, expected);
 }
 
 static int crb_do_acpi_start(struct tpm_chip *chip)
@@ -502,6 +565,46 @@ static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
 	return crb_try_pluton_doorbell(priv, false);
 }
 
+static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t chunk_size;
+	size_t offset = 0;
+	int rc;
+	bool expired;
+
+	while (offset < len) {
+		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
+		if (chunk_size == 0)
+			break;
+
+		memcpy_toio(priv->cmd, buf + offset, chunk_size);
+		offset += chunk_size;
+
+		/* Make sure that cmd is populated before issuing start. */
+		wmb();
+
+		if (offset < len) {
+			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
+			if (rc)
+				return rc;
+			expired = !crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+							CRB_START_NEXT_CHUNK, 0,
+							TPM2_TIMEOUT_C);
+			if (expired) {
+				dev_err(&chip->dev,
+					"Timeout waiting for backend to consume chunk\n");
+				return -ETIME;
+			}
+		} else {
+			rc = tpm_crb_start(chip, CRB_START_INVOKE);
+			if (rc)
+				return rc;
+		}
+	}
+	return crb_try_pluton_doorbell(priv, false);
+}
+
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -512,7 +615,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	 */
 	iowrite32(0, &priv->regs_t->ctrl_cancel);
 
-	if (len > priv->cmd_size) {
+	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
 		dev_err(&chip->dev, "invalid command count value %zd %d\n",
 			len, priv->cmd_size);
 		return -E2BIG;
@@ -522,7 +625,10 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	return tpm_crb_send_no_chunks(chip, buf, len);
+	if (len <= priv->cmd_size)
+		return tpm_crb_send_no_chunks(chip, buf, len);
+
+	return tpm_crb_send_chunks(chip, buf, len);
 }
 
 static void crb_cancel(struct tpm_chip *chip)
@@ -748,6 +854,11 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 		ret = PTR_ERR(priv->cmd);
 		goto out;
 	}
+	if (priv->regs_h)
+		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
+
+	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
+		dev_info(dev, "CRB Chunking is supported by backend\n");
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
@@ -786,8 +897,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 	priv->rsp = priv->cmd;
 
 out:
-	if (!ret)
+	if (!ret) {
 		priv->cmd_size = cmd_size;
+		priv->rsp_size = rsp_size;
+	}
 
 	__crb_go_idle(dev, priv, 0);
 
-- 
2.56.0

