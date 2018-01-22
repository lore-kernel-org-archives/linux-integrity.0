Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751087AbeAVOyW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEnlG2082920
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:21 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fnh3yu4sa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:21 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:19 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 01/10] ima-evm-utils: fix "ima_measurement" template fields length
Date: Mon, 22 Jan 2018 09:53:56 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-2-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The template data field length is uint32_t, not uint8_t.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/evmctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 313a0c5..a6c6e01 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1342,7 +1342,7 @@ void ima_ng_show(struct template_entry *entry)
 	char *algo, *path;
 
 	/* get binary digest */
-	field_len = *(uint8_t *)fieldp;
+	field_len = *(uint32_t *)fieldp;
 	fieldp += sizeof(field_len);
 	total_len -= sizeof(field_len);
 
@@ -1356,7 +1356,7 @@ void ima_ng_show(struct template_entry *entry)
 	total_len -= field_len;
 
 	/* get path */
-	field_len = *(uint8_t *)fieldp;
+	field_len = *(uint32_t *)fieldp;
 	fieldp += sizeof(field_len);
 	total_len -= sizeof(field_len);
 
@@ -1368,7 +1368,7 @@ void ima_ng_show(struct template_entry *entry)
 
 	if (!strcmp(entry->name, "ima-sig")) {
 		/* get signature */
-		field_len = *(uint8_t *)fieldp;
+		field_len = *(uint32_t *)fieldp;
 		fieldp += sizeof(field_len);
 		total_len -= sizeof(field_len);
 
-- 
2.7.4
