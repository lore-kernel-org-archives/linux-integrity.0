Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755344AbeEaOZP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 10:25:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VEOhVc130555
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jag9hxxmh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:14 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 31 May 2018 08:25:13 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 4/4] ima: Differentiate auditing policy rules from "audit" actions
Date: Thu, 31 May 2018 10:25:00 -0400
In-Reply-To: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
References: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180531142500.4193818-5-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
the IMA "audit" policy action.  This patch defines
AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.

Since we defined a new message type we can now also call
audit_log_task_info() for task specific fields. This now produces the
following record when parsing an IMA policy rule:

type=UNKNOWN[1807] msg=audit(1527722337.757:338): action=audit \
  func=BPRM_CHECK mask=MAY_EXEC ppid=1613 pid=1657 auid=0 uid=0 \
  gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=tty4 ses=4 \
  comm="echo" exe="/usr/bin/echo" \
  subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 res=1

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/uapi/linux/audit.h          |  1 +
 security/integrity/ima/ima_policy.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

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
index bc99713dfe57..d56857223b73 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -637,7 +637,7 @@ static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 		audit_log_format(ab, "%s<", key);
 	else
 		audit_log_format(ab, "%s=", key);
-	audit_log_format(ab, "%s ", value);
+	audit_log_format(ab, "%s", value);
 }
 static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 {
@@ -651,9 +651,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	char *p;
 	bool uid_token;
 	int result = 0;
+	const char *orig_rule = rule;
 
 	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
-				       AUDIT_INTEGRITY_RULE);
+				       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
@@ -669,6 +670,10 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			break;
 		if ((*p == '\0') || (*p == ' ') || (*p == '\t'))
 			continue;
+
+		if (p != orig_rule)
+			audit_log_format(ab, " ");
+
 		token = match_token(p, policy_tokens, args);
 		switch (token) {
 		case Opt_measure:
@@ -953,7 +958,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	else if (entry->action == APPRAISE)
 		temp_ima_appraise |= ima_appraise_flag(entry->func);
 
-	audit_log_format(ab, "res=%d", !result);
+	audit_log_task_info(ab, current);
+	audit_log_format(ab, " res=%d", !result);
 	audit_log_end(ab);
 	return result;
 }
-- 
2.13.6
