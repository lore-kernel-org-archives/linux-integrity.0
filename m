Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754953AbeFZTat (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 15:30:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QJTTpr109114
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 15:30:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jutw9hy6q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 15:30:49 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 15:30:47 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@liux.vnet.ibm.com>
Subject: [PATCH 1/2] tpm: Implement public tpm_put_chip() to release reference to chip
Date: Tue, 26 Jun 2018 15:30:39 -0400
In-Reply-To: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180626193040.2509798-2-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Some subsystems that got a hold of a TPM chip through tpm_default_chip()
need a way to release the reference to the TPM chip when they shut down.
The tpm_put_chip() function enables this.

Signed-off-by: Stefan Berger <stefanb@liux.vnet.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 10 ++++++++++
 include/linux/tpm.h         |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 46caadca916a..c744289d82e0 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -80,6 +80,16 @@ void tpm_put_ops(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_put_ops);
 
+/**
+ * tpm_put_chip() - Releae a ref to the tpm_chip
+ * @chip: Chip to put
+ */
+void tpm_put_chip(struct tpm_chip *chip)
+{
+	put_device(&chip->dev);
+}
+EXPORT_SYMBOL_GPL(tpm_put_chip);
+
 /**
  * tpm_default_chip() - find a TPM chip and get a reference to it
  */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e0e51c49a0e6..889dafe739e1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -62,6 +62,7 @@ extern int tpm_unseal_trusted(struct tpm_chip *chip,
 			      struct trusted_key_payload *payload,
 			      struct trusted_key_options *options);
 extern struct tpm_chip *tpm_default_chip(void);
+extern void tpm_put_chip(struct tpm_chip *chip);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -101,5 +102,8 @@ static inline struct tpm_chip *tpm_default_chip(void)
 {
 	return NULL;
 }
+static inline void tpm_put_chip(struct tpm_chip *chip)
+{
+}
 #endif
 #endif
-- 
2.17.1
