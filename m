Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:54471 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdLNQHC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 11:07:02 -0500
From: Alexander Steffen <Alexander.Steffen@infineon.com>
To: <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC: Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC][PATCH 1/3] tpm-chip: Move idr_replace calls to appropriate places
Date: Thu, 14 Dec 2017 17:06:12 +0100
Message-ID: <20171214160614.11808-2-Alexander.Steffen@infineon.com>
In-Reply-To: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
References: <20171214160614.11808-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

According to the comments, adding/removing the chip from the list should be
the first/last action in (un)register. But currently it is done in a
subfunction in the middle of the process. Moving the code from the
subfunctions to the appropriate places within (un)register ensures that the
code matches the comments.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm-chip.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index a114e8f..25ebe49 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -321,11 +321,6 @@ static int tpm_add_char_device(struct tpm_chip *chip)
 		}
 	}
 
-	/* Make the chip available. */
-	mutex_lock(&idr_lock);
-	idr_replace(&dev_nums_idr, chip, chip->dev_num);
-	mutex_unlock(&idr_lock);
-
 	return rc;
 }
 
@@ -333,11 +328,6 @@ static void tpm_del_char_device(struct tpm_chip *chip)
 {
 	cdev_device_del(&chip->cdev, &chip->dev);
 
-	/* Make the chip unavailable. */
-	mutex_lock(&idr_lock);
-	idr_replace(&dev_nums_idr, NULL, chip->dev_num);
-	mutex_unlock(&idr_lock);
-
 	/* Make the driver uncallable. */
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
@@ -432,6 +422,11 @@ int tpm_chip_register(struct tpm_chip *chip)
 		return rc;
 	}
 
+	/* Make the chip available. */
+	mutex_lock(&idr_lock);
+	idr_replace(&dev_nums_idr, chip, chip->dev_num);
+	mutex_unlock(&idr_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_chip_register);
@@ -451,6 +446,11 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+	/* Make the chip unavailable. */
+	mutex_lock(&idr_lock);
+	idr_replace(&dev_nums_idr, NULL, chip->dev_num);
+	mutex_unlock(&idr_lock);
+
 	tpm_del_legacy_sysfs(chip);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-- 
2.7.4
