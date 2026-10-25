Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959570;
	b=C0IOaEbTQs0BtbisyObrXkOOi/756MzGPUg1PGTTjJ4MIvapkm32dCUMPvg0cw9wa7E6
	 Z4EB1xxX6LdaYiq2npuQtGy5VZDphnMzEEirACkhRSkic8XQPaNF3fndvgIbKETq7wqkl
	 aqUDT9Ap3i23YCIWXvPoinz2M++iHvrYFpil4eZW/Pci/t4sPgrvQYh7QXQOvYwr55AIE
	 YMAbk2dlzGIbY4dxoP+l2aD1dZcw/FwMQ+Vgzf9BDa5ePIXMa653z3clU/o7OTfMUVlL+
	 zIZr3qBpVQybQJXUfnTCDHl7ZP1jxz66sqxf6+eMB8VRewoxCv2rNWcWBkGl+C9JmIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959570;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
	b=TTabX4mfD3s4Wh9wGME47eyVzrYTtGo1xS0C1R/wkUE4wz4xqoK2Whwqqa5dcLXkY66E
	 2DGwvzgklfVQYJAp7CpTjhTA7yTxr9HnVItECuV8xNmZ1yJvzUU0SLxB9+4K9C6bacJHm
	 oVksG8Fo8GDeuS+nKDorUMauxPOih/LSEcUkPnPVYf2qhyuCv61G3xruMJSN+eBFJNiIG
	 oyK2bmT5UnLv0NCHHX3Of3YjWChALbe8nD0EMVKYUPote3h9jp/Jwvyfku+TeaKG2Imu3
	 uWj8JjhPGLGuW/Fgww+yH++Jo/IlLu1plgGg3qLc0sX+0zAIb4ByqlCDSjGMpzc++sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rc83fdzo;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="JWrKF/m0";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDD606A324
	for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 20:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EDD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rc83fdzo;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JWrKF/m0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792959569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
	b=Rc83fdzoxRzOUc4WVH3HhLpISbQbz0L4BvBYMpM3CgWtV8p4NkwVbWM81l9+2iESXrd4Vc
	3ipLHOnOLi1ChvELFsSfnGJNdUHOUKY9rlXRXnKZwcFq8j0L2ZIOhrPckBCvOzALR0HCgw
	PAIgOlMREk9rxJLe8tX+v6dWkNkQVbA=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-od6HMq49N3uruCXxCKA9sw-1; Sun, 25 Oct 2026 16:19:27 -0400
X-MC-Unique: od6HMq49N3uruCXxCKA9sw-1
X-Mimecast-MFC-AGG-ID: od6HMq49N3uruCXxCKA9sw_1792959566
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so10789903c88.1
        for <linux-integrity@vger.kernel.org>; Sun, 25 Oct 2026 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792959566; x=1793564366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
        b=JWrKF/m0q8ltpPDWUdjylkCB5KM57PhXcEOzcpFvdwnTEN7+6C0ByoiFJ5pyhnzDYJ
         phf0rpY7WGZantzW3Gvxi4veiNi1UZd6J1Vwq+/9I4FwbBFp8W3FhIK9hxwL9sHIPTP2
         GeoJvlMVOA3m7byPkB7jI/wadGsRhHMM34Pj4Wcl9OXmo1BVy4aqjLNg4b2pBLYteoT/
         QvkdfFYs3ar/9XXYBZUQEwcvVhpcUublscqgzGv6712G/JAOZ1nwRrIrE8dkhiyN7OtY
         6cAhtzqzOKXVnrysRWidFltvzZJ1wUs5vyGTeorkAhM3FZfU5XOSR+r/MFJOrdalXat+
         uO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959566; x=1793564366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
        b=hY8eUYdoq7HKrylT2NGz2r3YM+TFArSQtRRx0f+0ZB0uImg0C0Th3ESSC0t3Fj6Irv
         1ZhQLyjVv+6mh5hvIAsXWsVRx4g5bCLCeEDwjZuDNOdfVQ8CtXP0CNLPwFUKFuB1FoQA
         6B8ySKcw3KfrWvIAWUswQqVENzpu+PRcS6PIad9ZWSojqqxNMKXSP+g3rFTTgXBRNVbW
         HqkH+n8tYzzX1evHFDEeV51+QXIr61mqCaKyGKeCxB0AvdxMrRPU1ZNkPy6BsF5kvPyQ
         9gGM6TAMm60CydMNtJNb50gXdYQ4TkrRX9qQDqL5lKCW6UMS9jUC6qafyzKGeL+CeTGt
         rTbA==
