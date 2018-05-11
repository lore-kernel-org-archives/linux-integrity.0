Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752014AbeEKBhE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 21:37:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4B1ZPkD113746
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 21:37:03 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hvx2wf7q3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 21:37:03 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 02:37:02 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ima: based on the "secure_boot" policy limit syscalls
Date: Thu, 10 May 2018 21:36:46 -0400
In-Reply-To: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1526002608-27474-2-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The builtin "secure_boot" policy adds IMA appraisal rules requiring kernel
modules (finit_module syscall), direct firmware load, kexec kernel image
(kexec_file_load syscall), and the IMA policy to be signed, but did not
prevent the other syscalls/methods from working.  Loading an equivalent
custom policy containing these same rules would have prevented the other
syscalls/methods from working.

This patch refactors the code to load custom policies, defining a new
function named ima_appraise_flag().  The new function is called either
when loading the builtin "secure_boot" or custom policies.

Fixes: 503ceaef8e2e ("ima: define a set of appraisal rules requiring file signatures")
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 03cbba423e59..df3e45878a87 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -440,6 +440,17 @@ void ima_update_policy_flag(void)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
 
+static int ima_appraise_flag(enum ima_hooks func)
+{
+	if (func == MODULE_CHECK)
+		return IMA_APPRAISE_MODULES;
+	else if (func == FIRMWARE_CHECK)
+		return IMA_APPRAISE_FIRMWARE;
+	else if (func == POLICY_CHECK)
+		return IMA_APPRAISE_POLICY;
+	return 0;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -478,9 +489,12 @@ void __init ima_init_policy(void)
 	 * Insert the appraise rules requiring file signatures, prior to
 	 * any other appraise rules.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
+	for (i = 0; i < secure_boot_entries; i++) {
 		list_add_tail(&secure_boot_rules[i].list,
 			      &ima_default_rules);
+		temp_ima_appraise |=
+		    ima_appraise_flag(secure_boot_rules[i].func);
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
@@ -934,12 +948,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	}
 	if (!result && (entry->action == UNKNOWN))
 		result = -EINVAL;
-	else if (entry->func == MODULE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_MODULES;
-	else if (entry->func == FIRMWARE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
-	else if (entry->func == POLICY_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_POLICY;
+	else if (entry->action == APPRAISE)
+		temp_ima_appraise |= ima_appraise_flag(entry->func);
+
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.7.5
