Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752532AbdI1MlB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 08:41:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8SCdAfE107173
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 08:41:00 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d8xbu23y4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 08:41:00 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 28 Sep 2017 22:40:57 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [RFC PATCH 2/3] integrity: use call_read_iter to calculate the file hash
Date: Thu, 28 Sep 2017 08:39:32 -0400
In-Reply-To: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1506602373-4799-3-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch replaces the ->read file operation method in
integrity_kernel_read() with the newer ->read_iter and sets the
read_iter rwf flag to indicate that the i_rwsem has been taken
exclusively.

Signed-off-by:  Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/iint.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index c84e05866052..df406bb96792 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -16,11 +16,13 @@
  *	  using a rbtree tree.
  */
 #include <linux/slab.h>
+#include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
@@ -184,18 +186,25 @@ security_initcall(integrity_iintcache_init);
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	char __user *buf = (char __user *)addr;
+	struct inode *inode = file_inode(file);
+	struct kvec iov = { .iov_base = addr, .iov_len = count };
+	struct kiocb kiocb;
+	struct iov_iter iter;
 	ssize_t ret;
 
+	lockdep_assert_held(&inode->i_rwsem);
+
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
+	if (!file->f_op->read_iter)
+		return -EBADF;
 
-	old_fs = get_fs();
-	set_fs(get_ds());
-	ret = __vfs_read(file, buf, count, &offset);
-	set_fs(old_fs);
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = offset;
+	iov_iter_kvec(&iter, READ | ITER_KVEC, &iov, 1, count);
 
+	ret = call_read_iter(file, &kiocb, &iter, 1);
+	BUG_ON(ret == -EIOCBQUEUED);
 	return ret;
 }
 
-- 
2.7.4