X-Forwarded-Encrypted: i=1; AKwUvBxfSUXuotRE3jRinsC4ClXMaK2NVCDwphKitm3Xs08u8BUV+iV8ZAAPzR9j0+i3heUqHPXaOmxyRGHyD4Ij5X4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9TdLCqMYYWOrUkgoO/Edzdy3Swj7q1ARTvQO9YK5TG/zsa+Ao
	aaInSZKnN7uEoUTVRRN//zJ7KgZZxNkBnA4ZMEQsjPIBQczOMShF8tIDo26LCDcQxHYn0qKP7TH
	yBtypu846MxU/D/yzrLI/9OaBzfdJf3AzkPYTu4nqwfVGV+Awf8+bem7nz+k1lJ31uC3BVA==
X-Gm-Gg: AYBFou1JrzFZxI7reVOsCi1dSCb2U0GWG/ye8uSpoEy1of5OB5074JhbhXPJZ8CTVtj
	Nn8XGajpUpmoVcmbF8wx5zXOlTgCFeAX7dgqe/4h+yT9mFcr9gVgXr1lIsxUBEu496/O3DhZ1eS
	cygqBsVaLgNz5lUwcYAoI+ipgG882ZNF8CjoACn6QcQ77MxOB++Tzt68YPkYe20eFqHXHmRm63y
	prgnrIuNPvaB8eEk5KILB6AF6icckbOg25IW07U9zdIHkb6KamgvNXjaC2ZpJEgeO3wymPr0Vf5
	3oAfLEX/CpxYfIZ7DYA2N+IMZ5lVXsSmPFJQ2MckLtuIAOsgD/WK1A+lbLpcR+x0GvJVngVxixE
	o4kI27QimKEWOJE1u+F5qvfizQJokVSGI6BS5Bnad
X-Received: by 2002:a05:7022:1108:b0:17b:fea8:1425 with SMTP id a92af1059eb24-1993f3ed32emr6942427c88.30.1792959565946;
        Sun, 25 Oct 2026 13:19:25 -0700 (PDT)
X-Received: by 2002:a05:7022:1108:b0:17b:fea8:1425 with SMTP id a92af1059eb24-1993f3ed32emr6942388c88.30.1792959565150;
        Sun, 25 Oct 2026 13:19:25 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm17656169c88.3.2026.10.25.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:19:24 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 6/6] tpm_crb: Implement command and response chunking logic
Date: Mon, 26 Oct 2026 01:48:58 +0530
Message-ID: <20261025201859.221991-7-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025201859.221991-1-armenon@redhat.com>
References: <20261025201859.221991-1-armenon@redhat.com>
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

With the introduction of support for Post Quantum Cryptography
algorithms in TPM, the commands and responses will grow in size.
Some TPMs have a physical hardware memory window (MMIO) that is
smaller than the commands we need to send. Therefore this commit
implements the core logic of sending/receiving data in chunks.

Instead of sending the whole command at once, the driver now sends it in
small chunks. After each chunk, it signals the TPM using a nextChunk
signal, and waits for the TPM to consume the data. Once the final piece
is delivered, the driver signals the TPM to begin execution by toggling
the start invoke bit. We use the same logic in reverse to read large
responses from the TPM.

This allows the driver to handle large payloads even when the hardware
interface has limited memory. This kernel-side support corresponds to
the backend implementation in QEMU [1]. QEMU reassembles the chunks
before passing them to the TPM emulator.

[1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 215 +++++++++++++++++++++++++++++--------
 1 file changed, 173 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 31f530744e90..8b2aaa109fc4 100644
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
@@ -369,38 +371,6 @@ static u8 crb_status(struct tpm_chip *chip)
 	return sts;
 }
 
-static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-{
-	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
-	unsigned int expected;
-
-	/* A sanity check that the upper layer wants to get at least the header
-	 * as that is the minimum size for any TPM response.
-	 */
-	if (count < TPM_HEADER_SIZE)
-		return -EIO;
-
-	/* If this bit is set, according to the spec, the TPM is in
-	 * unrecoverable condition.
-	 */
-	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
-		return -EIO;
-
-	/* Read the first 8 bytes in order to get the length of the response.
-	 * We read exactly a quad word in order to make sure that the remaining
-	 * reads will be aligned.
-	 */
-	memcpy_fromio(buf, priv->rsp, 8);
-
-	expected = be32_to_cpup((__be32 *)&buf[2]);
-	if (expected > count || expected < TPM_HEADER_SIZE)
-		return -EIO;
-
-	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
-
-	return expected;
-}
-
 static int crb_do_acpi_start(struct tpm_chip *chip)
 {
 	union acpi_object *obj;
@@ -472,17 +442,71 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 	return rc;
 }
 
