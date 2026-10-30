Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390829;
	b=wXMcIt0duaXxAfJnkuIcpCw0SOGgMEBiu0qJKUMQ9FpQPxxlZ2UGHUib1bndCQ7mCOcv
	 BL4rMLl4LDi2ryz+itRFJwQmq63aSW4gPfdTIIaLHEDDpNCXgdU3FHE3v8lCVnjvrGROw
	 7b0uSB8cA8412Nr+LgLoWCpCMbuppkE2NMJnSLnYiAfsNO0rKrKPgHlwuf8EFrajPYpje
	 u3pGGnrRAIgFuPmwiMq+We875b/GGTJiIAwdz+cCXQLvi5vX8S7N6S8TyRKC7bss1/PIz
	 9yviUWJllgj1e3uwucPk8xYNsftehPRKizL56Gtu1a3M63jgeJHYZeJ4tojWsDBFtpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390829;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=diYKtmvUk6f9EGCvKIL4rcZkTSpTp+pswHY3Aid0FZI=;
	b=hvdYl/6ITvcUqMcWSqox+qj+aM9LwDmKyHRIJife/DrL2p/LTWrGCx8Jn30BKcIqafm0
	 uBwjKP6FK2dkH6wDbe2muDc669TI8QU2sObhIVvXvy1LGMnh/kEaJ2StnFyS8PEbJtFSE
	 r67Q9ksV0C0n+ADtMV/+HSn1qgGcCTmjQHB0dWHWEkU4DMi6KdWThN3KTYw6xFSXkr8+8
	 dhqtLJyCSctukqbo3FdzWGsef4faSKFR3feqaOL/yiCmFeIsPfCcxL4oPPf0QhKWYgLOd
	 N9PEzuDMLDSjVZnZMW4F7pHkUCfyAbqZGMecAULlI1WCRFguC+e4f/0CLI/gP1FQ5Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WXD/pDss";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KF+wP1Cy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887C606A31E
	for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 20:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1887C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WXD/pDss;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KF+wP1Cy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793390828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diYKtmvUk6f9EGCvKIL4rcZkTSpTp+pswHY3Aid0FZI=;
	b=WXD/pDssKw+JBRQQQbFQXBI42HGQkl2oxq45RGpmtAZdzg+AepsOvxBbSCyQ79O/IY2ZJl
	rUkjfiqF1/eXUQnuKCiqD8PT+27mOxF8EyHpH4LXZjKpR1k+wMU6CBxw1HbEnOdpJwam+G
	pnppLZ8AKrRQs6JQZ/ildq3Sdzf4MZE=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-8iVj9-ypPOiITZouhPEhgw-1; Fri, 30 Oct 2026 16:07:05 -0400
X-MC-Unique: 8iVj9-ypPOiITZouhPEhgw-1
X-Mimecast-MFC-AGG-ID: 8iVj9-ypPOiITZouhPEhgw_1793390824
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2511796eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2026 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793390824; x=1793995624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diYKtmvUk6f9EGCvKIL4rcZkTSpTp+pswHY3Aid0FZI=;
        b=KF+wP1CyY+ekATFTzvOVFbPXgD+zSIGY3CPkMz+vxsKmSuJ+ICTZvkN8Lq6W9LU6ya
         rHW/FS/HixbUBIx3cn58oPMyGhI6pf2xTs/ICUQVFS61MRX3Q1Cp6vzndxGGvVCet5qQ
         yV23bIqWN56rRhVpz7I9gDqRIiIoohV0TlD7PwsyO0ftoGRvUrrmeWj3LK+pJ0atY0tm
         3qoMYcPD2IrmGNS+WSZ/ufy1crhR7/p4VzpNOpk93+sN0eryj4s9y95ofDcGUlyOZnZN
         bk30rO927kGGwnF2Mhzx1nPKoPaVFuicYR1+lCIhtOlcWsBPiOn+4tUxFx3M83Oi+4u2
         7Eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793390824; x=1793995624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=diYKtmvUk6f9EGCvKIL4rcZkTSpTp+pswHY3Aid0FZI=;
        b=bnewj5glSyWI65wtWZsaaEpVuKcOR4Ydcy0do9iuYG83/U1yeRsHK2dOUPi0Avf4Ve
         0VBOPozdunxwOAYjPSShNwBaFU//OGU/dLRMtny51LsOlKryZRJUSUWWuLQC0vTkv0SK
         3oJEeRiwylIsJKlxAWjgzf5aeU2Jxhru1GzrrEqYXrmG00I+2HpmB98LyUDnp4L2vAi7
         xP7Vxp7oP2Ahr4YZ2xIgVsEMx66ryoAxr/gusj6/rWwrMJhzw+83aqacQxEz1UAERMg2
         XgInsQGJnSpCfSpHeerAcwxYG0jRSTckbi3tb+O0CSZK3EPRHQokr7rVOlTnVIh5sYke
         jj4A==
