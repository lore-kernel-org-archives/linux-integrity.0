Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F31DC10F0B
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D075521873
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt7cHQgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfBZVur (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:50:47 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56080 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfBZVuq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 16:50:46 -0500
Received: by mail-pg1-f202.google.com with SMTP id g188so10494083pgc.22
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W4AQdO0YXdQStwIqEW9eH2qaknX9pHyjHHTGGLf92pQ=;
        b=vt7cHQgg0rmQthW6SACNWMPRAQHMlenslKOWDe+rCF7ovBql5MKsW7NDuE3vKU1lAY
         YgTfFGDnN1aDKXT+Quj45t3cxjZXNE2N7wJ6DNc9Gw4cVSsZE7S79IJAtmB2daYZEu6r
         0VV31zdh7/ZI8gSPu5MkX0FpWOuJzgL4NKFDoe3lG6uviBJ89deXswmo/zfbA6QmP6dX
         +QCuJw6JbSylCUho/LFj4AlkI13ZQ0eORzVqZgYCQuc2COnAyBrgFpZRKplFmg6H1CpD
         vLbYB89Gt8oB6FB0Jro3fvr/o7IJa79LaX6ezXdOvkEZc3vIML9U+zm1uP25EIvrjlzn
         yLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W4AQdO0YXdQStwIqEW9eH2qaknX9pHyjHHTGGLf92pQ=;
        b=A/b4VeP+Y9OBT790gXsIlLKv6ALHWSyDLsJPSyCmZZvesaw+Zs1dIOgPHrU168Yhl8
         En3JqtAqDrFtCW5NGhHQgfS68Apj8ybzl2GKHxQaqwbfjnHfGYJgzFpVOyQNrkeoAGYm
         +h04m6uknHu6AOWFl786Ut1aqYUPy9LmuISLuN/wVdIctcTd6wvFdkRu4TglpCDGmueN
         LykdbhGAFWOR3RPuHxOE/jw+gpcpgRx8Q06hhhW96JgQ+j4vJyJdUpemUcojYEAq0D9M
         6YQDsPOrOV9V01pgtkpnb8YLcZJQpMOo/H+ofazyB+zQ1dvffEvzHwrdKw1CCirqqzhQ
         Ga+A==
X-Gm-Message-State: AHQUAuY/ir1Sv0OdI0UvKZBtWDQ+YVvjb3toMSf4Ia4wvpgjFCE3+qIs
        yfvCjI7T4MtK9sz/cNjdUIf85Oc4p2F/6IRbU/f59svaBQLX++Upn0CAXQkRu6AJ3yrUXGqLvVN
        9mncg6psSWqaIMkyIBR9BxEoIqK3kmyMCMN5mo1wJBp3k8aet/lvxqEWU9zaw72d5wRz+O1Umam
        UlzdPmvksJIh/vt39vCiM=
X-Google-Smtp-Source: AHgI3IaguCd7CY+7KWQ8nxFIpRyRlWuQzJc7ZhQT5iZ+vP9IIupuw7K+BsVRCfqS19h76cryylU84wUOHiBc6Oh8MU/VpA==
X-Received: by 2002:a62:488c:: with SMTP id q12mr2672853pfi.92.1551217845940;
 Tue, 26 Feb 2019 13:50:45 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:50:32 -0800
In-Reply-To: <20190226215034.68772-1-matthewgarrett@google.com>
Message-Id: <20190226215034.68772-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH V2 2/4] IMA: Allow rule matching on filesystem subtype
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA currently allows rules to match on the filesystem type. Certain
filesystem types permit subtypes (eg, fuse). Add support to IMA to allow
rules to match on subtypes as well as types.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/ima_policy |  4 +++-
 security/integrity/ima/ima_policy.c  | 26 +++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 74c6702de74e..09a5def7e28a 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -21,7 +21,7 @@ Description:
 			audit | hash | dont_hash
 		condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
-				[euid=] [fowner=] [fsname=]]
+				[euid=] [fowner=] [fsname=] [subtype=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
 			option:	[[appraise_type=]] [permit_directio]
@@ -33,6 +33,8 @@ Description:
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
 			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
+			fsname:= file system type (e.g fuse)
+			subtype:= file system subtype (e.g ntfs3g)
 			uid:= decimal value
 			euid:= decimal value
 			fowner:= decimal value
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..dcecb6aae5ec 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -35,6 +35,7 @@
 #define IMA_EUID	0x0080
 #define IMA_PCR		0x0100
 #define IMA_FSNAME	0x0200
+#define IMA_SUBTYPE	0x0400
 
 #define UNKNOWN		0
 #define MEASURE		0x0001	/* same as IMA_MEASURE */
@@ -80,6 +81,7 @@ struct ima_rule_entry {
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
+	char *subtype;
 };
 
 /*
@@ -306,6 +308,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	if ((rule->flags & IMA_FSNAME)
 	    && strcmp(rule->fsname, inode->i_sb->s_type->name))
 		return false;
+	if ((rule->flags & IMA_SUBTYPE)
+	    && (inode->i_sb->s_subtype == NULL ||
+		strcmp(rule->subtype, inode->i_sb->s_subtype)))
+		return false;
 	if ((rule->flags & IMA_FSUUID) &&
 	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
 		return false;
@@ -672,7 +678,7 @@ enum {
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
-	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
+	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_subtype,
 	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
@@ -698,6 +704,7 @@ static const match_table_t policy_tokens = {
 	{Opt_mask, "mask=%s"},
 	{Opt_fsmagic, "fsmagic=%s"},
 	{Opt_fsname, "fsname=%s"},
+	{Opt_subtype, "subtype=%s"},
 	{Opt_fsuuid, "fsuuid=%s"},
 	{Opt_uid_eq, "uid=%s"},
 	{Opt_euid_eq, "euid=%s"},
@@ -923,6 +930,17 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			result = 0;
 			entry->flags |= IMA_FSNAME;
 			break;
+		case Opt_subtype:
+			ima_log_string(ab, "subtype", args[0].from);
+
+			entry->subtype = kstrdup(args[0].from, GFP_KERNEL);
+			if (!entry->subtype) {
+				result = -ENOMEM;
+				break;
+			}
+			result = 0;
+			entry->flags |= IMA_SUBTYPE;
+			break;
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
@@ -1254,6 +1272,12 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, " ");
 	}
 
+	if (entry->flags & IMA_SUBTYPE) {
+		snprintf(tbuf, sizeof(tbuf), "%s", entry->subtype);
+		seq_printf(m, pt(Opt_subtype), tbuf);
+		seq_puts(m, " ");
+	}
+
 	if (entry->flags & IMA_PCR) {
 		snprintf(tbuf, sizeof(tbuf), "%d", entry->pcr);
 		seq_printf(m, pt(Opt_pcr), tbuf);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

