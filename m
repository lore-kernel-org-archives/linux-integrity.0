Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297791;
	b=lkGnoQgB4+pTgHfTgXzPRKQ8hCC0QmOS7TzYNJElB91jwt7UXL6LEs6XUSgOE6Yvn1jK
	 JzArmlni3ra1xn7UhN5zWxMSr4jEEaISzuDB5cNuKmd2ZdJ1mSz3TiiY8iwiNbz7jNy5s
	 4n8y21fXMpoSyGRd/F6tgWfsVYN6R1lFqYhh/AMO5h/QA1X7ow5DQfYq5PE0T5bB4pPwh
	 jyzMHsePyGQI5uGG0IzcuH30+LRCJqTBgKzgCcqjVWcRyN2jqQd/ghYjTmo/Jd4SCb9NJ
	 Owf+1ZhcgRxVmLCGPxNUgcZV4d7sXjhCxzPD8CawtJdPr4AcqxxSvrPoHLLgMGgJqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297791;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kGCAJjCLhsAMNr80slCwUFe5tvwX7ZrzHAvRFP8FkYE=;
	b=fL8ifYLUUFegVhSA5V1s4r4+jW8HqyZSgs0kuU++Cj+mmzEG6FJP6CNOEVctqjrDp/Ch
	 VerFDfhZAe6vVRcfsO9E7vqUsYJ56X7b+1N2dbxF9GrRcXR6h4/5xIgWMDMR2YSRcCdzv
	 rMvs23MMJPKTpQJGCPewzdruRkYgCLyeRr1HIrkfz4yNSZv2+0jlq7fQ3I9KlnKSPoLLf
	 +wmnNAICnX5Jbc9pCZOQM4KR8OtPorkptHi6c7hBrlyi0wlDwKJJxfrZG678EwVsb95/V
	 KfpLwHWNDPgRcRfc4HXfFTE+yJEdZxGZML/xHmxl/oLQhUhzOI25lPoRDkqAwFcenPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCZubkXv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CAZUOY05;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3E606A33F
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D3E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fCZubkXv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CAZUOY05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGCAJjCLhsAMNr80slCwUFe5tvwX7ZrzHAvRFP8FkYE=;
	b=fCZubkXveRmZxZoZBRRT7qEL2futxRj3xP5waziHoMfQ2ROdB/m0A4C8eq2IZRJ9pIODuk
	h7jV9g53aewWqcQP8VE2Yfo9XhFNrtrwbmEGAFhP9EiuJJczyavbpYFRMGiy0QmB+Dw2kM
	IkXZlwy34cuSkZvs8hmxYWSalQQHj/w=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-K0CVQSXgP4i_oze7IN5LZg-1; Thu, 29 Oct 2026 14:16:21 -0400
