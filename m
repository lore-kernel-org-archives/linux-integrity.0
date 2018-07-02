Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752252AbeGBOiz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jul 2018 10:38:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62EcZGb116465
        for <linux-integrity@vger.kernel.org>; Mon, 2 Jul 2018 10:38:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jym51cwg2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jul 2018 10:38:55 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:38:52 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 2/8] kexec: add call to LSM hook in original kexec_load syscall
Date: Mon,  2 Jul 2018 10:37:57 -0400
In-Reply-To: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1530542283-26145-3-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

In order for LSMs and IMA-appraisal to differentiate between kexec_load
and kexec_file_load syscalls, both the original and new syscalls must
call an LSM hook.  This patch adds a call to security_kernel_load_data()
in the original kexec_load syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 kernel/kexec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index aed8fb2564b3..68559808fdfa 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -11,6 +11,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -195,10 +196,17 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 static inline int kexec_load_check(unsigned long nr_segments,
 				   unsigned long flags)
 {
+	int result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/* Permit LSMs and IMA to fail the kexec */
+	result = security_kernel_load_data(LOADING_KEXEC_IMAGE);
+	if (result < 0)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.7.5
