Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754078AbdLDO3I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 09:29:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB4EOXHj076606
        for <linux-integrity@vger.kernel.org>; Mon, 4 Dec 2017 09:29:07 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2en756v0xy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 04 Dec 2017 09:29:07 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 4 Dec 2017 14:29:05 -0000
Subject: [PATCH] evm: fix portable patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Mon, 04 Dec 2017 09:29:02 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512397742.3977.43.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

During some testing/review, I noticed that the "pass_immutable" needs
to be added the list of strings.  I've squashed this change with your
patch.

I've pushed this change out to #next-queued.

Mimi

---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 4f11430b5415..a8d502827270 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -31,7 +31,7 @@
 int evm_initialized;
 
 static char *integrity_status_msg[] = {
-	"pass", "fail", "no_label", "no_xattrs", "unknown"
+	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
 };
 char *evm_hmac = "hmac(sha1)";
 char *evm_hash = "sha1";
-- 
2.7.4
