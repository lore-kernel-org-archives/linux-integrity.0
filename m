Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41503D9661
	for <linux-integrity@vger.kernel.org>; Mon,  3 Aug 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749076; cv=none; b=G7wrJfX935KBIzDajYPOTJ7p2cs8AtRRAHeSADuE4C1A1fQleoQvIG+VnL5l1y/KAQdDowARyWv1l//0qI8pJt9S5zODlML4VvTkBDvbAjcQS+Uqj+cHCe/fVgcAs5t4nCd/S7c4QzZ3Cbcfma0eEaMES01mSZtKYMk1ibZEIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749076; c=relaxed/simple;
	bh=dkU4Tw0yAuLuGOa79nc/r9FpS2/pes1r5ogzZx5MrtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwJ6FVPtOc2El1S6sacLeIQmR2ffwnXd6bHgN3Xb57qifx9p9j7nivPa6Sq3LU4ukTWG8lgzdhJls0kOTEXKs5WC/pvDu5c3Vo5qsVxC4/+IBLpRRXGyy2T3tr4E2r4gUUFPjEoqk6KWkZR06ZZiHGsg3liYsaT91Da77RIQbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiepbW/6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiepbW/6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47fc4037340so231004f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 03 Aug 2026 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785749073; x=1786353873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9QHkMFg6ACXXBOTXO2bQNyqADWHuSvYdeuTGK7GMdw=;
        b=kiepbW/6iz3NKPMDNUbwTXw+hbivgOP2Fqb8LV0vZqrkEblPIjesGaA09gdq9EjlXp
         WFUSptGaT0ILpKMRG075lY4BmtSZJ87p/gVuwoZEn84tXVPuUqkJ9svVYe52f4ThDQU4
         UA304C9v4qkqHBvjsy0naLtIqdbDZTLg8exvgIzgvaSuSnXUnivvJDckjvj3/J/0XUj4
         ClwcrQ5CbQ/WbYgM1PfFjGV6U+R3BzQnXCLTLDVh+asZRFS7WhhBdPHEkv0gMRuczdHG
         XHg5FEksL4w7qvjwXSwXmR9OL8XXqDZRTcMYFbV7UYeDrjOjMnW/ACCzk6g3vn/lUWVg
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785749073; x=1786353873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9QHkMFg6ACXXBOTXO2bQNyqADWHuSvYdeuTGK7GMdw=;
        b=hHAV0cDybJHpB2V5u4W/TnSDFabzY362flKBYpA5Fy1deak9rP33dJ3gOCX+EuKYmc
         knWVhznfD6CyaCmYo/fuv7nuE66QDsAb02Fktm+fLgiajKBqFWTtyjiJSxhcCkkg9fvY
         GHb/8qsU0DuppVubNPxpFg2O90yAx1qkC9NvMnCE9TUXZfTIF/pwKwFu8IpW8lKDzi3V
         3M14kLVMuStexgpK8GPTJrmQlqWTFMs3UTofEIOhL8h9zqZo0nL8FxK4Xde+6vVz1Sq3
         UwsZRn5BuOzOtXcxnNsl/U6Wy6rtWgzLGYuqgXjH8K/1nalKTK8EMdyu+HH+JXCHeFKN
         ZWdw==
X-Forwarded-Encrypted: i=1; AHgh+RoAIY/NmAgPf740koItoRRzWCj1BbOCK8NYrWJNzEoby1xAHtMNmRNtQhCstqxzmIDmeSeEYU88Tjn5+GYd8CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykVeRZui/N/prKxR8qDeT5lkBzlTzGTocUT12PTRpGUpclThqN
	jvz97vgFHWdh4e4iV7Vw5SGzaYRAK19XgPvdaoCPopiPH0FEU3SyFI3a
X-Gm-Gg: AR+sD110iYt5PowH+AZL4cpHRBlo9fZzIy5MvlHVdLcy94Q3SpgAHXJ0eQorWgOn78T
	SczVeSOekf/1dIPjyC3EndI1qdZ/HCsX4cJ2Z/b2HFdsYPupYBD0ge+w2k62QXBgf94yz65IFXK
	GH/z4ZY3zZRqBxXK1euj7ISR9osNKtviYzUIYMRnHlIRsxZpYGHTkjMu/v3wdwgZwtARdq2Xwv8
	eMNAo0GQt0INMjEpK6y0oJNmGh+3LvFZ4RNPu0raKf3tB8hi7Y1S56HzKWS15mXvaOgLqme5TM1
	ji//kmmtgRG04/aYSKOzGjMKxfOoEalwBL+WHCGGHy0vyTDCkc+nJn870yT1javeJ8w0XzGwaJN
	D+PYkHIjFSv+8XS+6Ofsw94cr6NZ1e6nbjgi1HDS3XNbFcxkG6tBvsbnD3OgZQOZghPH6TnnvFd
	Vfn6poQZvRKsJd+eWk1s+lZ9iMWDE8d2bdOCpvS+ZNmFpRiQCs4bK8LVHrLereEhNc92lawIOay
	/Le0HmJ+5fx12AxD68GIFE=
X-Received: by 2002:a05:600c:840f:b0:495:4840:c6b with SMTP id 5b1f17b1804b1-4980c656b36mr87800415e9.1.1785749073091;
        Mon, 03 Aug 2026 02:24:33 -0700 (PDT)
Received: from thomas-precision3591.inria.fr ([2a04:cec0:101e:c128:4719:1287:c5e5:152c])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49807b5b4a2sm250009655e9.1.2026.08.03.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:24:32 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Fix barriers to prevent hwrng from activating during resume
Date: Mon,  3 Aug 2026 11:13:24 +0200
Message-ID: <20260803092240.18348-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory barrier is placed after clearing the suspened flag so
memory reordering between the wake up and clearing the flag is allowed.
The reader of the flag is missing the corresponding barrier.

Clear the flag after the memory barrier and add a memory barrier in
the reader.

Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/char/tpm/tpm-chip.c      | 3 +++
 drivers/char/tpm/tpm-interface.c | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 12b7394b34bd..7f500797b7a7 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -173,6 +173,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
 		goto out_lock;
 
+	/* Ensure that device is fully resumed */
+	rmb();
+
 	rc = tpm_chip_start(chip);
 	if (rc)
 		goto out_lock;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b..2de12b02f62b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -474,13 +474,12 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
-	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
-
 	/*
 	 * Guarantee that SUSPENDED is written last, so that hwrng does not
 	 * activate before the chip has been fully resumed.
 	 */
 	wmb();
+	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
 	return 0;
 }
-- 
2.43.0

