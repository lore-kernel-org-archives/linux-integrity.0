Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A98C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB9521873
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SARWUUNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfBZVux (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:50:53 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47677 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfBZVuw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 16:50:52 -0500
Received: by mail-vk1-f201.google.com with SMTP id y132so1118460vkd.14
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 13:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sTEnArxA3KhiLdOWIX5HwLoDvZHEQrk/7qv7T+h1Kus=;
        b=SARWUUNyP4ZaYFzfPqHmYTwCKaxhu5iosYKf5IGzgNAmQGmtXypdLpbbTsYmiwT0o2
         QW3yhqMRm8JamXNRu/UhU54O0T2pNlrukk9R0wRJfcw7StJD3QEUX5sfu4Fll5ph+LAp
         fqQij50oSfM847bVrbiLhw0EAzbrsG1dY4DG4hpZaoKr+LxxhwbVyeRETqwmtsMuIGZI
         jzVWm91kgTKXGsgnSqPehGp0ZjpagJ40E8g4Mb+3jYOzocNjTvW8+WBfC0uNfBc5ufJo
         yfS6bGCMYs3A0iyBVf+IG3gf7jy4nf7Z31rzhnN2xadZPCa8wdmkSPi9PStrnZ1P8irY
         Q0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sTEnArxA3KhiLdOWIX5HwLoDvZHEQrk/7qv7T+h1Kus=;
        b=fqIHg5mZmNTKdnxCjnEBOYhaQbYTHDmp4MBqHlYcBJk6KfCKz1Ykj5BdmxHvFAlpQx
         lzBpX8kqSQfSKfv63AyYOwcFBde1i+psl5fCTwR2a7S8W+2mk9OC74gegdNSRuwhNpSw
         cA8MsOa3kllh3uv4zpkYSnLquOnL122d9SdkrdxK6aPqF/aT/c0BQtUl/KJMIPXuO2G9
         TJyxbhYuJUm7AvkKB1a3kb9V4cgHubL6AbILc/Ljp2L2boHeJGVXGRRYyUsoZQljqQuQ
         VxtG/iJuhgawnLDNfYGkP9RtwqIzuRMBslJNyEDq4mBd+JB/dBHV08hpbOezfFoyuinL
         Pb/w==
X-Gm-Message-State: AHQUAub665OTOf9t1dNoc6e3jxME49TVMkYtK+yDngPuRXxwLbm2w6dd
        kjMdbtUAFych72BxAZ2w1ILAm05TwdviO2NcW10hv0GSk3wBbzuUeWH85DIJ6c0+vO77qLqiLUa
        HawfMn/PlxJ7yEFxUoVIadVxd7WFEovR+7evnfQ5naoCk6+YO22vLBmUMc4O3U/xeuMHj9prF4r
        KpNlGhnOa0gBwAqKGI8r4=
X-Google-Smtp-Source: AHgI3IbZwX/5sJf1k67SLWD48J8TgNVLpbdFCmviXknsx2gGdVMTt+DtmDxgrOeOZT/9kQH7dv5dcdoU9TGOwjBUmkXGjw==
X-Received: by 2002:a1f:1b82:: with SMTP id b124mr12503445vkb.11.1551217851266;
 Tue, 26 Feb 2019 13:50:51 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:50:34 -0800
In-Reply-To: <20190226215034.68772-1-matthewgarrett@google.com>
Message-Id: <20190226215034.68772-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH V2 4/4] FUSE: Allow filesystems to provide gethash methods
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

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
 fs/fuse/file.c            | 34 ++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 15 +++++++++++++++
 include/uapi/linux/fuse.h |  6 ++++++
 4 files changed, 62 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a59c16bd90ac..a791d69385de 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3099,6 +3099,38 @@ static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	inode_unlock(inode_out);
 
+	return err;
+};
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
 	return err;
 }
 
@@ -3119,6 +3151,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.get_hash	= fuse_file_get_hash,
 };
 
 static const struct file_operations fuse_direct_io_file_operations = {
@@ -3136,6 +3169,7 @@ static const struct file_operations fuse_direct_io_file_operations = {
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
+	.get_hash	= fuse_file_get_hash,
 	/* no splice_read */
 };
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 2f2c92e6f8cb..f63920ebce85 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -705,6 +705,13 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
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
index c2d4099429be..d0d4177fb099 100644
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
@@ -453,6 +454,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_ALLOW_GETHASH,
 	OPT_ERR
 };
 
@@ -465,6 +467,7 @@ static const match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_BLKSIZE,			"blksize=%u"},
+	{OPT_ALLOW_GETHASH,		"allow_gethash"},
 	{OPT_ERR,			NULL}
 };
 
@@ -551,6 +554,15 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			d->blksize = value;
 			break;
 
+		case OPT_ALLOW_GETHASH:
+			/*
+			 * This is relevant to security decisions made in
+			 * the root namespace, so restrict it more strongly
+			 */
+			if (capable(CAP_SYS_ADMIN))
+				d->allow_gethash = 1;
+			break;
+
 		default:
 			return 0;
 		}
@@ -574,6 +586,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",default_permissions");
 	if (fc->allow_other)
 		seq_puts(m, ",allow_other");
+	if (fc->allow_gethash)
+		seq_puts(m, ",allow_gethash");
 	if (fc->max_read != ~0)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
@@ -1163,6 +1177,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	fc->user_id = d.user_id;
 	fc->group_id = d.group_id;
 	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->allow_gethash = d.allow_gethash;
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b4967d48bfda..d106ea3e52f3 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -394,6 +394,7 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_GETHASH		= 48,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -817,4 +818,9 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+struct fuse_gethash_in {
+	uint32_t	size;
+	uint32_t	hash;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

