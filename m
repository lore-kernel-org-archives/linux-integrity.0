Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965816AbeE2SCa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 14:02:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4THsZev059087
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:30 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9an835xj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 14:02:28 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 19:02:25 +0100
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
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH v4 5/8] ima: based on policy require signed firmware (sysfs fallback)
Date: Tue, 29 May 2018 14:01:57 -0400
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Luis, is the security_kernel_post_read_file LSM hook in
firmware_loading_store() still needed after this patch?  Should it be
calling security_kernel_load_data() instead?

---

With an IMA policy requiring signed firmware, this patch prevents
the sysfs fallback method of loading firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a565d46084c2..4a87f78098c8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -475,8 +475,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 		return 0;
 	}
 
@@ -520,6 +522,12 @@ int ima_load_data(enum kernel_load_data_id id)
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case LOADING_FIRMWARE:
+		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
+			pr_err("Prevent firmware sysfs fallback loading.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 	default:
 		break;
 	}
-- 
2.7.5
