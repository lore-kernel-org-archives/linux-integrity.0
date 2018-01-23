Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751432AbeAWQ7e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jan 2018 11:59:34 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0NGxUPO137227
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2018 11:59:34 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fp82fjvge-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2018 11:59:32 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 23 Jan 2018 16:59:27 -0000
Subject: [PATCH] ima: re-initialize iint->atomic_flags
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Tue, 23 Jan 2018 11:59:23 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516726763.3615.2.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Intermittently security.ima is not being written for new files.  This
patch re-initializes the new slab iint->atomic_flags field before
freeing it.

Fixes: commit 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/iint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index fc38ca08dbb5..9700e96ab0f0 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -74,6 +74,7 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
+	iint->atomic_flags = 0UL;
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-- 
2.7.4
