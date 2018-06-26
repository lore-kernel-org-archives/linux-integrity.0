Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753089AbeFZRXn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 13:23:43 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QHJxLZ089678
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 13:23:43 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jupexhu8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 13:23:42 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 11:23:42 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v6 1/5] tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
Date: Tue, 26 Jun 2018 13:23:27 -0400
In-Reply-To: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
References: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180626172331.2505541-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Rename tpm_chip_find_get() to tpm_find_get_ops() to more closely match
the tpm_put_ops() counter part.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c      |  9 ++++++---
 drivers/char/tpm/tpm-interface.c | 14 +++++++-------
 drivers/char/tpm/tpm.h           |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0a62c19937b6..242b716aed5e 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -81,18 +81,21 @@ void tpm_put_ops(struct tpm_chip *chip)
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
 /**
- * tpm_chip_find_get() - find and reserve a TPM chip
+ * tpm_find_get_ops() - find and reserve a TPM chip
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  *
  * Finds a TPM chip and reserves its class device and operations. The chip must
- * be released with tpm_chip_put_ops() after use.
+ * be released with tpm_put_ops() after use.
+ * This function is for internal use only. It supports existing TPM callers
+ * by accepting NULL, but those callers should be converted to pass in a chip
+ * directly.
  *
  * Return:
  * A reserved &struct tpm_chip instance.
  * %NULL if a chip is not found.
  * %NULL if the chip is not available.
  */
-struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
+struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 {
 	struct tpm_chip *res = NULL;
 	int chip_num = 0;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index c43a9e28995e..b4bb34216050 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -929,7 +929,7 @@ int tpm_is_tpm2(struct tpm_chip *chip)
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -953,7 +953,7 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
@@ -1012,7 +1012,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 	u32 count = 0;
 	int i;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -1141,7 +1141,7 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -1261,7 +1261,7 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!out || !num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
@@ -1323,7 +1323,7 @@ int tpm_seal_trusted(struct tpm_chip *chip, struct trusted_key_payload *payload,
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
 
@@ -1351,7 +1351,7 @@ int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	int rc;
 
-	chip = tpm_chip_find_get(chip);
+	chip = tpm_find_get_ops(chip);
 	if (!chip || !(chip->flags & TPM_CHIP_FLAG_TPM2))
 		return -ENODEV;
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7f2d0f489e9c..c38772474091 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -535,7 +535,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
-struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip);
+struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
 
-- 
2.17.1
