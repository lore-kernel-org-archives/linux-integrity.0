Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45308 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKCUSw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 16:18:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id n69so4468017lfn.2
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 13:18:51 -0700 (PDT)
Date: Fri, 3 Nov 2017 23:18:49 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] evm: return the real setxattr/removexattr failure status
 for inode without xattr support
Message-ID: <20171103231849.0fb36c15@totoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch provide changes in order to return the real setxattr/removexattr
failure status for inode without xattr support.

Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>

 security/integrity/evm/evm_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9826c02e2db8..ca412d65a416 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -294,8 +294,7 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 		if (!posix_xattr_acl(xattr_name))
 			return 0;
 		evm_status = evm_verify_current_integrity(dentry);
-		if ((evm_status == INTEGRITY_PASS) ||
-		    (evm_status == INTEGRITY_NOXATTRS))
+		if (evm_status == INTEGRITY_NOXATTRS)
 			return 0;
 		goto out;
 	}
@@ -319,12 +318,15 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 				    -EPERM, 0);
 	}
 out:
-	if (evm_status != INTEGRITY_PASS)
-		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
-				    dentry->d_name.name, "appraise_metadata",
-				    integrity_status_msg[evm_status],
-				    -EPERM, 0);
-	return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
+	if ((evm_status == INTEGRITY_PASS) ||
+	    (evm_status == INTEGRITY_UNKNOWN))
+		return 0;
+
+	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
+			    dentry->d_name.name, "appraise_metadata",
+			    integrity_status_msg[evm_status],
+			    -EPERM, 0);
+	return -EPERM;
 }
 
 /**
