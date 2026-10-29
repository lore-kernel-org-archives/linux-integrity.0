Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297780;
	b=miGIEgShs1WRgH/UsYEq1AGVOWf1RGmgRxwV5ekkAouK+RkaSfqKN71qJfZ8EFCGhWeg
	 mQbxh/9Baxoq0ABHnvjXagtBOpbUPYK7f9AXPVRyIFDKNIdDcFg7rVDN9cp8F+t9+/b5w
	 tDIeqdbdEfTXU1amlKCj21HzY015kRabzmiDSN5YvBDA8JveRgIFrhhREGPOq9JRxgaNy
	 aBVVzsFZGYjUj1T59OTx5d1dnxLSu9+U2i0zWD1v++9MYvzEkLzWA4vFEXYI5yH7wTpbv
	 i2qpA9IdN/DhpF2q48na3uraE+LNPJYs2iWGnfhmfnQK9CmwuGoYh3Nd+vQyhsuMb4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297780;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2tS3eXI+GYtBaGafTHoSTalVWek/DeALoJUQz18kIds=;
	b=KAkLu0baDB2kzhQTriE2If7AnG4+iSpWUlAL3/v5BzmaoluFqsddyX3nYq/TUjQo5dRQ
	 T5aHEVK7Swe50TDX1EyHubSjvOAKWMkLNAAK4Sn1ufdY3/Z0L9jv9Jw4a2579388KBBwD
	 pl+cQj1xiq/AK2qCADqwMaRL2Ca1ttM2Qqsqpo2Vd3kyzt5r6T1Sy6xJhvJd5vx5L3XqJ
	 141fHWcLF4CQXDpj4zjbbvpKt54pujpOFhkiO2102+veKe05lE0+N5M0rmdg+ebYLz6V5
	 XomuT1vmruUPdxtcnJJ5PAkTBm5o26ol6HNjwTbiKC6lHmQIr9ThpsZNB5Q8f7JQG2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RodfbLdd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gO6svSDM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D342606A324
	for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 18:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D342606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RodfbLdd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gO6svSDM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793297778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tS3eXI+GYtBaGafTHoSTalVWek/DeALoJUQz18kIds=;
	b=RodfbLddFfRjWJht+X1PgqQ7OLrYg/N4iYLxLkvL9+m+vdeBkIdrhEgK8Qv/k0aULztwM6
	eJVK9fsDmkpxn6y0I3UI7GGcPXqHudmi85ykbD3t4vp9ostMUa1odQYFsYzjd4i7E24WLs
	nax1fVdFL/8eVE7P6s3denyGajuYc/I=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-qlcZAh9FO6uv1wGy8yBoHw-1; Thu, 29 Oct 2026 14:16:11 -0400
X-MC-Unique: qlcZAh9FO6uv1wGy8yBoHw-1
X-Mimecast-MFC-AGG-ID: qlcZAh9FO6uv1wGy8yBoHw_1793297770
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3692c5b061bso6556548eec.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Oct 2026 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793297770; x=1793902570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tS3eXI+GYtBaGafTHoSTalVWek/DeALoJUQz18kIds=;
        b=gO6svSDMstJKXH79YN3eBGIaWp1QpExra+J3d5VqdakTzUhZZRgDJ4bNjiKtpLUDrZ
         s2BtVDldJSCp4Q6OjBJUrtW/7xzoOuemLLXUh/ekswHVUPEmazLyjv323WCqXuiQ6Kwl
         1qySxlZ5RvHGAjidCv0/O00sbV+i6wyMkqgeNXLBE1jxnIuG50cFbogSNuISElFmbmmg
         hr+hcFJ0M/c3wcR4vZzVyQQenhalo7aqN0RLGnGq3zRkb6WeBOLYwWl1zTDp4M+wloyd
         N1RiNeIM/mCiPEjNnp+NUysRixZ4K8FVBxQRF13UBbPycyWi0O74VucLBtuET5OQWDfl
         cxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297770; x=1793902570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2tS3eXI+GYtBaGafTHoSTalVWek/DeALoJUQz18kIds=;
        b=2sMqzEd+/xwzwhOTPLm6Ji9LG1sMwRAvFSCc9iixI/J44raLeBcEEYy7p4RI6+IoLC
         jJe9sCwXg7qIfUgA5RSAsXmNKAgzydqqhZ+p2+VRLH9/FsXeeUDnaGnE49yRjWYkUs4o
         LxqVZQPmSvty/f37YI3hDCJW7hrS5JhUJyp6riam0QkIK3CG0VIgWCX/gD+y/4kGP6Ia
         iyNVR5MOtgDC9Cl8aI0a+LsiTI8a016mWyhn73fhxQM6HKJ0bINxfj0ggSZXaZEqR2/c
         3nLiQ6O9jHNqenBk0FCp8QCsc4BN3H3ihFBJe2E/6CIOzz+hzBd3Cv9vAV8p0xDI3ow5
         sDyw==
