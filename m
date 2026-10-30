Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390841;
	b=XK4bR5V1Z8BsemyMKF2oyb8t59gIhIKuOrxEEfdIds1iYdK2+7+bR569kth+3XWC2/8o
	 3k3lT2+8xU45uqpbufRqJ4s4lQXj4nvgADRL3z+RvmwbG6G3GbzqTkFxprg2Y9Y6RR6ne
	 H5+1qT6lIxlRjNz5Egc8U7TkS6nFGinhI2iCKqEXEVZaCikk5gvUv0wZFBEYzAK6IuSLl
	 g11iUFim6DiAEQgnJOa6cPQ7DinrknZ2BD15jxoovJEPyphwgkfiW4Xw0bNUywf4IBciw
	 2osam6+7jzrj5AA5wXkCLY+/R9Ralv8Iqf4xUcVQGDOInSp8hkHojEd2tsGc9d3/qbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h0iJNfxOXpvZ7j0zVb3aEpT99gOMiKrRT29/xX7pPg4=;
	b=aq2VUH8e5TQn3a+O2B3Lb9ORk2M3NmAqBDBmW4Ds7Our9bNRaKD/8sktH3ZPr4LmzoWB
	 6hBBzIxRloIbHyf88Ca01Ftei7qQak7WLno6emzKEkiFxm/dEKcd5y5FhP8IQUX3QjE+j
	 ATajYO0aB5JScrIAJ7oCThoUUc6bVFeYq35YgWHn2VUyWlVFXHGx9gQ3SFYKW1LK2qOBG
	 QjBncxXLCqmKTiV67EJjs6NrBF0YwKZJDRLZ/F4sQzkqvF4j+XQhJ9PR2l3OUZoWjhkzJ
	 903MP4mSXTtcVoFSvXk+UWzRnpvR4O71LDZqjoRL1D6XywtsIwopSK4KqhvtffiK95Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NywCN03V;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PSTO1TQZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EA606A320
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D5EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NywCN03V;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PSTO1TQZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0iJNfxOXpvZ7j0zVb3aEpT99gOMiKrRT29/xX7pPg4=;
	b=NywCN03V46iSwnVFQVt0Bx9y6qhjj3+93Ma3X+CevI3ua4iXY4D8nSWcW4fVI71cw1Pst3
	NgYI6TeszEbjDiHD28eOzyEJe8TRTOSq61YyFCXtz7o9z0+j7Nv9fbQ7GT8Weic53hLNA9
	jmnEYSoHg1vXZhZcS/dBnDT9y9p8zW8=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-gKxYnm9JOYe4OBDydVMVhw-1; Fri, 30 Oct 2026 16:07:19 -0400
X-MC-Unique: gKxYnm9JOYe4OBDydVMVhw-1
X-Mimecast-MFC-AGG-ID: gKxYnm9JOYe4OBDydVMVhw_1793390838
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a190c53a3so1423949eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390838; x=1793995638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0iJNfxOXpvZ7j0zVb3aEpT99gOMiKrRT29/xX7pPg4=;
        b=PSTO1TQZo3V9zgZX/8U7xYw6W9VZV+swDKhSG3l1n9dOfZ8W0xEC24lgPL5yIDfotB
         FqYfB8oK+Nn7EbC1dVHUcLaCKoNyJ5Arv1b4PMthiLswoy/hph5cLtViDBPPZ4Dmkmmj
         E7y5lrc01sYzDHuTm/I5l2NfcxdfSZDKju0EPAToGY1+L3RyN/44GRKU07wRsh5P95bT
         AR67fb6ctC/7unrk0EUsXZ0nTl55TIBrvWUmVKmt9gIc3uO8FGulyzExo5Ne7poPcg8Q
         TH56n4WCFo/OFNWjCEUPQQQp3n7EV5xves2YFTks/mof7zICzYB287QDJ/t2UKNra7QC
         moAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390838; x=1793995638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0iJNfxOXpvZ7j0zVb3aEpT99gOMiKrRT29/xX7pPg4=;
        b=lBDHQ/onk9N40swwPfzvVvGMSBxFsofq+In6HegmvrbfnfDsCGBb/hbV+keOeTzuFQ
         wQI0rD9p6fIGf0JSXDE2rF+F0D2IncrE8KVYBywqL0/JjGaFEb/WL1E2Oy87Ccg+O5kz
         A4siPO8xDLebVPxSJzN29iStLORhRtDKmtAW9MEmG7EOu7do1GwIoYzOFzh62kwGtWfO
         h/5GyLn2Oq/HPzLecxRYvh4+SbjE/3fycj6WRJGw/6wUhSl1Mg46zvNA1SC5NKw+jcIt
         TE7H3JcnGAQzTY11hsyGVSXPRbo3x2B00xS9ErMRBVje2ueEokyGku2Y7jlCSUtrZThP
         t47g==
