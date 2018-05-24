Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S971298AbeEXULT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 16:11:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4OK4EZH126914
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j5yr7vjfh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:18 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 24 May 2018 16:11:17 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 7/8] ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
Date: Thu, 24 May 2018 16:11:04 -0400
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180524201105.3179904-8-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If Integrity is not auditing, IMA shouldn't audit, either.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      |  1 +
 security/integrity/ima/ima_policy.c |  6 +++++-
 security/integrity/integrity.h      | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c83..94c2151331aa 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -12,6 +12,7 @@ config IMA
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
+	select INTEGRITY_AUDIT if AUDIT
 	help
 	  The Trusted Computing Group(TCG) runtime Integrity
 	  Measurement Architecture(IMA) maintains a list of hash
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7297450b813c..3aed25a7178a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -609,6 +609,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 			      bool (*rule_operator)(kuid_t, kuid_t))
 {
+	if (!ab)
+		return;
+
 	if (rule_operator == &uid_gt)
 		audit_log_format(ab, "%s>", key);
 	else if (rule_operator == &uid_lt)
@@ -630,7 +633,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
+	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
+				       AUDIT_INTEGRITY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9f2924cafa53..2afa266aea42 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -203,6 +203,11 @@ void integrity_audit_msg_common(struct audit_buffer *ab, struct inode *inode,
 				const unsigned char *fname, const char *op,
 				const char *cause, int result);
 
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return audit_log_start(ctx, gfp_mask, type);
+}
 #else
 static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       const unsigned char *fname,
@@ -220,4 +225,9 @@ static inline void integrity_audit_msg_common(struct audit_buffer *ab,
 {
 }
 
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return NULL;
+}
 #endif
-- 
2.13.6
