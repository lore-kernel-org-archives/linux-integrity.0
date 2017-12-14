Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:56611 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdLNQGv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 11:06:51 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 2/3] tpm-chip: Return TPM error codes from auto_startup functions
Date: Thu, 14 Dec 2017 17:06:13 +0100
Message-ID: <20171214160614.11808-3-Alexander.Steffen@infineon.com>
In-Reply-To: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The auto_startup functions for TPM1 and TPM2 convert all TPM error codes to
ENODEV on exit. But since there is only one caller for those functions,
this code can be consolidated within the caller. Additionally, this allows
the caller to distinguish between a TPM being present (but returning error
responses for some commands) and no TPM being present (or the TPM
malfunctioning completely).

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm-chip.c      | 4 +++-
 drivers/char/tpm/tpm-interface.c | 6 ++----
 drivers/char/tpm/tpm2-cmd.c      | 4 +---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 25ebe49..9cbe1ef 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -398,8 +398,10 @@ int tpm_chip_register(struct tpm_chip *chip)
 			rc = tpm2_auto_startup(chip);
 		else
 			rc = tpm1_auto_startup(chip);
-		if (rc)
+		if (rc < 0)
 			return rc;
+		else if (rc > 0)
+			return -ENODEV;
 	}
 
 	tpm_sysfs_add_device(chip);
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ebe0a1d..38e85ac 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -997,7 +997,8 @@ EXPORT_SYMBOL_GPL(tpm_do_selftest);
  *                     sequence
  * @chip: TPM chip to use
  *
- * Returns 0 on success, < 0 in case of fatal error.
+ * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
+ * a TPM error code.
  */
 int tpm1_auto_startup(struct tpm_chip *chip)
 {
@@ -1012,10 +1013,7 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	return rc;
 out:
-	if (rc > 0)
-		rc = -ENODEV;
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index f40d206..6cda355 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -1045,7 +1045,7 @@ static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
  *                     sequence
  * @chip: TPM chip to use
  *
- * Returns 0 on success, < 0 in case of fatal error.
+ * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_auto_startup(struct tpm_chip *chip)
 {
@@ -1080,8 +1080,6 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
 out:
-	if (rc > 0)
-		rc = -ENODEV;
 	return rc;
 }
 
-- 
2.7.4
