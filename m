Return-Path: <SRS0=meRY=NU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D684C43441
	for <linux-integrity@archiver.kernel.org>; Fri,  9 Nov 2018 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AED20840
	for <linux-integrity@archiver.kernel.org>; Fri,  9 Nov 2018 09:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AED20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeKITL3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:11:29 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727519AbeKITL3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Nov 2018 14:11:29 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8002798090E86;
        Fri,  9 Nov 2018 09:31:43 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 9 Nov 2018 09:31:37 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <nayna@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: [PATCH] Apply on top of: tpm: dynamically allocate active_banks array
Date:   Fri, 9 Nov 2018 10:29:25 +0100
Message-ID: <20181109092925.2908-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch checks if a PCR bank is active (at least one bit in the
pcr_select mask is set).
---
 drivers/char/tpm/tpm2-cmd.c | 44 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 533089cede07..eba8f8d00a09 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -854,15 +854,20 @@ struct tpm2_pcr_selection {
 
 static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
-	struct tpm2_pcr_selection pcr_selection;
+	struct tpm2_pcr_selection *pcr_selection;
 	struct tpm_buf buf;
 	void *marker;
 	void *end;
 	void *pcr_select_offset;
 	u32 sizeof_pcr_selection;
+	u32 nr_possible_banks;
+	u32 nr_active_banks = 0;
+	u16 *possible_banks;
+	u16 hash_alg;
 	u32 rsp_len;
 	int rc;
 	int i = 0;
+	int j;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	if (rc)
@@ -877,13 +882,12 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	if (rc)
 		goto out;
 
-	chip->nr_active_banks = be32_to_cpup(
+	nr_possible_banks = be32_to_cpup(
 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
 
-	chip->active_banks = kmalloc_array(chip->nr_active_banks,
-					   sizeof(*chip->active_banks),
-					   GFP_KERNEL);
-	if (!chip->active_banks) {
+	possible_banks = kmalloc_array(nr_possible_banks,
+				       sizeof(*possible_banks), GFP_KERNEL);
+	if (!possible_banks) {
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -893,7 +897,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
 	end = &buf.data[rsp_len];
 
-	for (i = 0; i < chip->nr_active_banks; i++) {
+	for (i = 0; i < nr_possible_banks; i++) {
 		pcr_select_offset = marker +
 			offsetof(struct tpm2_pcr_selection, size_of_select);
 		if (pcr_select_offset >= end) {
@@ -901,14 +905,30 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 			break;
 		}
 
-		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
-		chip->active_banks[i] = be16_to_cpu(pcr_selection.hash_alg);
-		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
-			sizeof(pcr_selection.size_of_select) +
-			pcr_selection.size_of_select;
+		pcr_selection = (struct tpm2_pcr_selection *)marker;
+		hash_alg = be16_to_cpu(pcr_selection->hash_alg);
+
+		for (j = 0; j < pcr_selection->size_of_select; j++)
+			if (pcr_selection->pcr_select[j])
+				break;
+
+		if (j < pcr_selection->size_of_select)
+			possible_banks[nr_active_banks++] = hash_alg;
+
+		sizeof_pcr_selection = sizeof(pcr_selection->hash_alg) +
+			sizeof(pcr_selection->size_of_select) +
+			pcr_selection->size_of_select;
 		marker = marker + sizeof_pcr_selection;
 	}
 
+	chip->nr_active_banks = nr_active_banks;
+	chip->active_banks = kmemdup(possible_banks,
+				     nr_active_banks * sizeof(*possible_banks),
+				     GFP_KERNEL);
+	if (!chip->active_banks)
+		rc = -ENOMEM;
+
+	kfree(possible_banks);
 out:
 	tpm_buf_destroy(&buf);
 
-- 
2.17.1

