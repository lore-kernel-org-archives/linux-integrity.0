Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50852 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJEDZI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 23:25:08 -0400
Received: by mail-qk1-f201.google.com with SMTP id g131-v6so9693159qke.17
        for <linux-integrity@vger.kernel.org>; Thu, 04 Oct 2018 13:30:13 -0700 (PDT)
Date: Thu,  4 Oct 2018 13:30:05 -0700
In-Reply-To: <20181004203007.217320-1-mjg59@google.com>
Message-Id: <20181004203007.217320-2-mjg59@google.com>
Mime-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com>
Subject: [PATCH 1/3] VFS: Add a call to obtain a file's hash
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA wants to know what the hash of a file is, and currently does so by
reading the entire file and generating the hash. Some filesystems may
have the ability to store the hash in a secure manner resistant to
offline attacks (eg, filesystem-level file signing), and in that case
it's a performance win for IMA to be able to use that rather than having
to re-hash everything. This patch simply adds VFS-level support for
calling down to filesystems.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/read_write.c    | 24 ++++++++++++++++++++++++
 include/linux/fs.h |  6 +++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 39b4a21dd933..9ba3ce4bb838 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2081,3 +2081,27 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	return ret;
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range);
+
+/**
+ * vfs_gethash - obtain a file's hash
+ * @file:	file structure in question
+ * @hash_algo:	the hash algorithm requested
+ * @buf:	buffer to return the hash in
+ * @size:	size allocated for the buffer by the caller
+ *
+ * This function allows filesystems that support securely storing the hash
+ * of a file to return it rather than forcing the kernel to recalculate it.
+ * Filesystems that cannot provide guarantees about the hash being resistant
+ * to offline attack should not implement this functionality.
+ *
+ * Returns 0 on success, -EOPNOTSUPP if the filesystem doesn't support it.
+ */
+int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
+		 size_t size)
+{
+	if (!file->f_op->get_hash)
+		return -EOPNOTSUPP;
+
+	return file->f_op->get_hash(file, hash, buf, size);
+}
+EXPORT_SYMBOL(vfs_get_hash);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c0b4a1c22ff..540316cfd461 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/hash_info.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -1764,6 +1765,8 @@ struct file_operations {
 	int (*dedupe_file_range)(struct file *, loff_t, struct file *, loff_t,
 			u64);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*get_hash)(struct file *, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 } __randomize_layout;
 
 struct inode_operations {
@@ -1838,7 +1841,8 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern int vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 				     struct file *dst_file, loff_t dst_pos,
 				     u64 len);
-
+extern int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
-- 
2.19.0.605.g01d371f741-goog
