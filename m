Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f201.google.com ([209.85.223.201]:41595 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdI0WRP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:15 -0400
Received: by mail-io0-f201.google.com with SMTP id f72so18912ioj.0
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:14 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:51 -0700
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
Message-Id: <20170927221653.11219-5-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Subject: [PATCH 4/6] EVM: Add an hmac_ng xattr format
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Create an additional HMAC on-disk xattr format, identical to the current
one but with an additional 64 bits of data to indicate which metadata
was used to create the HMAC. Make use of this information when
calculating the value to compare against it.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm_main.c | 18 ++++++++++++++++++
 security/integrity/integrity.h    | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 52b6fff91f8d..383f003b428e 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -127,6 +127,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					     struct integrity_iint_cache *iint)
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
+	struct evm_hmac_ng_data *hmac_ng_data;
 	struct evm_ima_xattr_data calc;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	int rc, xattr_len;
@@ -190,6 +191,23 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 						    xattr_value_len);
 		}
 		break;
+	case EVM_XATTR_HMAC_NG:
+		hmac_ng_data = (struct evm_hmac_ng_data *)xattr_data;
+		flags = be64_to_cpu(digsig_ng_data->hdr.flags);
+
+		if (xattr_len != sizeof(struct evm_hmac_ng_data)) {
+			evm_status = INTEGRITY_FAIL;
+			goto out;
+		}
+		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
+				   xattr_value_len, flags, calc.digest);
+		if (rc)
+			break;
+		rc = crypto_memneq(hmac_ng_data->digest, calc.digest,
+				   sizeof(calc.digest));
+		if (rc)
+			rc = -EINVAL;
+		break;
 	default:
 		rc = -EINVAL;
 		break;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 2fa0d7bc55fb..9abd99224916 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -63,6 +63,7 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_HMAC,
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
+	EVM_XATTR_HMAC_NG,
 	IMA_XATTR_LAST
 };
 
@@ -71,6 +72,11 @@ struct evm_ima_xattr_data {
 	u8 digest[SHA1_DIGEST_SIZE];
 } __packed;
 
+struct evm_ima_xattr_ng_hdr {
+	u8 type;
+	__be64 flags;
+} __packed;
+
 #define IMA_MAX_DIGEST_SIZE	64
 
 struct ima_digest_data {
@@ -102,6 +108,11 @@ struct signature_v2_hdr {
 	uint8_t sig[0];		/* signature payload */
 } __packed;
 
+struct evm_hmac_ng_data {
+	struct evm_ima_xattr_ng_hdr hdr;
+	u8 digest[SHA1_DIGEST_SIZE];
+} __packed;
+
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
-- 
2.14.2.822.g60be5d43e6-goog
