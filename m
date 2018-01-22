Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751216AbeAVOyh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEqfAR183350
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:36 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fngwj3x7r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:36 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:34 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 09/10] ima-evm-utils: verify IMA file hashes stored as xattrs
Date: Mon, 22 Jan 2018 09:54:04 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-10-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

evmctl "ima_verify" verifies file signatures stored as xattrs on the
local filesystem.  This patch adds support for verifying the file hashes
stored as xattrs.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/evmctl.c    |  3 +++
 src/imaevm.h    |  1 +
 src/libimaevm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5d1c6ea..9142ed4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -794,6 +794,9 @@ static int verify_ima(const char *file)
 		}
 	}
 
+	if (sig[0] == IMA_XATTR_DIGEST_NG || sig[0] == IMA_XATTR_DIGEST)
+		return ima_verify_hash(file, sig, len);
+
 	return ima_verify_signature(file, sig, len, NULL, 0);
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index f5cee7d..d624571 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -205,6 +205,7 @@ int key2bin(RSA *key, unsigned char *pub);
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
+int ima_verify_hash(const char *file, unsigned char *digest, int digestlen);
 void init_public_keys(const char *keyfiles);
 
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 247100f..bc9c496 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -49,6 +49,7 @@
 #include <dirent.h>
 #include <string.h>
 #include <stdio.h>
+#include <linux/hash_info.h>
 
 #include <openssl/pem.h>
 #include <openssl/evp.h>
@@ -613,6 +614,47 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	return verify_hash(hash, hashlen, sig + 1, siglen - 1);
 }
 
+int ima_verify_hash(const char *file, unsigned char *digest, int digestlen)
+{
+	unsigned char hash[64];
+	int hashlen, hash_algo = HASH_ALGO_SHA1;
+
+	if (digest[0] == IMA_XATTR_DIGEST_NG)
+		hash_algo = digest[1]; 
+
+	if (hash_algo < 0  || hash_algo > HASH_ALGO__LAST) {
+		log_err("Invalid signature\n");
+		return -1;
+	}
+
+	/* Use hash algorithm as retrieved from xattr */
+	params.hash_algo = pkey_hash_algo[hash_algo];
+
+	hashlen = ima_calc_hash(file, hash);
+	if (hashlen <= 1)
+		return hashlen;
+
+	if (digest[0] == IMA_XATTR_DIGEST_NG) {
+		if (hashlen != digestlen - 2 ||
+		    memcmp(digest + 2, hash, hashlen)) {
+			log_err("Hash ng verification failed\n");
+			return -1;
+		}
+		log_info("Hash verification is OK\n");
+		return 0;
+	} else if (digest[0] == IMA_XATTR_DIGEST) {
+		if (hashlen != digestlen - 1 ||
+		    memcmp(digest + 1, hash, hashlen)) {
+			log_err("Hash verification failed\n");
+			return -1;
+		}
+		log_info("Hash verification is OK\n");
+		return 0;
+	}
+	log_err("Unknown security.ima format\n");
+	return -1;
+}
+
 /*
  * Create binary key representation suitable for kernel
  */
-- 
2.7.4
