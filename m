Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753026AbeBSPSZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 10:18:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1JFFV3v051178
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 10:18:24 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g7yqcvjcd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Feb 2018 10:18:24 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 19 Feb 2018 15:18:22 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v1 2/2] fuse: define the filesystem as untrusted
Date: Mon, 19 Feb 2018 10:18:03 -0500
In-Reply-To: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1519053483-18396-3-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Files on FUSE can change at any point in time without IMA being able
to detect it.  The file data read for the file signature verification
could be totally different from what is subsequently read, making the
signature verification useless.

FUSE can be mounted by unprivileged users either today with fusermount
installed with setuid, or soon with the upcoming patches to allow FUSE
mounts in a non-init user namespace.

This patch sets the SB_I_IMA_UNTRUSTED_FS flag.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..2cbf01fc85a2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1080,6 +1080,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
+	sb->s_iflags |= SB_I_IMA_UNTRUSTED_FS;
 
 	file = fget(d.fd);
 	err = -EINVAL;
-- 
2.7.5
