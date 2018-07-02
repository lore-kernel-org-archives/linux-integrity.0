Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752672AbeGBOjM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jul 2018 10:39:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62Ecelr130616
        for <linux-integrity@vger.kernel.org>; Mon, 2 Jul 2018 10:39:11 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyjrtgdyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jul 2018 10:39:11 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:39:09 +0100
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
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 7/8] ima: based on policy warn about loading firmware (pre-allocated buffer)
Date: Mon,  2 Jul 2018 10:38:02 -0400
In-Reply-To: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Some systems are memory constrained but they need to load very large
firmwares.  The firmware subsystem allows drivers to request this
firmware be loaded from the filesystem, but this requires that the
entire firmware be loaded into kernel memory first before it's provided
to the driver.  This can lead to a situation where we map the firmware
twice, once to load the firmware into kernel memory and once to copy the
firmware into the final resting place.

To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
into a pre-allocated buffer") introduced request_firmware_into_buf() API
that allows drivers to request firmware be loaded directly into a
pre-allocated buffer. (Based on the mailing list discussions, calling
dma_alloc_coherent() is unnecessary and confusing.)

(Very broken/buggy) devices using pre-allocated memory run the risk of
the firmware being accessible to the device prior to the completion of
IMA's signature verification.  For the time being, this patch emits a
warning, but does not prevent the loading of the firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

---
Changelog v5:
- Instead of preventing loading firmware from a pre-allocate buffer,
emit a warning.

 security/integrity/ima/ima_main.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e467664965e7..7da123d980ea 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -416,6 +416,15 @@ void ima_post_path_mknod(struct dentry *dentry)
 		iint->flags |= IMA_NEW_FILE;
 }
 
+static int read_idmap[READING_MAX_ID] = {
+	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
+	[READING_MODULE] = MODULE_CHECK,
+	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
+	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
+	[READING_POLICY] = POLICY_CHECK
+};
+
 /**
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
@@ -439,18 +448,16 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;	/* We rely on module signature checking */
 	}
+
+	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_warn("device might be able to access firmware prior to signature verification completion.\n");
+		}
+	}
 	return 0;
 }
 
-static int read_idmap[READING_MAX_ID] = {
-	[READING_FIRMWARE] = FIRMWARE_CHECK,
-	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
-	[READING_MODULE] = MODULE_CHECK,
-	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
-	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
-};
-
 /**
  * ima_post_read_file - in memory collect/appraise/audit measurement
  * @file: pointer to the file to be measured/appraised/audit
-- 
2.7.5
