Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390835;
	b=iR+XJvEQ5mzKT24/Vf3c9SUWuF6Prm8xbEcR4VLMrzaODQEo4e8HBooRQq7dZ2g4VDY4
	 P47qLDw+r/VAmXv+P7Stn+2KMW5b+npuaKXVTVeScCm9nn2VqHDFh2neWhEhTk2iJWqhV
	 ECb7g43GcsH8jwlXhZOBJlJGmnSAr5N+UuSd6ReUXOSCMmOmrT907QSJD3l+fL4knuF5M
	 NVZmJjzkC96T1rrXChr11cHec/15LNhl8yfa+vaPErLBGMfxYf/Nh50RIKZSQ/GKHpQmm
	 hXQtRxrqWFtkBtAwtXG9hvBFOhntybj10GClNREWZzoCn2MUC+QHDjTV4MD4KndZFmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d+pX9N1kFcamoWGS6O2wutMA7nvNx4/Lu88LU4koO24=;
	b=fVmd6cbLcR0VKhZDfbtVkqvIM/Apbo92HEM2syR1jzjptwUiXGKxLD0Ja3Fs82iyrNNd
	 +syKpeGWBJZOBBhZ3dWqnQXXt1DVDGT8E7Rq6vL0s78COuA4r2l5KR8iJXc8X0k5FweIj
	 3TqqOY9IkqCi7H8cHjWE80TFcfrT2pkEqgkf7pf/wsD2JFhRJaX4Dpuel9S95WE/jsFQ9
	 2p5S3ZsfGCbh7HR/MN7gciwaLcB6RckxY+ygq174LIniu/aUelTCPprwVzzltD6XZKA2x
	 zAJO/fbQifx48Deqx0Pn5NS5pd+TGsi0ywctt1DAyVG0Y46ayIZfSuPnqoZ6XtfSyVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="SJw7m/c7";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Yh8fRN+b;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39602606A323
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39602606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SJw7m/c7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Yh8fRN+b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+pX9N1kFcamoWGS6O2wutMA7nvNx4/Lu88LU4koO24=;
	b=SJw7m/c7jnKZ66XhnkVGN9OW7tg/tPsTVd4oRYdy/r+Eo/bu8xkQNH/HM5JTqhm8uAeJQb
	mv12R+6ybms9fWSRCXi6zxmNHAB7gY3A9B0M5Ad255OsC/lOI0sBk4DWVRpGDId1rYrjet
	vJv77bRTuw7u4HW0IjlnVXTc8H5GdAg=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-2OETFeF3Pg-L2JKk86wMoA-1; Fri, 30 Oct 2026 16:07:12 -0400
X-MC-Unique: 2OETFeF3Pg-L2JKk86wMoA-1
X-Mimecast-MFC-AGG-ID: 2OETFeF3Pg-L2JKk86wMoA_1793390828
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c5aef2a74so4313715eec.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390828; x=1793995628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+pX9N1kFcamoWGS6O2wutMA7nvNx4/Lu88LU4koO24=;
        b=Yh8fRN+bcSSi3jnFjAzjdvj888KIf6WI3gZqrdSJrdwJHGETbcD1r4JvP7uF6td9Op
         TSlZAkkDEX43XE+FSj4HRJoKklbZkHslF5+7vDnqvAlzM76arX406Zr1NCHISsQFOn7n
         +EAQnzl3B0MfZouA514AJNBLAteHqeOiskvHlXCNIFpS+gJRvr85MqMNd4dUZ5iwU18Q
         54qpKhRBh86amUVXtOZ39TzqnhxKMgi0kncoSAIq0jiwT3N+Q8aA8lW6TAksddwn10Jb
         P8yAiJ+iiJblTl4+rpMG/q4oZbrd8WnfCYTJ/I2DlTuUXDov3VmLmEgbOMiO6itvJoGj
         GhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390828; x=1793995628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d+pX9N1kFcamoWGS6O2wutMA7nvNx4/Lu88LU4koO24=;
        b=Nu8+na0leyhllu3XnZuJGMzP/LYoyO2w/LvBO6cEJ5n+wpNAWbtFIhVP6X0nYTK1i+
         ExLvZP8WkKabgt6iKlPrVlWYlxqAQq9EFeF2iNuy1eRe7ipxBRNYyMAJutHrBImZssR+
         z7LtxFaaPXTGLkUlgdtbxUkFIvM1ycfeO4o4Y+ReekTKYu84h72GSV4jjPx5cHCNmq0z
         wz4G1hLZGfDXzqZfo0np26H69TcA/4G6347MIAHAWpXyoMVSafucxenAX5pqCLrt+w5U
         yS6JmTb6GbEjoIMfNXjd/vAoyaFPB03UM6IEuCvfx7mcO9AA5OgXGbdOTqgNBg6Uvubw
         X5uQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvNb5cYoeEB1Q/d6Mne5uapqMpzb+xgiY0V4726O3nyhaLcI9x9xCglvzC9AjB8wFfGB/2Q7jink9XCbwtAww=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrcsv4OMA8P8zV7zTWYZUA2xH9oiWdo7d7oXl0kLLOgDZ3drFg
	d5RPpeyhChoWPgLlv4duhSP8xuAVMjPPe7sT/Si9D2hxSJwpWHz+MWzjFc+zCyAEw9zQ1RmN1Uv
	vP6VtgYJJ7myzDwp5AY6CatNwQ+pCjowXPJi6ZcbArUm3Xrk1E7mZesVPngYRmCxlNWU3OQ==
X-Gm-Gg: AYBFou2vd11n8ahuhRHpnSzsHNthfMyocWmujPEysD5ObLOlHkhTKZK9r+DvMtYY5Kv
	7WiuMgrTEW3HdvtNkt9/H1S8LzIr+7FFOzYh9J8BG8EZn1KUHcNsOP4RJquenMbMawDkIMiCJeM
	soyW2mEytD4HZlZOV1WM3YCHKVBC8QF+IgXOshAxR+IdSFyFyrKeJaXvIlAYWi6JjKGYu/tMplV
	HDeTyjVkPCsMnZkSXsKW1IGki4+MFFM7WLlrUZI8kjkyk5Sl3wsTvAER/5tCNE40MBUj0iaIW8C
	Z8B+cwqe0kaqCxf84msQk0B/Um64+LtzuCOPTIsRcxLZXFkuSm/cw77TjxBEJGh+bTXiAh5s2Y5
	0sMhFHZCjh1BngnYE7ahTs4XMhmL3ZOHPXRNu60TOsc1qOboGmj21K6T+eoBt7CsPCwGOEpU5kK
	6tOc0mQU2rQ8FBlg==
X-Received: by 2002:a05:7300:c8c3:b0:36a:1b62:da with SMTP id 5a478bee46e88-36a42340be0mr4770731eec.12.1793390827538;
        Fri, 30 Oct 2026 13:07:07 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c3:b0:36a:1b62:da with SMTP id 5a478bee46e88-36a42340be0mr4770688eec.12.1793390826746;
        Fri, 30 Oct 2026 13:07:06 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:07:06 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 3/7] tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
Date: Sat, 31 Oct 2026 01:36:45 +0530
Message-ID: <20261030200649.357508-4-armenon@redhat.com>
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

The current implementation of tpm_crb_start() is limited to triggering
the CRB_START_INVOKE bit. To support command and response chunking, the
driver must be able to send other control bits, like
CRB_START_NEXT_CHUNK, using the same platform-specific paths.

This commit adds the start_cmd parameter to tpm_crb_start() so the
caller can specify which command to send.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261029181541.99505-4-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
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

