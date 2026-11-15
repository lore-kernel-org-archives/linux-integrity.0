Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706501;
	b=mxcOSluLr/jUtHMUAqCh+rUS8/4LQ4EJ60SjyUd3YJdUQWwhlvSxQJbLSCcsdCXF0iaZ
	 OBc+Gw6thBG7xSbsX7yf9EM8tjRPP0Rp8+6TbEB+V+Ky8M/FpmJMAnYGwlKKq8ZLOxP9Z
	 fC8aZ8LwFya/9MPYQVDUIzGNLnE+6nGDLWSInnNX7jHmUD83noONXYxfrd14iQ4n8o6C8
	 8BRMk15XkPk+5PHK53a90uvEOdY4/JpCCPRuqGMYC3W0JI2rjZEVkbQgPc7jKYWHDi1Or
	 hR5iwmgL1ImNoojXfUA+nqBjqqDu1NhVhZF50zejDQK4ogEWYBt8+BRpaUKTx/H+1Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CRGAUvOGM7cXeBiNifNubn0WANT9Nl+imZXj5mUQRV4=;
	b=KSnEfjPb8VXX4Cm/sORzfwsckHe8muMPuZ0Ab8UHUe7OF/9cpOKzaJZhjRJznC5WL9se
	 f22kVJqpyuEEghahbHOrfr41UQ3OJiPIAMy3KT3DQ4OT4CaoKSX9qJce+PhExDyciGhGa
	 h48BfhGCApoJ9PSyALUNsB4jMWJ3smL7ECVIXWGPhYlUxd3npfjTvLKPTRElB04i6SZOx
	 pSwtPaaZ6y1tuZBnHTVSc8jDxxQA7hNTt5xKSRcp2RlNLhTLrNFV37saj7dOjQySNl7aB
	 rVYqI649RLkZRUkWBa7bcxef0HEPwhzFjRQUsoeqBnNFlTwZSYKrjpmsyj1OU9GUgQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L7Z9GksH;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBF606A883
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 01:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66BBF606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L7Z9GksH
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e95bd1c14cso32204615ad.2
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 17:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794706501; x=1795311301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRGAUvOGM7cXeBiNifNubn0WANT9Nl+imZXj5mUQRV4=;
        b=L7Z9GksHVQp6Gvhb1y7Dp1+wrzgzxQeF609lfKbG8erVBH8cWqLDDYDQ+LCpK/PpMe
         eFLIUVzl0Dt6RBXN01kpQO/iyjLHhudWnfNpLN01Bk6f+0DOlzg7sJUDzeeD9byT0vnL
         2b0CgqzT1w3QRw70UtYWIMcxpJRassQU4JXxwjnRjw+LhfrZ6aV6WPpfpvA3H17+fCgY
         Z+Wqp3cZHgmjZ/VsLwiuDvmhotmDocgHyC9tnp6pjKdbeZgsMyDX/5go7INkFwuz8sjR
         SR8LZ+RvnCS6vfvIhD8JIMx4nu6978l0bLUxsYg251DBDzzQSOy6gB+QUIVsW0PW1B0b
         0Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794706501; x=1795311301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRGAUvOGM7cXeBiNifNubn0WANT9Nl+imZXj5mUQRV4=;
        b=xuIhgx+TO/d4EG60xDzqMmwVfTrHLZEJR7Kexsj5GNKYgeI7XE1tPuoPMmq+8XU6rM
         FE0zRA168op1EGMnZE7HW3Gwxk4ZGpoKBGYnf+/D95+Gc7P9d1cDcr+Qt2/6N+tPk3QJ
         1c3pRl4l4BeQWWTr+/JFDZHK2X3aOI+JeShBdtYARsf9Ulp+hi2Alty1BxgxcXVMq/08
         5zIeOH2NhFvgIiTEqk9QGgo1snijdAyrasCi/5/wcLrXM5ndoSpxmVi1ARfC+kkElzIo
         Nf7OMXcvjRr5omobE3D3zYf0Y4cZRy0zvsRKxF53Uvhmgrm4Fh/zKWK9pRK1NKnT1h1o
         YqGw==
X-Forwarded-Encrypted: i=1; AL+hErHFoFIDdvPqOujiE7dBwze7ViTKpnbqY6xGMrLvY3ByOUIA9Pm48N3FxYR3MtPee0JhnjNR4WXw8/WFAtLWBbQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aS9ocrCT1Nw5of9mhcOdRaqE74d7h/75VTkE5A+XEwrgbxf5A
	4Ne739PHOGaPZwOWEP2R8CQ17c2o8Io0ZFbZPx3a0EpXzF2bXGZYFa+2