+static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int rc;
+
+	memcpy_toio(priv->cmd, buf, len);
+
+	/* Make sure that cmd is populated before issuing start. */
+	wmb();
+
+	rc = tpm_crb_start(chip, CRB_START_INVOKE);
+	if (rc)
+		return rc;
+
+	return crb_try_pluton_doorbell(priv, false);
+}
+
+static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t offset = 0;
+	size_t chunk_size;
+	int rc;
+
+	while (offset < len) {
+		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
+
+		if (chunk_size == 0)
+			break;
+
+		memcpy_toio(priv->cmd, buf + offset, chunk_size);
+		offset += chunk_size;
+
+		/* Make sure that cmd is populated before issuing start. */
+		wmb();
+		if (offset < len) {
+			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
+			if (rc)
+				return rc;
+			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+									 CRB_START_NEXT_CHUNK, 0,
+									 TPM2_TIMEOUT_C)) {
+				dev_err(&chip->dev,
+						"Timeout waiting for backend to consume chunk\n");
+				return -ETIME;
+			}
+		} else {
+			rc = tpm_crb_start(chip, CRB_START_INVOKE);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return crb_try_pluton_doorbell(priv, false);
+}
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
-	int rc = 0;
 
 	/* Zero the cancel register so that the next command will not get
 	 * canceled.
 	 */
 	iowrite32(0, &priv->regs_t->ctrl_cancel);
 
-	if (len > priv->cmd_size) {
+	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
 		dev_err(&chip->dev, "invalid command count value %zd %d\n",
 			len, priv->cmd_size);
 		return -E2BIG;
@@ -492,16 +516,115 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	memcpy_toio(priv->cmd, buf, len);
+	if (len <= priv->cmd_size)
+		return tpm_crb_send_no_chunks(chip, buf, len);
 
-	/* Make sure that cmd is populated before issuing start. */
-	wmb();
+	return tpm_crb_send_chunks(chip, buf, len);
+}
 
-	rc = tpm_crb_start(chip, CRB_START_INVOKE);
-	if (rc)
-		return rc;
+static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
 
-	return crb_try_pluton_doorbell(priv, false);
+	/* Read the first 8 bytes in order to get the length of the response.
+	 * We read exactly a quad word in order to make sure that the remaining
+	 * reads will be aligned.
+	 */
+	memcpy_fromio(buf, priv->rsp, 8);
+
+	expected = be32_to_cpup((__be32 *)&buf[2]);
+	if (expected > count || expected < TPM_HEADER_SIZE)
+		return -EIO;
+
+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
+
+	return expected;
+}
+
+static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
+							   unsigned int expected)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t offset = 0;
+	size_t chunk_size;
+	size_t first_read;
+	int rc;
+
+	if (expected > count)
+		return -EIO;
+	/*
+	 * Set chunk_size by comparing the size of the buffer that the upper
+	 * layer has allocated (count) to the hardware tpm limit (priv->rsp_size).
+	 * This is to prevent buffer overflow while writing to buf.
+	 */
+	chunk_size = min_t(size_t, count, priv->rsp_size);
+	if (chunk_size < 8)
+		return -EIO;
+
+	memcpy_fromio(buf, priv->rsp, 8);
+
+	/*
+	 * Compare the actual size of the response we found in
+	 * the header to the chunk size
+	 */
+	first_read = min_t(size_t, expected, chunk_size);
+
+	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
+	offset = first_read;
+
+	while (offset < expected) {
+		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
+		if (rc)
+			return rc;
+
+		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+								 CRB_START_NEXT_CHUNK, 0,
+								 TPM2_TIMEOUT_C)) {
+			dev_err(&chip->dev, "Timeout waiting for backend response\n");
+			return -ETIME;
+		}
+
+		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
+		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
+		offset += chunk_size;
+	}
+
+	return expected;
+}
+
+static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
+
+	/* A sanity check that the upper layer wants to get at least the header
+	 * as that is the minimum size for any TPM response.
+	 */
+	if (count < TPM_HEADER_SIZE)
+		return -EIO;
+
+	/* If this bit is set, according to the spec, the TPM is in
+	 * unrecoverable condition.
+	 */
+	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
+		return -EIO;
+
+	/*
+	 * Peek at the first 8 bytes to determine the response size
+	 */
+	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
+
+	if (expected <= priv->rsp_size)
+		return tpm_crb_recv_no_chunks(chip, buf, count);
+
+	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
+		dev_err(&chip->dev,
+			    "Response larger than MMIO and chunking not supported\n");
+		return -EIO;
+	}
+
+	return tpm_crb_recv_chunks(chip, buf, count, expected);
 }
 
 static void crb_cancel(struct tpm_chip *chip)
@@ -728,6 +851,12 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 		goto out;
 	}
 
+	if (priv->regs_h)
+		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
+
+	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
+		dev_info(dev, "CRB Chunking is supported by backend\n");
+
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
 	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
@@ -765,8 +894,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 	priv->rsp = priv->cmd;
 
 out:
-	if (!ret)
+	if (!ret) {
 		priv->cmd_size = cmd_size;
+		priv->rsp_size = rsp_size;
+	}
 
 	__crb_go_idle(dev, priv, 0);
 
-- 
2.54.0

