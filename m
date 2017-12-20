Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39638 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755055AbdLTLfv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Dec 2017 06:35:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id i11so9101526wmf.4
        for <linux-integrity@vger.kernel.org>; Wed, 20 Dec 2017 03:35:50 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 3/4] tpm: follow coding style for variable declaration in tpm_tis_core_init()
Date: Wed, 20 Dec 2017 12:35:37 +0100
Message-Id: <20171220113538.16099-4-javierm@redhat.com>
In-Reply-To: <20171220113538.16099-1-javierm@redhat.com>
References: <20171220113538.16099-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The coding style says "use just one data declaration per line (no commas
for multiple data declarations)" so follow this convention.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/char/tpm/tpm_tis_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 09da1e1adc40..534cd46fdfae 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -798,7 +798,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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
