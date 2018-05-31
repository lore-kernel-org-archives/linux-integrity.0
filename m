Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755195AbeEaOZL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 10:25:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VEOjT3130669
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jag9hxxje-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 10:25:10 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 31 May 2018 08:25:10 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] ima: Use audit_log_format() rather than audit_log_string()
Date: Thu, 31 May 2018 10:24:58 -0400
In-Reply-To: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
References: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180531142500.4193818-3-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Remove the usage of audit_log_string() and replace it with
audit_log_format().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/ima/ima_policy.c  | 3 +--
 security/integrity/integrity_audit.c | 6 +-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1d00db19d167..3fcf0935468c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -634,8 +634,7 @@ static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 		audit_log_format(ab, "%s<", key);
 	else
 		audit_log_format(ab, "%s=", key);
-	audit_log_string(ab, value);
-	audit_log_format(ab, " ");
+	audit_log_format(ab, "%s ", value);
 }
 static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 {
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 90987d15b6fe..db30763d5525 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -45,11 +45,7 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			 audit_get_sessionid(current));
 	audit_log_task_context(ab);
-	audit_log_format(ab, " op=");
-	audit_log_string(ab, op);
-	audit_log_format(ab, " cause=");
-	audit_log_string(ab, cause);
-	audit_log_format(ab, " comm=");
+	audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
 	audit_log_untrustedstring(ab, get_task_comm(name, current));
 	if (fname) {
 		audit_log_format(ab, " name=");
-- 
2.13.6
