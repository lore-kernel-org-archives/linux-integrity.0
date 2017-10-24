Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbdJXRhP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Oct 2017 13:37:15 -0400
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        james.l.morris@oracle.com, dmitry.kasatkin@gmail.com,
        zohar@linux.vnet.ibm.com, rusty@rustcorp.com.au, jeyu@kernel.org
Subject: [PATCH v3 1/2] module: export module signature enforcement status
Date: Tue, 24 Oct 2017 15:37:00 -0200
Message-Id: <db45763f63b08ba27affc6bb79edbf6e331292ea.1508865786.git.brdeoliv@redhat.com>
In-Reply-To: <cover.1508865786.git.brdeoliv@redhat.com>
References: <cover.1508865786.git.brdeoliv@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

A static variable sig_enforce is used as status var to indicate the real
value of CONFIG_MODULE_SIG_FORCE, once this one is set the var will hold
true, but if the CONFIG is not set the status var will hold whatever
value is present in the module.sig_enforce kernel cmdline param: true
when =1 and false when =0 or not present.

Considering this cmdline param take place over the CONFIG value when
it's not set, other places in the kernel could misbehave since they
would have only the CONFIG_MODULE_SIG_FORCE value to rely on. Exporting
this status var allows the kernel to rely in the effective value of
module signature enforcement, being it from CONFIG value or cmdline
param.

Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
---
 include/linux/module.h |  7 +++++++
 kernel/module.c        | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index fe5aa3736707..c69b49abe877 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -639,6 +639,8 @@ static inline bool is_livepatch_module(struct module *mod)
 }
 #endif /* CONFIG_LIVEPATCH */
 
+bool is_module_sig_enforced(void);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -753,6 +755,11 @@ static inline bool module_requested_async_probing(struct module *module)
 	return false;
 }
 
+static inline bool is_module_sig_enforced(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module.c b/kernel/module.c
index de66ec825992..d1c194b057a2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -278,6 +278,16 @@ static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
 #endif /* !CONFIG_MODULE_SIG_FORCE */
 
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
 /* Block module loading/unloading? */
 int modules_disabled = 0;
 core_param(nomodule, modules_disabled, bint, 0);
-- 
2.13.6
