Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E19DC282CE
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A32C21B69
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfBKQzJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:55:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:36158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfBKQzI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 11:55:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 970A3ACC0;
        Mon, 11 Feb 2019 16:55:07 +0000 (UTC)
From:   Ignaz Forster <iforster@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Cc:     Fabian Vogt <fvogt@suse.com>, Ignaz Forster <iforster@suse.de>,
        Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 4/5] Ignore IMA / EVM xattrs during copy_up
Date:   Mon, 11 Feb 2019 17:53:22 +0100
Message-Id: <20190211165323.9369-5-iforster@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190211165323.9369-1-iforster@suse.com>
References: <20190211165323.9369-1-iforster@suse.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ignaz Forster <iforster@suse.de>

EVM tries to protect these attributes during copy_up, resulting in
the failure of the copy_up operation.

This patch will skip the attributes (similar to selinux) to allow
for later recalculation. This, however, introduces another problem:
As overlayfs does not check the file integrity on copy_up, files with
an invalid hash will suddenly become valid again after the copy_up
operation.

Co-developed-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Ignaz Forster <iforster@suse.de>
---
 security/integrity/evm/evm_main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 5ecaa3d6fe0b..e7667f1159c9 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -23,6 +23,7 @@
 #include <linux/integrity.h>
 #include <linux/evm.h>
 #include <linux/magic.h>
+#include <linux/lsm_hooks.h>
 
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
@@ -548,6 +549,22 @@ int evm_inode_init_security(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(evm_inode_init_security);
 
+static int evm_inode_copy_up_xattr(const char *name)
+{
+	/* The copy_up hook above sets the initial context on an inode, but we
+	 * don't then want to overwrite it by blindly copying all the lower
+	 * xattrs up.  Instead, we have to filter out SELinux-related xattrs.
+	 */
+	if (strcmp(name, XATTR_NAME_EVM) == 0 ||
+			strcmp(name, XATTR_NAME_IMA) == 0)
+		return 1; /* Discard */
+	/*
+	 * Any other attribute apart from SELINUX is not claimed, supported
+	 * by selinux.
+	 */
+	return -EOPNOTSUPP;
+}
+
 #ifdef CONFIG_EVM_LOAD_X509
 void __init evm_load_x509(void)
 {
@@ -559,6 +576,10 @@ void __init evm_load_x509(void)
 }
 #endif
 
+static struct security_hook_list evm_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(inode_copy_up_xattr, evm_inode_copy_up_xattr)
+};
+
 static int __init init_evm(void)
 {
 	int error;
@@ -567,6 +588,8 @@ static int __init init_evm(void)
 
 	evm_init_config();
 
+	security_add_hooks(evm_hooks, ARRAY_SIZE(evm_hooks), "evm");
+
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
 	if (error)
 		goto error;
-- 
2.20.1

