Return-Path: <SRS0=XaU3=RB=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FAC43381
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326A421873
	for <linux-integrity@archiver.kernel.org>; Tue, 26 Feb 2019 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0pghNy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfBZVuo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:50:44 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:42661 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfBZVuo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Feb 2019 16:50:44 -0500
Received: by mail-it1-f202.google.com with SMTP id j127so3386917itj.7
        for <linux-integrity@vger.kernel.org>; Tue, 26 Feb 2019 13:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OrLpVbFrhqHDu/nyMeqzGxF462Au6CRl2ys6e5+Fmlc=;
        b=M0pghNy1IQHmsn3LwD2Rcupn1ATT8/1wGNHkMW9MAWjSBSLDvTiaRdLeXMYpwV+7WD
         jSLN5JxVQV7bsATkpBQTv+/5fmChgvq/z1uPIRBoBLou23Fjlr6nXL6L6z1fcs3vnE+i
         oXR0uUWVHDs/rrMjZ7zUPmjMSDK3lTBFZCvGmiAozC9gq1IHzO4+esKKscVmTOiqFo0u
         fbRgYPr3rEQcvIzALTLF8MywzJJvAvgp4ZpMWI39RXnbAe1FDwKLCWnWsdU+FktpFxDo
         DlQ5uLlkfw8VSkg9bpX0X3dXkm15u6YVl3ezMs5qMordxE3TrTfKkkOxYTlflREAs5wr
         3eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OrLpVbFrhqHDu/nyMeqzGxF462Au6CRl2ys6e5+Fmlc=;
        b=ooKENFA6ODPqpVv9kZSK6wvpRNlbc53F2KwxfPMH/O+rxnh55nYTVf068YR5XO0OM5
         FBKeP/fS1TJJfu7kcItHbMgL2+QYu0AkKKLucWeH+SZuBpDu5YST2KdibPg2dXgQBD55
         CR34UoOniOVgcQ5iSiesY/FyYPv81KwFawi3cjmJLtV0KI4/R2VU2GDxL3BI/UeV2fHL
         QIjAxReXON5JL1M2cxFqKbQcOh7r9OxFBIiQCclP/QAv+q6nLhEF9xJNcFOGbfq5N5eL
         8uxWAKMR7a+0ecEOlAufSwFawSVlOWlUamE+iH576pd1YuZPVZgwG2bxtjjK3SANk+lJ
         YK+g==
X-Gm-Message-State: AHQUAuar5lC4KwsvCTnEIAPxxvbUFlzOIFt02xejtF3mmkuvHWNjGRpf
        61MHtDkIEW6L0uUaly3A8WpoJG9R7YAAJ3w7VD2GFXHtoXiqDoxYGwXYAcUuZkTRCstBH5ceN8i
        SkdCbEJ0If6gvRkiD/MS7QaeokIMP47Jl7hHA7bRtgunf9Y+MUAScnrRlYq+UKYKqIVRrUbwNej
        hcleJ3o4kxgd48UNDeWkE=
X-Google-Smtp-Source: AHgI3IZbVD7NCGm3UXQ5pHDo2aRoNP9MyW1XXkOooFu5JiDCKU/A+poA+djdpw+M0YUSl/X/+PykqMmaDaCNfYuTJkaAZw==
X-Received: by 2002:a24:220a:: with SMTP id o10mr3938734ito.22.1551217843625;
 Tue, 26 Feb 2019 13:50:43 -0800 (PST)
Date:   Tue, 26 Feb 2019 13:50:31 -0800
In-Reply-To: <20190226215034.68772-1-matthewgarrett@google.com>
Message-Id: <20190226215034.68772-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH V2 1/4] VFS: Add a call to obtain a file's hash
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
index ff3c5e6f87cf..2b86f912be34 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -2150,3 +2150,27 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
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
index 29d8e2cfed0e..c6de2855cfdb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/hash_info.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -1819,6 +1820,8 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	int (*get_hash)(struct file *, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 } __randomize_layout;
 
 struct inode_operations {
@@ -1895,7 +1898,8 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
-
+extern int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,
+			size_t size);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

