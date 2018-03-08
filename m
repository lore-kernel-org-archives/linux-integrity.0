Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750897AbeCHUY0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 15:24:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28KK3lK032708
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 15:24:26 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gk99879fd-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 15:24:25 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 20:24:22 -0000
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
Subject: [PATCH v3 1/4] ima: fail file signature verification on non-init mounted filesystems
Date: Thu,  8 Mar 2018 15:24:07 -0500
In-Reply-To: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1520540650-7451-2-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

FUSE can be mounted by unprivileged users either today with fusermount
installed with setuid, or soon with the upcoming patches to allow FUSE
mounts in a non-init user namespace.

This patch addresses the new unprivileged non-init mounted filesystems,
which are untrusted, by failing the signature verification.

This patch defines two new flags SB_I_IMA_UNVERIFIABLE_SIGNATURE and
SB_I_UNTRUSTED_MOUNTER.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dongsu Park <dongsu@kinvolk.io>
Cc: Alban Crequy <alban@kinvolk.io>
Cc: Serge E. Hallyn <serge@hallyn.com>

---
Changelog v3:
- Fix SB_IMA_UNVERIFIABLE_SIGNATURE & SB_I_UNTRUSTED_MOUNTER test.

Changelog v2:
- Limit patch to non-init mounted filesystems.
- Define 2 sb->s_iflags

Changelog v1:
- Merged the unprivileged and privileged patches.
- Dropped IMA fsname support.
- Introduced a new IMA builtin policy named "untrusted_fs".
- Replaced fs_type flag with sb->s_iflags flag.

 include/linux/fs.h                    |  2 ++
 security/integrity/ima/ima_appraise.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..4e1c76af7b68 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1320,6 +1320,8 @@ extern int send_sigurg(struct fown_struct *fown);
 
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
+#define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
+#define SB_I_UNTRUSTED_MOUNTER		0x00000040
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 1b177461f20e..4bafb397ee91 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -302,7 +302,19 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 out:
-	if (status != INTEGRITY_PASS) {
+	/*
+	 * File signatures on some filesystems can not be properly verified.
+	 * On these filesytems, that are mounted by an untrusted mounter,
+	 * fail the file signature verification.
+	 */
+	if ((inode->i_sb->s_iflags &
+	    (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) ==
+	    (SB_I_IMA_UNVERIFIABLE_SIGNATURE | SB_I_UNTRUSTED_MOUNTER)) {
+		status = INTEGRITY_FAIL;
+		cause = "unverifiable-signature";
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+				    op, cause, rc, 0);
+	} else if (status != INTEGRITY_PASS) {
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
@@ -319,6 +331,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	} else {
 		ima_cache_flags(iint, func);
 	}
+
 	ima_set_cache_status(iint, func, status);
 	return status;
 }
-- 
2.7.5
