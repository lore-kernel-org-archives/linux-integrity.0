Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33119 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdLYCW5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 21:22:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id g130so31968747wme.0
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 18:22:56 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2 1/3] tpm: delete the TPM_TIS_CLK_ENABLE flag
Date: Mon, 25 Dec 2017 03:22:49 +0100
Message-Id: <20171225022251.6464-2-javierm@redhat.com>
In-Reply-To: <20171225022251.6464-1-javierm@redhat.com>
References: <20171225022251.6464-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This flag is only used to warn if CLKRUN_EN wasn't disabled on Braswell
systems, but the only way this can happen is if the code is not correct.

So it's an unnecessary check that just makes the code harder to read.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---

 drivers/char/tpm/tpm_tis.c      | 15 ---------------
 drivers/char/tpm/tpm_tis_core.c |  2 --
 drivers/char/tpm/tpm_tis_core.h |  1 -
 3 files changed, 18 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index c847fc69a2fc..4b73e28458e3 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -138,9 +138,6 @@ static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
@@ -152,9 +149,6 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
@@ -165,9 +159,6 @@ static int tpm_tcg_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	*result = ioread16(phy->iobase + addr);
 
 	return 0;
@@ -177,9 +168,6 @@ static int tpm_tcg_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	*result = ioread32(phy->iobase + addr);
 
 	return 0;
@@ -189,9 +177,6 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	if (is_bsw() && !(data->flags & TPM_TIS_CLK_ENABLE))
-		WARN(1, "CLKRUN not enabled!\n");
-
 	iowrite32(value, phy->iobase + addr);
 
 	return 0;
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index dc3600fc79b7..f2bd99fa8352 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -751,7 +751,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 		return;
 
 	if (value) {
-		data->flags |= TPM_TIS_CLK_ENABLE;
 		data->clkrun_enabled++;
 		if (data->clkrun_enabled > 1)
 			return;
@@ -782,7 +781,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 		 * sure LPC clock is running before sending any TPM command.
 		 */
 		outb(0xCC, 0x80);
-		data->flags &= ~TPM_TIS_CLK_ENABLE;
 	}
 }
 
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index afc50cde1ba6..d5c6a2e952b3 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -86,7 +86,6 @@ enum tis_defaults {
 
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
-	TPM_TIS_CLK_ENABLE		= BIT(1),
 };
 
 struct tpm_tis_data {
-- 
2.14.3
