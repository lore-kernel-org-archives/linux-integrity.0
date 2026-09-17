Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309922701B6
	for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2026 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648978; cv=none; b=DeiWFdWcNVup/MqbIDegGwo/XdttTmQ14F5GEp4rHLamaJoY3Z/0HvmjtdQdcCBI/MswWim5lJAR/AouWjcsu34KY5pbBsiMh5e0Baz54yO2/UG1bvHmWCXTlJNb9xuCYDshDhFAgUrno1Ke9A3AAQVYPbAR83/1rQ4zQMa/+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648978; c=relaxed/simple;
	bh=+h9xvV+FmfsvD3o4x5A4hhDvjrjYOG6lR0QGp99K5mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIHyAAcr/0eDJhwq0aizaO01i1jsfXYf2I40oyVY6xjjZyMCEHU7ZvMHwf1UAkZnGHezbXguwkYImsNaz1Rm7ogDgY+8iP6vKZw+gWPvxQzulLL9PKnoH+QWD5fXboQIKx2LSpJaItQBVDo84g3yOiHNPTSkdMC3YhCerrDKfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMNy/HC4; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMNy/HC4"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso5951275e9.2
        for <linux-integrity@vger.kernel.org>; Thu, 17 Sep 2026 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648967; x=1790253767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H3XOkTTYIjCOyk/autE/aPM8JwQM44JJhJTWr5dHFho=;
        b=KMNy/HC4qP/UMPp/IJ31m6W+tlUdG6d3xwPw/PDrtbEhdjRFUQx9/kx+p7UQJgnnhS
         D1WuQXcXuwpArAkuv1GM3nAJxCE4hPQ8IUMuSc0P0KPwf7oOF782NK++AxtsFfJmXCPF
         nG/vN6TFESyAUOcJF5X0SUpelVZGjrfIEWB/KVw8/c/ZWT99wxC4wmInMWXe/Wc6pRWn
         dF7NahRlAUeFwJXYQ61M52lwxidDej+GbzslCsV0rimsF/79wdgYWdzuQurgeLXx7HTu
         IuZ0y5brz8PLRu5KPopmtxtPu6jvZkkYV4Mm/MPb1vQYbuqtE1VZtx3jBwxXC+soLo9X
         nD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648967; x=1790253767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3XOkTTYIjCOyk/autE/aPM8JwQM44JJhJTWr5dHFho=;
        b=08fQcxO81+AuzsVaqfNJt98WBJythwAX2/rayEtohNLtdAJquewVhZn897C8oEwjy4
         VeuKrxMe+wDL/ihHWVVZHe1oXbn8nD6ypyhCUgEpkZ15U4vhANdilRQHalUODQ0jGXdZ
         fn9x0xx6BcxfnO/eH0gSL5P0uRLJMNh+IW8RK+xOueak0ZgiKPs1SpYsjjv/fOOsRSjd
         yEkJSMzL8VxirFrOwod/F4sJ6EozeNlLIqrSEbNjKYcR6hepb5GwYMhUZqQDGOkRCEtK
         owms2SQhSfx18/Gl85WpSwyssStvBcnIgBwBYZV0ySEOdtD23+dzPWDC9eRVMHL80a1R
         +rvA==
X-Forwarded-Encrypted: i=1; AKwUvBx0QK1L0CceGfMvu5dwRe9OdPFPhSxGtD/fVC/l4Yx0hZ9m6KleVSFeB+y/V5HhXzudCJj9qhz9sWRA3XL6e5s=@vger.kernel.org
X-Gm-Message-State: AFuF++kAVv8jy5nBkI+4V1S4sgwMFDX2kcMuyBkmKaxyKdRQiWK9UHuk
	wIK3NU6PDZ5sV5/vG4u1ecnFbLO0myAV8ug5bxoJxLrWou7BtpzdaG6P
X-Gm-Gg: AYBFou2xrvibTnAnH8g1W8MXXnZQgoBp7igdH6PXhbLRjD9DKjwJFgMw/4Q7fgri6sO
	zIXGy5VCJ5pBdtFqoi6rdWuwUXvbSlpkPcYUzi4bXnQizUodp+LYC/SawslYnOKv/2Z04XJJITD
	vQQIcbfHD+M/AY9hgm6kTA0tUKpf4UoSU9omrbVo+NGU4hyW6+re2ZgaIvC/CahH7f3gEpdbYxl
	spHRFa+sKneys2etMtmuhSo0FrsaFvG6JBDqrPflyFjdmAuqtTqqTsD7s72skBUsc1NYhrGL4pK
	h+KnPP+oltyC8TetzqNYKE9w5y3ZnN+bOPoO9KapUbRpFT6A5kgJ8ZLYkRWmWo0WD851MtvrkYl
	kob2QQXXWotHiSc8JzlBh+nzY9XmnF+ExfagwUgGo5ex9OgAxHaHx16e0CrTubTsioN4caMko/W
	DMaBu+YSkkSMZT+KnTe8grQ38CYg0UMG/wqSvZcNUuPb7LW4uoUmjCVN+BKJTQkdNlMu6noqNOf
	9uFGRv1dLhRgy/AsVe+bMGySIgZBhG1PdTA4jW0jEDVvfKf9ZKH/ys1qK3DiPUfO/+6fANBAM2o
	rJa17c4xhKIHzGygfERb8A==
X-Received: by 2002:a05:600c:350d:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-49eb73253ebmr75509995e9.20.1789648966979;
        Thu, 17 Sep 2026 05:42:46 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd226ee5sm80976605e9.3.2026.09.17.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:42:46 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v1 1/1] tpm: tis_i2c: Deassert optional reset line before probing
Date: Thu, 17 Sep 2026 14:42:11 +0200
Message-ID: <20260917124211.136221-1-stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

The common TPM Device Tree binding already documents resets and
reset-gpios, but the TIS I2C driver never requests a reset control.
As a result, an I2C TPM held in reset by board wiring remains
inaccessible and the first register access during probe fails.

Request the optional reset control and deassert it before
communicating with the TPM. This keeps existing boards without a reset
line unchanged while allowing platforms using resets or reset-gpios to
release the TPM before probe continues.

Tested on a Variscite DART-MX95 with an ST33KTPM2XI2C TPM using
reset-gpios.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index d55f30fef00a..cde0b093ed58 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -12,6 +12,7 @@
 
 #include <linux/i2c.h>
 #include <linux/crc-ccitt.h>
+#include <linux/reset.h>
 #include "tpm_tis_core.h"
 
 /* TPM registers */
@@ -330,6 +331,7 @@ static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
 static int tpm_tis_i2c_probe(struct i2c_client *dev)
 {
 	struct tpm_tis_i2c_phy *phy;
+	struct reset_control *reset;
 	const u8 crc_enable = 1;
 	const u8 locality = 0;
 	int ret;
@@ -346,6 +348,16 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
 	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
 	phy->i2c_client = dev;
 
+	reset = devm_reset_control_get_optional_exclusive(&dev->dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(&dev->dev, PTR_ERR(reset),
+				     "failed to get reset control\n");
+
+	ret = reset_control_deassert(reset);
+	if (ret)
+		return dev_err_probe(&dev->dev, ret,
+				     "failed to deassert reset\n");
+
 	/* must precede all communication with the tpm */
 	ret = tpm_tis_i2c_init_guard_time(phy);
 	if (ret)
-- 
2.47.3

