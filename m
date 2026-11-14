Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684883;
	b=GGsCyf2mv0fe8V6T+LAtWtp/UC2bpr7txRUFQxwKhBf2DkE474qLx9uAtV8JR1sXJ2AC
	 ma3FdMvEWrNFRUTtdFff2mrZY4Aq7iBMD4xTTdcUcCTEeDPtd6VteD0a4MCD6j4b1AHJF
	 2v0tX3cO8WcBl7HwQzbgPe6VBDNaiQMN0s9MjANnm2MWesS2LY84SmZGbx92e4eioUgh5
	 M9tv2F7mA/GiL8iTlvvf3MiWIES8O5hQwApBQqE6/xX1bu9pHE8r/VB6M60hiPlFr/LSL
	 ouAeIFOCa8t5qyzmlqgyJR6za51qHn07KMm5j627Q9BF7Nyfy8/YBihcqrlWpnmyoXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5irTJeCQfqm7AWnnyXmuLFQGD8l/R9bAv0K62WDnA+o=;
	b=iNTWGbS6gRZnUXq1gcHRVoRhlzl4XN7fOpqwEctXVxHdlBfrmlxFESe8sqEcvWJOrtjN
	 6EYSCqJ66G7Oj/fBNjVGX49mU30NghCLK4HUxWk32ZA+u02Bv7L/AzoQV6vASnFq1f+fA
	 mGZ8T3EesZY/nWBNlgCfZMhEHfjcjpShFF7OUHdl6WVf0jwaeeeM1zaLNYwoKpmJbqEq8
	 9RM+i5EGK70cFuFTa7xx0dLk7iEHFU8VU+6F+vP39jqOAK32rLjMgrw/3UWPwkbw+Rolj
	 kAe9i43OBLlmX5WRGo5z9vMi78kqWMWleVw0zeMx3YdaWqj4E+CCNy4ZL8aE3Or5lzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSwJXxE8;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD9606A894
	for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 19:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9FD9606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSwJXxE8
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1691668a12.0
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794684882; x=1795289682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5irTJeCQfqm7AWnnyXmuLFQGD8l/R9bAv0K62WDnA+o=;
        b=ZSwJXxE8C60iPMVXxd+x+sdue0oR3ePZsQuYbPlj0+90EAxgLPID9NVWeIBdHO6cpk
         j2k+ptGu/gXthz/j039nJSFXEL1yORjMEdLGMal6SMrYVTlkG6t7ASzF+hUD+xcONbV9
         VthC+0Bjwnd6HDBl7/UZPhd6pSwJMIbjQHxIvDKfP8qPH8jZWIyKVi5J7BVwyaFFaZFt
         0U2E5GEN/V9JK5JEka7Tzhv/H8DXzoxKu+bFybbiPVJDoM7AahveNIsoKafzPWD9tMjp
         zmA7WSbAzBcHhCf8liZkohbAmpPixwVKjV0IvnN5aYJ8VeuT9jijkULCe7r1dDtUZxC0
         FRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794684882; x=1795289682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5irTJeCQfqm7AWnnyXmuLFQGD8l/R9bAv0K62WDnA+o=;
        b=ph4BQ91pFmUkd6yQfRa22mPzRdjymQ6X7IFDbC6ZL8CE3oF+CJrq5RvqALTbHsRmyI
         WcU53LYaAumNnvwlkHrETl7PfZX8JbZhanwsvSu31zG4FRqKM43l9SPu9tr6aMrLqF+d
         FW2XwkIvM+/iX0ZSJmCVrEVAF61JTz0ZHPIKHgcKOEaUlFgqz1OofHTyxq8koPZJNrX2
         5xhcqVKLvslCH9rwWQ6fCfrYmnUAW42HLeak/7XcVFHY1pdE4/n5/ImYggTQhrjN1kMg
         5/3YxPradJnPcNDGMZDM6eSfXdUyYF+VbzHhsmLsIRKTCpHfkkJuLOMtx5aSV1nK7jdJ
         KoUA==
X-Forwarded-Encrypted: i=1; AL+hErHCpBs1s73o4Cdr7NYmcMejL8grgKcbVRF4D3N+k379Jn7suf9pUBjsfdN2FfvVnnl0DUrzxG1dhDAUxUUmdBw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GUhqEvIRdGeFVsFcW7e35cGp5VKmXxf3TXwvIRFyAeH+6PuIJ
	OVzVTQQgobgelndFhhVJNsM48QLaApr18LPsWEEMeMgYgojfuyBT5ipX
