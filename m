Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-vk0-f73.google.com ([209.85.213.73]:54515 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752950AbeFHV5x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Jun 2018 17:57:53 -0400
Received: by mail-vk0-f73.google.com with SMTP id 196-v6so5590276vko.21
        for <linux-integrity@vger.kernel.org>; Fri, 08 Jun 2018 14:57:53 -0700 (PDT)
MIME-Version: 1.0
Date: Fri,  8 Jun 2018 14:57:42 -0700
In-Reply-To: <20180608215743.224253-1-mjg59@google.com>
Message-Id: <20180608215743.224253-2-mjg59@google.com>
References: <20180608215743.224253-1-mjg59@google.com>
Subject: [PATCH V3 1/2] evm: Don't deadlock if a crypto algorithm is unavailable
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

When EVM attempts to appraise a file signed with a crypto algorithm the
kernel doesn't have support for, it will cause the kernel to trigger a
module load. If the EVM policy includes appraisal of kernel modules this
will in turn call back into EVM - since EVM is holding a lock until the
crypto initialisation is complete, this triggers a deadlock. Add a
CRYPTO_NOLOAD flag and skip module loading if it's set, and add that flag
in the EVM case in order to fail gracefully with an error message
instead of deadlocking.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 crypto/api.c                        | 2 +-
 include/linux/crypto.h              | 5 +++++
 security/integrity/evm/evm_crypto.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index 0ee632bba064..7aca9f86c5f3 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -229,7 +229,7 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
 	mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
 
 	alg = crypto_alg_lookup(name, type, mask);
-	if (!alg) {
+	if (!alg && !(mask & CRYPTO_NOLOAD)) {
 		request_module("crypto-%s", name);
 
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 6eb06101089f..e8839d3a7559 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -112,6 +112,11 @@
  */
 #define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
 
+/*
+ * Don't trigger module loading
+ */
+#define CRYPTO_NOLOAD			0x00008000
+
 /*
  * Transform masks and values (for crt_flags).
  */
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 494da5fcc092..bea847dc0919 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -97,7 +97,8 @@ static struct shash_desc *init_desc(char type)
 		mutex_lock(&mutex);
 		if (*tfm)
 			goto out;
-		*tfm = crypto_alloc_shash(algo, 0, CRYPTO_ALG_ASYNC);
+		*tfm = crypto_alloc_shash(algo, 0,
+					  CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
 		if (IS_ERR(*tfm)) {
 			rc = PTR_ERR(*tfm);
 			pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
-- 
2.18.0.rc1.242.g61856ae69a-goog
