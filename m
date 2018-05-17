Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752596AbeEQOuB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 May 2018 10:50:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4HEj92S120764
        for <linux-integrity@vger.kernel.org>; Thu, 17 May 2018 10:50:01 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j1bmvrp3r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 17 May 2018 10:50:00 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 17 May 2018 15:49:58 +0100
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
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH v2 9/9] ima: based on policy prevent loading firmware (pre-allocated buffer)
Date: Thu, 17 May 2018 10:48:50 -0400
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1526568530-9144-10-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Question: can the device access the pre-allocated buffer at any time?

By allowing devices to request firmware be loaded directly into a
pre-allocated buffer, will this allow the device access to the firmware
before the kernel has verified the firmware signature?

Is it dependent on the type of buffer allocated (eg. DMA)?  For example,
qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent().

With an IMA policy requiring signed firmware, this patch would prevent
loading firmware into a pre-allocated buffer.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
---
 security/integrity/ima/ima_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 29d1a929af5c..6224468845e6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -452,6 +452,15 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		return 0;
 	}
 
+	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
+			return -EACCES;
+		}
+		return 0;
+	}
+
 	if (read_id == READING_FIRMWARE_FALLBACK_SYSFS) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.7.5
