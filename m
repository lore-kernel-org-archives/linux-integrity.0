Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753280AbeEKOmq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 10:42:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4BEeAEd052644
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 10:42:45 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hwbukm3mr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 10:42:45 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 11 May 2018 08:42:44 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        john.johansen@canonical.com
Subject: [RFC PATCH v4 3/5] ima: differentiate auditing policy rules from "audit" actions
Date: Fri, 11 May 2018 10:42:28 -0400
In-Reply-To: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
to reflect the IMA policy rules.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/uapi/linux/audit.h          | 3 ++-
 security/integrity/ima/ima_policy.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 4e61a9e05132..8966e7ff1c4c 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -146,7 +146,8 @@
 #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
 #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
 #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
-#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
+#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
+#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 915f5572c6ff..3a1412db02a3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -619,7 +619,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
+	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
-- 
2.14.3
