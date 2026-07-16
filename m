Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AA220ED
	for <linux-integrity@vger.kernel.org>; Thu, 16 Jul 2026 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160266; cv=none; b=Bgdt1f/WBE4Qohi5GPMHGwvdiIRK9JRam2za7xIXp2V0cm8+anZZGp3f5fzfVeQjuxYYeXCl7gKs/0tQ0O3AGckxjYsLayizKkfIvS7NdhnlzPK2lvI8I/jGFARC4Pb0H7oz+OcKf96hyhMaH3w8gnb+KaJN2NuII0PQO7YL8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160266; c=relaxed/simple;
	bh=cjSbt+GVSzgutghVrfQP8/3UXe81/EKamqssfS+Gc+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StcxLMxQmYTcRVPf9Nr9JvHND7jhhuzOImPUm7uCUTTd5FBaw6zdEl0KKg63kAacpAH5CRIOufuuroMz7i8bNneF+r9uXnqCw+6Wyfu9e0HR38ra7cvhGkyRmX7cTdtn8jFaQ/WTE5dBlJM0W0wpyWzMJaSG1vqqIUuXuJqoKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7gymfd/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7gymfd/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cca0c5799eso34372605ad.0
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jul 2026 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784160265; x=1784765065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1kBdUU9x3GgTo7sRVI3Isnfl0f5gHbcdHM43ihRGMg=;
        b=Q7gymfd/NIpqd3fZoID/tMaf3eXJRddw0YqlkK//DLSU3HtSA5Ce02Et5caxJ58hAz
         uOKkcqXHzxwCTtpHz43s7N0npxWdwM8i+uTt1kCeYPxo03ZdVcES5SdlodcFkBSAcoU1
         yjDiPNZoNn3OxbJDtB1seMnzzfgXPm9NEBH+ScslapduFrh/yIKQNWteMUoNxV/WtQ0k
         Jybju0fZFR6doBK3TVLoPLm9EU7Akb4Q7VQZBNYey8dA/6Lgg2/c2h0mwNMjt/3V79jY
         8kmpXs3Y7tniZhd9A5DLKyo/wkY0rKLW/ysuO1oBRsXnVdHvf+AOv5aMwc5ecCc3iaTo
         ve9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784160265; x=1784765065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1kBdUU9x3GgTo7sRVI3Isnfl0f5gHbcdHM43ihRGMg=;
        b=WnucjI+dp29eZNBFQtjYSs02IOrq6Z0IynL8tQG4OkP4JSLGaMtRuNKclKg0kSXR8C
         I/My+DfnF/qKp9V5oRMdW6mBsYuPAQ65ioRp2UlEeWs/A+JbVHEIKRkBdWxIxlErYHd2
         sQf5m9WnO1Dv9JRWTl016i7Pe6C6WkQ4iOLBSEtPgyH8W8Fmu7sfWuN0Ng+1mgb0nelc
         Leti2CICCvvkyXDT289Zvpo6V+EuajC0kdfc6bZ6JQ5sMZ+cdfuzqdjPgsDhHpJkg4+P
         5+5xce1ff/eLKHk0c6G5j4RfREDGechJPm1oyVWZ/Ga5KwIGldgjERD2W2JlYPaz3RHV
         T3VA==
X-Forwarded-Encrypted: i=1; AHgh+Rpc6u41GbTmcjQnjdoEPv/N1yD2OT8UoiOWkxEjyVkfqb5y9pUKFedrxl5IfKme8aKSS/322hEeTdBb+nrBrO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVgDN58rfwRf7pdGTBJtq9VM1rSfyLW22RPTH4qxHaqluckHu
	n8PkvX7S7gHhYl3bIZEI5YAf799dZfewY+K95Jlgj3Vk4BJLrMumeoTe
X-Gm-Gg: AfdE7cl6jd7E371YCJRaKCLw6DUHgL0G5dyvTd3HEQPoTmr33N46sNbFZfHnEM6iKvk
	mVtGKViIgCUusryFzh6a8nFF74VfOOb7oFed5qn0K0P3mBb6AmkhvA7jLaUdJeMf7x0vOJfGWuj
	JRb7YlvVUT8BPRxOLzZT11vp42F/MhVD58lEtI+pxlOED9UoazK+2wFYCHR4fe9af1tvEB5PEi4
	cDrzkYBhXNkVwqaSHQh6IVZEPFPnqdyVPNDe+6TNs7C63jbS+1i0dP0nNWn4/BjLjhVitz9ol95
	cYoQ33IcmC5GVFNhKI33UFAG83lKqT5hxxYobQNKAbl4y/CplOK1l4olhUOmujOX8c5NnBmhwWy
	SgB2B8oCqoY+sFBxyK8yfCUS0YKSHkMs2v9VStCVNK6UCxCHN443z+x3nkHqqMSG5vl1y2ecPyJ
	HYs89inBfWKa1+75lDTjFPbjRU5xvraudE7IfKwXyPceRv/fKw29fFVlJqim2jXXpZGWMK3jX0W
	g==
X-Received: by 2002:a17:902:d2cf:b0:2c9:97a8:aff4 with SMTP id d9443c01a7336-2ce9f3d8422mr191906295ad.45.1784160264802;
        Wed, 15 Jul 2026 17:04:24 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::9dab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055f193sm10177695ad.46.2026.07.15.17.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:04:24 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH] tpm: use kfree_sensitive() for context and session buffers
Date: Wed, 15 Jul 2026 18:03:55 -0600
Message-ID: <20260716000355.13825-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The context_buf and session_buf fields in struct tpm_space contain
TPM context blobs which may include sensitive cryptographic material.
Use kfree_sensitive() instead of kfree() to ensure the memory is
zeroed before being freed, consistent with how chip->auth is handled
in the same tpm_dev_release() function since commit c424d2664f08
("tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()")

Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/char/tpm/tpm-chip.c   | 4 ++--
 drivers/char/tpm/tpm2-space.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 12b7394b34bd..6f16fc358175 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -244,8 +244,8 @@ static void tpm_dev_release(struct device *dev)
 	idr_remove(&dev_nums_idr, chip->dev_num);
 	mutex_unlock(&idr_lock);
 
-	kfree(chip->work_space.context_buf);
-	kfree(chip->work_space.session_buf);
+	kfree_sensitive(chip->work_space.context_buf);
+	kfree_sensitive(chip->work_space.session_buf);
 #ifdef CONFIG_TCG_TPM2_HMAC
 	kfree_sensitive(chip->auth);
 #endif
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..a7200e6dc462 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -46,7 +46,7 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 	space->session_buf = kzalloc(buf_size, GFP_KERNEL);
 	if (space->session_buf == NULL) {
-		kfree(space->context_buf);
+		kfree_sensitive(space->context_buf);
 		/* Prevent caller getting a dangling pointer. */
 		space->context_buf = NULL;
 		return -ENOMEM;
@@ -64,8 +64,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 		tpm_put_ops(chip);
 	}
 
-	kfree(space->context_buf);
-	kfree(space->session_buf);
+	kfree_sensitive(space->context_buf);
+	kfree_sensitive(space->session_buf);
 }
 
 int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-- 
2.55.0

