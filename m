Return-Path: <SRS0=+7J6=RV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A8C43381
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F80213F2
	for <linux-integrity@archiver.kernel.org>; Mon, 18 Mar 2019 19:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFMunJOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfCRTvx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:51:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40730 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfCRTvx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Mar 2019 15:51:53 -0400
Received: by mail-pf1-f201.google.com with SMTP id z26so14518137pfa.7
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 12:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SXteoWL9bpeJoilHME4ZrwdnvwfbbMsRFl8oDKZhO7Q=;
        b=IFMunJOzoGUyo8PFNfqV3LotVDhDhlJw7qVhpAC06oqsAev6Mpsrjoej3tl4Wk+YhX
         YW0CsvWfKtqjXKFuGs6e2oqp+4z5HkN42bLCBq7XUNc5xlhiLNa8riknMta4YbYSLlVT
         DG8EH8xbFQXppsOgsG6yMyFkOmKwLcHEK6dqP5xzTefKyH4G+NPmvaTBiNsEGLC7pDoH
         hWbcDJleKgPJKeyHxxndMqpgviaTROxSNEc98Qnf9mHp3/LL0zUCm+l66DkmLdGkqgbE
         SOsy65WsP9soiZOUnFvWjsIJJzxWD0SQSsua7tF59MJ3/uQ2rip0Ui8v87WokIAJTHlZ
         uTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SXteoWL9bpeJoilHME4ZrwdnvwfbbMsRFl8oDKZhO7Q=;
        b=HRX20cIjP5yflVVi95Aoi6jmQbqWKVrfyNbKJf0mNWxTrhVe6rZ0wEolHwdhKj4mSP
         gJYsLGDMIYlPTf5MlENyPKhRDiMkFkBa7uxuuJq4tGp49YL9IiWJ83Pea6PJgwgvOwk1
         /2ib6FU+f+9FT0vSZD3kS0xCz6tC5INGJfag06b575w3MB4w7SlTzVCJs73lx8doiDmH
         VZCt7AxoEE7m1DQ78qjalcCvHX0r0Gum1r/ma07yRrX7eWefTq0BcOKTAg06SI4xI+qc
         RWAsYClezA7ah0iTY/SDrhhMSEoDUsmEEWkt/2DSfORzFtk90Vq9j+NsYtV6JyG7K6f9
         Rrfg==
X-Gm-Message-State: APjAAAUimzd7az4nxKLWV59+UHfckyymF+QFBBANNd0C4A2YLZaT1kKv
        /X3Xho4gCKwlAw2GL8kvhhP4fgk2CgRI0GwEvvEsSNUXmmkTpsXf8CLhStbXLfkFPwu3xZZ2YVz
        YwUe5SoJe/IHGVyuDZ+FRSLEwCxZiMmVevPDQMqbe8InsBmO8x3IsOzW1S57dXMdsVUpsGJI0Ae
        nnD04fwkINxN9eXmiOLOU=
X-Google-Smtp-Source: APXvYqxV/rya0JnPoSjAI8U40zz+MWcdA4T4ea78bKLObHj4dP7Ijgp6BtxjoNflOlTIB89Ae+7iK5jmaVtLiaiFKCYayg==
X-Received: by 2002:a17:902:a60c:: with SMTP id u12mr6241391plq.114.1552938711985;
 Mon, 18 Mar 2019 12:51:51 -0700 (PDT)
Date:   Mon, 18 Mar 2019 12:51:39 -0700
In-Reply-To: <1552822761.8658.158.camel@linux.ibm.com>
Message-Id: <20190318195139.111959-1-matthewgarrett@google.com>
Mime-Version: 1.0
References: <1552822761.8658.158.camel@linux.ibm.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC] kexec: Allow kexec_file() with appropriate IMA policy when
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
 include/linux/ima.h                 |  9 +++++
 kernel/kexec_file.c                 |  9 +++--
 security/integrity/ima/ima.h        |  3 ++
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 52 +++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 3 deletions(-)

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
index 0cfe4f6f7f85..3598f93a731a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -20,11 +20,11 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/fs.h>
-#include <linux/ima.h>
 #include <crypto/hash.h>
 #include <crypto/sha.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/ima.h>
 #include <linux/kernel.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
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
index cc12f3449a72..93a6825bfcaf 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/crypto.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include <linux/security.h>
 #include <linux/hash.h>
 #include <linux/tpm.h>
@@ -115,6 +116,8 @@ struct ima_kexec_hdr {
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
index 8bc8a1c8cb3f..bbd1d5b3d45a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -21,6 +21,7 @@
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
 #include <linux/ima.h>
+#include <linux/evm.h>
 
 #include "ima.h"
 
@@ -1336,4 +1337,55 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
+
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

