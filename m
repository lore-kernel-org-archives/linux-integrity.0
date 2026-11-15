Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706503;
	b=HP08CO15cUZInlRsuyeytF+64OigyJz0zfoaOJtI568mZc+2W2Ls6fNKL6ILfNDPgOxv
	 656Wf/dxANpAgWsJgEDJfNru2GBCJtLXQQCIzLQdB1iG5BtWJK+pAuJjNi9/4m+22GlvZ
	 5+zQ8sEID0wPcsFuW+rS0DWl3UKzBRbAYgE+3k7mY+jsrKgcBYkRVk2RZGgeH9gfjt0mD
	 xYsk30VedCVGiQyj9Hr4jrMjrJVNwO90OSIwR7o0jHPC5uLp76MbQksQ3V/oSij/42gWH
	 rlJMjlGRVAHhYYqiU+IFS10F4lbExl2xguqLbH7Bky9h0ZpftARy01qRAUJ+ZjCBMFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oMtWGlskVqXWYTGgT8kUzvtSaHGUGjmSxElRD/6sbRw=;
	b=IZSDEQzHCjw9yQDLWUI2qJATe5vl1ip0SSzKmtmX9cFHzktfIL3O+NB7mTyw0t3lC83K
	 uWQQVWLCprnebYk3aV8v61azSg6AXrD9lnHjBmXDjkJuhgs7vkdN2yddkjI7wPr1ij5qk
	 AjPCGgRf0g/YzL+POqI8OHp3wXsXtIpJ1mENZ7vg4qi0CX3IFSDodhcEEP1KwcShxQmKw
	 pb4MRDqZHckBgg+onwby3D7Qsac5a5EpaKCz4E77nem1wQhw0RP4b4evP4EcdLemFXwm8
	 a4DJcA/qnfwVCOoMnr4mC2cP3ysQfNeApD7E1yk3gS127TZdPbn3zNHry8LabcAdpKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LilD7GJx;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64315606A8A5
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 01:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64315606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LilD7GJx
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso32204805ad.2
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 17:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794706503; x=1795311303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMtWGlskVqXWYTGgT8kUzvtSaHGUGjmSxElRD/6sbRw=;
        b=LilD7GJxr03jIzB7EtXGcdYh/bYS7LilwamkzJF3H76Vhg6R8PmB0Jygd06fV5Mird
         OcjnnHflXjVswXGE4WDW+bbzzmZnyjzaVFvkYxMOfxROzACIlg2+Djm1byEpJ6AX6tSf
         OS4zS3ARYBgsvIWBdInSEyfWYLs4u4gQFO2m9lWiFykZrLSxSCrlbylXMiPCwCclwaMU
         bKDpEfZoqHcxi2u+kGQEcB4ZmnJLzkB6AKNJCi1WWhgCNqfC/pWyHaaHZVPymkfKpRnG
         M0MW5aq0x0n+WRXQIJGf5uHmAcLcTj8hH1CVZbKOccm/DGnso/1/tY7buaS+TKbM0GqX
         QGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794706503; x=1795311303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMtWGlskVqXWYTGgT8kUzvtSaHGUGjmSxElRD/6sbRw=;
        b=RgmdUu8N1BEv/d+ZxX5bM6bdmxDO045jaHcWIB4T7+eRbvpXjEHwp5ncg5LOsvXhSE
         /YuVNU7MDSAHO4NYCThgZrvIsGP9h32c3O0lJZfZxedYZ7K1xSBHc1vNtWQxojIVgfgU
         cGYzLwzqr2uDNkcKI7NLGudruZyAft18zmeb/7L7JUCMp3zBoNcG5W/6ZFWqleuYLHTo
         1O40At7g4Vvilu234HUz/0E7tfkorsjXlYq1vepePXp6ZxRK5+1wajnHx8ksQ1fYAg7f
         9DZtjw2ldRbdh5Gq5HgQ8D3qECMsr63j4nF+S6YdRgRapF6/u96VjFLKWyIEVpK53RbK
         By9Q==
X-Forwarded-Encrypted: i=1; AL+hErHegWZxp7hbIZFmSTEcApcZGm954eO6JggUMqNFG6lNbAkIKAZcDOrzVx+OVx4xIjrh408MZSxdCVbLeN1kkZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KiWwZhAFaOMMCVQc/Bsopu3kALZuFTqDXOC2KWap6NZzHFTIo
	pfHVodj2IOoWDkrjVZ0nEPcslOVhCOt6cNq0hKrLWRsPHfPxlMpiAX+OTeIc6w==
