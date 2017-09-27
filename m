Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f73.google.com ([209.85.218.73]:61291 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdI0WRR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:17 -0400
Received: by mail-oi0-f73.google.com with SMTP id m198so8758110oig.19
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:52 -0700
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
Message-Id: <20170927221653.11219-6-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Subject: [PATCH 5/6] EVM: Write out HMAC xattrs in the new format
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Write out HMACs in the NG format rather than the original format.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm.h        |  2 +-
 security/integrity/evm/evm_crypto.c | 10 ++++++----
 security/integrity/evm/evm_main.c   | 10 ++++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index 1d8201b1fb8a..e4de787508f2 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -56,7 +56,7 @@ int evm_init_key(void);
 int evm_update_evmxattr(struct dentry *dentry,
 			const char *req_xattr_name,
 			const char *req_xattr_value,
-			size_t req_xattr_value_len);
+			size_t req_xattr_value_len, u64 flags);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
 		  size_t req_xattr_value_len, u64 flags, char *digest);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 9ce55ac6781e..a00c48c52307 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -259,16 +259,18 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
  * Expects to be called with i_mutex locked.
  */
 int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
-			const char *xattr_value, size_t xattr_value_len)
+			const char *xattr_value, size_t xattr_value_len,
+			u64 flags)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct evm_ima_xattr_data xattr_data;
+	struct evm_hmac_ng_data xattr_data;
 	int rc = 0;
 
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			xattr_value_len, evm_default_flags, xattr_data.digest);
+			   xattr_value_len, flags, xattr_data.digest);
 	if (rc == 0) {
-		xattr_data.type = EVM_XATTR_HMAC;
+		xattr_data.hdr.type = EVM_XATTR_HMAC_NG;
+		xattr_data.hdr.flags = cpu_to_be64(flags);
 		rc = __vfs_setxattr_noperm(dentry, XATTR_NAME_EVM,
 					   &xattr_data,
 					   sizeof(xattr_data), 0);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 383f003b428e..77eda423824d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -188,7 +188,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			    !IS_IMMUTABLE(d_backing_inode(dentry)))
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
-						    xattr_value_len);
+						    xattr_value_len,
+						    evm_default_flags);
 		}
 		break;
 	case EVM_XATTR_HMAC_NG:
@@ -427,7 +428,8 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 
 	evm_reset_status(dentry->d_inode);
 
-	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
+	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len,
+			    evm_default_flags);
 }
 
 /**
@@ -447,7 +449,7 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 
 	evm_reset_status(dentry->d_inode);
 
-	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
+	evm_update_evmxattr(dentry, xattr_name, NULL, 0, evm_default_flags);
 }
 
 /**
@@ -488,7 +490,7 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 		return;
 
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
-		evm_update_evmxattr(dentry, NULL, NULL, 0);
+		evm_update_evmxattr(dentry, NULL, NULL, 0, evm_default_flags);
 }
 
 /*
-- 
2.14.2.822.g60be5d43e6-goog
