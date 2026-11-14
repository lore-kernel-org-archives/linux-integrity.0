Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684884;
	b=Qo7zElQrb3TaSBvhfPL5F01rmVBYfyIyi0Nx6sHykVXU7QRDr38UR0oPpTLt5eW2XgbI
	 J141908aAtuAoUJGHp8t7m5orqmEROBU/C9YcuQaZpT14ujqCwWVM9x24CMjFDV8JsNRg
	 c8hx+SilCGq92SSb2Ck+2U8fQjHNV6+TeUsPES1UQ+AIiZDpvlB2cAXz4ra74M60bhpNL
	 tTbA2NxeJL3kJk/f8eRhlK100++qrlL2y2wSSVXdNc/E1uDVv4tHSIz4YnXNZ3Gjsc5/j
	 1t0TOAI0qyeRPt1ec+T9f7HvFy3JLZ2MD/0Rt77/OlVd0eDRpZ7N3DBh93ouFoNDIIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GqHSBBvuKVnGq+xQNg0Da7XlBn10HLSlZo3Xm5Uwi08=;
	b=DvVcEcLz1J71db9tixaSchd19+VQl94LVLC5Kay0oIfMxqSK8yDaDl/bJlk3DMogQCe1
	 nNdAH7VfGOf4xYxSrsWhFw9aM5iEDpv+F28ITNlC6Kv/Iu2O0QENl+OrXuAXt04gjMgTR
	 vosklKp/1qT1BiRcI7u0q+wnRDaSNoNFCld/FGkqq7pupPQGgCQzwK8Qdmgn1B8BgTLKD
	 9gV5TRZTuWE5gfpua68mP4QG/Lg6iFU97/7cRXOGt+SSxQV9wc4GackvjqieJEt8ATr+j
	 pSUNRmDl9WeZP3dOtbvrVNQPg9s7aozTyvO6tjud9H9P1ZLGkHgfcemd0KvDPRX7EuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HIqjILTQ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DD606A8A3
	for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 19:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C42DD606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HIqjILTQ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2041861a91.2
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 11:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794684883; x=1795289683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqHSBBvuKVnGq+xQNg0Da7XlBn10HLSlZo3Xm5Uwi08=;
        b=HIqjILTQQcJ4V4N5eYR7zuvO14EW2ejb6vE6C99S3QdaUOvuw/fDCBJijMOpVF1ltD
         Vk8QRg1/8JQHAHmU3D/PF4vWHxqAzuWLfbzbqPw0jSs1qttON/vIeJ6EXbK5qmbe/MJX
         qz3PqT0Kbcym0mbLJQ8djT71gyWpJvDXrk50Piky6iJRYtkcM9aqQYe1d9FiyXKSGXcy
         pQuMUSwYT0rTs5PazEYCR+K79D7Cai/ljVSSaQr7oZPKr+uBnCXF6ptoazJWGzv2nn++
         VXOiv8bytIZDYv7GWT2n7e2VYq7knCcdaPi58z2rOUamEM6aAeaD+/OTEH9dwsGTCcYt
         iYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794684883; x=1795289683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqHSBBvuKVnGq+xQNg0Da7XlBn10HLSlZo3Xm5Uwi08=;
        b=mU9HlOO8VvOy9OsF64BRBs9uFBJUXCJF31nY/j6CcWgTWrDCIic9uz8GNarCGO/OWB
         FzIbC1f/Sev2TWZj3ffpePRwPVV1/MjZoKEoO3TObtCBMPzDQlhY3qDF+lLoduyy29kL
         PalkzhSfGp5aVV7yuKclvjLPy0uqoMIFf3GE4j+2zXixEcJqJr2nPZ68aBoE0eh3qeuu
         oE4+g05wanwTz1tolau+o68myW0/T1B7efxwZ+/lVrwENQQEi7WoksUkCVzkrJ7lXGUE
         1nrKLohWOf5lf15CtsySnArQf9nB9Kyvs4NAWfy0slBLL2sdDpADFHqxUpPYlpT+2fOa
         XfZA==
X-Forwarded-Encrypted: i=1; AL+hErEhQnzv8E/aQhh1vdONM2VAIcpHUqpdQ6RBTMwGO+/f6wRkorAeMJAcErtjQIIDvYJMawv7nisCMHEBkCds1xs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ztz4kTEJWLL/Wz5JMonHxogkHx7ImpUzaABpXfeyu064LU8Vj
	bHamaNFA5/K49FzGmJqNV9k6QysI8OqDip4loxP2S9xpzleaf4hZVawd7rDFtA==
