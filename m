Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752111AbdLHSNT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 13:13:19 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8IDGlQ108542
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 13:13:19 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eqyqg0eq6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 13:13:08 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 18:12:24 -0000
Subject: [PATCH] ima: define a new policy option named "force"
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 08 Dec 2017 13:12:20 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512756740.3846.3.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

There are times instead of relying on previously cached status
information we want to force the file to be re-measured, re-appraised,
and re-audited.

This patch defines a new policy option named "force", which forces
files to be re-measured, re-appraised or re-audited.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_main.c    | 22 ++++++++++++++++++++--
 security/integrity/ima/ima_policy.c  |  8 +++++++-
 security/integrity/integrity.h       |  1 +
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 2028f2d093b2..b0e8143c681f 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -24,7 +24,7 @@ Description:
 				[euid=] [fowner=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=]] [permit_directio]
+			option:	[[appraise_type=]] [permit_directio] [force]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4dce3626dd4d..2a483184bc9a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -228,9 +228,27 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
 				 IMA_ACTION_FLAGS);
 
-	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
-		/* reset all flags if ima_inode_setxattr was called */
+	/*
+	 * Reset the measure, appraise and audit cached flags either if
+	 * ima_inode_setxattr was called or based on policy, forcing
+	 * the file to be re-evaluated.
+	 */
+	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
 		iint->flags &= ~IMA_DONE_MASK;
+	} else if (action & IMA_FORCE) {
+		if (action & IMA_MEASURE) {
+			iint->measured_pcrs = 0;
+			iint->flags &=
+			    ~(IMA_COLLECTED | IMA_MEASURE | IMA_MEASURED);
+		}
+		if (action & IMA_APPRAISE)
+			iint->flags &=
+			    ~(IMA_COLLECTED | IMA_APPRAISE | IMA_APPRAISED |
+			      IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK);
+		if (action & IMA_AUDIT)
+			iint->flags &=
+			    ~(IMA_COLLECTED | IMA_AUDIT | IMA_AUDITED);
+	}
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 93dcf1bf92a8..878ae1a06e1e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -533,7 +533,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_force
 };
 
 static match_table_t policy_tokens = {
@@ -566,6 +566,7 @@ static match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_force, "force"},
 	{Opt_err, NULL}
 };
 
@@ -895,6 +896,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->flags |= IMA_PCR;
 
 			break;
+		case Opt_force:
+			entry->flags |= IMA_FORCE;
+			break;
 		case Opt_err:
 			ima_log_string(ab, "UNKNOWN", p);
 			result = -EINVAL;
@@ -1168,6 +1172,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->flags & IMA_FORCE)
+		seq_puts(m, "force ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 50a8e3365df7..4e16b1212d0f 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -35,6 +35,7 @@
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
 #define EVM_IMMUTABLE_DIGSIG	0x08000000
+#define IMA_FORCE		0x10000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.7.4
