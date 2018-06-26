Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934606AbeFZLG3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 07:06:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QB4GfY096761
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 07:06:28 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jum2g0u7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 07:06:28 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 07:06:26 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v5 3/5] tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
Date: Tue, 26 Jun 2018 07:06:17 -0400
In-Reply-To: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
References: <20180626110619.2362791-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180626110619.2362791-4-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
is passed in.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index f551061262c9..b01d34983766 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -124,29 +124,23 @@ EXPORT_SYMBOL_GPL(tpm_default_chip);
  */
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
 {
-	struct tpm_chip *res = NULL;
-	int chip_num = 0;
-	int chip_prev;
-
-	mutex_lock(&idr_lock);
+	int rc;
 
-	if (!chip) {
-		do {
-			chip_prev = chip_num;
-			chip = idr_get_next(&dev_nums_idr, &chip_num);
-			if (chip && !tpm_try_get_ops(chip)) {
-				res = chip;
-				break;
-			}
-		} while (chip_prev != chip_num);
-	} else {
+	if (chip) {
 		if (!tpm_try_get_ops(chip))
-			res = chip;
+			return chip;
+		return NULL;
 	}
 
-	mutex_unlock(&idr_lock);
-
-	return res;
+	chip = tpm_default_chip();
+	if (!chip)
+		return NULL;
+	rc = tpm_try_get_ops(chip);
+	/* release additional reference we got from tpm_default_chip() */
+	put_device(&chip->dev);
+	if (!rc)
+		return NULL;
+	return chip;
 }
 
 /**
-- 
2.17.1
