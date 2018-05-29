Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36419 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965720AbeE2SCe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 14:02:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4THt58G095878
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:33 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j98gesdav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:32 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 19:02:30 +0100
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
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH v4 7/8] ima: based on policy prevent loading firmware (pre-allocated buffer)
Date: Tue, 29 May 2018 14:01:59 -0400
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1527616920-5415-8-git-send-email-zohar@linux.vnet.ibm.com>
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
pre-allocated buffer.  The QCOM_MDT_LOADER calls dma_alloc_coherent() to
allocate this buffer.  According to Documentation/DMA-API.txt,

     Consistent memory is memory for which a write by either the
     device or the processor can immediately be read by the processor
     or device without having to worry about caching effects.  (You
     may however need to make sure to flush the processor's write
     buffers before telling devices to read that memory.)

Devices using pre-allocated DMA memory run the risk of the firmware
being accessible by the device prior to the kernel's firmware signature
verification has completed.

Loading firmware already calls the security_kernel_read_file LSM hook.
With an IMA policy requiring signed firmware, this patch prevents
loading firmware into a pre-allocated buffer.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 security/integrity/ima/ima_main.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4a87f78098c8..3dae605a1604 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -419,6 +419,15 @@ void ima_post_path_mknod(struct dentry *dentry)
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
@@ -442,18 +451,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;	/* We rely on module signature checking */
 	}
+
+	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
+			return -EACCES;
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
