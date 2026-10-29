Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297789;
	b=kkWly5eEcVHMsddne42IjmAVHBgdcxd9g87Figz/VJhBOjTZBeqUNultE76XRbUClrE3
	 rSTnqg0DqNQCcTLhGfA/TVHnUk87hdAG0wiyrnmTOmfMdO6ffSeA/FSMFHoHtKqQYw7jd
	 SnuU0Q0MpIBJjFxSLMijA2gLN47Z/Vghm8oAW0GOGXTx2ROHcxy1eo/2wTqKXSyCvBY88
	 vThIymSTK7njHXjktsiUXx/3q37DLc5AQ+mlfhWvxf585jrUiyCngyljlC24S0WeI5FEz
	 jon7YptHzsE1sHveF+EfS6q+dblt11ntsr6fxbGrBLabyRHas4gV/u+Ru3JKWIiF2nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297789;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2hAQDlU+S+SxQSPcNtLHuLHsFmmhuBOY9HbR41qMS0I=;
	b=ylrXQHbyKITLPzCc4m1/MVUauMF3OjNadcIOritTsgHXssowUaAtfE07HV2+XPj4uYy6
	 0Y3AlpQmnzTXNCavfnS4fX0ROPb0ebb61GyWomyj84gXmzU7Fuu3KpQQ53QE8K3/GGrUa
	 oLPPYsWt5UuWRcmkvFTdDt19viPBojIpyG9HV6SgtRGnL19Zc2K4rM13CosSDHM68z1Cm
	 M7LMQf8ZMVWO4xgmN1qQs68Rk6jyNMXyoGM4Ye289QFH8Uu4zlLGqOeG9beyaEoMBJVch
	 bVQ4jXxOmIAk31BuAs1Qmk6DUaGrQazKhTrE6AbmfCjSFtpGiRoV7Gr2cM6aM9IgX4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OTlnyJfR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SLP2ZorM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25A60A2622
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC25A60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OTlnyJfR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SLP2ZorM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hAQDlU+S+SxQSPcNtLHuLHsFmmhuBOY9HbR41qMS0I=;
	b=OTlnyJfRyBmiRMrAs9iQTtKkQpf2m/lFDsmKQW0Uiaw3q+7EUiI1mCqfOhudY+ZcViYAO/
	wxPun75MikjCV96+/Xi7Owj0eE4XPsagiWic1SM3W/A1GZ1rmIYnPy1cRbsJUaE9Fir/h7
	/ZZXSHT2E2wXz8pqrjxJKqeS64XmaNk=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-rXf7PuFWPjaENUugTqmP8Q-1; Thu, 29 Oct 2026 14:16:25 -0400
X-MC-Unique: rXf7PuFWPjaENUugTqmP8Q-1
X-Mimecast-MFC-AGG-ID: rXf7PuFWPjaENUugTqmP8Q_1793297784
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a190c53a3so1408777eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297784; x=1793902584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hAQDlU+S+SxQSPcNtLHuLHsFmmhuBOY9HbR41qMS0I=;
        b=SLP2ZorMG6c5/peVI7pXBO+RhZ4YskZGd1YNrxbaPdnhN2rhUllriNqOpHHVdpAIOU
         hBX9TwOP86q9HqPMk2mMp+73Op6gRUFjh+ATrqy1cFYp80QP7MtcncXQ6Sxd/QkmOYig
         6FASyjcwf0K2+SjV6HeeoRydmqsu+lCC6nWlJyKcAw2lG9iCwJQGLRAMM0QwrcKSqsAB
         q2DPQUsBwLAs0c8rnURb0cXqPc2e2d6AMU7O49IVyThMnoMKr+aBIGWmrDzH8vt/LkwV
         4whiDH4z5rlHRhOscwv81jJbmtAh0kXPzOaXkBEhdjJmT9QGPg+BhgRwvoKrH9PesCPN
         JUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297784; x=1793902584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hAQDlU+S+SxQSPcNtLHuLHsFmmhuBOY9HbR41qMS0I=;
        b=xbuDa7iYQ5zsCtfcZpMs8t+K/Bgen3RLgfNGaDRYY60N0wX0HnoydB8eALjSyKg52g
         9S9IE2n78rbYS6bX5oAopgSwnb/rUICshWoO3vIzRmKPpBZmntum9tuUFPV8SSqsQd0q
         /tiGHdkz7URaANQaQSGWKwYTPDsLT9erzCFIGPtIFHhdxfc/XettHGRvWUM6yh55wFkk
         bhr4gjhguHlKJ/+86+n7EG7WImMgV30R+RkKAwdAIJ4nDjJCNMxzQ+OHvjpkAt7yfUYE
         jJrSpHasAZoNkbN7sbAfsZKIv1JXvb1ySH61z/oPJamaJdIRm6kTgdb/pMBzzEe7RAub
         rayg==