X-Forwarded-Encrypted: i=1; AKwUvBzBnZPrYNagMHKxOdq4kw1SLbOYjWt2qv7a5O3HRUt0j3ACSQCGJJ+vw9hr61Dgszg7uVL/WWkrbuDseE7HyLw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTWi/pJw6kpzKbXpQLt2wajYr1NJJZIQA8xyIKBPCFfi2iIuNO
	Istbxs28ig8vEr1/fIyMyRc2gLQK9ZKaupyuHNQOxMk5b+14XcDQhvcjTmAuzk4CdNU20vloNRa
	EQhtMSN6JiQXLlPw9jwp3BO/Cm5CuOCE3z7SJGONekw6e4bKlCjRRe9M4/XnldyF5QAyd+Q==
X-Gm-Gg: AYBFou0odPp1MtNXR/LpGUmROgWGrgn+RsAnNBUYUDW+Nwpwr0xMQv54dRvGf3kXOiM
	6n8T4ergDnImpVQNo1IW8npUqgoltr8hSGCvmR7fn0K7j+05n5BQZMAF1cdan21Oj7mI0nSr9gM
	gunjbN/Oj3KpffmUBsofCd7+L1tCVtaPVOg2sXSwYdsQ9d9uHTwkcv4+U+GYp9wID3ao6Qbj4kg
	wBXl70Kkp8eEkpKqpBfx5SgKH/H8Y/xenyqM/vWZ2Jmv7oRkGU/AkW2u0/wTKOimqdlv1Rax9N6
	7PY/+YLrdksRlZaOVo0xW5Xtt4mZdUDxmPaUASvI3AItNe5Fzs5yqD3k7bQQ3UhTccwrAnx8erI
	SrJ36dBZIPcbt6WX6OerxcvQl50S/KtZZziPj2BJ5TdupnSPesrAp9yO+2OED7XGvTtwUgw0bqS
	9LWZUQec7gvzPB/A==
X-Received: by 2002:a05:7301:1886:b0:35e:6eae:c01a with SMTP id 5a478bee46e88-36a4237d9d5mr4756045eec.19.1793390824141;
        Fri, 30 Oct 2026 13:07:04 -0700 (PDT)
X-Received: by 2002:a05:7301:1886:b0:35e:6eae:c01a with SMTP id 5a478bee46e88-36a4237d9d5mr4755998eec.19.1793390823358;
        Fri, 30 Oct 2026 13:07:03 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.47.195.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm10581834eec.29.2026.10.30.13.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 13:07:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 2/7] tpm_crb: Split start method into a separate header
Date: Sat, 31 Oct 2026 01:36:44 +0530
Message-ID: <20261030200649.357508-3-armenon@redhat.com>
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

The current implementation handles different platform start methods
(ACPI, ARM SMC, and ARM FFA) directly within crb_send().
Move this logic into a new helper function, tpm_crb_start(). This is a
pure refactor with no functional changes intended.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261029181541.99505-3-armenon@redhat.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 52 +++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index d76f9e30f036..148ef5c487ce 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -446,6 +446,34 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
+static int tpm_crb_start(struct tpm_chip *chip)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int rc = 0;
+
+	/*
+	 * The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
+	 * report only ACPI start but in practice seems to require both
+	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
+	 */
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
+	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
+	    !strcmp(priv->hid, "MSFT0101"))
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+	if (priv->sm == ACPI_TPM2_START_METHOD ||
+	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
+		rc = crb_do_acpi_start(chip);
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
+	}
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
+	}
+	return rc;
+}
+
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -471,29 +499,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	/* Make sure that cmd is populated before issuing start. */
 	wmb();
 
-	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
-	 * report only ACPI start but in practice seems to require both
-	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
-	 */
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
-	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
-	    !strcmp(priv->hid, "MSFT0101"))
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-
-	if (priv->sm == ACPI_TPM2_START_METHOD ||
-	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
-		rc = crb_do_acpi_start(chip);
-
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
-	}
-
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
-	}
-
+	rc = tpm_crb_start(chip);
 	if (rc)
 		return rc;
 
-- 
2.56.0

