Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751418AbeFDUzK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jun 2018 16:55:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w54KijWN004012
        for <linux-integrity@vger.kernel.org>; Mon, 4 Jun 2018 16:55:10 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jd99trv5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 04 Jun 2018 16:55:10 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Mon, 4 Jun 2018 14:55:09 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 4/4] ima: Differentiate auditing policy rules from "audit" actions
Date: Mon,  4 Jun 2018 16:54:55 -0400
In-Reply-To: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
the IMA "audit" policy action.  This patch defines
AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.

Since we defined a new message type we can now also pass the
audit_context and get an associated SYSCALL record. This now produces
the following records when parsing IMA policy's rules:

type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
  func=MMAP_CHECK mask=MAY_EXEC res=1
type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
  func=FILE_CHECK mask=MAY_READ res=1
type=SYSCALL msg=audit(1527888965.738:320): arch=c000003e syscall=1 \
  success=yes exit=17 a0=1 a1=55bcfcca9030 a2=11 a3=7fcc1b55fb38 \
  items=0 ppid=1567 pid=1601 auid=0 uid=0 gid=0 euid=0 suid=0 \
  fsuid=0 egid=0 sgid=0 fsgid=0 tty=tty2 ses=2 comm="echo" \
  exe="/usr/bin/echo" \
  subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/uapi/linux/audit.h          | 1 +
 security/integrity/ima/ima_policy.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 65d9293f1fb8..cb358551376b 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -148,6 +148,7 @@
 #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
 #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
 #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
+#define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index bc99713dfe57..f7230db217a7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -652,8 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
-				       AUDIT_INTEGRITY_RULE);
+	ab = integrity_audit_log_start(current->audit_context, GFP_KERNEL,
+				       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
-- 
2.13.6
