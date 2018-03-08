Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750783AbeCHUZI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 15:25:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28KP8OO124159
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 15:25:08 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gkaf9v1tw-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 15:24:32 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 20:24:30 -0000
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
Subject: [PATCH v3 4/4] fuse: define the filesystem as untrusted
Date: Thu,  8 Mar 2018 15:24:10 -0500
In-Reply-To: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Files on FUSE can change at any point in time without IMA being able
to detect it.  The file data read for the file signature verification
could be totally different from what is subsequently read, making the
signature verification useless.

FUSE can be mounted by unprivileged users either today with fusermount
installed with setuid, or soon with the upcoming patches to allow FUSE
mounts in a non-init user namespace.

This patch sets the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag and when
appropriate sets the SB_I_UNTRUSTED_MOUNTER flag.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/fuse/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bbfd2b..ef309958e060 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1080,6 +1080,9 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
+	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	if (sb->s_user_ns != &init_user_ns)
+		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
 	file = fget(d.fd);
 	err = -EINVAL;
-- 
2.7.5
