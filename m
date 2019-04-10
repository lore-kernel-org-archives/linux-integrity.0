Return-Path: <SRS0=XOlz=SM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E80C10F11
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Apr 2019 14:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9BA20693
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Apr 2019 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqwbhv5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfDJO6n (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:58:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34929 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfDJO6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Apr 2019 10:58:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so2101657lfu.2
        for <linux-integrity@vger.kernel.org>; Wed, 10 Apr 2019 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8CkaaltMugY3eRTYW67A254BOWVpW/XBlsV/2QWapqM=;
        b=Aqwbhv5DmyuwVaSjsaacLFLBU5dqja07Q9HAa463Rud+AB9v37+peZg3OWhg9MUWqF
         YQv406jpHC+cDBRL3vkfC4wK2TCPcQ4cw/bfuLDAoU/EJrZfmz06KBAgG/URKKKPBeSw
         QlV7GfVn5Hh9ifdFvbn0xhify4qzpLv2U9TMP+6ZsT4Kh5JBdDOfzdqT3jItCgip1/sA
         /a2FW6KDRKzCy4U1HeREH8IDOzEAFju7XrZ+APwn1a09tyEowNRuyV6dK5vbkC//Hi9g
         1NlhvQE2LammMmwTDjzgm14lw+AStaThmfYoFiQEu1EFeysCbZ74vXw7mjoy2TdR913p
         8p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8CkaaltMugY3eRTYW67A254BOWVpW/XBlsV/2QWapqM=;
        b=E6+cSDL6rH48jB9qpbvZhU1DTdX9SPH3gZi1iD2Fv5oeL00K+Kr0IfAZzigR6XWGCO
         AyomYtt1WkttFn/7vAh00f4Ebrg+2ykAF2JQRsiNxKlZBzHIQl2G+PiTNv3XCgUCfO0H
         qaW03a/8n4QK0Ytru578+Yp7id/bUZ9KMUSSrG07jpbarJz6NBSB6Fk19zRe/cUYNbvA
         O4jP55XX94c4PTPL4s5R48SOICddCM6ArKs5wHXKaeBDOD8WsrNoJSmK/ldX4rF888+L
         bmn4Kce9J47brvtOd3MXsjl8I8UzzjxGO+j7uPS3GGlEhPFEYk7P9Y0ttBHpLPoL+DO6
         htYg==
X-Gm-Message-State: APjAAAW8ExNCxgz5RVeQXi4QRHERsofedf35TU60sOoBVyzrUuPGWDnO
        6Iqmiwc1khKr1V1LOKmpzwsxR3oj
X-Google-Smtp-Source: APXvYqwrKiEPxUPIRWaJ3Kkac7kcyl6WBjwsqzdDtzgrowBES/oKNECORnnkerBPhaJTMMfDlzSYoA==
X-Received: by 2002:ac2:48b1:: with SMTP id u17mr23696992lfg.5.1554908320934;
        Wed, 10 Apr 2019 07:58:40 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84b8-177.dhcp.inet.fi. [46.132.184.177])
        by smtp.gmail.com with ESMTPSA id k15sm7273512lji.2.2019.04.10.07.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 07:58:40 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     Janne Karhunen <Janne.Karhunen@gmail.com>,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH] integrity: make 'sync' update the inode integrity state
Date:   Wed, 10 Apr 2019 17:56:59 +0300
Message-Id: <20190410145659.26347-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Janne Karhunen <Janne.Karhunen@gmail.com>

When a file is open for writing, kernel crash or power outage
is guaranteed to corrupt inode integrity state leading to file
appraisal failure on the subsequent boot. Allow applications
to be designed with integrity measurements in mind by making
sure the integrity state is recomputed when sync(fd) is
intentionally called for the open file.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 fs/sync.c                         |  3 +++
 include/linux/ima.h               |  1 +
 include/linux/lsm_hooks.h         |  5 +++++
 include/linux/security.h          |  6 ++++++
 security/integrity/ima/ima_main.c | 31 ++++++++++++++++++++++++++++++-
 security/security.c               |  5 +++++
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..6c01f1970eac 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/backing-dev.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
@@ -194,6 +195,8 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
 		return -EINVAL;
 	if (!datasync && (inode->i_state & I_DIRTY_TIME))
 		mark_inode_dirty_sync(inode);
+	security_file_sync(file);
+
 	return file->f_op->fsync(file, start, end, datasync);
 }
 EXPORT_SYMBOL(vfs_fsync_range);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..dbd6c56ae7e1 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -20,6 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
+extern void ima_file_update(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a9b8ff578b6b..196a04d06fb6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -541,6 +541,9 @@
  *	Save open-time permission checking state for later use upon
  *	file_permission, and recheck access if anything has changed
  *	since inode_permission.
+ * @file_sync:
+ *	Called when sync is being requested for file. Primary use is to make
+ *	sure integrity measurement of the file is kept in sync with the data.
  *
  * Security hooks for task operations.
  *
@@ -1596,6 +1599,7 @@ union security_list_options {
 					struct fown_struct *fown, int sig);
 	int (*file_receive)(struct file *file);
 	int (*file_open)(struct file *file);
+	void (*file_sync)(struct file *file);
 
 	int (*task_alloc)(struct task_struct *task, unsigned long clone_flags);
 	void (*task_free)(struct task_struct *task);
@@ -1892,6 +1896,7 @@ struct security_hook_heads {
 	struct hlist_head file_send_sigiotask;
 	struct hlist_head file_receive;
 	struct hlist_head file_open;
+	struct hlist_head file_sync;
 	struct hlist_head task_alloc;
 	struct hlist_head task_free;
 	struct hlist_head cred_alloc_blank;
diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..467cfa02f9f6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -315,6 +315,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+void security_file_sync(struct file *file);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
@@ -876,6 +877,11 @@ static inline int security_file_open(struct file *file)
 	return 0;
 }
 
+static inline void security_file_sync(struct file *file)
+{
+	return;
+}
+
 static inline int security_task_alloc(struct task_struct *task,
 				      unsigned long clone_flags)
 {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..e60b878d8356 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -16,7 +16,7 @@
  *
  * File: ima_main.c
  *	implements the IMA hooks: ima_bprm_check, ima_file_mmap,
- *	and ima_file_check.
+ *	ima_file_update and ima_file_check.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -375,6 +375,35 @@ int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+/**
+ * ima_file_update - called from sync to update xattrs
+ * @file: pointer to file structure being updated
+ */
+void ima_file_update(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct integrity_iint_cache *iint;
+
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+		return;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return;
+
+	mutex_lock(&iint->mutex);
+	if (atomic_read(&inode->i_writecount) == 1) {
+		clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
+		if (!IS_I_VERSION(inode) ||
+		    !inode_eq_iversion(inode, iint->version)) {
+			iint->flags &= ~IMA_COLLECTED;
+			ima_update_xattr(iint, file);
+		}
+	}
+	mutex_unlock(&iint->mutex);
+}
+EXPORT_SYMBOL_GPL(ima_file_update);
+
 /**
  * ima_path_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
diff --git a/security/security.c b/security/security.c
index 23cbb1a295a3..6a0980a1df22 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1451,6 +1451,11 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+void security_file_sync(struct file *file)
+{
+	ima_file_update(file);
+}
+
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
-- 
2.17.1

