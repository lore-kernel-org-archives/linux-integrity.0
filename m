Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43291 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934613AbeF2INR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jun 2018 04:13:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so3655844pgw.10
        for <linux-integrity@vger.kernel.org>; Fri, 29 Jun 2018 01:13:17 -0700 (PDT)
From: Louis Collard <louiscollard@chromium.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH v2] tpm: Allow tpm_tis drivers to set hwrng quality.
Date: Fri, 29 Jun 2018 16:12:58 +0800
Message-Id: <20180629081258.155228-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Adds plumbing required for drivers based on tpm_tis to set hwrng quality.

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
Changes since v1:
- based on (hopefully!) correct git tree

 drivers/char/tpm/tpm_tis_core.c | 2 ++
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8b46aaa9e049..d2345d9fd7b5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -875,6 +875,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
 
+	chip->hwrng.quality = priv->rng_quality;
+
 	/* Maximum timeouts */
 	chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index f6e1dbe212a7..f48125f1e6e0 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -99,6 +99,7 @@ struct tpm_tis_data {
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
+	unsigned short rng_quality;
 };
 
 struct tpm_tis_phy_ops {
-- 
2.13.5
