Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3713EFFCB
	for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879692; cv=none; b=S3jloJw1PGhw882B8jDg4SKCOLOGk8UUHb3HQ6vp52pVi+TlqowVi70uB5HQ2BFEnVe/qCSHWypti7CdbKjNT7Autgtq06vo3Dg63RbWANbRR6isuSIPrTX9itNWfiAjcu0EnLCgrPic8VlzoOcfmHHaIVwPU4piSGlIC4DykvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879692; c=relaxed/simple;
	bh=AEsIZBvhIg+ptwqhrgMw5/o+SifZBkqY2LGhfABVAgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgGs/VIQHJ3PjWimDWR0n4VP54twdhpPibuvctM7adYW8FhZOPFckoSotZ1LHGKAkEBYzrI0o2TmrKvYpY+nBSWGkqw1nrbjWdieSVPN+TJsbwd+Y6ErqXBqIqUaWX9hTAz/ky1VK0GqRBKa2BveRQSboPW9rZchSRwYkS/J4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coBeEVvs; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coBeEVvs"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso402583eec.1
        for <linux-integrity@vger.kernel.org>; Fri, 15 May 2026 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879690; x=1779484490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=;
        b=coBeEVvsyKMe+/GM59nTqRYYeTG/lbe6vF3i6caGpAAMgihF00MSEWu2XJ9Ny6jiAV
         m2O0yfD6B/RfRNMbB66uXqWrHopQsmWEwHWx/7/JFN/BpLWdDXDlnskqQSzdC1TMXDoL
         qNFJ0U7zX5STDkUASmgJZz8OM7L4az784r4w5ECU/JPafOUXY5BYTMWf39OwV/qmNtad
         SLSWqznff0nD6CJyrzCpNMrEooGH1nnuwhwIg5T4pyDwRQmb3f9V2jek6ebW8aQF9BUO
         7075k5g8Ejy0Ihhy6rSwzmudgJyJfdCoAvIe0xieBbc+Kt3FX08LITXTSmOnbAsD60yb
         xjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879690; x=1779484490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=;
        b=fdPyJe1VhlnoOC8fdEkwwLUAvzcLPcHid1Pmk/O1PKQk99Rst6tc4ldq5qb+/5d8SW
         x3EtNOJXkXCDo/5HuBx32+ZecOPxDHU/lQUuOKZJWmzllJraMdrIQo7TVbZ8IDYHePkU
         tEwwwGnx26v8+qBUNRJTYshoueWKoXpoMUkZoba08a1aeh5FGnz7fb2hwHdO9Ys/Fmr8
         Ote9H7UAfC+HKpUAQZYieWsjgSvchhC57FPxu7mlWeT+6BbFST4rpleJb7JcCXnwU7Po
         ka+G1f+XypacJV4XqT+sHQ6VsDd8GZRuXxKQgeviLn36vScgkJCWG/m+WI+OlQBvk6/k
         /Z6w==
X-Forwarded-Encrypted: i=1; AFNElJ/M7mCqqNK7UkPDDU60iSSwsG2LUqMX9i6nKYe9T1m5gTMhC2WXiEKXZ9RkbQl8HE+w+Ue9Xlm7TlwNnLy+hgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJBC2x5oqPm8S1fSGiKMWBN4uzCDQIxWgzUIP8CtGua0TwMGd
	VHYEck728spkMguRzfXAdLNRhWqgH+j9VOSR3plkDfqTPuvrwIFM7Pb6
X-Gm-Gg: Acq92OFw5myZ1WDo+00Pi4NhknSb7b0yE3QT3cFaxnAqkns3pvY8/TcASXWIwEKdG+V
	T32VRzDvholvloV3v/1KTq9unyhOl/SUIZX1G6pCDd532cJHgPfIr+bxEttgitkjDgO28BdOkU2
	aRtRzsnTQVLTjTB7SBkuCKbyNzR55+o9gtWoITs16+AcQFMmFbZwwlWPrphrgdKCWhZZ4UkEz68
	Yx9V0pHerGev/ERFYG2S5ddc6iAIq3OJAQzJL9XSZzpSgLt0SB4B/0k8uRdL5LUNrS2oGoybGf3
	bdoanELHqsKM4asnezpvPUYOAgKCnEX84jcFveRT8chAH7XWvlMVihQudH9jZfxMsOuAoMvoaEn
	LoTb0ltUP9LsfU2HjlX4vVmKTakkNS2wgfK5ICu5ybAxL1B23A0HxWSTM4CTHkoT+8BkCZ08vqS
	mhSmmmZP7reYEt2gbWMZQu50krbebmTHw=
X-Received: by 2002:a05:7300:4307:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-30398655963mr2890920eec.21.1778879689799;
        Fri, 15 May 2026 14:14:49 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm8120311eec.13.2026.05.15.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:49 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 13/38] tpm/tpm_tis: Allow locality to be set to a different value
Date: Fri, 15 May 2026 14:13:45 -0700
Message-ID: <20260515211410.31440-14-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Provide a one-time function tpm_chip_set_locality() for setting the
correct locality needed by DRTM launches.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-chip.c     | 35 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c |  2 ++
 include/linux/tpm.h             |  4 ++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0719577e584d..a9620b27b63d 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
 	if (rc < 0)
 		return rc;
 
@@ -343,6 +343,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->kernel_locality = 0;
 	return chip;
 
 out:
@@ -658,3 +659,35 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 	tpm_del_char_device(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_unregister);
+
+/**
+ * tpm_chip_set_locality() - Set the TPM locality the kernel uses
+ * @chip:	&tpm_chip instance
+ * @locality:   new locality
+ *
+ * This a one time function to set the locality the kernel driver
+ * uses. Returns zero or POSIX error on failure.
+ */
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
+{
+	int ret;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
+		tpm_put_ops(chip);
+		return -EPERM;
+	}
+
+	chip->kernel_locality = locality;
+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+	tpm_put_ops(chip);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 70aba05f4ee1..cf6d929ce5aa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1125,6 +1125,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c3..4a26a49040b9 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -159,6 +159,8 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+	/* the locality used by kernel */
+	u8 kernel_locality;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
@@ -197,6 +199,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 	TPM_CHIP_FLAG_SYNC			= BIT(11),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(12),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -244,6 +247,7 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.47.3

