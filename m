Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751282AbeAVOy1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MErUOL125828
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:26 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fnhbkjh87-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:26 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:23 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 03/10] ima-evm-utils: fix spelling error
Date: Mon, 22 Jan 2018 09:53:58 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-4-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/evmctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a6c6e01..746fc09 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1310,7 +1310,7 @@ void ima_extend_pcr(uint8_t *pcr, uint8_t *digest, int length)
 	SHA1_Final(pcr, &ctx);
 }
 
-static int ima_verify_tamplate_hash(struct template_entry *entry)
+static int ima_verify_template_hash(struct template_entry *entry)
 {
 	uint8_t digest[SHA_DIGEST_LENGTH];
 
@@ -1446,7 +1446,7 @@ static int ima_measurement(const char *file)
 		}
 
 		if (validate)
-			ima_verify_tamplate_hash(&entry);
+			ima_verify_template_hash(&entry);
 
 		if (!strcmp(entry.name, "ima"))
 			ima_show(&entry);
-- 
2.7.4
