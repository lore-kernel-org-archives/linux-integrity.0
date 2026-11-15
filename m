Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706500;
	b=0WQ/M5w+zX8x/Lsvd7ssDXWZGSnSCbCWI8S4T8ARpGQ/ltRD6YWpByvZFjSoVpp83e8D
	 09kNcsraMPkTysSFOglps7YIIcF15g8htsxjnojvVuvOLmgTnJZu/OzFMz+pS+3zowQW+
	 hnDOaRpBrAWuJk65MP2QPr2NTHBLVoHWCbKmvcBGVoO5/0rD4NvQVJ80MvXddT8eS2WT7
	 1TAklvZT+Q/IM3IIqoA8kp5QTvpWKhe46rarhRL3kuZHvQN3lJDgsrlxmUivQCujGOJ8O
	 jp21ANFz+Pz+9Tqlnlpbk0G8XScYuPTwR28hYRxREuCjh4aqm7osT/k+57xlOFRawEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OczTFag+4rrpYiC7SwR0JFMdaa1DWemeh7STu5Jts6Q=;
	b=hxjqMbrVg0eE0rELwi5RpZSwfvBMwsdQCgNvdYL78Kobcwuuhwbr6NVd/Iz59/+h1e7W
	 b1IUIxS/Z5ZUfv7fVwJCEWE1R1x44Ywkhs1xjMR0PXYbvTERhz5evbES5/ITOjwaBGJXg
	 PVLatVLH/AimaBFxzCg8pI1VQp4+iNWQnB5YAzibRHs6r/fAF2Rw/NstjTPh8o5FuSgh3
	 JOH5jlzGXCjxn3jQPOg1hWI3wCT2zCuQbYSy9nXKQt4Z+M0Z4Q+y6cnGmHzukjfHdqvwl
	 8tKDpKZbnR7/7ZEXlP3mn1K92zQp8D9+eGqxp6XuKON1LC0bKMGjjqZwfmDJ73CyRgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRMikMdE;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E8606A329
	for <linux-integrity@vger.kernel.org>; Sun, 15 Nov 2026 01:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A2E8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRMikMdE
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987a2ba0cso12383365ad.3
        for <linux-integrity@vger.kernel.org>; Sat, 14 Nov 2026 17:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794706500; x=1795311300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OczTFag+4rrpYiC7SwR0JFMdaa1DWemeh7STu5Jts6Q=;
        b=eRMikMdEzKDARPSpg40y/hYEod3qTu+9jV9ibYgtAcaPEeQb+6r4XjXEr1rR5DUmKJ
         UN7qX/dL9Q451OFC206rCvr0htXc8ihh8+CIunjseBO1Qj+uSofuJlXFHQCj3n51O4gB
         Wa1wiQKAWB4fRd6QqPQ4AJ6TJ/GDj+zlMxatLqlmecR95yi7C5OxcIC9mzvfO0vp54WZ
         egrXTmIgFN57tkACvP/M9BYaWgj/pJ5agFKdRdsy8MQrYNP9TxFKVjhAujikujSI1MdC
         DRzHm51qMfW8DbqBlhMwHILziOHSrrSQu2XfogXU86g14xv1jM6UHcV8XZ+pdoGwgDMf
         bbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794706500; x=1795311300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OczTFag+4rrpYiC7SwR0JFMdaa1DWemeh7STu5Jts6Q=;
        b=FLEoafinHIlnXq8G4IRSEqb7tNWwnCeTZ06ccJvE9aLR+5vgFAhjxrzLeBgYJR5xsk
         2KtCAsiMUa00WDGlOkQp8Ck8ykNfc5O9p7kUF9GRO/SYI15SQcBeVzlGXYrsdo7J49st
         5O7t+LkXyOwSz+bQL/zKn6++zrtF1gJdlV1FtMtm549D8sCwE9aEcMcCeIXETExfTzuU
         ue3P56RjGhAvJqg3cdegNE3hSOhG2WZuYnyYwbc6BLYDZADrFYe5PSsWsbLQa3wXtcoA
         or/CALgBMWbN6KWcbdrNucYM06wgsuAi+2pnZ6KJpLDfYVPrw54bVKN9IaFSlBBlulmn
         JC5w==
X-Forwarded-Encrypted: i=1; AL+hErFgS/A2gIv5xyTNM6u1lU57O1FNttMFgDVKgYtOnQ4G6bHCNmFSfhcPjXKDBFSR9qN8C1Wnx87fp1fNUEK7X5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+okn63p77AtgjokXdGdT4iC/DtNruM7FySOOyNPKcMml6NETJm
	o8cjoHpWkC/6zy4VUJtXdPbLHjmhXydamBB7gBmomOb80x185ieFJmzk
