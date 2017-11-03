Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:52481 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdKCUSC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 16:18:02 -0400
Received: by mail-lf0-f66.google.com with SMTP id b190so4441707lfg.9
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 13:18:01 -0700 (PDT)
Date: Fri, 3 Nov 2017 23:17:59 +0300
From: Mikhail Kurinnoi <viewizard@viewizard.com>
To: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH] evm: allow uid/gid/mode changes for inode without xattr
 support
Message-ID: <20171103231759.518e2c04@totoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch provide changes in order to allow uid/gid/mode changes for
inode without xattr support.

Signed-off-by: Mikhail Kurinnoi <viewizard@viewizard.com>

 security/integrity/evm/evm_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 9826c02e2db8..e365ea39a3ed 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -431,7 +431,8 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	enum integrity_status evm_status;
 
-	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
+	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) ||
+	    !(d_backing_inode(dentry)->i_opflags & IOP_XATTR))
 		return 0;
 	evm_status = evm_verify_current_integrity(dentry);
 	if ((evm_status == INTEGRITY_PASS) ||
