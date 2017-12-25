Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45331 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdLYCXA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 21:23:00 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so30525691wme.4
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 18:22:59 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: James Ettle <james@ettle.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v2 3/3] tpm: only attempt to disable the LPC CLKRUN if is already enabled
Date: Mon, 25 Dec 2017 03:22:51 +0100
Message-Id: <20171225022251.6464-4-javierm@redhat.com>
In-Reply-To: <20171225022251.6464-1-javierm@redhat.com>
References: <20171225022251.6464-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
signal during TPM transactions.

Unfortunately this breaks other devices that are attached to the LPC bus
like for example PS/2 mouse and keyboards.

One flaw with the logic is that it assumes that the CLKRUN is always
enabled, and so it unconditionally enables it after a TPM transaction.

But it could be that the CLKRUN# signal was already disabled in the LPC
bus and so after the driver probes, CLKRUN_EN will remain enabled which
may break other devices that are attached to the LPC bus but don't have
support for the CLKRUN protocol.

Fixes: 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: James Ettle <james@ettle.org.uk>
Tested-by: Jeffery Miller <jmiller@neverware.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---

This patch fixes the bug reported for the Fedora kernel [0] and the kernel
bugzilla [1]. The issue and the propossed solution were discussed in this
[2] thread.

[0]: https://bugzilla.redhat.com/show_bug.cgi?id=1498987
[1]: https://bugzilla.kernel.org/show_bug.cgi?id=197287
[2]: https://patchwork.kernel.org/patch/10119417/


 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 03daf7017e0f..a72a9f03286d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -747,7 +747,8 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
 	u32 clkrun_val;
 
-	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
+	if (!IS_ENABLED(CONFIG_X86) || !is_bsw() ||
+	    !data->ilb_base_addr)
 		return;
 
 	if (value) {
@@ -806,6 +807,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 vendor;
 	u32 intfcaps;
 	u32 intmask;
+	u32 clkrun_val;
 	u8 rid;
 	int rc, probe;
 	struct tpm_chip *chip;
@@ -831,6 +833,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 					ILB_REMAP_SIZE);
 		if (!priv->ilb_base_addr)
 			return -ENOMEM;
+
+		clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
+		/* Check if CLKRUN# is already not enabled in the LPC bus */
+		if (!(clkrun_val & LPC_CLKRUN_EN)) {
+			iounmap(priv->ilb_base_addr);
+			priv->ilb_base_addr = NULL;
+		}
 	}
 
 	if (chip->ops->clk_enable != NULL)
-- 
2.14.3
