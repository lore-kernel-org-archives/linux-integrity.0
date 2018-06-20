Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933136AbeFTUmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 16:42:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKemi4012885
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 16:42:45 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqswvau5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 16:42:45 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 14:42:44 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put() for other subsystems
Date: Wed, 20 Jun 2018 16:42:33 -0400
In-Reply-To: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Implement tpm_chip_find() for other subsystems to find a TPM chip and
get a reference to that chip. Once done with using the chip, the reference
is released using tpm_chip_put().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h         |  9 +++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0a62c19937b6..eaaf41ce73d8 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -81,6 +81,43 @@ void tpm_put_ops(struct tpm_chip *chip)
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
 /**
+ * tpm_chip_put() - Release a ref to the tpm_chip
+ * @chip: Chip to put
+ */
+void tpm_chip_put(struct tpm_chip *chip)
+{
+	if (chip)
+		put_device(&chip->dev);
+}
+
+/**
+ * tpm_chip_find() - find a TPM chip and get a reference to it
+ */
+struct tpm_chip *tpm_chip_find(void)
+{
+	struct tpm_chip *chip, *res = NULL;
+	int chip_num = 0;
+	int chip_prev;
+
+	mutex_lock(&idr_lock);
+
+	do {
+		chip_prev = chip_num;
+		chip = idr_get_next(&dev_nums_idr, &chip_num);
+		if (chip) {
+			get_device(&chip->dev);
+			res = chip;
+			break;
+		}
+	} while (chip_prev != chip_num);
+
+	mutex_unlock(&idr_lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_find);
+
+/**
  * tpm_chip_find_get() - find and reserve a TPM chip
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  *
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 06639fb6ab85..f0d1abcaf4af 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -61,6 +61,8 @@ extern int tpm_seal_trusted(struct tpm_chip *chip,
 extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
+extern struct tpm_chip *tpm_chip_find(void);
+extern void tpm_chip_put(struct tpm_chip *chip);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -96,5 +98,12 @@ static inline int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	return -ENODEV;
 }
+static inline struct tpm_chip *tpm_chip_find(void)
+{
+	return NULL;
+}
+static inline void tpm_chip_put(struct tpm_chip *chip)
+{
+}
 #endif
 #endif
-- 
2.13.6
