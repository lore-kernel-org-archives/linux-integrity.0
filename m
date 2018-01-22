Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbeAVOyj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEqrTQ088722
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fnfnqevrm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:38 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:35 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 10/10] ima-evm-utils: add support for validating multiple pcrs
Date: Mon, 22 Jan 2018 09:54:05 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-11-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The IMA measurement list may contain records for different PCRs.  This
patch walks the measurement list, calculating a PCR aggregate value for
each PCR.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/evmctl.c | 44 +++++++++++++++++++++++++++-----------------
 src/imaevm.h |  3 +++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9142ed4..5029235 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1417,13 +1417,16 @@ int ima_ng_show(struct template_entry *entry)
 
 static int ima_measurement(const char *file)
 {
-	uint8_t pcr[SHA_DIGEST_LENGTH] = {0,};
-	uint8_t pcr10[SHA_DIGEST_LENGTH];
+	uint8_t pcr[NUM_PCRS][SHA_DIGEST_LENGTH] = {{0}};
+	uint8_t hwpcr[SHA_DIGEST_LENGTH];
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
 	int err = -1;
-	int verify_sig_failed = 0;
+	bool verify_sig_failed[NUM_PCRS] = {0,};
+	bool verify_failed = false;
+	int i;
 
+	memset(zero, 0, SHA_DIGEST_LENGTH);
 	memset(fox, 0xff, SHA_DIGEST_LENGTH);
 
 	log_debug("Initial PCR value: ");
@@ -1440,7 +1443,8 @@ static int ima_measurement(const char *file)
 		init_public_keys(params.keyfile);
 
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
-		ima_extend_pcr(pcr, entry.header.digest, SHA_DIGEST_LENGTH);
+		ima_extend_pcr(pcr[entry.header.pcr], entry.header.digest,
+			       SHA_DIGEST_LENGTH);
 
 		if (!fread(entry.name, entry.header.name_len, 1, fp)) {
 			log_err("Unable to read template name\n");
@@ -1472,29 +1476,35 @@ static int ima_measurement(const char *file)
 			ima_show(&entry);
 		} else {
 			if (ima_ng_show(&entry) != 0)
-				verify_sig_failed = 1;
+				verify_sig_failed[entry.header.pcr] = true;
 		}
 	}
 
-	tpm_pcr_read(10, pcr10, sizeof(pcr10));
 
-	log_info("PCRAgg: ");
-	log_dump(pcr, sizeof(pcr));
+	for (i = 0; i < NUM_PCRS; i++) {
+		if (memcmp(pcr[i], zero, SHA_DIGEST_LENGTH) == 0)
+			continue;
+
+		log_info("PCRAgg %.2d: ", i);
+		log_dump(pcr[i], SHA_DIGEST_LENGTH);
 
-	log_info("PCR-10: ");
-	log_dump(pcr10, sizeof(pcr10));
+		tpm_pcr_read(i, hwpcr, sizeof(hwpcr));
+		log_info("HW PCR-%d: ", i);
+		log_dump(hwpcr, sizeof(hwpcr));
 
-	if (memcmp(pcr, pcr10, sizeof(pcr))) {
-		log_err("PCRAgg does not match PCR-10\n");
-		goto out;
-	} else if (verify_sig_failed == 1) {
-		log_err("PCRAgg matches PCR-10, but list contains unknown keys or invalid signatures\n");
+		if (memcmp(pcr[i], hwpcr, sizeof(SHA_DIGEST_LENGTH)) != 0) {
+			log_err("PCRAgg %d does not match HW PCR-%d\n", i, i);
+
+			verify_failed = true;
+		} else if (verify_sig_failed[i] == true) {
+			log_err("PCRAgg %d matches PCR-%d, but list contains unknown keys or invalid signatures\n", i, i);
+		}
 	}
 
-	err = 0;
+	if (!verify_failed)
+		err = 0;
 out:
 	fclose(fp);
-
 	return err;
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index d624571..0507947 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -188,6 +188,9 @@ struct RSA_ASN1_template {
 	size_t size;
 };
 
+#define	NUM_PCRS 20
+#define DEFAULT_PCR 10
+
 extern const struct RSA_ASN1_template RSA_ASN1_templates[PKEY_HASH__LAST];
 extern struct libevm_params params;
 
-- 
2.7.4