X-Gm-Gg: AYBFou0jI93IuQ+7TdzDT1JkFGqZ1GYh8Ep2YWcN8kQ6HCKFBnzwSU4Oc/nFhBlJQcY
	/Gg2/QHFhoOIjqzC/hffU3fr04jc1BQtiGxJAW+y+ppvxF6NghDdGK60vOB1ChbskfnaeC/ss3u
	+7/lpU6zTAh63n2i5AB/kHB8M9mZXiQjl6n903gdlWUUJdPP5iX70OBx/OuF5ksVMDA6zEzahaT
	u6goe8c/HAuz2TidgRa7RJtOaZlz1ebD2pqI85YlHEeMxaiPAgAeK28mtcMdkMziUnzD7FgEWyZ
	DICGi2oilFdMIqRqG9Mg9RfoOrtQPAyuBw5MH3BfGWWaIyxpb8cn094f5BfCTuDY8E2WruffhKQ
	rqkQVihFGNLZg/CZSU1DAA+NWS2nnx1gusSrXT4WEeDsyss+qGLqUsLu9Xag4f4o55rk5eDvGqK
	lOfwOwnEbr3U3/PeI5GMuo+TkDvziv48U6swmUjuMOPkdgkipxbUg6DTH1OHtNBJZNgfUZfHXJp
	Uf8T+0bgiKZudUDRqqbRnf4/EulkDF10+16V1pLUdXl0CNyRKzwkN78XsCTsoGsgUlXOhWFKg5l
	NfPqWt8y5EhwsDKP41B11KRyw/NpUKgr/A1W+fkS+3Osuxpq2zvjTJ6rRD0gG+Xa0n4hjmXGnX3
	Iv1WMos+dKQ4tCaxJjP6pmblcSvi0u8RKHXGTN6q8fgsnLYkJWMUYP0SkQjXGNM4icQPduYxLeA
	sPwaDsy/gUUQJEd28HmmbXOowmrPHuu0jTOwDocliUPl0GiDUf6V/nBwD0xGuK+g==
X-Received: by 2002:a17:902:e5c9:b0:2ed:84c6:5d5 with SMTP id d9443c01a7336-2ee0de3e85emr70675995ad.42.1794706500714;
        Sat, 14 Nov 2026 17:35:00 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75dde9sm23671935ad.22.2026.11.14.17.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:35:00 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	apais@microsoft.com,
	rachelmenge@linux.microsoft.com,
	hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v3 1/4] tpm: Cache TPM2 start method
Date: Sun, 15 Nov 2026 01:34:53 +0000
Message-ID: <20261115013456.212141-2-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115013456.212141-1-sidchintamaneni@gmail.com>
References: <20261115013456.212141-1-sidchintamaneni@gmail.com>
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

From: Jarkko Sakkinen <jarkko@kernel.org>

Both tpm_tis and tpm_crb retrieve the start method from the ACPI TPM2
table during device probe, and tpm_crb_ffa also needs it before chip
allocation.

Cache the start method in tpm2_acpi_start_method during tpm_init(), log
it when a TPM2 ACPI table is present, and export it for the leaf
drivers, defaulting to ACPI_TPM2_NOT_ALLOWED when the table is absent or
invalid.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Co-developed-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e0385b16616b..c18b060d7da2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -534,8 +534,17 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
+#ifdef CONFIG_ACPI
+u32 tpm2_acpi_start_method = ACPI_TPM2_NOT_ALLOWED;
+EXPORT_SYMBOL_GPL(tpm2_acpi_start_method);
+#endif
+
 static int __init tpm_init(void)
 {
+#ifdef CONFIG_ACPI
+	struct acpi_table_tpm2 *tbl;
+	acpi_status status;
+#endif
 	int rc;
 
 	rc = class_register(&tpm_class);
@@ -562,6 +571,18 @@ static int __init tpm_init(void)
 		goto out_unreg_chrdev;
 	}
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_TPM2, 1, (typeof(tbl->header) **)&tbl);
+		if (ACPI_SUCCESS(status)) {
+			if (tbl->header.length >= sizeof(*tbl))
+				tpm2_acpi_start_method = tbl->start_method;
+			acpi_put_table((struct acpi_table_header *)tbl);
+			pr_info("tpm: TPM2 ACPI start method: 0x%02x\n", tpm2_acpi_start_method);
+		}
+	}
+#endif
+
 	return 0;
 
 out_unreg_chrdev:
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index fa554c5ad80b..212ca2410c93 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -100,6 +100,7 @@ void tpm_sysfs_add_device(struct tpm_chip *chip);
 
 
 #ifdef CONFIG_ACPI
+extern u32 tpm2_acpi_start_method;
 extern void tpm_add_ppi(struct tpm_chip *chip);
 #else
 static inline void tpm_add_ppi(struct tpm_chip *chip)

base-commit: 7e52fc165aa50e70e8df3c879d04fc0ff1673d4a
-- 
2.45.4