X-Gm-Gg: AYBFou37Dsvii6pNaVwkEZRcNiFL1Wb/TZI11Exv5GKoQ+LWK2kGFUGH5E2GadoA48s
	hvy3Zc9yzLdspbJB1WQZLTeazFARuaYIMBu6OHesT9RcVcSpdE+Y7OxWgR0uKLjOAj4+SabBJ9n
	EJmhRK0NvptsfHyTA7QFY+N3VDEwE7hojKs9k21nx2NUVTuLkgJM7rQqlM+psOZE0P6VEoy7KJ3
	LGHtYO+Z6PZD3h/VcM4VMSJTCtcSb3jy2gjufFuh9gkxhxmdC5f1Z7VFXvKWXwVpCcYE2dwbhx7
	2PvIA9Oec44A4ryy5sW85b6gz6hUWednsaMoRJalWDTxdx9d+K4tEXHoqy3KBfm7F7PcKTGdF8l
	QPbBnG/vtS5T917aISyx57dg30pYmDHcNjTAe3O7KzE3OAsIAQCZVhImP7g6BD+VIbgM7c+xFlX
	heR3IGuf3HEC3Kd0MXT6cYbbWYh9z0cfuD9tL3Yco3oPUz1JXfejQ+mQpHsuTY3b+TyM08ohZ6Y
	1Ju8NN1YevGJ7H0AZ0ehMQDcnrAk5wGikF5PQS11vo3KS2Q0cWzz5JBZZYY2e8ZISLZRjgTIlxZ
	tcNnoSsEPaxy9GmqdlFmeKfJ4ZFHvq4nJO0cuDH9fRfXKmpkgfaV7Y2+R3asGkXWsx4EPJ8HyP3
	GGVkd2cBxwKkHHdsbYiEShcdRdagKTOfEKb6yoRgcYrA4uZnTQ0xJL29Z6EiXO98nMHLsFMpLJm
	SEGid2tT7paiskLsI60XiVfNKhxL2HpfcexShvjpWl/A==
X-Received: by 2002:a17:90b:2882:b0:3b0:9a2e:b491 with SMTP id 98e67ed59e1d1-3b1b0dacca3mr5922566a91.66.1794684882159;
        Sat, 14 Nov 2026 11:34:42 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b24938bdsm5093969a91.1.2026.11.14.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:34:41 -0800 (PST)
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
Subject: [PATCH v2 3/4] tpm: tpm_tis: Use cached tpm2_acpi_start_method
Date: Sat, 14 Nov 2026 19:34:33 +0000
Message-ID: <20261114193434.117714-4-sidchintamaneni@gmail.com>
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

Use the cached tpm2_acpi_start_method value in check_acpi_tpm2() instead
of mapping and unmapping the ACPI TPM2 table again during probe.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 drivers/char/tpm/tpm_tis.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 6f8344894ea5..a6fb6f889e7d 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -138,28 +138,24 @@ MODULE_DEVICE_TABLE(acpi, tpm_acpi_tbl);
 static int check_acpi_tpm2(struct device *dev)
 {
 	const struct acpi_device_id *aid = acpi_match_device(tpm_acpi_tbl, dev);
-	struct acpi_table_tpm2 *tbl;
-	acpi_status st;
-	int ret = 0;
 
 	if (!aid || aid->driver_data != DEVICE_IS_TPM2)
 		return 0;
 
-	/* If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
-	 * table is mandatory
+	/*
+	 * If the ACPI TPM2 signature is matched then a global ACPI_SIG_TPM2
+	 * table is mandatory.
 	 */
-	st = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
-	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
+	if (tpm2_acpi_start_method == ACPI_TPM2_NOT_ALLOWED) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
 	}
 
 	/* The tpm2_crb driver handles this device */
-	if (tbl->start_method != ACPI_TPM2_MEMORY_MAPPED)
-		ret = -ENODEV;
+	if (tpm2_acpi_start_method != ACPI_TPM2_MEMORY_MAPPED)
+		return -ENODEV;
 
-	acpi_put_table((struct acpi_table_header *)tbl);
-	return ret;
+	return 0;
 }
 #else
 static int check_acpi_tpm2(struct device *dev)
-- 
2.45.4

