Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:5448 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752472AbdKCXaK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 19:30:10 -0400
From: Azhar Shaikh <azhar.shaikh@intel.com>
To: jarkko.sakkinen@intel.com, linux-integrity@vger.kernel.org
Cc: azhar.shaikh@intel.com
Subject: [PATCH RFC] tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
Date: Fri,  3 Nov 2017 16:30:09 -0700
Message-Id: <1509751809-148601-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Commit 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell
systems") disabled CLKRUN protocol during TPM transactions and re-enabled
once the transaction is completed. But there were still some corner cases
observed where, reading of TPM header failed for savestate command
while going to suspend, which resulted in suspend failure.
To fix this issue keep the CLKRUN protocol disabled for the entire
duration of a single TPM command and not disabling and re-enabling
again for every TPM transaction.

Fixes: 5e572cab92f0bb5 ("tpm: Enable CLKRUN protocol for Braswell systems")

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
 drivers/char/tpm/tpm-interface.c |  4 ++++
 drivers/char/tpm/tpm_tis.c       | 39 +++++++++++++++++----------------------
 drivers/char/tpm/tpm_tis_core.c  | 27 +++++++++++++++++++++++++++
 drivers/char/tpm/tpm_tis_core.h  | 13 +++++++++++++
 include/linux/tpm.h              |  1 +
 5 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1d6729be4cd6..5a1f48f41e0d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -413,6 +413,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (chip->dev.parent)
 		pm_runtime_get_sync(chip->dev.parent);
 
+	chip->ops->clk_toggle(chip, true);
+
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
@@ -489,6 +491,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		chip->locality = -1;
 	}
 out_no_locality:
+	chip->ops->clk_toggle(chip, false);
+
 	if (chip->dev.parent)
 		pm_runtime_put_sync(chip->dev.parent);
 
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e2d1055fb814..c7b1deaa1b75 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -148,12 +148,13 @@ static inline bool is_bsw(void)
 
 /**
  * tpm_platform_begin_xfer() - clear LPC CLKRUN_EN i.e. clocks will be running
+ * @data:	struct tpm_tis_data instance
  */
-static void tpm_platform_begin_xfer(void)
+void tpm_platform_begin_xfer(struct tpm_tis_data *data)
 {
 	u32 clkrun_val;
 
-	if (!is_bsw())
+	if (!is_bsw() || (data->flags & TPM_TIS_CLK_ENABLE))
 		return;
 
 	clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
@@ -172,12 +173,13 @@ static void tpm_platform_begin_xfer(void)
 
 /**
  * tpm_platform_end_xfer() - set LPC CLKRUN_EN i.e. clocks can be turned off
+ * @data:	struct tpm_tis_data instance
  */
-static void tpm_platform_end_xfer(void)
+void tpm_platform_end_xfer(struct tpm_tis_data *data)
 {
 	u32 clkrun_val;
 
-	if (!is_bsw())
+	if (!is_bsw() || (data->flags & TPM_TIS_CLK_ENABLE))
 		return;
 
 	clkrun_val = ioread32(ilb_base_addr + LPC_CNTRL_REG_OFFSET);
@@ -193,19 +195,12 @@ static void tpm_platform_end_xfer(void)
 	outb(0xCC, 0x80);
 
 }
+
 #else
 static inline bool is_bsw(void)
 {
 	return false;
 }
-
-static void tpm_platform_begin_xfer(void)
-{
-}
-
-static void tpm_platform_end_xfer(void)
-{
-}
 #endif
 
 static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
@@ -213,12 +208,12 @@ static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	while (len--)
 		*result++ = ioread8(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -228,12 +223,12 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	while (len--)
 		iowrite8(*value++, phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -242,11 +237,11 @@ static int tpm_tcg_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	*result = ioread16(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -255,11 +250,11 @@ static int tpm_tcg_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	*result = ioread32(phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
@@ -268,11 +263,11 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	tpm_platform_begin_xfer();
+	tpm_platform_begin_xfer(data);
 
 	iowrite32(value, phy->iobase + addr);
 
-	tpm_platform_end_xfer();
+	tpm_platform_end_xfer(data);
 
 	return 0;
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdde971bc810..b1e48673e672 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -661,6 +661,32 @@ void tpm_tis_remove(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_tis_remove);
 
+#ifdef CONFIG_X86
+/**
+ * tpm_tis_clkrun_toggle() - Keep clkrun protocol disabled for entire duration
+ *                           of a single TPM command
+ * @chip:	TPM chip to use
+ * @value:	1 - Disable CLKRUN protocol, so that clocks are free running
+ *		0 - Enable CLKRUN protocol
+ */
+static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
+{
+	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
+
+	if (value) {
+		tpm_platform_begin_xfer(data);
+		data->flags |= TPM_TIS_CLK_ENABLE;
+	} else {
+		data->flags &= ~TPM_TIS_CLK_ENABLE;
+		tpm_platform_end_xfer(data);
+	}
+}
+#else
+static void tpm_tis_clkrun_toggle(struct tpm_chip *chip, bool value)
+{
+}
+#endif
+
 static const struct tpm_class_ops tpm_tis = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = tpm_tis_status,
@@ -673,6 +699,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
 	.req_canceled = tpm_tis_req_canceled,
 	.request_locality = request_locality,
 	.relinquish_locality = release_locality,
+	.clk_toggle = tpm_tis_clkrun_toggle,
 };
 
 int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6bbac319ff3b..71bdf03039f4 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -81,6 +81,7 @@ enum tis_defaults {
 
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
+	TPM_TIS_CLK_ENABLE		= BIT(1),
 };
 
 struct tpm_tis_data {
@@ -153,4 +154,16 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 int tpm_tis_resume(struct device *dev);
 #endif
 
+#ifdef CONFIG_X86
+void tpm_platform_begin_xfer(struct tpm_tis_data *data);
+void tpm_platform_end_xfer(struct tpm_tis_data *data);
+#else
+void tpm_platform_begin_xfer(struct tpm_tis_data *data)
+{
+}
+void tpm_platform_end_xfer(struct tpm_tis_data *data)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 5a090f5ab335..10753ec56d0a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -50,6 +50,7 @@ struct tpm_class_ops {
 				unsigned long *timeout_cap);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
 	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
+	void (*clk_toggle)(struct tpm_chip *chip, bool value);
 };
 
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
-- 
1.9.1
