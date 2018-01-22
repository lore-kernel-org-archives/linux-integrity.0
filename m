Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751121AbeAVOyd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEoI2p037155
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:32 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fne74thd3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:32 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:29 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 06/10] ima-evm-utils: indicate measurement list signature verification failure
Date: Mon, 22 Jan 2018 09:54:01 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-7-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Walking the measurement list and calculating the PCR to compare
against the TPM is only the first step.  The next step is verifying
the file signatures contained in the measurement list.  This patch
differentiates between the two.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/evmctl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index e0ed93d..f791a5b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1333,13 +1333,14 @@ void ima_show(struct template_entry *entry)
 	log_debug_dump(entry->header.digest, sizeof(entry->header.digest));
 }
 
-void ima_ng_show(struct template_entry *entry)
+int ima_ng_show(struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
 	uint32_t field_len;
 	int total_len = entry->template_len, digest_len, len, sig_len;
 	uint8_t *digest, *sig = NULL;
 	char *algo, *path;
+	int err = 0;
 
 	/* get binary digest */
 	field_len = *(uint32_t *)fieldp;
@@ -1392,12 +1393,13 @@ void ima_ng_show(struct template_entry *entry)
 	if (sig) {
 		log_info(" ");
 		log_dump(sig, sig_len);
-		ima_verify_signature(path, sig, sig_len);
+		err = ima_verify_signature(path, sig, sig_len);
 	} else
 		log_info("\n");
 
 	if (total_len)
 		log_err("Remain unprocessed data: %d\n", total_len);
+	return err;
 }
 
 static int ima_measurement(const char *file)
@@ -1407,6 +1409,7 @@ static int ima_measurement(const char *file)
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
 	int err = -1;
+	int verify_sig_failed = 0;
 
 	memset(fox, 0xff, SHA_DIGEST_LENGTH);
 
@@ -1452,10 +1455,12 @@ static int ima_measurement(const char *file)
 		if (validate)
 			ima_verify_template_hash(&entry);
 
-		if (!strcmp(entry.name, "ima"))
+		if (!strcmp(entry.name, "ima")) {
 			ima_show(&entry);
-		else
-			ima_ng_show(&entry);
+		} else {
+			if (ima_ng_show(&entry) != 0)
+				verify_sig_failed = 1;
+		}
 	}
 
 	tpm_pcr_read(10, pcr10, sizeof(pcr10));
@@ -1469,6 +1474,8 @@ static int ima_measurement(const char *file)
 	if (memcmp(pcr, pcr10, sizeof(pcr))) {
 		log_err("PCRAgg does not match PCR-10\n");
 		goto out;
+	} else if (verify_sig_failed == 1) {
+		log_err("PCRAgg matches PCR-10, but list contains unknown keys or invalid signatures\n");
 	}
 
 	err = 0;
-- 
2.7.4
