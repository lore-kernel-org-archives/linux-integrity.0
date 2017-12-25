Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46745 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdLYCW6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 21:22:58 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so30699478wme.5
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 18:22:58 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2 2/3] tpm: follow coding style for variable declaration in tpm_tis_core_init()
Date: Mon, 25 Dec 2017 03:22:50 +0100
Message-Id: <20171225022251.6464-3-javierm@redhat.com>
In-Reply-To: <20171225022251.6464-1-javierm@redhat.com>
References: <20171225022251.6464-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The coding style says "use just one data declaration per line (no commas
for multiple data declarations)" so follow this convention.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---

 drivers/char/tpm/tpm_tis_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index f2bd99fa8352..03daf7017e0f 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -803,7 +803,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		      const struct tpm_tis_phy_ops *phy_ops,
 		      acpi_handle acpi_dev_handle)
 {
-	u32 vendor, intfcaps, intmask;
+	u32 vendor;
+	u32 intfcaps;
+	u32 intmask;
 	u8 rid;
 	int rc, probe;
 	struct tpm_chip *chip;
-- 
2.14.3
