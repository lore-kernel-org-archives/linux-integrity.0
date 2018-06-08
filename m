Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36855 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeFHGyo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jun 2018 02:54:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so5225956plp.3
        for <linux-integrity@vger.kernel.org>; Thu, 07 Jun 2018 23:54:44 -0700 (PDT)
From: Louis Collard <louiscollard@chromium.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH] tpm: Add module parameter for hwrng quality.
Date: Fri,  8 Jun 2018 14:54:38 +0800
Message-Id: <20180608065438.110109-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

It is now possible for drivers to easily specify a hwrng quality, however
most do not currently do this, and in cases where they do, it may be
desirable to override the driver-specified value with a user-specified
one. This patch adds a parameter to set or override the hwrng quality.

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
 drivers/char/tpm/tpm-chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0a62c19937b6..4def49cfc634 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -33,6 +33,11 @@
 DEFINE_IDR(dev_nums_idr);
 static DEFINE_MUTEX(idr_lock);
 
+static short override_rng_quality = -1;
+module_param(override_rng_quality, short, 0644);
+MODULE_PARM_DESC(override_rng_quality,
+		 "tpm-rng quality (overrides values provided by drivers)");
+
 struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
@@ -409,6 +414,13 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
 		 "tpm-rng-%d", chip->dev_num);
 	chip->hwrng.name = chip->hwrng_name;
 	chip->hwrng.read = tpm_hwrng_read;
+	if (override_rng_quality > -1) {
+		dev_info(&chip->dev,
+			 "Overriding hwrng quality for %s: driver default=%d, override=%d",
+			 chip->hwrng.name, chip->hwrng.quality,
+			 override_rng_quality);
+		chip->hwrng.quality = override_rng_quality;
+	}
 	return hwrng_register(&chip->hwrng);
 }
 
-- 
2.13.5
