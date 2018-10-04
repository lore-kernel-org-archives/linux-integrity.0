Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-oi1-f202.google.com ([209.85.167.202]:33049 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeJEDZK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 23:25:10 -0400
Received: by mail-oi1-f202.google.com with SMTP id p14-v6so7225186oip.0
        for <linux-integrity@vger.kernel.org>; Thu, 04 Oct 2018 13:30:15 -0700 (PDT)
Date: Thu,  4 Oct 2018 13:30:06 -0700
In-Reply-To: <20181004203007.217320-1-mjg59@google.com>
Message-Id: <20181004203007.217320-3-mjg59@google.com>
Mime-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com>
Subject: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
From: Matthew Garrett <mjg59@google.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Some filesystems may be able to provide hashes in an out of band manner,
and allowing them to do so is a performance win. This is especially true
of FUSE-based filesystems where otherwise we recalculate the hash on
every measurement. Make use of this by default, but provide a parameter
to force recalculation rather than trusting the filesystem.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 security/integrity/ima/ima_crypto.c             | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 92eb1f42240d..617ae0f83b14 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1612,6 +1612,11 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	ima.force_hash= [IMA] Force hash calculation in IMA
+			Format: <bool>
+			Always calculate hashes rather than trusting the
+			filesystem to provide them to us.
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7e7e7e7c250a..f25259b2b6ec 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -32,6 +32,10 @@ static unsigned long ima_ahash_minsize;
 module_param_named(ahash_minsize, ima_ahash_minsize, ulong, 0644);
 MODULE_PARM_DESC(ahash_minsize, "Minimum file size for ahash use");
 
+static bool ima_force_hash;
+module_param_named(force_hash, ima_force_hash, bool_enable_only, 0644);
+MODULE_PARM_DESC(force_hash, "Always calculate hashes");
+
 /* default is 0 - 1 page. */
 static int ima_maxorder;
 static unsigned int ima_bufsize = PAGE_SIZE;
@@ -431,6 +435,13 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 		return -EINVAL;
 	}
 
+	if (!ima_force_hash) {
+		hash->length = hash_digest_size[hash->algo];
+		rc = vfs_get_hash(file, hash->algo, hash->digest, hash->length);
+		if (!rc)
+			return 0;
+	}
+
 	i_size = i_size_read(file_inode(file));
 
 	if (ima_ahash_minsize && i_size >= ima_ahash_minsize) {
-- 
2.19.0.605.g01d371f741-goog
