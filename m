Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6D446075;
	Tue, 15 Sep 2026 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503165; cv=none; b=EwlGm7d7NUO9Gq0RpOFk+dINoqzGijstqjagxHrrBcrdRNApOuncHUVIp5bEQy+pUS/sepoc9pX2eSpsMX/w0M4NJLE+ZTZ6Bwx2JYlsBQnrn3O6k1hSq+YNuSA0I6eg1oRm+DMGTJlK8Ocmwj4at4p8GUM+nSZlEYNk0/h8Q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503165; c=relaxed/simple;
	bh=n8kA8z5IAQ2DNDYl9JoppnmxWiw0Te9FFMhhhGZ7x2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MA8H9OG41bYXA/i5NoYd6e68yxAQh5dLCeEe/sCZ2fEzvxnLoU6YN6o4rtI40yLey3yyIXwI/aMz0D+qzzNafACj01sVOqpHhkEPy6Ip46R2Dq8Abyqq4dnuvU+/CHRnUqd3kzEC4bieGZtzWaSs8wwN0KbdNNkntW5W67bVoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQST8Svb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQST8Svb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C301F000FF;
	Tue, 15 Sep 2026 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503164;
	bh=HwkSK33A6r89PxbOj+v6/6AqFQUJhWyvWEsw9Um63qY=;
	h=From:To:Cc:Subject:Date;
	b=AQST8Svb3ixrEnBNli0Gy6y+7yjKEr8STeUVD8fpRGi5l19vEdaz81gGnQ/AwkzOa
	 HWnl20iv/TPjPTckdH8/FxTyCOi8NyagTMYf2j6TWdG1z+PKhH9bATRHoashKJVlg5
	 LgV5QOs4SN0iM3R4x/dhu7aWhKiubT7c7C12f+oMyAymm2vCMIC+QKzhVhXJ7rRzs2
	 xYmQT8PbHzMxldiGori6zBJmceuUMI/gil3WK3TuVbD5qVE5LLdjTbBAwAzT4rjjtv
	 ZR0rnK/rdddHE/nzeebHahOH3g/pfY54t0C65mFptwHX8McczO89n5Ur7Ixl2YSLsT
	 edXUjtybCOJ0w==
From: Arnd Bergmann <arnd@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Li Jun <lijun01@kylinos.cn>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jim Broadus <jbroadus@gmail.com>,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: fix build regression for tpm_tis_resume
Date: Tue, 15 Sep 2026 22:12:29 +0200
Message-ID: <20260915201239.3529332-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Using DEFINE_SIMPLE_DEV_PM_OPS means that there is no a code reference
to the unused tpm_tis_resume, but that fails here since the declaration
is hidden:

drivers/char/tpm/tpm_tis_i2c.c:322:61: error: 'tpm_tis_resume' undeclared here (not in a function); did you mean 'tpm_tis_remove'?
  322 | static DEFINE_SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
      |                                                             ^~~~~~~~~~~~~~

Remove the incorrect #ifdef.

Fixes: 2249200ee420 ("tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/tpm/tpm_tis_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index d737b3d67411..741130056876 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -161,8 +161,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		      const struct tpm_tis_phy_ops *phy_ops,
 		      acpi_handle acpi_dev_handle);
 
-#ifdef CONFIG_PM_SLEEP
 int tpm_tis_resume(struct device *dev);
-#endif
 
 #endif
-- 
2.53.0