X-Forwarded-Encrypted: i=1; AKwUvBzsdhlDk38nLz5K6+WV4ERR8UQVSO5ejYLVUyy1sXRap6qtCPbhz9NcOnPpH/bHTNB9MVWBdO14WrBYqxbMrPM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx3TJsb79BI8sUoWPhZ9mtobu6trImNpJGEQVIQXmI5DMtmMyL
	L7lt4CGj8xD2H34TAtYOHO2DKWjRwSfAbLzN5gZuwLZ4OilT8JXFHErXWwicZfE5TODtchS1RB0
	y1GW0huD7fZuSmbIos7qw9HqI6iBJ5dwk0ZJfMxIpKWSDkMzWr9r8YyyWoJDFPPsL6Mjn1w==
X-Gm-Gg: AYBFou1Vxs59kCZ8y5589bI7sw633VFCNNff2W/fUbKhxvOGLel1v2y7WczDTtzAI/6
	kSr8y236dWPkSTPKPh3gnBiBFJMTGqWIQBYg94iq6QXpudzMsS4On/B0qkTYDD06wDPn/CIE1dq
	hAlwjnh7JL7rysJUvF6vCThc0NnNQFMTVxzK9jkpopPz92HE9ibdAYxW+bb7/FdOZmF+Y9DtQol
	m0Sx3fL/9eq0xwfQ0vsiJnPSXwKnB0AhjPkDlWD4tLB0baNvkLLnaN3bEgWQZe3eJSw/UUqOtrT
	St6ES5SE52g1krqxun94DwCVrI2l8X2CeOXaNWFyusNdIQ2cGNqdIP6utSCiV7ahSSjYDspV5Tl
	wffKLUbE/g53znw8zotxWcYobtolgPiHOQ+fL6D4e7Wt15xTPSlBkdLS2J4zYsZD0fhL9/HU64V
	TCo0hngQvxomDsmg==
X-Received: by 2002:a05:7300:f587:b0:35a:3b98:b428 with SMTP id 5a478bee46e88-36a424011f5mr3925844eec.12.1793390837974;
        Fri, 30 Oct 2026 13:07:17 -0700 (PDT)
X-Received: by 2002:a05:7300:f587:b0:35a:3b98:b428 with SMTP id 5a478bee46e88-36a424011f5mr3925802eec.12.1793390837265;
        Fri, 30 Oct 2026 13:07:17 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:07:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 6/7] tpm_crb: Factor crb_send()/crb_recv() bodies into helpers
Date: Sat, 31 Oct 2026 01:36:48 +0530
Message-ID: <20261030200649.357508-7-armenon@redhat.com>
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

A later patch adds CRB chunking, which needs its own send/receive
loops alongside the existing single-shot transfer. Move the body of
crb_send() into tpm_crb_send_no_chunks() and the body of crb_recv()
into tpm_crb_recv_no_chunks().

Pure code motion, no behavior change. Also fix the block comment to the
kernel's preferred multi-line style.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261029181541.99505-7-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 71 ++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 30ca8192d3a8..f0bac9e1f1e8 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -369,24 +369,13 @@ static u8 crb_status(struct tpm_chip *chip)
 	return sts;
 }
 
-static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	unsigned int expected;
 
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
+	/*
+	 * Read the first 8 bytes in order to get the length of the response.
 	 * We read exactly a quad word in order to make sure that the remaining
 	 * reads will be aligned.
 	 */
@@ -399,6 +388,28 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
 
 	return expected;
+
+}
+
+static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+
+	/*
+	 * A sanity check that the upper layer wants to get at least the header
+	 * as that is the minimum size for any TPM response.
+	 */
+	if (count < TPM_HEADER_SIZE)
+		return -EIO;
+
+	/*
+	 * If this bit is set, according to the spec, the TPM is in
+	 * unrecoverable condition.
+	 */
+	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
+		return -EIO;
+
+	return tpm_crb_recv_no_chunks(chip, buf, count);
 }
 
 static int crb_do_acpi_start(struct tpm_chip *chip)
@@ -474,12 +485,29 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 	return rc;
 }
 
-static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
+static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	int rc = 0;
 
-	/* Zero the cancel register so that the next command will not get
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
+static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+
+	/*
+	 * Zero the cancel register so that the next command will not get
 	 * canceled.
 	 */
 	iowrite32(0, &priv->regs_t->ctrl_cancel);
@@ -494,16 +522,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	memcpy_toio(priv->cmd, buf, len);
-
-	/* Make sure that cmd is populated before issuing start. */
-	wmb();
-
-	rc = tpm_crb_start(chip, CRB_START_INVOKE);
-	if (rc)
-		return rc;
-
-	return crb_try_pluton_doorbell(priv, false);
+	return tpm_crb_send_no_chunks(chip, buf, len);
 }
 
 static void crb_cancel(struct tpm_chip *chip)
-- 
2.56.0

