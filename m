Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C548C07E9D
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Jul 2021 13:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015CC61073
	for <linux-integrity@archiver.kernel.org>; Mon, 19 Jul 2021 13:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhGSMzZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 19 Jul 2021 08:55:25 -0400
Received: from smtp1.axis.com ([195.60.68.17]:51429 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238910AbhGSMzZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 08:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1626701765;
  x=1658237765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rG79cmaur5aZ2uT+KGBQlc1kQUYbY7EHtaaEJwD1afE=;
  b=Fz/kwcYY00mcIqLrVq5yL14NszIC8uRGLZnZ4QyCGQMQqVbQYA+BLt2Y
   hzDNuJI+lMJWwcyRGKFEfyYlLIJ8WZxOuVSO6+Gnpm24+E/o8vSGorzFk
   wCwIOgW6bfX1HdRSWA6GTQThpq0jSEUn1kei03k9WvXVf1ZnU6qGk4pwt
   A+wioB/JEMjuicb1mdNKRmVXKD2XUngyRjEidQRbeH4jKRVKM6/plWkA5
   EkKg9blimR488NrMXAw9zlrjZx7I6F5u6evh1oxYplDhpHQglY10MKgI4
   vMp6aXqPs9eMKj0gJeGRefVy3kNJAyr2shXBTtBeJgRxEDm8O7DbTUFrJ
   A==;
From:   Borys Movchan <borysmn@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <kernel@axis.com>, Borys Movchan <borysmn@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Date:   Mon, 19 Jul 2021 15:37:17 +0200
Message-ID: <20210719133717.18797-1-borysmn@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail03w.axis.com (10.20.40.9) To XBOX07.axis.com
 (10.0.15.177)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On some systems, especially embedded, TPM might start in
Upgrade/Reduced mode due to the previous failure of a firmware
upgrade process. Allow the TPM driver to handle such situations
properly. Enables a possibility for userspace application to
finalize TPM upgrade or recovery if required.

Signed-off-by: Borys Movchan <borysmn@axis.com>
---
 drivers/char/tpm/tpm-chip.c | 23 +++++++++++++++--------
 drivers/char/tpm/tpm2-cmd.c | 12 ++++++++++--
 include/linux/tpm.h         |  1 +
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..ff2367c447fb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -574,20 +574,25 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
+	bool limited_mode = false;
 
 	rc = tpm_chip_start(chip);
 	if (rc)
 		return rc;
 	rc = tpm_auto_startup(chip);
-	if (rc) {
+	if (rc == -EIO) {
+		limited_mode = true;
+	} else if (rc) {
 		tpm_chip_stop(chip);
 		return rc;
 	}
 
-	rc = tpm_get_pcr_allocation(chip);
-	tpm_chip_stop(chip);
-	if (rc)
-		return rc;
+	if (!limited_mode) {
+		rc = tpm_get_pcr_allocation(chip);
+		tpm_chip_stop(chip);
+		if (rc)
+			return rc;
+	}
 
 	tpm_sysfs_add_device(chip);
 
@@ -595,9 +600,11 @@ int tpm_chip_register(struct tpm_chip *chip)
 
 	tpm_add_ppi(chip);
 
-	rc = tpm_add_hwrng(chip);
-	if (rc)
-		goto out_ppi;
+	if (!limited_mode) {
+		rc = tpm_add_hwrng(chip);
+		if (rc)
+			goto out_ppi;
+	}
 
 	rc = tpm_add_char_device(chip);
 	if (rc)
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a25815a6f625..7468353ed67d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -718,7 +718,8 @@ static int tpm2_startup(struct tpm_chip *chip)
  *                     sequence
  * @chip: TPM chip to use
  *
- * Returns 0 on success, < 0 in case of fatal error.
+ * Returns 0 on success, -ENODEV in case of fatal error,
+ *	    -EIO in case of Reduced/Upgrade mode
  */
 int tpm2_auto_startup(struct tpm_chip *chip)
 {
@@ -729,7 +730,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		goto out;
 
 	rc = tpm2_do_selftest(chip);
-	if (rc && rc != TPM2_RC_INITIALIZE)
+	if (rc == TPM2_RC_UPGRADE) {
+		rc = -EIO;
+		goto out;
+	} else if (rc && rc != TPM2_RC_INITIALIZE)
 		goto out;
 
 	if (rc == TPM2_RC_INITIALIZE) {
@@ -743,6 +747,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
+	if (rc) { /* Succeeded until here, but failed -> reduced mode */
+		rc = -EIO;
+		goto out;
+	}
 
 out:
 	if (rc > 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..e873c42907f0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -207,6 +207,7 @@ enum tpm2_return_codes {
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_UPGRADE		= 0x012D,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
-- 
2.20.1

