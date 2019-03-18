Return-Path: <SRS0=+7J6=RV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB891C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746BE2171F
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 23:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvzyiTii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCRXDV (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:03:21 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42030 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCRXDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Mar 2019 19:03:21 -0400
Received: by mail-pf1-f202.google.com with SMTP id f67so1523616pfh.9
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KSN6gLTZamI3jI7qn2eiyCI8B4/UxmaBvUhqA5AWAdo=;
        b=EvzyiTiihJWIRlr5sCIlC6MaOYzDpI+I+atk9BvQXDJtXroHbPf5DJ+A2buIVHCwNU
         ESYB6g6ReIfpYHkJhkmNzPnPwQsD8T3a7aMCLTj4ZmPjt33Sc30mVVzYZ6baciSdmLJX
         Rjjeko1BSRf1vfz6qogwpqdpuGs27rozC8fZUAL/JPiK67OciS58/sPeVs45PHHpyPio
         sCiyidtY6nj9DM8sOACIyYQ4B5hBTjWrgB6drsBEoaY3JCwqAPuxmc3x+FCNFTmIT3K8
         fGjQoHLy4p6SC+UdyJN7otVEWIXCgnaIgS4DQwJFP8+z+uwL6aaTUPd65ws+HxCV58Zt
         PBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KSN6gLTZamI3jI7qn2eiyCI8B4/UxmaBvUhqA5AWAdo=;
        b=qoM/j2ODV/FbqbRspCBkau+CQ85qtwZDUX7hhbOJv3Zk7gBPddQCJlD2itCojZFqQp
         hucZcD4GNnixlQz86JNUzIOPd8CgVZIGiz+O7+sKllw0dim5LanDRQm0R0breM0v5sd4
         N8OJ6Vcs3BOd6Er8EXsYJuKYQ560r3BvHABZn1UJF5O9z9T2+jN5q13S5Ga9zyzjasAH
         z3SJCfngbhdGqclqu5nnAAE2w3msr5LYLHU8u3ZjdiPKZ6NjjiNmf5PhyEPuH0Zy9JfH
         qtvSS2WSqWdoHzHDAsJ/WrP8nEXnnW4PWk8fINsgTzM5gB3x7g9IqxhYU0bgVHZCG2nw
         NGaQ==
X-Gm-Message-State: APjAAAVDRf1UH4GdG8LFORRvpXcUCokbkno5NjDvPEct2nsyBSe4qkaf
        wmh7B8lqWLMnBuzEVRMWIW87veY+WzaRZEqm1/PiYbBb4oZ7Bc2o73vlaCfnEd0QcSrfAuHmSUk
        gvLRjX72ivEtRgQbmPU1pSDsKnODssSmoTZV7j3YedEC4w3KixCGQrPVk5wiIIeg1B+e0ghh0y1
        WF5muGrkC4JmHt3r4+mE8=
X-Google-Smtp-Source: APXvYqwPAmhsxz8gEqO2jhXkaSYHnSwJAsBeocjAiUvlmO3fSl3cjmtX8Zx19l2FsL5wapvPuh9laij8nj0kax34mhb2Mg==
X-Received: by 2002:a63:6a45:: with SMTP id f66mr7735737pgc.56.1552950199391;
 Mon, 18 Mar 2019 16:03:19 -0700 (PDT)
Date:   Mon, 18 Mar 2019 16:03:15 -0700
Message-Id: <20190318230315.232204-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH] kexec: Allow kexec_file() with appropriate IMA policy when
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, kexec@lists.infradead.org,
        dyoung@redhat.com, ebiederm@xmission.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Systems in lockdown mode should block the kexec of untrusted kernels.
For x86 and ARM we can ensure that a kernel is trustworthy by validating
a PE signature, but this isn't possible on other architectures. On those
platforms we can use IMA digital signatures instead. Add a function to
determine whether IMA has or will verify signatures for a given event type,
and if so permit kexec_file() even if the kernel is otherwise locked down.
This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
in order to prevent an attacker from loading additional keys at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---

Mimi, this relies on the lockdown patchset but I /think/ is independent
of the arch policy code - as a result I think it's possible to include
this in lockdown PR if that works for you, otherwise it can go through
your tree once the lockdown code is merged?

 include/linux/ima.h                 |  9 ++++++
 kernel/kexec_file.c                 |  7 +++-
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..a78c04580a3c 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -132,4 +132,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_signature(enum kernel_read_file_id func);
+#else
+static inline bool ima_appraise_kexec_signature(enum kernel_read_file_id func)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0cfe4f6f7f85..8ffa4b75c620 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -240,7 +240,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 		ret = 0;
 
-		if (kernel_is_locked_down(reason)) {
+		/* If IMA is guaranteed to appraise a signature on the kexec
+		 * image, permit it even if the kernel is otherwise locked
+		 * down.
+		 */
+		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+		    kernel_is_locked_down(reason)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..fe03cc6f1ca4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -115,6 +115,8 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+extern const int read_idmap[];
+
 #ifdef CONFIG_HAVE_IMA_KEXEC
 void ima_load_kexec_buffer(void);
 #else
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..927fe889201a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -473,7 +473,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	return 0;
 }
 
-static const int read_idmap[READING_MAX_ID] = {
+const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..33e0b64305af 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1337,3 +1337,53 @@ int ima_policy_show(struct seq_file *m, void *v)
 	return 0;
 }
 #endif	/* CONFIG_IMA_READ_POLICY */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+/*
+ * ima_appraise_signature: whether IMA will appraise a given function using
+ * an IMA digital signature. This is restricted to cases where the kernel
+ * has a set of built-in trusted keys in order to avoid an attacker simply
+ * loading additional keys.
+ */
+bool ima_appraise_signature(enum kernel_read_file_id id)
+{
+	struct ima_rule_entry *entry;
+	bool found = false;
+	enum ima_hooks func;
+
+	if (id >= READING_MAX_ID)
+		return false;
+
+	func = read_idmap[id] ?: FILE_CHECK;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if (entry->action != APPRAISE)
+			continue;
+
+		/*
+		 * A generic entry will match, but otherwise require that it
+		 * match the func we're looking for
+		 */
+		if (entry->func && entry->func != func)
+			continue;
+
+		/*
+		 * We require this to be a digital signature, not a raw IMA
+		 * hash.
+		 */
+		if (entry->flags & IMA_DIGSIG_REQUIRED)
+			found = true;
+
+		/*
+		 * We've found a rule that matches, so break now even if it
+		 * didn't require a digital signature - a later rule that does
+		 * won't override it, so would be a false positive.
+		 */
+		break;
+	}
+
+	rcu_read_unlock();
+	return found;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
-- 
2.21.0.225.g810b269d1ac-goog

