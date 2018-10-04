Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io1-f74.google.com ([209.85.166.74]:46101 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeJEDZN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 23:25:13 -0400
Received: by mail-io1-f74.google.com with SMTP id l4-v6so10024512iog.13
        for <linux-integrity@vger.kernel.org>; Thu, 04 Oct 2018 13:30:18 -0700 (PDT)
Date: Thu,  4 Oct 2018 13:30:07 -0700
In-Reply-To: <20181004203007.217320-1-mjg59@google.com>
Message-Id: <20181004203007.217320-4-mjg59@google.com>
Mime-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com>
Subject: [PATCH 3/3] FUSE: Allow filesystems to provide gethash methods
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

FUSE implementations may have a secure way to provide file hashes (eg,
they're a front-end to a remote store that ties files to their hashes).
Allow filesystems to expose this information, but require an option to
be provided before it can be used. This is to avoid malicious users
being able to mount an unprivileged FUSE filesystem that provides
incorrect hashes.

A sufficiently malicious FUSE filesystem may still simply swap out its
contents after the hash has been obtained - this patchset does nothing
to change that, and sysadmins should have appropriate policy in place to
protect against that.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/fuse/file.c            | 35 +++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 10 ++++++++++
 include/uapi/linux/fuse.h |  6 ++++++
 4 files changed, 58 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 32d0b883e74f..0696671ea070 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3011,6 +3011,39 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	return err;
 }
 
+
+static int fuse_file_get_hash(struct file *file, enum hash_algo hash,
+			      uint8_t *buf, size_t size)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_conn *fc = ff->fc;
+	FUSE_ARGS(args);
+	struct fuse_gethash_in inarg;
+	int err = 0;
+
+	if (!fc->allow_gethash)
+		return -EOPNOTSUPP;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.size = size;
+	inarg.hash = hash;
+	args.in.h.opcode = FUSE_GETHASH;
+	args.in.h.nodeid = ff->nodeid;
+	args.in.numargs = 1;
+	args.in.args[0].size = sizeof(inarg);
+	args.in.args[0].value = &inarg;
+	args.out.numargs = 1;
+	args.out.args[0].size = size;
+	args.out.args[0].value = buf;
+
+	err = fuse_simple_request(fc, &args);
+
+	if (err == -ENOSYS)
+		err = -EOPNOTSUPP;
+
+	return err;
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
@@ -3027,6 +3060,7 @@ static const struct file_operations fuse_file_operations = {
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
+	.get_hash	= fuse_file_get_hash,
 };
 
 static const struct file_operations fuse_direct_io_file_operations = {
@@ -3044,6 +3078,7 @@ static const struct file_operations fuse_direct_io_file_operations = {
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
+	.get_hash	= fuse_file_get_hash,
 	/* no splice_read */
 };
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f78e9614bb5f..b4d4736cbb38 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -637,6 +637,13 @@ struct fuse_conn {
 	/** Allow other than the mounter user to access the filesystem ? */
 	unsigned allow_other:1;
 
+	/*
+	 * Allow the underlying filesystem to the hash of a file. This is
+	 * used by IMA to avoid needing to calculate the hash on every
+	 * measurement
+	 */
+	unsigned allow_gethash:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index db9e60b7eb69..8051506d245f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -70,6 +70,7 @@ struct fuse_mount_data {
 	unsigned group_id_present:1;
 	unsigned default_permissions:1;
 	unsigned allow_other:1;
+	unsigned allow_gethash:1;
 	unsigned max_read;
 	unsigned blksize;
 };
@@ -454,6 +455,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ALLOW_GETHASH,
 	OPT_ERR
 };
 
@@ -466,6 +468,7 @@ static const match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_BLKSIZE,			"blksize=%u"},
+	{OPT_ALLOW_GETHASH,		"allow_gethash"},
 	{OPT_ERR,			NULL}
 };
 
@@ -552,6 +555,10 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			d->blksize = value;
 			break;
 
+		case OPT_ALLOW_GETHASH:
+			d->allow_gethash = 1;
+			break;
+
 		default:
 			return 0;
 		}
@@ -575,6 +582,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",default_permissions");
 	if (fc->allow_other)
 		seq_puts(m, ",allow_other");
+	if (fc->allow_gethash)
+		seq_puts(m, ",allow_gethash");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
@@ -1141,6 +1150,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fc->user_id = d.user_id;
 	fc->group_id = d.group_id;
 	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->allow_gethash = d.allow_gethash;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 92fa24c24c92..a43e80ea675d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -381,6 +381,7 @@ enum fuse_opcode {
 	FUSE_READDIRPLUS   = 44,
 	FUSE_RENAME2       = 45,
 	FUSE_LSEEK         = 46,
+	FUSE_GETHASH       = 47,
 
 	/* CUSE specific operations */
 	CUSE_INIT          = 4096,
@@ -792,4 +793,9 @@ struct fuse_lseek_out {
 	uint64_t	offset;
 };
 
+struct fuse_gethash_in {
+	uint32_t	size;
+	uint32_t	hash;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.19.0.605.g01d371f741-goog
