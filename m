Return-Path: <SRS0=+0OV=RP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A02C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Mar 2019 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57008214D8
	for <linux-integrity@archiver.kernel.org>; Tue, 12 Mar 2019 19:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9ohsg7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCLT5T (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:57:19 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37886 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLT5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Mar 2019 15:57:19 -0400
Received: by mail-pg1-f201.google.com with SMTP id a6so3825765pgj.4
        for <linux-integrity@vger.kernel.org>; Tue, 12 Mar 2019 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RsummdRFClOWh9gvzr2oxKiHNcTq2WPCECZIXmAyRAA=;
        b=i9ohsg7BKuRzWnwYfix/SqEDZzp6FTG4bS6fqJD8F/GFux3MogwofHM/x5wSRkKnh0
         1vwnoJgfeC6TO1srQ5bs4EYN8GjT5F/3C6Uy3VZGmP5MUCzFEqCPACZMnFYOv883X+vG
         NBxkZ7BTYBVzVaCUChP1XGH4is8Eg52Hj2HFUmI9nPvBUGSgY+BHOCFsvbUhrbvOepQg
         s8mTFaIATc6BlX9xzlIHBF53fqG1I17ZGdS7kDQgC08yMTM3bTy/CFe6azRGdw2AofsA
         dtV5WdzD7zMMsWJdYaapy3+gVLrU1Y1OaLMHhd9wc4VZ0UJQXBFxapxmi/Y4SS86AVkH
         Levw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RsummdRFClOWh9gvzr2oxKiHNcTq2WPCECZIXmAyRAA=;
        b=FxSLdLG1pd90xH7N0H4mAXDDlBv5CHHIQ7HrwkqJVXsaFJbJWV9wluPpdNeXtS2+Qa
         ETSfkE3k7iGybrb5M8msgFrMCw47wTDN0YHcQhtdjFzVdjxrbpFFV7bkzDbl8qPNB99Q
         uu/dG6IdJM1eN5GQ7pe6o0Ep/USb5TDsj10reeZOwk50kQUFtbYi4N/Zm+CqpEGzDawx
         Wa6sb/5E1rzjdzMg4kxdliZId28Q3FwrcZ6xbYShBOtRVfId2cKXCFUUBDQSs7zk7bnW
         z0TrvP6+6FMILABFvsMBWOjG/9b1fjvIM2XVxF4FULZKywyfvptExWez4U/L5zoJd181
         iVug==
X-Gm-Message-State: APjAAAU8eFD/VBkmoqQT/8Dudx/MfJJoxBD4JSH61YKZlo8fn/4JfkMw
        uSbjkbXSm2+l0cYFxhl4IgiRtWVY02eLBWWjLwJWxM4IEf+8KdKYJcwFixpHoybtfdGPafH4lYC
        eGh4zyaEJqy9Q5XWIQKKFKxwRslLg84j++Ww+Q7ea6YFGAl1+haN8UHOvXD8p5DG9JrX1ntmkoV
        XDfFYSX6IOkrLbJJUSo/4=
X-Google-Smtp-Source: APXvYqxyYmzfMHYPC8IQeiwHBmXUNFxaC/gA4jWrNKjZPp1p7Nbis6jeAOuZfyGopxk+QRpN7ipUVZioiBMxqPgRFgydSw==
X-Received: by 2002:a65:47c4:: with SMTP id f4mr15447900pgs.111.1552420638611;
 Tue, 12 Mar 2019 12:57:18 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:57:15 -0700
Message-Id: <20190312195715.101995-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [RFC] kexec: Allow kexec_file() with appropriate IMA policy when
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com,
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
platforms we can use IMA instead, either with native IMA digital
signatures or EVM-protected IMA hashes. Add a function to determine
whether IMA will verify signatures on kexec files, and if so permit
kexec_file() even if the kernel is otherwise locked down. This is
restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set in
order to prevent an attacker from loading additional keys at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/evm.h                 |  6 +++++
 include/linux/ima.h                 |  9 ++++++++
 kernel/kexec_file.c                 |  9 ++++++--
 security/integrity/evm/evm_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 35 +++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 8302bc29bb35..6e89d046b716 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -15,6 +15,7 @@
 struct integrity_iint_cache;
 
 #ifdef CONFIG_EVM
+extern bool evm_key_loaded(void);
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 					     const char *xattr_name,
@@ -45,6 +46,11 @@ static inline int posix_xattr_acl(const char *xattrname)
 #endif
 #else
 
+static inline bool evm_key_loaded(void)
+{
+	return false;
+}
+
 static inline int evm_set_key(void *key, size_t keylen)
 {
 	return -EOPNOTSUPP;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..2ec593537c9b 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -132,4 +132,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_kexec_signature(void);
+#else
+static inline bool ima_appraise_kexec_signature(void)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0cfe4f6f7f85..8ca607f1b515 100644
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
+		if (!ima_appraise_kexec_signature() &&
+		    kernel_is_locked_down(reason)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b6d9f14bc234..aad61bc0f774 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -87,7 +87,7 @@ static void __init evm_init_config(void)
 	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
 }
 
-static bool evm_key_loaded(void)
+bool evm_key_loaded(void)
 {
 	return (bool)(evm_initialized & EVM_KEY_MASK);
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..c06b1a6b3528 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -21,6 +21,7 @@
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
 #include <linux/ima.h>
+#include <linux/evm.h>
 
 #include "ima.h"
 
@@ -1336,4 +1337,38 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
+
 #endif	/* CONFIG_IMA_READ_POLICY */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+/*
+ * ima_appraise_kexec: whether IMA will appraise a kexec image, either via
+ * IMA digital signatures or with a hash and EVM validation
+ */
+bool ima_appraise_kexec_signature(void)
+{
+	struct ima_rule_entry *entry;
+	bool found = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if (entry->func != KEXEC_KERNEL_CHECK ||
+		    entry->action != APPRAISE)
+			continue;
+
+		/*
+		 * We require this to be a digital signature, not a raw IMA
+		 * hash. An IMA hash is acceptable as long as it's covered
+		 * by an EVM signature.
+		 */
+		if (entry->flags & IMA_DIGSIG_REQUIRED ||
+		    evm_key_loaded()) {
+			found = true;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return found;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
-- 
2.21.0.360.g471c308f928-goog

