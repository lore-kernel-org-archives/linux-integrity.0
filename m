Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-yb0-f201.google.com ([209.85.213.201]:34079 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753556AbeE3U2M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 16:28:12 -0400
Received: by mail-yb0-f201.google.com with SMTP id f13-v6so1852324ybg.1
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 13:28:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 30 May 2018 13:28:04 -0700
In-Reply-To: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
Message-Id: <20180530202804.148245-1-mjg59@google.com>
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
Subject: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>,
        wangjunwen@baidu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Does this help?

Trying to instantiate a non-existent crypto algorithm will cause the
kernel to trigger a module load. If EVM appraisal is enabled, this will
in turn trigger appraisal of the module, which will fail because the
crypto algorithm isn't available. Add a CRYPTO_NOLOAD flag and skip
module loading if it's set, and add that flag in the EVM case.
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
index eb87d40c62a5..ff8687232a1a 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -97,7 +97,8 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
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
2.17.1.1185.g55be947832-goog