X-Gm-Gg: AYBFou0FWdClJnB+BnWXG52+R3KloaBO3yga7xZXTlflECB+3aboxBfFhYpq2T8GC1X
	mOA3C3F9IIW0LBCOFL47PRvxBfvWPUtirPKrAMKFvOXza0WyP9QsWHq2hO9RDaLSZ3eHX7il0sK
	QHOzRfER9iUaxTLKuTPV950taT65+GzhTRI8Wd3LF6Mw4GGX6clK+NyOXUNmiteKaLg3ZQ1UteB
	KQPwkNIQmR4fonvfDys+i2IIGuMOz4uZCA2zBFg3trldK56QNC9uvSMOcNuK8ofvAMzeeCirSlC
	QZq3USUfDkQTCtAjRhCfvV6Y6c9vgQl7v+GDkRQoigOTwo4yPt1o8obU5AlYI2QSfdW1gGW7gWy
	holvhUa5jVqjresgRVpNKCL+FX1tIsF24WukwjUeblduFU54/nRUlxwh/fBdXfOcnGQ6+OGHHvW
	+Y5cGI3Xy+62LaMaZ8tVYpm4BL+sKgVs06YwfALu4nXDLtwMIfOezHbld2xFzDxclRSf832xMwi
	KiTNNeGnITQBLP9QMO17ruSc3bM3rGeFLpqdU9Phm9uUi1YlcDkoV/F1k0LbmFOiCekdBigzSFY
	AwM/oVRaw8UFH6VwB3fPDlQbAucmsIvZdDjqYIlkWis7HM3PhqnRq0VILkPp4oUoMVjcbVyeudK
	r1Igm+xvUzXh8DnjcD85AdVgWcwYXvWBXVIilrgsMb3C4yGLmSaEnrKJBz6QXisqck8VW65MhmQ
	FZH8cyMzC0vQYgRDfOUwZA7K+UIsgb7PM74uUwfXQK
X-Received: by 2002:a17:90b:58f0:b0:3b1:4eb6:b3a with SMTP id 98e67ed59e1d1-3b1b081887amr6439067a91.8.1794684883214;
        Sat, 14 Nov 2026 11:34:43 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm5093969a91.1.2026.11.14.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:34:42 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v2 4/4] tpm: tpm_crb: Use cached tpm2_acpi_start_method
Date: Sat, 14 Nov 2026 19:34:34 +0000
Message-ID: <20261114193434.117714-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114193434.117714-1-sidchintamaneni@gmail.com>
References: <20261114193434.117714-1-sidchintamaneni@gmail.com>
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

Check the cached tpm2_acpi_start_method value at the start of
crb_acpi_probe() before mapping the ACPI TPM2 table for CRB-specific
parameters. This avoids mapping the table when it is absent or when the
device uses ACPI_TPM2_MEMORY_MAPPED and belongs to tpm_tis.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm_crb.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 4749a9183726..c1c2b72459a2 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -945,18 +945,23 @@ static int crb_acpi_probe(struct platform_device *pdev)
 	if (!device)
 		return -ENODEV;
 
-	status = acpi_get_table(ACPI_SIG_TPM2, 1,
-				(struct acpi_table_header **) &buf);
-	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
+	sm = tpm2_acpi_start_method;
+	if (sm == ACPI_TPM2_NOT_ALLOWED) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
 	}
 
 	/* Should the FIFO driver handle this? */
-	sm = buf->start_method;
-	if (sm == ACPI_TPM2_MEMORY_MAPPED) {
-		rc = -ENODEV;
-		goto out;
+	if (sm == ACPI_TPM2_MEMORY_MAPPED)
+		return -ENODEV;
+
+	status = acpi_get_table(ACPI_SIG_TPM2, 1,
+				(struct acpi_table_header **)&buf);
+	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
+		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
+		if (ACPI_SUCCESS(status))
+			acpi_put_table((struct acpi_table_header *)buf);
+		return -EINVAL;
 	}
 
 	priv = devm_kzalloc_obj(dev, struct crb_priv);
-- 
2.45.4

