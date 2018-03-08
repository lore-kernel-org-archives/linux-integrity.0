Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750896AbeCHUY1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 15:24:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28K6mnu169572
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 15:24:27 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gkb6gjc00-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 15:24:26 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 20:24:25 -0000
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
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH v3 2/4] ima: re-evaluate files on privileged mounted filesystems
Date: Thu,  8 Mar 2018 15:24:08 -0500
In-Reply-To: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1520540650-7451-3-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch addresses the fuse privileged mounted filesystems in a "secure"
environment, with a correctly enforced security policy, which is willing
to assume the inherent risk of specific fuse filesystems that are well
defined and properly implemented.

As there is no way for the kernel to detect file changes, the kernel
ignores the cached file integrity results and re-measures, re-appraises,
and re-audits the file.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: Serge E. Hallyn <serge@hallyn.com>
---
 security/integrity/ima/ima_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a5d225ffc388..f550f25294a3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/iversion.h>
+#include <linux/fs.h>
 
 #include "ima.h"
 
@@ -230,9 +231,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
 				 IMA_ACTION_FLAGS);
 
-	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
-		/* reset all flags if ima_inode_setxattr was called */
+	/*
+	 * Re-evaulate the file if either the xattr has changed or the
+	 * kernel has no way of detecting file change on the filesystem.
+	 * (Limited to privileged mounted filesystems.)
+	 */
+	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
+	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
+	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER))) {
 		iint->flags &= ~IMA_DONE_MASK;
+		iint->measured_pcrs = 0;
+	}
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
-- 
2.7.5
