Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CF5C282CE
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B221B69
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfBKQzG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:55:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:36136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfBKQzG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 11:55:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C983AAC8D;
        Mon, 11 Feb 2019 16:55:04 +0000 (UTC)
From:   Ignaz Forster <iforster@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Cc:     Fabian Vogt <fvogt@suse.com>, Ignaz Forster <iforster@suse.de>,
        Fabian Vogt <fvogt@suse.de>
Subject: [PATCH 3/5] Execute IMA post create hook in vfs_create
Date:   Mon, 11 Feb 2019 17:53:21 +0100
Message-Id: <20190211165323.9369-4-iforster@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190211165323.9369-1-iforster@suse.com>
References: <20190211165323.9369-1-iforster@suse.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ignaz Forster <iforster@suse.de>

When creating a new file on overlayfs, the file can not be accessed
due to missing security.ima / security.evm xattrs, as the creation of
the required hashes is never triggered.

Similarly to the existing handling of tmpfiles, trigger file hash
generation by calling ima_post_create_file.

Co-developed-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Ignaz Forster <iforster@suse.de>
---
 fs/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 744e89474cda..3b4021e4fc32 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2910,8 +2910,10 @@ int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (error)
 		return error;
 	error = dir->i_op->create(dir, dentry, mode, want_excl);
-	if (!error)
+	if (!error) {
 		fsnotify_create(dir, dentry);
+		ima_post_create_file(dentry->d_inode);
+	}
 	return error;
 }
 EXPORT_SYMBOL(vfs_create);
-- 
2.20.1

