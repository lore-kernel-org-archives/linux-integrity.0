Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754427AbeFTQUM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 12:20:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGFsbX141457
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:20:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqt7n89m0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 12:20:09 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 10:20:07 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 6/6] ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead
Date: Wed, 20 Jun 2018 12:19:48 -0400
In-Reply-To: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180620161948.1464255-7-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Get rid of ima_used_chip and use ima_tpm_chip variable instead for
determining whether to use the TPM chip.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        | 1 -
 security/integrity/ima/ima_crypto.c | 2 +-
 security/integrity/ima/ima_init.c   | 7 ++-----
 security/integrity/ima/ima_queue.c  | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 53a88d578ca5..18491c0e9b97 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -54,7 +54,6 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 extern int ima_policy_flag;
 
 /* set during initialization */
-extern int ima_used_chip;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct rw_semaphore ima_tpm_chip_lock;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index da7715240476..bc6ad6b3243a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -635,7 +635,7 @@ static void __init ima_pcrread(int idx, u8 *pcr)
 
 	down_read(&ima_tpm_chip_lock);
 
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		goto out;
 
 	result = tpm_pcr_read(ima_tpm_chip, idx, pcr);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 24db06c4f463..84fba44c4415 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -27,7 +27,6 @@
 
 /* name for boot aggregate entry */
 static const char *boot_aggregate_name = "boot_aggregate";
-int ima_used_chip;
 struct rw_semaphore ima_tpm_chip_lock = __RWSEM_INITIALIZER(ima_tpm_chip_lock);
 struct tpm_chip *ima_tpm_chip;
 
@@ -67,7 +66,7 @@ static int __init ima_add_boot_aggregate(void)
 	iint->ima_hash->algo = HASH_ALGO_SHA1;
 	iint->ima_hash->length = SHA1_DIGEST_SIZE;
 
-	if (ima_used_chip) {
+	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
@@ -114,7 +113,6 @@ static int ima_shutdown(struct notifier_block *this, unsigned long action,
 	if (ima_tpm_chip) {
 		tpm_chip_put(ima_tpm_chip);
 		ima_tpm_chip = NULL;
-		ima_used_chip = 0;
 	}
 	up_write(&ima_tpm_chip_lock);
 	return NOTIFY_DONE;
@@ -133,8 +131,7 @@ int __init ima_init(void)
 
 	ima_tpm_chip = tpm_chip_find();
 
-	ima_used_chip = (ima_tpm_chip != NULL);
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		pr_info("No TPM chip found, activating TPM-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 6c9427939a28..591ff3d76fe6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -143,7 +143,7 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 	int result = 0;
 
 	down_read(&ima_tpm_chip_lock);
-	if (!ima_used_chip)
+	if (!ima_tpm_chip)
 		goto out;
 
 	result = tpm_pcr_extend(ima_tpm_chip, pcr, hash);
-- 
2.13.6
