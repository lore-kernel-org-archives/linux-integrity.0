Return-Path: <SRS0=qs9M=RS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1158C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 15 Mar 2019 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA5E218AC
	for <linux-integrity@archiver.kernel.org>; Fri, 15 Mar 2019 22:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ry5/Xv2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCOWDo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:03:44 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36621 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfCOWDo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Mar 2019 18:03:44 -0400
Received: by mail-qt1-f201.google.com with SMTP id q12so7045642qtr.3
        for <linux-integrity@vger.kernel.org>; Fri, 15 Mar 2019 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jGzl9oOCNWB+w5O5kT8+UavT6LpgvD1h8m7yg5mswfI=;
        b=ry5/Xv2uiFIRACWf0J3QAxQQ3EkaCuAWAZxL9W6oOggYsU9oq3htVPDBN58qqoNKZW
         K76m6le7Am0dit0ijRzhIMXJagieCj4n4CQ45ilYx6fF078ovbXnGtPXtxA3w76h3hx2
         RZEuSBYlsZgN8ksMQPNUsMWIyIyTdiGvyhEK+HUMmfJ14+QRAFmcCNXuhB/XeTfSNtwx
         KTn/8CsZ4UR3KteS0qXB+LZLpu3WqLZ8XRDZivitm4IGZ4AHx8XCWWvZEYnyOOiG+xVm
         CAVJw6vrmGVExzwY/qduFO3Z99KPbyJnQIRCqn9CpQuOO0RciFi3EnqabTKfjoH1hhHz
         5eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jGzl9oOCNWB+w5O5kT8+UavT6LpgvD1h8m7yg5mswfI=;
        b=LsUX1SACwFWpVD29aJgpe6f9b4eeV2V1Hn7CjC5zmdVXq2DQpy+mtXLM8syUAIoBIB
         BraPmfx73+gCZ1W99XBv6b/9oaIaTgB3T0Gw5twyLaCNMdUHJwP/FhcR8530CXCEBxFm
         3UHMIeG4b1X9xBzEh4bWaFLBlxVxSP3uCcREu/RQziBxkmAOlgm0wGnRIvp78wt3J8L+
         9QKUkLUvh47MGFGrfmbdb/KRc9GktQtvV04yffOIbXM4hYPdf5Fb3pDty8FHmPKSF9Vo
         fMrqwRw+4rVyZoJ6pVghV95ksyCJZQYfqd8tJ4V5Jcl5xyzQc+9ramITjwShKWG6qMDb
         Pkxg==
X-Gm-Message-State: APjAAAVQvNxtlDgVsR19Ilft7bg9aDnKi9nnocornE6c0kfW7xQZCGBl
        T8V8IAE1o+d9HKiIJ1VlhF+N/rGexdnTkBwIq1mnAhUE3u1QOO2KpXo7OKyQN4NbibmLZvvBpBu
        1HLICffhlTCTjYd2wBtddskJxnqR+2G5qncsnOrW8iikxkfx/kHqQPYjW4vEQOcTB5WA+4MdC9g
        iYJA3lPdGOmc3x5kuAJqs=
X-Google-Smtp-Source: APXvYqwLAxSPw6AohKbcEV5Wm0EQuIzv/ogFGENODirqQWf4NfsmWBMHjL1qU0j+WC5LEU2pmhgirTaaGTukdNOqxtuPAg==
X-Received: by 2002:a0c:bf06:: with SMTP id m6mr2949970qvi.7.1552687422765;
 Fri, 15 Mar 2019 15:03:42 -0700 (PDT)
Date:   Fri, 15 Mar 2019 15:03:36 -0700
In-Reply-To: <1552607929.8658.54.camel@linux.ibm.com>
Message-Id: <20190315220336.220554-1-matthewgarrett@google.com>
Mime-Version: 1.0
References: <1552607929.8658.54.camel@linux.ibm.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
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
platforms we can use IMA digital signatures instead. Add a function to
determine whether IMA will verify signatures for a given event type, and
if so permit kexec_file() even if the kernel is otherwise locked down.
This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
in order to prevent an attacker from loading additional keys at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/linux/evm.h                 |  6 ++++
 include/linux/ima.h                 | 28 +++++++++++++++++++
 kernel/kexec_file.c                 |  9 ++++--
 security/integrity/evm/evm_main.c   |  2 +-
 security/integrity/ima/ima.h        | 20 +-------------
 security/integrity/ima/ima_policy.c | 43 +++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 22 deletions(-)

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
index dc12fbcf484c..a42e2a9a08b7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -27,6 +27,25 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 
+#define __ima_hooks(hook)		\
+	hook(NONE)			\
+	hook(FILE_CHECK)		\
+	hook(MMAP_CHECK)		\
+	hook(BPRM_CHECK)		\
+	hook(CREDS_CHECK)		\
+	hook(POST_SETATTR)		\
+	hook(MODULE_CHECK)		\
+	hook(FIRMWARE_CHECK)		\
+	hook(KEXEC_KERNEL_CHECK)	\
+	hook(KEXEC_INITRAMFS_CHECK)	\
+	hook(POLICY_CHECK)		\
+	hook(MAX_CHECK)
+#define __ima_hook_enumify(ENUM)	ENUM,
+
+enum ima_hooks {
+	__ima_hooks(__ima_hook_enumify)
+};
+
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -132,4 +151,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 	return 0;
 }
 #endif /* CONFIG_IMA_APPRAISE */
+
+#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
+extern bool ima_appraise_signature(enum ima_hooks func);
+#else
+static inline bool ima_appraise_kexec_signature(enum ima_hooks func)
+{
+	return false;
+}
+#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
 #endif /* _LINUX_IMA_H */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0cfe4f6f7f85..3e04506a00a2 100644
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
+		if (!ima_appraise_signature(KEXEC_KERNEL_CHECK) &&
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
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cc12f3449a72..71614a8ed2aa 100644
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
@@ -171,25 +172,6 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	return hash_long(*digest, IMA_HASH_BITS);
 }
 
-#define __ima_hooks(hook)		\
-	hook(NONE)			\
-	hook(FILE_CHECK)		\
-	hook(MMAP_CHECK)		\
-	hook(BPRM_CHECK)		\
-	hook(CREDS_CHECK)		\
-	hook(POST_SETATTR)		\
-	hook(MODULE_CHECK)		\
-	hook(FIRMWARE_CHECK)		\
-	hook(KEXEC_KERNEL_CHECK)	\
-	hook(KEXEC_INITRAMFS_CHECK)	\
-	hook(POLICY_CHECK)		\
-	hook(MAX_CHECK)
-#define __ima_hook_enumify(ENUM)	ENUM,
-
-enum ima_hooks {
-	__ima_hooks(__ima_hook_enumify)
-};
-
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..adeae1ab9ee9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -21,6 +21,7 @@
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
 #include <linux/ima.h>
+#include <linux/evm.h>
 
 #include "ima.h"
 
@@ -1336,4 +1337,46 @@ int ima_policy_show(struct seq_file *m, void *v)
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
+bool ima_appraise_signature(enum ima_hooks func)
+{
+	struct ima_rule_entry *entry;
+	bool found = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, ima_rules, list) {
+		if (entry->action != APPRAISE)
+			continue;
+
+		/* A generic entry will match, but otherwise require that it
+		 * match the func we're looking for
+		 */
+		if (entry->func && entry->func != func)
+			continue;
+
+		/* We require this to be a digital signature, not a raw IMA
+		 * hash.
+		 */
+		if (entry->flags & IMA_DIGSIG_REQUIRED)
+			found = true;
+
+		/* We've found a rule that matches, so break now even if it
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

