Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE93E6DF7
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465425; cv=none; b=swGso/kkQcROGHlNM65RZGTKupAGDHCigaqnqsZSV/8Hru8/j39LtWsl0kTTHUQV3qXzLY9h90sZcEAgFbmTn+puBgPlrvuFOggEe3tlwmc+uEbKpbhKoZFzQ/o84RmYjsIwyJvBuo3JRxXnR9Zh8I0AOy+LMUoEaddcpaICmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465425; c=relaxed/simple;
	bh=eI8Zz9/DvFlFMyuY5M2n3vkEU8ORZ0dhS33SWMoTOsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyespBCIfIj57+RoSAyi8vTOa/A3v9MGKyMjQDGDydE6Ks71GF0cUccMsXdiIIzQmK0NjsZXZL+hMdJ9HPITRuz1OCzXBPoVQhx3dRfCBCMbNTW3uQqmtHBqTOmnU3aA3xK1aKUT3aOtb2vzElHJZqVHRUZ+NJ+z7NChqrIBsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi6ZWTt7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi6ZWTt7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c825c88744so934815ad.1
        for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2026 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782465423; x=1783070223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxAYIQj9s5X+fT9D5TWK/p2lDh+fqIxSGOdW7cp4vPo=;
        b=bi6ZWTt7yqVJqEldKhaJaSsGWGZ1Mq7Fg7PPAIxaJ8vqjWCSWVrulm9QADFmqsjfFR
         VukDWZPxLhN3e3J4H69jB7xnP0Kilo2S12OYH20sJv/GDDET/TGEEVfJeuljFlTmI0yV
         7OwEpxwReLZAMIujoddu9povTtoyDOGe2IFwkO9pyatjvwb0OGqJdUE2c4HP7CE3q6aC
         dDm4e1aZlROlBhIM5dTcAHoOdjV9d2dPe+DWG1mAcvzF1ozAQhipXNzBSpXKk+cX6HIB
         SPGNB449Aebd4953B+0qcymV4tPIS+uDUqJ3st2S1mFibMhv/eLwIKOLJI83Ws747fvL
         slhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465423; x=1783070223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxAYIQj9s5X+fT9D5TWK/p2lDh+fqIxSGOdW7cp4vPo=;
        b=mT4CQxeRSWfG0uE3ClinJzpSttHVFXz4JGMEDgaTw1KtVurCdkxYmBgrtKKRWIYJ4c
         Y/HoxgmhU39zmi+YEskMM4trDSM6GCtvlTXTUiViBIbUMRR2Dzu4NeJg9jYNA9UEhg6b
         uz5w7p6cgGSIg5qjBU6r9megi+YDue0/shkxziwuP71KdjTyRBGfQjESy/dev6GGFTKI
         PmA4GZSmBXYgTHIxkiEh/C7R7QSsZlYFY27AMQunrNTyFX0mRfSi1eBOy/+il9Le9oEv
         5Pe5HPKkPeI7EVNM5AHicjmCfRevCbYvtprAO3PzY/OwMTUMk5RamEWD5BkXXVMBHUVz
         YFMw==
X-Forwarded-Encrypted: i=1; AHgh+RrRvJFzjCRGbem1QJ3BrKkzSQZhEaiRh4UHHv4mOBsCj2mAkdcKxUb98cPT6smKpGhoTDPqWKIt1EROwyoolcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqAFAPeFIF7WOeH3maEtctOYU96N0dTFlhhMT7vDtM6rkj5Oe
	bZ2IdySMBN/4u1t93jKoYQcIV+lr7AR28ayswVfkeU344GO0nzaaw+Q=
X-Gm-Gg: AfdE7clK08p6ba+CbOX96ewI52AQOOxTX1kBE5JxQ8d+ITRfj0aMqtT/JqlS69asi+W
	VirqThffPH6r4CmGFY1FKR9zxBqwkF/FPLk9GK0sgaJJ/azzvhsuF8+29RLaVhWYd2ESeOb7RYh
	WLA3OLs0h+NTIrtJ7LCsNvESoXs1pPZjeY4klwEkvV6a9QP0ldz0zBelygTSw/HAryglNkYHzRk
	s4fniDWwbrJHoySIdMgfl4r5VvP6VJ5fbUWY2fwrS4KGSxumr7TgMUQEHVV6V13/ArpaPoKan4+
	YjBHp3jjbuXMtohiTCfQ9KBdysi2V0Nn2AtxO+wluxQaAzjfe08cpbugAlzjsLoNAeN0Z0VbbVU
	dTjdyRXLjlJu1K67gKOkd5brMA8HbQnUvJW+yIX64tB0oqax3LXxV+i636xGfBQLno78HX20TUa
	k1EmYj76d+yzOK7I8PdKovQ1qWCsLcOzMNPJBHuo9SHm31d58YZ5IEdydTKugUNfQaiU3FABF7U
	vZT243zWZWnaOnaiy4LqgqLbi84xqU7Sr81WRYOxuTCSLTkRA==
X-Received: by 2002:a17:903:196b:b0:2c7:9e67:c5c6 with SMTP id d9443c01a7336-2c7fc75cbf8mr67096205ad.19.1782465423385;
        Fri, 26 Jun 2026 02:17:03 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b26e6sm35750355ad.52.2026.06.26.02.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 02:17:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
Date: Fri, 26 Jun 2026 18:16:53 +0900
Message-Id: <20260626091653.54929-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_nuvoton_wait_for_stat() enables the IRQ before waiting for the
interrupt handler to report a status change. If the wait times out, or is
interrupted before the handler runs, the function returns without
balancing the enable_irq() call.

Disable the IRQ before leaving the failed wait path. Also preserve an
interrupted wait's original error code instead of converting it to
-ETIMEDOUT inside the helper.

Fixes: 4c336e4b1556 ("tpm: Add support for the Nuvoton NPCT501 I2C TPM")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/char/tpm/tpm_i2c_nuvoton.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index d44903b..aa36730 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -182,8 +182,10 @@ static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
 						      timeout);
 		if (rc > 0)
 			return 0;
-		/* At this point we know that the SINT pin is asserted, so we
-		 * do not need to do i2c_nuvoton_check_status */
+
+		disable_irq(priv->irq);
+		if (rc < 0)
+			return rc;
 	} else {
 		unsigned long ten_msec, stop;
 		bool status_valid;
-- 
2.47.1