X-Forwarded-Encrypted: i=1; AKwUvByy2jF7TePC18cWEt7sGXfyDWIYkbFvCiyYwlFhMwiqvC5WdzBrVXHkvMoU1yGndFXPX1g0t42igDJj+nWojEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzRdpRsrAfSfkiJB0UzDTqVtIV2T4xDANtt8LLCVWdhUNV5RDQ
	zka+j53U2m7GgK6Ki4jGYNUTYgtyOXgko0OT3xgxB6wBEgw6afNQ5YEHzgzh/Gglu9AZ3nmCknO
	yfR/qmZJlCntHmuZIywN/SKS4xXN5NR//9LiRl69jhzb1wmXoHHkiyza0J9dTjHdcOaNOBg==
X-Gm-Gg: AYBFou0UXBoEqFcWgov/0grqVMrGf9PXY3+nuDZ5wbwKSETUkFmZuqm5IMef8/W6x9J
	l/Y3Y/2pIOCQ4g7+9CUFJymbrVKTv+ccsmd4FBevGwu7fpCa3yXnMSnKvi6t4AgzJwEPmtBVG9C
	4S6M2EXRtaDWLrn3f2hp1Tp1ZPLd+PLxNYXt1w5zVUY8p0g+TfZSuWOeBssaN2LPEHj1YlRU1hT
	kLDU9Fv1mcUEYDNVTVS1hwTJaooLoh7Z2+07/uxiUW4Sxt8jsLq6/eR6eIfemD4qhnDSTUgTD9d
	my6RWKMDX74hrrLcVyl+HSqEduDnEP6R8SgOKxxRkgzWsRmnyS72Y9QCJJap7bvIyCpw/VTy/US
	i4PX1j1k+zmwyfRKacWcIaeOypYekLjOxbP6dFn1tcXAQQfPdM2bGV8JRvAmRjr7Ql7Ol4NpOzq
	jCX9fgMLyIeZCjEQ==
X-Received: by 2002:a05:693c:8211:b0:369:f3a3:fad6 with SMTP id 5a478bee46e88-36a42340d04mr213912eec.4.1793297783736;
        Thu, 29 Oct 2026 11:16:23 -0700 (PDT)
X-Received: by 2002:a05:693c:8211:b0:369:f3a3:fad6 with SMTP id 5a478bee46e88-36a42340d04mr213870eec.4.1793297782784;
        Thu, 29 Oct 2026 11:16:22 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:16:21 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 7/7] tpm_crb: Implement command and response chunking logic
Date: Thu, 29 Oct 2026 23:45:41 +0530
Message-ID: <20261029181541.99505-8-armenon@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029181541.99505-1-armenon@redhat.com>
References: <20261029181541.99505-1-armenon@redhat.com>
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
---
 drivers/char/tpm/tpm_crb.c | 119 +++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index f0bac9e1f1e8..e14b1feb3fea 100644
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
@@ -388,12 +397,54 @@ static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
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
 
 	/*
 	 * A sanity check that the upper layer wants to get at least the header
@@ -409,7 +460,17 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
 		return -EIO;
 
-	return tpm_crb_recv_no_chunks(chip, buf, count);
+	/* Peek at the first 8 bytes to determine the response size */
+	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
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
@@ -502,6 +563,46 @@ static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
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
@@ -512,7 +613,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	 */
 	iowrite32(0, &priv->regs_t->ctrl_cancel);
 
-	if (len > priv->cmd_size) {
+	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
 		dev_err(&chip->dev, "invalid command count value %zd %d\n",
 			len, priv->cmd_size);
 		return -E2BIG;
@@ -522,7 +623,10 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	return tpm_crb_send_no_chunks(chip, buf, len);
+	if (len <= priv->cmd_size)
+		return tpm_crb_send_no_chunks(chip, buf, len);
+
+	return tpm_crb_send_chunks(chip, buf, len);
 }
 
 static void crb_cancel(struct tpm_chip *chip)
@@ -748,6 +852,11 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
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
@@ -786,8 +895,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
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

