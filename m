Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754407AbeFTQUC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 12:20:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGECxE029694
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:20:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsmnt0a1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:20:01 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 10:20:00 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 2/6] tpm: Get additional kref with every call to tpm_try_get_ops()
Date: Wed, 20 Jun 2018 12:19:44 -0400
In-Reply-To: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180620161948.1464255-3-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Get a reference to the TPM chip on every call to tpm_try_get_ops()
and release the reference in tpm_put_ops().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 5 ++++-
 include/linux/tpm.h         | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index a933676194a4..23b667c730f6 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -58,6 +58,8 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 	if (!chip->ops)
 		goto out_lock;
 
+	kref_get(&chip->kref);
+
 	return 0;
 out_lock:
 	up_read(&chip->ops_sem);
@@ -77,6 +79,7 @@ void tpm_put_ops(struct tpm_chip *chip)
 {
 	up_read(&chip->ops_sem);
 	put_device(&chip->dev);
+	tpm_chip_put(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
@@ -129,7 +132,7 @@ static void tpm_chip_free(struct kref *kref)
 	kfree(chip);
 }
 
-static void tpm_chip_put(struct tpm_chip *chip)
+void tpm_chip_put(struct tpm_chip *chip)
 {
 	if (chip)
 		kref_put(&chip->kref, tpm_chip_free);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 06639fb6ab85..cdb3ecdfc933 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -61,6 +61,7 @@ extern int tpm_seal_trusted(struct tpm_chip *chip,
 extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
+extern void tpm_chip_put(struct tpm_chip *chip);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -96,5 +97,8 @@ static inline int tpm_unseal_trusted(struct tpm_chip *chip,
 {
 	return -ENODEV;
 }
+static inline void tpm_chip_put(struct tpm_chip *chip)
+{
+}
 #endif
 #endif
-- 
2.13.6
