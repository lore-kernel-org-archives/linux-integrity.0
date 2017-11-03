Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:54386 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbdKCH0z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 03:26:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so2055311lfh.11
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 00:26:54 -0700 (PDT)
Received: from totoro ([83.217.199.75])
        by smtp.gmail.com with ESMTPSA id r23sm1082767lja.32.2017.11.03.00.26.53
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Nov 2017 00:26:53 -0700 (PDT)
Date: Fri, 3 Nov 2017 10:26:52 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: linux-integrity@vger.kernel.org
Subject: [PATCH] evm: allow metadata changes for inode without xattr support
Message-ID: <20171103102652.0618859d@totoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch provide changes in order to allow metadata changes for
inode without xattr support.


Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>

 security/integrity/evm/evm_main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9826c02e2db8..51151c43433d 100644
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
@@ -435,7 +437,8 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
 	if ((evm_status == INTEGRITY_PASS) ||
-	    (evm_status == INTEGRITY_NOXATTRS))
+	    (evm_status == INTEGRITY_NOXATTRS) ||
+	    (evm_status == INTEGRITY_UNKNOWN))
 		return 0;
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
