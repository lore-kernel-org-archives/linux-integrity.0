Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754398AbeD3TBk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Apr 2018 15:01:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3UIxF6Z159526
        for <linux-integrity@vger.kernel.org>; Mon, 30 Apr 2018 15:01:39 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hp4wpjr8j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Apr 2018 15:01:39 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 30 Apr 2018 20:01:37 +0100
Subject: [PATCH] ima: define a new policy condition based on the filesystem
 name
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity <linux-integrity@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Date: Mon, 30 Apr 2018 15:01:34 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525114894.5669.5.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

If/when file data signatures are distributed with the file data, this
patch will not be needed.  In the current environment where only some
files are signed, the ability to differentiate between file systems is
needed.  Some file systems consider the file system magic number
internal to the file system.

This patch defines a new IMA policy condition named "fsname", based on
the superblock's file_system_type (sb->s_type) name. This allows policy
rules to be expressed in terms of the filesystem name.

The following sample rules require file signatures on rootfs files
executed or mmap'ed.

appraise func=BPRM_CHECK fsname=rootfs appraise_type=imasig
appraise func=FILE_MMAP fsname=rootfs appraise_type=imasig

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index b8465e00ba5f..74c6702de74e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -21,7 +21,7 @@ Description:
 			audit | hash | dont_hash
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=]]
+				[euid=] [fowner=] [fsname=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [permit_directio]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d89bebf85421..03cbba423e59 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -33,6 +33,7 @@
 #define IMA_INMASK	0x0040
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
+#define IMA_FSNAME	0x0200
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -74,6 +75,7 @@ struct ima_rule_entry {
 		void *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
+	char *fsname;
 };
 
 /*
@@ -273,6 +275,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSMAGIC)
 	    && rule->fsmagic != inode->i_sb->s_magic)
 		return false;
+	if ((rule->flags & IMA_FSNAME)
+	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
+		return false;
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -540,7 +545,7 @@ enum {
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -565,6 +570,7 @@ static match_table_t policy_tokens = {
 	{Opt_func, "func=%s"},
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
+	{Opt_fsname, "fsname=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -776,6 +782,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if (!result)
 				entry->flags |= IMA_FSMAGIC;
 			break;
+		case Opt_fsname:
+			ima_log_string(ab, "fsname", args[0].from);
+
+			entry->fsname = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->fsname) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_FSNAME;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1104,6 +1121,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_FSNAME) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->fsname);
+		seq_printf(m, pt(Opt_fsname), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.7.5
