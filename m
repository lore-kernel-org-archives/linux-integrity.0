Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755338AbeEaOZN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 10:25:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VEOBnf014491
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:12 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jajpmr8wk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:12 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 31 May 2018 08:25:12 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 3/4] ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
Date: Thu, 31 May 2018 10:24:59 -0400
In-Reply-To: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
References: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180531142500.4193818-4-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If Integrity is not auditing, IMA shouldn't audit, either.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      |  1 +
 security/integrity/ima/ima_policy.c |  6 +++++-
 security/integrity/integrity.h      | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

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
index 3fcf0935468c..bc99713dfe57 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -628,6 +628,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 			      bool (*rule_operator)(kuid_t, kuid_t))
 {
+	if (!ab)
+		return;
+
 	if (rule_operator == &uid_gt)
 		audit_log_format(ab, "%s>", key);
 	else if (rule_operator == &uid_lt)
@@ -649,7 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
+	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
+				       AUDIT_INTEGRITY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0bb372eed62a..e60473b13a8d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -15,6 +15,7 @@
 #include <linux/integrity.h>
 #include <crypto/sha.h>
 #include <linux/key.h>
+#include <linux/audit.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -199,6 +200,13 @@ static inline void evm_load_x509(void)
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
 			 const char *cause, int result, int info);
+
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return audit_log_start(ctx, gfp_mask, type);
+}
+
 #else
 static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       const unsigned char *fname,
@@ -206,4 +214,11 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       int result, int info)
 {
 }
+
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return NULL;
+}
+
 #endif
-- 
2.13.6
