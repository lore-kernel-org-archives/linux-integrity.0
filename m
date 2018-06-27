Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37109 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964850AbeF0Ndr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jun 2018 09:33:47 -0400
Received: by mail-qk0-f195.google.com with SMTP id t79-v6so1012144qke.4
        for <linux-integrity@vger.kernel.org>; Wed, 27 Jun 2018 06:33:47 -0700 (PDT)
Date: Wed, 27 Jun 2018 16:33:42 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: linux-integrity@vger.kernel.org
Cc: Matthias Gerstner <mgerstner@suse.de>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] integrity: prevent deadlock during digsig verification.
Message-ID: <20180627163342.3e1d6333@totoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch aimed to prevent deadlock during digsig verification.The point
of issue - user space utility modprobe and/or it's dependencies (ld-*.so,
libz.so.*, libc-*.so and /lib/modules/ files) that could be used for
kernel modules load during digsig verification and could be signed by
digsig in the same time.

First at all, look at crypto_alloc_tfm() work algorithm:
crypto_alloc_tfm() will first attempt to locate an already loaded
algorithm. If that fails and the kernel supports dynamically loadable
modules, it will then attempt to load a module of the same name or alias.
If that fails it will send a query to any loaded crypto manager to
construct an algorithm on the fly.  

We have situation, when public_key_verify_signature() in case of RSA
algorithm use alg_name to store internal information in order to construct
an algorithm on the fly, but crypto_larval_lookup() will try to use
alg_name in order to load kernel module with same name.

1) we can't do anything with crypto module work, since it designed to work
exactly in this way;
2) we can't globally filter module requests for modprobe, since it
designed to work with any requests.

In this patch, I propose add an exception for "crypto-pkcs1pad(rsa,*)"
module requests only in case of enabled integrity asymmetric keys support.
Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules for
sure, we are safe to fail such module request from crypto_larval_lookup().
In this way we prevent modprobe execution during digsig verification and
avoid possible deadlock if modprobe and/or it's dependencies also signed
with digsig.

Requested "crypto-pkcs1pad(rsa,*)" kernel module name formed by:
1) "pkcs1pad(rsa,%s)" in public_key_verify_signature();
2) "crypto-%s" / "crypto-%s-all" in crypto_larval_lookup().
"crypto-pkcs1pad(rsa," part of request is a constant and unique and could
be used as filter.


Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>

 include/linux/integrity.h              | 13 +++++++++++++
 security/integrity/digsig_asymmetric.c | 23 +++++++++++++++++++++++
 security/security.c                    |  7 ++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index c2d6082..8678e32 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -43,4 +43,17 @@ static inline void integrity_load_keys(void)
 }
 #endif /* CONFIG_INTEGRITY */
 
+#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
+
+extern int integrity_kernel_module_request(char *kmod_name);
+
+#else
+
+static inline int integrity_kernel_module_request(char *kmod_name)
+{
+	return 0;
+}
+
+#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
+
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 80052ed..f1ab90c 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -115,3 +115,26 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pr_debug("%s() = %d\n", __func__, ret);
 	return ret;
 }
+
+/**
+ * integrity_kernel_module_request - prevent crypto-pkcs1pad(rsa,*) requests
+ * @kmod_name: kernel module name
+ *
+ * We have situation, when public_key_verify_signature() in case of RSA
+ * algorithm use alg_name to store internal information in order to
+ * construct an algorithm on the fly, but crypto_larval_lookup() will try
+ * to use alg_name in order to load kernel module with same name.
+ * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
+ * we are safe to fail such module request from crypto_larval_lookup().
+ *
+ * In this way we prevent modprobe execution during digsig verification
+ * and avoid possible deadlock if modprobe and/or it's dependencies
+ * also signed with digsig.
+ */
+int integrity_kernel_module_request(char *kmod_name)
+{
+	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/security/security.c b/security/security.c
index f825304..d53b4cb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -929,7 +929,12 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 
 int security_kernel_module_request(char *kmod_name)
 {
-	return call_int_hook(kernel_module_request, 0, kmod_name);
+	int ret;
+
+	ret = call_int_hook(kernel_module_request, 0, kmod_name);
+	if (ret)
+		return ret;
+	return integrity_kernel_module_request(kmod_name);
 }
 
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
