Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750859AbdJHE2c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Oct 2017 00:28:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v984Nd90020484
        for <linux-integrity@vger.kernel.org>; Sun, 8 Oct 2017 00:28:31 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2devrrj2a5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Oct 2017 00:28:31 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 8 Oct 2017 05:28:29 +0100
Subject: [PATCH] vfs: fix mounting a filesystem with i_version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date: Sun, 08 Oct 2017 00:28:21 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507436901.5841.4.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The mount i_version flag is not enabled in the new sb_flags.  This patch
adds the missing SB_I_VERSION flag.

Fixes: e462ec5 "VFS: Differentiate mount flags (MS_*) from internal
       superblock flags"
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3b601f115b6c..d18deb4c410b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2825,7 +2825,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 			    SB_MANDLOCK |
 			    SB_DIRSYNC |
 			    SB_SILENT |
-			    SB_POSIXACL);
+			    SB_POSIXACL |
+			    SB_I_VERSION);
 
 	if (flags & MS_REMOUNT)
 		retval = do_remount(&path, flags, sb_flags, mnt_flags,
-- 
2.7.4
