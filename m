Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44627 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030363AbeCAMit (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Mar 2018 07:38:49 -0500
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] evm: check for remount ro in progress before writing
Date: Thu,  1 Mar 2018 13:38:45 +0100
Message-Id: <20180301123845.26189-1-s.hauer@pengutronix.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

EVM might update the evm xattr while the VFS performs a remount to
readonly mode. This is not properly checked for, additionally check
the s_readonly_remount superblock flag before writing.
The bug can for example be observed with UBIFS. UBIFS checks the free
space on the device before and after a remount. With EVM enabled the
free space sometimes differs between both checks.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 security/integrity/evm/evm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index a8d502827270..4a147a998aa7 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -185,6 +185,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 					iint->flags |= EVM_IMMUTABLE_DIGSIG;
 				evm_status = INTEGRITY_PASS_IMMUTABLE;
 			} else if (!IS_RDONLY(d_backing_inode(dentry)) &&
+				   !(dentry->d_inode->i_sb->s_readonly_remount) &&
 				   !IS_IMMUTABLE(d_backing_inode(dentry))) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
-- 
2.16.1
