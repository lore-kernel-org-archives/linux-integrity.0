Return-Path: <SRS0=npIO=OT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D29C04EB8
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Dec 2018 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A2C20821
	for <linux-integrity@archiver.kernel.org>; Mon, 10 Dec 2018 13:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A2C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeLJNZG (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:25:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeLJNZG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Dec 2018 08:25:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77759AED5;
        Mon, 10 Dec 2018 13:25:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, linux-integrity@vger.kernel.org,
        zohar@linux.vnet.ibm.com, amir73il@gmail.com, jmorris@namei.org,
        jlayton@kernel.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        akpm@linux-foundation.org, adilger.kernel@dilger.ca,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] fs: Convert open-coded "is inode open for write" check
Date:   Mon, 10 Dec 2018 15:25:00 +0200
Message-Id: <20181210132500.10864-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210131903.4528-1-nborisov@suse.com>
References: <20181210131903.4528-1-nborisov@suse.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is a generic helper inode_is_open_for_write that could be used
when checking i_writecount. Use it instead of opencoding
if (i_writecount > 0) check.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Changes v2: 
 * This time actually compile-tested it, doh...


 fs/ext4/inode.c                    | 2 +-
 fs/ext4/mballoc.c                  | 7 +++----
 fs/locks.c                         | 2 +-
 fs/notify/fanotify/fanotify_user.c | 2 +-
 security/integrity/ima/ima_main.c  | 2 +-
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 22a9d8159720..04e5bc0b5c8d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -391,7 +391,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 	 * inode's preallocations.
 	 */
 	if ((ei->i_reserved_data_blocks == 0) &&
-	    (atomic_read(&inode->i_writecount) == 0))
+	    !inode_is_open_for_write(inode))
 		ext4_discard_preallocations(inode);
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e2248083cdca..b811a9cb896e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4176,9 +4176,8 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
-	if ((size == isize) &&
-	    !ext4_fs_is_busy(sbi) &&
-	    (atomic_read(&ac->ac_inode->i_writecount) == 0)) {
+	if ((size == isize) && !ext4_fs_is_busy(sbi)
+	    && !inode_is_open_for_write(ac->ac_inode)) {
 		ac->ac_flags |= EXT4_MB_HINT_NOPREALLOC;
 		return;
 	}
@@ -4258,7 +4257,7 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 			(unsigned) ar->goal, ac->ac_flags, ac->ac_2order,
 			(unsigned) ar->lleft, (unsigned) ar->pleft,
 			(unsigned) ar->lright, (unsigned) ar->pright,
-			atomic_read(&ar->inode->i_writecount) ? "" : "non-");
+			inode_is_open_for_write(ar->inode) ? "" : "non-");
 	return 0;
 
 }
diff --git a/fs/locks.c b/fs/locks.c
index 2ecb4db8c840..16ea7d89a67d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1646,7 +1646,7 @@ check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
 	if (flags & FL_LAYOUT)
 		return 0;
 
-	if ((arg == F_RDLCK) && (atomic_read(&inode->i_writecount) > 0))
+	if ((arg == F_RDLCK) && inode_is_open_for_write(inode))
 		return -EAGAIN;
 
 	if ((arg == F_WRLCK) && ((d_count(dentry) > 1) ||
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e03be5071362..98b0769e4cf2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -669,7 +669,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 	 */
 	if ((flags & FAN_MARK_IGNORED_MASK) &&
 	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
-	    (atomic_read(&inode->i_writecount) > 0))
+	    inode_is_open_for_write(inode))
 		return 0;
 
 	return fanotify_add_mark(group, &inode->i_fsnotify_marks,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1b88d58e1325..05fbf8a2fa42 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -103,7 +103,7 @@ static void ima_rdwr_violation_check(struct file *file,
 	} else {
 		if (must_measure)
 			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if ((atomic_read(&inode->i_writecount) > 0) && must_measure)
+		if (inode_is_open_for_write(inode) && must_measure)
 			send_writers = true;
 	}
 
-- 
2.17.1

