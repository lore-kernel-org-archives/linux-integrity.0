Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:51434 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdI0WRT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Sep 2017 18:17:19 -0400
Received: by mail-oi0-f74.google.com with SMTP id a74so8701118oib.10
        for <linux-integrity@vger.kernel.org>; Wed, 27 Sep 2017 15:17:19 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Sep 2017 15:16:53 -0700
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
Message-Id: <20170927221653.11219-7-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Subject: [PATCH 6/6] EVM: Add a new digital signature format
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

As a companion to

EVM: Add an hmac_ng xattr format

add an equivalent format for digital signatures, identical to the
previous format but with an additional 64 bits of information about
which metadata was used to generate the signature. This allows for
distributing digital signatures that protect the metadata without having
to include the inode number (something that's not known in advance)

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/evm/evm_main.c | 26 ++++++++++++++++++++++++++
 security/integrity/integrity.h    |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 77eda423824d..a58ff5d8caf6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -128,9 +128,11 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 {
 	struct evm_ima_xattr_data *xattr_data = NULL;
 	struct evm_hmac_ng_data *hmac_ng_data;
+	struct evm_ima_xattr_ng_data *digsig_ng_data;
 	struct evm_ima_xattr_data calc;
 	enum integrity_status evm_status = INTEGRITY_PASS;
 	int rc, xattr_len;
+	u64 flags;
 
 	if (iint && iint->evm_status == INTEGRITY_PASS)
 		return iint->evm_status;
@@ -209,6 +211,30 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		if (rc)
 			rc = -EINVAL;
 		break;
+	case EVM_IMA_XATTR_DIGSIG_NG:
+		digsig_ng_data = (struct evm_ima_xattr_ng_data *)xattr_data;
+		flags = be64_to_cpu(digsig_ng_data->hdr.flags);
+
+		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
+				   xattr_value_len, flags, calc.digest);
+		if (rc)
+			break;
+		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
+				 (const char *)&digsig_ng_data->sig,
+				 xattr_len-sizeof(struct evm_ima_xattr_ng_hdr),
+				 calc.digest, sizeof(calc.digest));
+		if (!rc) {
+			/* Replace RSA with HMAC if not mounted readonly and
+			 * not immutable
+			 */
+			if (!IS_RDONLY(d_backing_inode(dentry)) &&
+			    !IS_IMMUTABLE(d_backing_inode(dentry)))
+				evm_update_evmxattr(dentry, xattr_name,
+						    xattr_value,
+						    xattr_value_len,
+						    evm_default_flags);
+		}
+		break;
 	default:
 		rc = -EINVAL;
 		break;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9abd99224916..f41ccf42df65 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -64,6 +64,7 @@ enum evm_ima_xattr_type {
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
 	EVM_XATTR_HMAC_NG,
+	EVM_IMA_XATTR_DIGSIG_NG,
 	IMA_XATTR_LAST
 };
 
@@ -113,6 +114,11 @@ struct evm_hmac_ng_data {
 	u8 digest[SHA1_DIGEST_SIZE];
 } __packed;
 
+struct evm_ima_xattr_ng_data {
+	struct evm_ima_xattr_ng_hdr hdr;
+	struct signature_v2_hdr sig;
+} __packed;
+
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
-- 
2.14.2.822.g60be5d43e6-goog
