Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727040AbeJJAwS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 20:52:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w99HTZra018428
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 13:34:15 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n0ywhtcdf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 13:34:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 9 Oct 2018 18:34:13 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, pjones@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v6 2/5] ima: prevent kexec_load syscall based on runtime secureboot flag
Date: Tue,  9 Oct 2018 23:00:34 +0530
In-Reply-To: <20181009173037.32630-1-nayna@linux.vnet.ibm.com>
References: <20181009173037.32630-1-nayna@linux.vnet.ibm.com>
Message-Id: <20181009173037.32630-3-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Nayna Jain <nayna@linux.ibm.com>

When CONFIG_KEXEC_VERIFY_SIG is enabled, the kexec_file_load syscall
requires the kexec'd kernel image to be signed. Distros are concerned
about totally disabling the kexec_load syscall. As a compromise, the
kexec_load syscall will only be disabled when CONFIG_KEXEC_VERIFY_SIG
is configured and the system is booted with secureboot enabled.

This patch disables the kexec_load syscall only for systems booted with
secureboot enabled.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
---
 security/integrity/ima/ima_main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dce0a8a217bb..9031c99e37a6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -505,20 +505,24 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id)
 {
-	bool sig_enforce;
+	bool ima_enforce, sig_enforce;
 
-	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
-		return 0;
+	ima_enforce =
+		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
 
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
-		if (ima_appraise & IMA_APPRAISE_KEXEC) {
+		if (IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
+		    && arch_ima_get_secureboot())
+			return -EACCES;
+
+		if (ima_enforce && (ima_appraise & IMA_APPRAISE_KEXEC)) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
 		break;
 	case LOADING_FIRMWARE:
-		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
+		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
@@ -526,7 +530,8 @@ int ima_load_data(enum kernel_load_data_id id)
 	case LOADING_MODULE:
 		sig_enforce = is_module_sig_enforced();
 
-		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
+		if (ima_enforce && (!sig_enforce
+				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
 			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
-- 
2.13.6
