Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AA48A8A7
	for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635041; cv=none; b=JaQmWKo3DPNpU7dZATg56RebySjzmiLnPrV+1YEekwJggyMB2bgTA35oU3xdL3yZIgpHQVIiue46EH4MPGVRG1AmqfQ1uvnlZuADmh734uwmZBsz+ACKd0XySye0vIjnurPGnS0CdjY4Hyc6v9CPb3/sMe7Fv8UDV5m0asXZxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635041; c=relaxed/simple;
	bh=atvP6J3eoLP5zb6eAsQYmguZHfq7Y8aVIuBXLId6zhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dABGS/cVtDN8Ht5Fw/NpkwzyAsMdbLqWe7O6t7KBMdTqdpGI0ARXGNyTb9lGjWaiJ9ahl1pQrcy1dh1mZ3Ld7hPaqXcWFzGc8kSy3lQR+RzeCCxzFN6XXGq+NgBzjZJu7vh02qMQ7SwLPErcC++JlsJwL2y8WQad5oaEYz2jTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km5rBvNw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km5rBvNw"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e507b079dso1698301b3a.0
        for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635039; x=1787239839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FepzhvApFnVO+ELlsD4ByDy5sUKL+A9n8XFq2GWrLlw=;
        b=Km5rBvNwlbAgPrSyGkp0U/XOPwVnmaZPNAYtlyU0wsDuYGKG5hZ1KRHKFjSGprOu/j
         ckzxD5flaDxRoLhuI/xb9TC3D4n7kyhyTPPWkINS+sWBzOsAtzN+ozJ/UB/SVnr5pyy1
         eGF2dx9MDA+46ii3TwK7IRnwdiY52xK2XDdACyhEKF/o+/2dJgKQOp+J716r2AiLDqhY
         MiOdT9Exx9mq2RczxVauTGPiJb7vn/bwqlRUViFzL9C8ZbD27BzqTSnsCW2OXOs/UD26
         f/g/wZwCjM6gi0YvHH4xUcHn6Wm+aHQT5utNCxWOhVdVDf0a9KjbIf47q/8CVoOQcfXI
         kqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635039; x=1787239839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FepzhvApFnVO+ELlsD4ByDy5sUKL+A9n8XFq2GWrLlw=;
        b=LDhZ/zUi9L/T51+Eel3moMWHHsUny8BIPH3UqCx/SVIYLY93wzzSb5eKUEaebwLg1O
         hmOMe9oYHMaw784S5PHG4ol1GPdsf8aQl3mQXqlcHpAxl5EVsTlZlIZGEfRYp6Guj5pw
         C6hQ70vJ66SSpnKP5Cfszz2IOPRTEncvfwC6NL6N8U1qfvzMDMn/lO7zvyLyjIGRxlIM
         OWHKmPyitPx80ACA0AEXFwQqyuQD4huqoUQRi1p1xso/YHYlyNzUYg1gdsV2/IaMMbnz
         AyEl1IciPHHACtwkSZEslZX+/oKeZV33lQ/5EZILMDQiXK4Q/EiIHQTADt5Zo50yDxmO
         B0/A==
X-Gm-Message-State: AOJu0Yxo2oNclmpTgH4AW5g2SfrNQuYie3Ev7PCRXVDyl6VMJOMNTrrg
	g8U2lmcPQeX5PSkW+6mllpuFTJsYLkZ+Ma1BhPINGfQFCWKNkuL9pH6pWgc6QIdzTVk=
X-Gm-Gg: AR+sD10HWA7VKRH7eemTOZd4BqZS6EzhmBEc7bSDLZ+NWJ/aJf5i9U4AxKORkWXyIO6
	BgDBVqEfVWTTYYXO/k5DtxAu+XpCHQRnE6RRDgAlRUC9+sd6mzX7mKioGUxl49cHbGzETOPdsm2
	pZlZ5RRQssIZsd9yTLt75ZX01HC5FvoCrVUWhxEY0E3n9r2BJdHsemj2o0RuALGspf52k7FPqMt
	qPPJOPze3WVWMAsyh1HrwfNsLGL70TT/qzh5w7LGfxtG6taLggJlJSfBUHXe9aVy6qbMcvG7HnE
	5+tYo9Ip10hOi5L//rwogL1RztgiSPDg6GXeTi13ZNkgb59ql1ayaXqwlKC+ML4brjzhfl2BW3i
	tze/GS9Zb/pyMxaZlc2vtFkCMIPRmOn+hPLC3U6q21NkfndRLG47vH5suL/h7iRwQEhs6YeYbyu
	iJ6sPNP+MYQGvSW3We/jPIpR4R21acYXYZGWq7GvUKzRw7zy+IjKq5PHvn5l4xblE5hjSrHSX3v
	FHXxzI=
X-Received: by 2002:a05:6a00:3485:b0:845:d6a5:716b with SMTP id d2e1a72fcca58-84fc7514c97mr7766799b3a.23.1786635039061;
        Thu, 13 Aug 2026 08:30:39 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3b7:6da1:c188:d14f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc477e53esm1134246b3a.14.2026.08.13.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:30:38 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH 1/2] tpm: st33zp24: Return zero on status read failure
Date: Thu, 13 Aug 2026 23:30:31 +0800
Message-ID: <20260813153032.3951878-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

st33zp24_status() ignores the result of the transport read and returns
data even when no byte was received. The I2C transport, for example,
skips i2c_master_recv() when the register-select write is short or fails,
leaving data uninitialized. The resulting stack value can be interpreted
as TPM_STS flags and let status checks complete spuriously.

The status callback cannot propagate a transport error. Return zero
unless recv() reports exactly one byte. With no status bits set, callers
retry or take their existing timeout or error path instead of acting on
an invalid status value.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 251a7b08213a ("TPM: STMicroelectronics ST33 I2C KERNEL 3.x")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index e2b7451ea7ccd3..898e8d01d26698 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -93,7 +93,9 @@ static u8 st33zp24_status(struct tpm_chip *chip)
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	u8 data;
 
-	tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS, &data, 1);
+	if (tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS, &data, 1) != 1)
+		return 0;
+
 	return data;
 }
 
-- 
2.51.0

