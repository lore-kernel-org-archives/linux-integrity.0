Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38600 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeFHHLv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jun 2018 03:11:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id b14-v6so7756107pls.5
        for <linux-integrity@vger.kernel.org>; Fri, 08 Jun 2018 00:11:51 -0700 (PDT)
From: Louis Collard <louiscollard@chromium.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH] tpm: Allow tpm_tis drivers to set hwrng quality.
Date: Fri,  8 Jun 2018 15:11:46 +0800
Message-Id: <20180608071146.110567-1-louiscollard@chromium.org>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Adds plumbing required for drivers based on tpm_tis to set hwrng quality.

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
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
