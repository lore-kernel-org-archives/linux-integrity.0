Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35348A8B8
	for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635043; cv=none; b=WlKrIW9qyT9AucoEpkiaNXQJwJHJzcKECOYHtbjHPD/2EWc31roPaL6MyAnCGvLWt5SDM2n+A1AgKvWPUR9Pt8hbpUGgG0kBGWw9AIFuRqlZV9l5L0Wcn6Su1qJ86INi95wbfqaX2CbJjgXE/41dkoXK7p7fL/gSq8P57vagdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635043; c=relaxed/simple;
	bh=zS4yBiMhynVY+GeN45tgiN2toKrueGRWsHvxyPuW1X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzI2WadnHvJILczjBsBMRBRV3Vyv0cLt11eLxukuvVUV07Rzw5ECbIy4HqDmJnw1+neODzhHzyIIzTU/rzpI8Bqb/aDxWkHpmGu+KrLi6Fl2UdepUTFvbNyTIrd+6M6Q31D5RcXOzR65YnT8WZUBmmLRfUXFiDtZk4DksZeau3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWGhWNYT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWGhWNYT"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so2547915b3a.3
        for <linux-integrity@vger.kernel.org>; Thu, 13 Aug 2026 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635042; x=1787239842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7PUKjGwrD+vFs6TW/81bEPyuY0N1UHpM7KlRzR6uxjE=;
        b=MWGhWNYTdqIXWfWh+aE5zRxAf1V68K0f55K1Ihe5bCWUVx4IiLugx43tFmWCRZ7VQJ
         /nP+sni1Dqg0ZJTsmEqUGPZrS1zCCsaqZet1r33BhKANm8ij/YLLFe+ugvB1+v8zvIjY
         uAuaKipSiZgq3zYLRyzPerOuK8ssjtDcSC//qAt9/LWFB7W6DNX1TVx2GjD7ohSvmhZC
         A27wVND+1rWItLWdjocXDPVLLv9EpWpuE9Ace2l28vVGTlzj0hyI6mElKC3e5GjgsEId
         cl2FRJag+9L6xjNGZijKRJMxX8UE7iJBFGWmp0J7Szs/0fDEHMPAxklfGguJ1kHzEeZU
         idWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635042; x=1787239842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7PUKjGwrD+vFs6TW/81bEPyuY0N1UHpM7KlRzR6uxjE=;
        b=K5zPYP4KnjyCq6agzsev6fmCvrDsDLRxfPVM5AV5WXdI5C+tr4IpCRR9WNtHjsiP0n
         05qXMDrUMpzvlBjBX+9UCQuRAOdQ4cgXC+e8dMp0C86cDQ7K2QBm5zZ1rBiyzoHviyUi
         obPHyMVmjMGFxIgBjT5pKg5patVkY+utJlyfhZTy2CSWNVigOLACS1COGHjv2ZT+0Omo
         RMkCqTKRMT5OEwmMK+A3A2WhcCHm42/Xrx5huRQGfEJnuAKagHc4B5y9RE3ma4c63Dgx
         DUtO/wKzecWndNcw/2Bo7L573j0GGAGlLbsWA9hNUjSCKP7vT1HizslrcsL5vly7zPeJ
         1l+g==
X-Gm-Message-State: AOJu0Yxx7aWkukVeKfgM5pN3cgnkpBUV+Itzmw/OKc7RHgi+EBzlOP7q
	voWyfUdJHDOU019YRnd6nOqPbLl9PYF8oxjNDx2KSmBWyM1IgdCV6lyr4XHwmA==
X-Gm-Gg: AR+sD10kXwXurUP0RYIojd57yVF6ZdQvuwHENabmLik3EnUf5QueXL4NrlBiTVUZApG
	MGsPpwYyrEwKU0sm5h4aiLOGi6h642SxbAwEaaHGTGtsu8Xr6ZOX9b/kOgp247DP38KeaP3G5OI
	ux6yRkIo/iGn6zu2Tkgiwu4Bus3q34TzIVOwvgZE3rXz3iHlFbUevl4MST1Bx3koV0oUw3GiiuY
	RobZ9EQD5tQ35kY5/bAyOTY+/BeEQrUq+43hGCFC07hYtCwXh/Wl+8p5ih0jEbohtMnlTTwX/5U
	yOR+viFgwcwykoJfKgXwkRbqJyYWltyex4aGO59HEivO+n3XA4je2cnUTFPesrVA3TRInO/Bui7
	z5l3pFgAbb48iz9xUf/TE7aKz74OWz2IuqhMglcpZ+u9BK3LD0TlXQz3MxOrnxCW9laWmoM1DQm
	q21la/5n1q50MWWSTy+9jG4N0Hkgqpkna+H8bDcT1qn3U20jxFmoYciPvcj4uN6ij0QbOyt0U2q
	CnmdkM=
X-Received: by 2002:a05:6a00:4501:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84fc768405emr8166658b3a.38.1786635041601;
        Thu, 13 Aug 2026 08:30:41 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3b7:6da1:c188:d14f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc477e53esm1134246b3a.14.2026.08.13.08.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:30:41 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: linux-integrity@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH 2/2] tpm: st33zp24: Validate locality read result
Date: Thu, 13 Aug 2026 23:30:32 +0800
Message-ID: <20260813153032.3951878-2-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813153032.3951878-1-ruoyuw560@gmail.com>
References: <20260813153032.3951878-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_locality() treats every nonzero transport return as success. SPI
errors remain negative, while the I2C path can convert a negative write
error through its byte-sized status variable. Either result is nonzero
even though the TPM_ACCESS byte can remain unwritten, so indeterminate
ACTIVE_LOCALITY and VALID bits can falsely report an active locality.

Require recv() to return exactly the requested byte before examining
TPM_ACCESS. Transport errors and short reads now report an inactive
locality, while successful reads retain the existing behavior.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 251a7b08213a ("TPM: STMicroelectronics ST33 I2C KERNEL 3.x")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 898e8d01d26698..0e2deff94c3672 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -106,10 +106,10 @@ static bool check_locality(struct tpm_chip *chip)
 {
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	u8 data;
-	u8 status;
+	int status;
 
 	status = tpm_dev->ops->recv(tpm_dev->phy_id, TPM_ACCESS, &data, 1);
-	if (status && (data &
+	if (status == 1 && (data &
 		(TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
 		(TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID))
 		return true;
-- 
2.51.0

