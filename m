Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731590AbeGMSWM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Jul 2018 14:22:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DI4C8A113202
        for <linux-integrity@vger.kernel.org>; Fri, 13 Jul 2018 14:06:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k70gf93dk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 13 Jul 2018 14:06:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 13 Jul 2018 19:06:27 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH v6 5/8] ima: based on policy require signed firmware (sysfs fallback)
Date: Fri, 13 Jul 2018 14:06:00 -0400
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1531505163-20227-6-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

With an IMA policy requiring signed firmware, this patch prevents
the sysfs fallback method of loading firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 71fecfef0939..e467664965e7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -472,8 +472,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 		return 0;
 	}
 
@@ -517,6 +519,12 @@ int ima_load_data(enum kernel_load_data_id id)
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