X-Forwarded-Encrypted: i=1; AKwUvBwnwSo0ojve5m49TAzp/ghoD4jUBYO+6eDJec09fN3MJKzJHpPGPgRovhLDT5M7A1/fF585n/ggZevMP3oRcDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwc8JuOKwGn+zDG0rgUgPpYVz3+nqI+jtNFdZPeQGE/PsbOzz/
	8XEE5HPtSS7zet2XLcqfeYlVgn6KSpYkomsjgJq/MhCPwwLDotiQ3utSOghRWCLcWfuVrztc/Ej
	V2jz19fpEBwVGpGcGNa9+PJFsaZXxEv7wvsAprTrpn5KjfjYrpKH5BvgReZoyZ+MfPq9mww==
X-Gm-Gg: AYBFou2HUQ7qRLmyaawF3yJxSe57+QTV95F8HQSaXTbckD+r0nYqI+x5gF94Jfmbfxi
	BHuG8Hk48+amkpLp1ljioHCyEu/XNnid9Iwb+OtGApOEvPD9E0NQaTWVTQbnApgUvjapdupm707
	JIQxENPhpxNXGQI2ShKJIv+re2TQJ/df8XTnWQMQh5bDVQqARqfOP9aF99Yc9f+TlyZStB97FpV
	Zndu+NsdxRsHrTrnpVarKYbdGfFa5ycO+5Pr37Pgx9FPyLxviD/LG6Q9jE3vYzPnsiwoLJxr6gG
	o0jDl30g1k1cM0O3Yvbk4jTaMeyfsq53DaCovFhpiftp3gTD8i0dwVuaAEPlNKwmimlx5KUwnVE
	+jYAPjSBpGxhvVocHRHyRjuM8pDfa+0MaEavwy3Xtx2590xD/4WaA/g3ZaRE6b7RsCqlzUVOucR
	U7QJiuf6h11W0znw==
X-Received: by 2002:a05:693c:6092:b0:369:f3b8:2c54 with SMTP id 5a478bee46e88-36a423f0f70mr215487eec.30.1793297769680;
        Thu, 29 Oct 2026 11:16:09 -0700 (PDT)
X-Received: by 2002:a05:693c:6092:b0:369:f3b8:2c54 with SMTP id 5a478bee46e88-36a423f0f70mr215455eec.30.1793297769000;
        Thu, 29 Oct 2026 11:16:09 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm259163eec.4.2026.10.29.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:16:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 3/7] tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
Date: Thu, 29 Oct 2026 23:45:37 +0530
Message-ID: <20261029181541.99505-4-armenon@redhat.com>
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

The current implementation of tpm_crb_start() is limited to triggering
the CRB_START_INVOKE bit. To support command and response chunking, the
driver must be able to send other control bits, like
CRB_START_NEXT_CHUNK, using the same platform-specific paths.

This commit adds the start_cmd parameter to tpm_crb_start() so the
caller can specify which command to send.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 148ef5c487ce..30ca8192d3a8 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -446,7 +446,7 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
-static int tpm_crb_start(struct tpm_chip *chip)
+static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	int rc = 0;
@@ -459,16 +459,16 @@ static int tpm_crb_start(struct tpm_chip *chip)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
 	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
 	    !strcmp(priv->hid, "MSFT0101"))
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 	if (priv->sm == ACPI_TPM2_START_METHOD ||
 	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
 		rc = crb_do_acpi_start(chip);
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
 	}
 	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
 	}
 	return rc;
@@ -499,7 +499,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	/* Make sure that cmd is populated before issuing start. */
 	wmb();
 
-	rc = tpm_crb_start(chip);
+	rc = tpm_crb_start(chip, CRB_START_INVOKE);
 	if (rc)
 		return rc;
 
-- 
2.56.0

