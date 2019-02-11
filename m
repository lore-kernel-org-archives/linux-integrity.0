Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E0CC169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFDC21B69
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBKQzK (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:55:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:36172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfBKQzK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 11:55:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A199ADD8;
        Mon, 11 Feb 2019 16:55:09 +0000 (UTC)
From:   Ignaz Forster <iforster@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Cc:     Fabian Vogt <fvogt@suse.com>, Ignaz Forster <iforster@suse.de>,
        Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 5/5] Use __vfs_getxattr to get overlayfs xattrs
Date:   Mon, 11 Feb 2019 17:53:23 +0100
Message-Id: <20190211165323.9369-6-iforster@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190211165323.9369-1-iforster@suse.com>
References: <20190211165323.9369-1-iforster@suse.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ignaz Forster <iforster@suse.de>

In vfs_getxattr a query of "security.selinux" will return
"unlabeled", while in __vfs_getxattr -ENODATA will be returned for
the same query. This causes a difference in the generated EVM hashes
for the file on the underlying file system and overlayfs.

Circumvent this by calling __vfs_getxattr directly.

Co-developed-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Ignaz Forster <iforster@suse.de>
---
 fs/overlayfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3b7ed5d2279c..e2c737936576 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -374,7 +374,8 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	res = __vfs_getxattr(realdentry, d_backing_inode(realdentry),
+			name, value, size);
 	revert_creds(old_cred);
 	return res;
 }
-- 
2.20.1