X-Gm-Gg: AYBFou24ml57/55paXPUy8t81Uco7LImNd0Xd3tvItcCm1aoNIepWCocWMOpNukJitd
	9YnDCxBvrekdqdeXAioYX1BOMZdOMKGR3ZuSrH5oqvQbZdtb+2AbokjGttMyC7wMoAzBQMRpBQo
	VINwYBsc3LTlUSCjNuyzeyKUXIh4sAlhL/Tg6brZw6y6zsCooiFRSmyaa3qp0/FgWVw8zWPzGzg
	p6wIg4BtjqX3SYwx+cOB5De83p4EHmOy7TLRCeFbVu2AfdipZ2DS7egUiu5YsEl9Y9gTIRy4W/S
	Mit7VAQ7q17cJcO8BZva9F+uiwjKtLu8jTfdYbgL2havUucNp9nZcw8S4S3Hpzaet6BNDYRGnTc
	aDHvZEFlQdbxqBriWiFS+GgQQvbDoPnlKs0IE1foAczbcg3mFmh5HOaM6mcZMI58lwzp/SXVhM6
	3/SyTYRF4lfncBjBolrjIVxU/PW9kElercqW+6Q82oj7AQ3+6hzIXt9Mgs1YZDQv0ypZTpiFhzX
	1jgE5xL3ZM0sk906dfo7bp2UTZ6vIwRg8D6YUvH2XVFe+cKFMN/Y48YoQ/D/pBWzDBsb9qZAGZQ
	PM06OljO3VC/MBV9xlScCG/I2ciNlvOELUUncCIT83YRmBlFKks1LFhQSbnZHLYXQEll2A1BbYE
	TtlLW1weh9CPtZS+3Yuc15P3j6PaFy2i+Fe9PxWBGqPLmVrJFzz+gmZknEnym+oFWFifVlWigE3
	DWazRq+P3AbnF7YWgt4EhHnujc+71yAoWb+1j12S+WIfQCqEldPTRh1JndOAju/g==
X-Received: by 2002:a17:903:3c2e:b0:2ed:3f47:9691 with SMTP id d9443c01a7336-2ee0dc05bc1mr66811655ad.42.1794706499678;
        Sat, 14 Nov 2026 17:34:59 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75dde9sm23671935ad.22.2026.11.14.17.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:34:58 -0800 (PST)
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
Subject: [PATCH v3 0/4] tpm: Cache ACPI TPM2 start method and gate tpm_crb_ffa probe
Date: Sun, 15 Nov 2026 01:34:52 +0000
Message-ID: <20261115013456.212141-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series caches the ACPI TPM2 start method in tpm_init() and uses
the cached tpm2_acpi_start_method value across tpm_crb_ffa, tpm_tis,
and tpm_crb.

Patch 1 caches the ACPI TPM2 start method once in tpm_init() into
tpm2_acpi_start_method (defaulting to ACPI_TPM2_NOT_ALLOWED when
absent or invalid) and logs it when a TPM2 ACPI table is present.
Patch 2 checks tpm2_acpi_start_method in tpm_crb_ffa_probe() and
returns -ENODEV unless ACPI advertises ACPI_TPM2_CRB_WITH_ARM_FFA,
skipping FF-A probing on non-FF-A platforms while keeping modular
tpm_crb/tpm_crb_ffa loading intact.
Patches 3 and 4 update tpm_tis and tpm_crb to use the cached
tpm2_acpi_start_method value directly.

Changes in v3:
- Log tpm2_acpi_start_method in tpm_init() after acpi_put_table() and
  use a single-line acpi_get_table() call with typeof(tbl->header)
  cast (Jarkko Sakkinen).
- Remove check_acpi_tpm2() in tpm_tis and open-code the check in
  tpm_tis_init(), dropping dev_err() and returning -ENODEV (Jarkko
  Sakkinen).
- Remove priv->sm and local sm in tpm_crb, use tpm2_acpi_start_method
  throughout, drop the probe dev_err() messages, and return -ENODEV
  (Jarkko Sakkinen).

Changes in v2:
- Expand into a 4-patch series caching tpm2_acpi_start_method in
  tpm_init() and converting tpm_crb_ffa, tpm_tis, and tpm_crb to use
  it (Jarkko Sakkinen).
- Move the tpm_crb_ffa start_method check from module_init into
  tpm_crb_ffa_probe() so tpm_crb.ko and tpm_crb_ffa.ko still load
  cleanly on non-FF-A systems when built as modules.

v2: https://lore.kernel.org/linux-integrity/20261114193434.117714-1-sidchintamaneni@gmail.com/
v1: https://lore.kernel.org/linux-integrity/20261112233807.70664-1-sidchintamaneni@gmail.com/

Jarkko Sakkinen (1):
  tpm: Cache TPM2 start method

Siddharth Chintamaneni (3):
  tpm: tpm_crb_ffa: Only probe when ACPI TPM2 uses FF-A
  tpm: tpm_tis: Use cached tpm2_acpi_start_method
  tpm: tpm_crb: Use cached tpm2_acpi_start_method

 drivers/char/tpm/tpm-interface.c | 21 ++++++++
 drivers/char/tpm/tpm.h           |  1 +
 drivers/char/tpm/tpm_crb.c       | 82 +++++++++++++++-----------------
 drivers/char/tpm/tpm_crb_ffa.c   |  5 ++
 drivers/char/tpm/tpm_tis.c       | 45 +++---------------
 5 files changed, 71 insertions(+), 83 deletions(-)


base-commit: 7e52fc165aa50e70e8df3c879d04fc0ff1673d4a
-- 
2.45.4