X-Gm-Gg: AYBFou2LzT2n8hV/KB15sRvr7iG7V8r4AbuEMWZo4GApxhGdl85fhsl7AHIfoXeXvmq
	hodj2wKWT/fEmZ0bY8019ivUbm8zth7C6I9ey5NZuFQM6TqHo59ah+X6qatT6CH6ysKKv/gjjel
	Sakqw+k+UJa/d+V1QIx9IW1lhSlIhggBrc22ZfVV2ZijMsZY2UaaQ7CAjFT2qAhaPWyxK9YuCm6
	bXi6ejF3IQtFIbYu/IZ5QR0XhoSWp4Nfifpq4CeBV1zRXqYZhPX2i3Df5nDQOpNzuLoVSmdEAWO
	CVO3tuZGIpRHbIE9PHFfklv8xh8V04fjLEhjJol8FD2qEf5XBQ4EWlHVEONxNOa4bDgj0pgfJw0
	/UYDnw7/N0+SrHn1rpCOW2Rw2fHfBouXOCg42PNj6GutJ61GRwv6OSeh6TVSWrbUOS92j64AepW
	pIgls7xMJCn3phCEz+mvgdx0Knbs+7OasG1LZNX9bjK1LniBd4jn7VmzNuSPRyEjXEtyiOBNPVS
	+RvoO+3bhkrzAymX/U+lQODwtmHBY1M+JSeBEk8unQqxgZykPbLfK/nqtBUOMbRFyTexLfILB5a
	6oV7kfngWsp/A58fK8DUdw787Exbfx1XLBCWfZVOHB6enKavGT9MotAUCbBQz+muGcR4PceJKiA
	xUkKrjG/6ppRn6UMXvG4IUca9dE9ALOBo6m8PtB4Hw1WJ6uo7KKX0B5xRKQ3cDxX4+6y153oWp8
	t4AsNoP8xd7V5D+8pHBcva0Slfi9t9I99b5fN7KmpK
X-Received: by 2002:a17:902:e848:b0:2e5:98d7:8202 with SMTP id d9443c01a7336-2ee0dd2dbe6mr71270395ad.13.1794706502800;
        Sat, 14 Nov 2026 17:35:02 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75dde9sm23671935ad.22.2026.11.14.17.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:35:02 -0800 (PST)
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
Subject: [PATCH v3 3/4] tpm: tpm_tis: Use cached tpm2_acpi_start_method
Date: Sun, 15 Nov 2026 01:34:55 +0000
Message-ID: <20261115013456.212141-4-sidchintamaneni@gmail.com>
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

Use the cached tpm2_acpi_start_method value instead of mapping and
unmapping the ACPI TPM2 table again during probe. Remove
check_acpi_tpm2() and open-code the start method check directly in
tpm_tis_init(), returning -ENODEV when the device does not use
ACPI_TPM2_MEMORY_MAPPED.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm_tis.c | 45 +++++---------------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 6f8344894ea5..df2d8c1c2be0 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -127,45 +127,11 @@ static inline int is_itpm(struct acpi_device *dev)
 #endif
 
 #if defined(CONFIG_ACPI)
-#define DEVICE_IS_TPM2 1
-
 static const struct acpi_device_id tpm_acpi_tbl[] = {
-	{"MSFT0101", DEVICE_IS_TPM2},
+	{"MSFT0101"},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, tpm_acpi_tbl);
-
-static int check_acpi_tpm2(struct device *dev)
-{
-	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
-	struct acpi_table_tpm2 *tbl;
-	acpi_status st;
-	int ret = 0;
-
-	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
-		return 0;
-
-	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
-	 * table is mandatory
-	 */
-	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
-	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
-		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
-		return -EINVAL;
-	}
-
-	/* The tpm2_crb driver handles this device */
-	if (tbl->start_method != ACPI_TPM2_MEMORY_MAPPED)
-		ret = -ENODEV;
-
-	acpi_put_table((struct acpi_table_header *)tbl);
-	return ret;
-}
-#else
-static int check_acpi_tpm2(struct device *dev)
-{
-	return 0;
-}
 #endif
 
 static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
@@ -222,11 +188,12 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 {
 	struct tpm_tis_tcg_phy *phy;
 	int irq = -1;
-	int rc;
 
-	rc = check_acpi_tpm2(dev);
-	if (rc)
-		return rc;
+#ifdef CONFIG_ACPI
+	if (acpi_match_device(tpm_acpi_tbl, dev) &&
+	    tpm2_acpi_start_method != ACPI_TPM2_MEMORY_MAPPED)
+		return -ENODEV;
+#endif
 
 	phy = devm_kzalloc_obj(dev, struct tpm_tis_tcg_phy);
 	if (phy == NULL)
-- 
2.45.4