X-MC-Unique: K0CVQSXgP4i_oze7IN5LZg-1
X-Mimecast-MFC-AGG-ID: K0CVQSXgP4i_oze7IN5LZg_1793297780
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3692c5b061bso6556846eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297780; x=1793902580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGCAJjCLhsAMNr80slCwUFe5tvwX7ZrzHAvRFP8FkYE=;
        b=CAZUOY05/XO+N2Zkx46MVbF4Sp6loMjB0pqzLS97jY7wusLufmdgNRqVG8C0HgFtOx
         7JM1IM8SrugOthimf8wUVt1dFHbGqBV74jvhRKb9HMVaXErm0nxKGHOJ0BEz3gnMyhnY
         +u2Jm3hfYOsoWBMBc+mRSIQjx6y4HlEer7Dfk1uq2qtnOBbG4BQwjxWXJovETlTyIx1n
         2bbql/y6Sk5zcWvXXgiUqiCGswB80gjUzPlUBQexP1bRPofB3TwEFom/doizjDwp0xmV
         +KefWfZW1Oq2sLSRoJcgQQFbzWz8VYC6hLJdJFlGd9iO0Ur28eWjPWFYx0UuJLZbOoNl
         +noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297780; x=1793902580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kGCAJjCLhsAMNr80slCwUFe5tvwX7ZrzHAvRFP8FkYE=;
        b=i8FtQRCNmxmu79CtKm2ixJfHY+d8aXpZekk8m+TUMi1+hdEmgmZYqOiJtOZ/9UPU78
         whxiNJBFST48Ecio7B2LvZobk0DVtDt/PxSIQujTkQyJwZ6/P6RGB8sume6ZI7osFjcr
         hxPhe2QdPoAvfXqzGMS6dawMaDORCMQmA3OjwyFmUjhmyRrmqdGjJpbh+u8Lwg+Kjyee
         12rciP2owevQp3FE+4epG1PgZlOOMPCTB0DGZT7sqKNkcpbJU6ibYbWV5nZaPq235POD
         DGNNOBtCU3ngH1j/sXBzpnURurwVxvCwfQQ1gV4ZvU06SFfJZx0CCOOHmfwqkbq2L9ta
         q2KQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6PsdC++NQNjz/+6QZIUntjPGe0Ue1K5FG4OSYEYYJZ21me+Tsr1PJ7NLOerQJtAcrKiiQ7JeCtAnMej6oMsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0p+a5E/LlPkXWWA6zZ35btV5vr/ZeUHIzxYJx8Cck8K21Q/E/
	J+38t0WxzivFyfs3QB8qsLebEF8BXhA0/TZwSUXtaaQ0WCbioLLdKS5csLepCUiV1GUnGq3K96H
	wLtiZPTlWw4JzC2w0mmCsde9JBjo6pPRwoV3nCOcPYaVEyIvfI0RrTeAu8cidXF5VROhszQ==
X-Gm-Gg: AYBFou1/NBPAF8VNwknkTgx779zmYIlUQKpLmY5U9dXsCwSTEO+5y9KrgA3CTa0U1vt
	aRRpCvdfKliezphnuw/CxubOiM33rvw+LzwSaRx8UDfy1l6nbnGZgHVOoraKe7dgExcNJCglPLY
	XfptR08C6vbmxjq3bE01ehRsDuVjcXvdVHrGcryAskdcBfNVU5VcOmAfZjiZtTqyFYJTxeqdFLG
	m/5bG5C48qKbuiACxxiYAGQ/KMWwSPZBo3czj9I7YUM5kpci52QAbplIAGeprT7Y41oRVUMej0D
	JDbS5HtiI2HRCgRT0DauPeyXtpdj9PnGVasSPSkx9KxAUOTwrOUAtz0u97aKQ0d25LbwWGB/Kpr
	EgFBXA/SuOJkAhrS5HYxFWtn9opwZ6W5pqfPGcg3sWKdmK1W6l1ba1IhezPxS2kOKro9nucQ/5j
	SWg9FFzKJlzddINw==
X-Received: by 2002:a05:693c:42cb:b0:35e:51d6:9f6f with SMTP id 5a478bee46e88-36a423bf856mr219675eec.27.1793297779727;
        Thu, 29 Oct 2026 11:16:19 -0700 (PDT)
X-Received: by 2002:a05:693c:42cb:b0:35e:51d6:9f6f with SMTP id 5a478bee46e88-36a423bf856mr219626eec.27.1793297778887;
        Thu, 29 Oct 2026 11:16:18 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:16:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 6/7] tpm_crb: Factor crb_send()/crb_recv() bodies into helpers
Date: Thu, 29 Oct 2026 23:45:40 +0530
Message-ID: <20261029181541.99505-7-armenon@redhat.com>
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

A later patch adds CRB chunking, which needs its own send/receive
loops alongside the existing single-shot transfer. Move the body of
crb_send() into tpm_crb_send_no_chunks() and the body of crb_recv()
into tpm_crb_recv_no_chunks().

Pure code motion, no behavior change. Also fix the block comment to the
kernel's preferred multi-line style.

Signed-off-by: Arun Menon <armenon@redhat.com>
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

