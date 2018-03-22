Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47253 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbeCVOnw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 10:43:52 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v2 1/2] ima: Introduce ima_alloc_alg() to reduce duplicity
Date: Thu, 22 Mar 2018 15:43:12 +0100
Message-Id: <20180322144313.28748-2-pvorel@suse.cz>
In-Reply-To: <20180322144313.28748-1-pvorel@suse.cz>
References: <20180322144313.28748-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This is preparation for next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima_crypto.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 205bc69361ea..ddc18f4633e5 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -62,36 +62,33 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
 static struct crypto_shash *ima_shash_tfm;
 static struct crypto_ahash *ima_ahash_tfm;
 
-int __init ima_init_crypto(void)
+static int ima_alloc_shash(struct crypto_shash **tfm, const char *alg_name)
 {
 	long rc;
 
-	ima_shash_tfm = crypto_alloc_shash(hash_algo_name[ima_hash_algo], 0, 0);
-	if (IS_ERR(ima_shash_tfm)) {
-		rc = PTR_ERR(ima_shash_tfm);
-		pr_err("Can not allocate %s (reason: %ld)\n",
-		       hash_algo_name[ima_hash_algo], rc);
+	*tfm = crypto_alloc_shash(alg_name, 0, 0);
+	if (IS_ERR(*tfm)) {
+		rc = PTR_ERR(*tfm);
+		pr_err("Can not allocate %s (reason: %ld)\n", alg_name, rc);
 		return rc;
 	}
 	return 0;
 }
 
+int __init ima_init_crypto(void)
+{
+	return ima_alloc_shash(&ima_shash_tfm, hash_algo_name[ima_hash_algo]);
+}
+
 static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 {
 	struct crypto_shash *tfm = ima_shash_tfm;
-	int rc;
 
 	if (algo < 0 || algo >= HASH_ALGO__LAST)
 		algo = ima_hash_algo;
 
-	if (algo != ima_hash_algo) {
-		tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);
-		if (IS_ERR(tfm)) {
-			rc = PTR_ERR(tfm);
-			pr_err("Can not allocate %s (reason: %d)\n",
-			       hash_algo_name[algo], rc);
-		}
-	}
+	if (algo != ima_hash_algo)
+		ima_alloc_shash(&tfm, hash_algo_name[algo]);
 	return tfm;
 }
 
-- 
2.12.3
