Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752156AbeEKBhJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 21:37:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4B1Ymnf059922
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 21:37:09 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hvxmany8a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 21:37:08 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 11 May 2018 02:37:06 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 3/3] ima: based on policy require signed kexec kernel images
Date: Thu, 10 May 2018 21:36:48 -0400
In-Reply-To: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1526002608-27474-4-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The original kexec_load syscall can not verify file signatures.  This
patch differentiates between the kexec_load and kexec_file_load
syscalls.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima.h        | 1 +
 security/integrity/ima/ima_main.c   | 9 +++++++++
 security/integrity/ima/ima_policy.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 35fe91aa1fc9..03c9c37ee345 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -233,6 +233,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
+#define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 74d0bd7e76d7..754ece08e1c6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -444,6 +444,15 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;	/* We rely on module signature checking */
 	}
+
+	if (!file && read_id == READING_KEXEC_IMAGE) {
+		if ((ima_appraise & IMA_APPRAISE_KEXEC) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index df3e45878a87..a9e96a884867 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_FIRMWARE;
 	else if (func == POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
+	else if (func == KEXEC_KERNEL_CHECK)
+		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
 
-- 
2.7.5
