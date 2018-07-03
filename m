Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752550AbeGCLT1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 07:19:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63BIWnH076011
        for <linux-integrity@vger.kernel.org>; Tue, 3 Jul 2018 07:19:27 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k067fcxew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jul 2018 07:19:27 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 05:19:26 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH] ima: Remove unused is_ima_appraise_enabled() function.
Date: Tue,  3 Jul 2018 07:19:17 -0400
Message-Id: <20180703111917.3265212-1-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Remove the unused is_ima_appraise_enabled() function.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/linux/ima.h                   |  6 ------
 security/integrity/ima/ima_appraise.c | 10 ----------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..7f6952f8d6aa 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -75,17 +75,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
 #endif
 
 #ifdef CONFIG_IMA_APPRAISE
-extern bool is_ima_appraise_enabled(void);
 extern void ima_inode_post_setattr(struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
-static inline bool is_ima_appraise_enabled(void)
-{
-	return 0;
-}
-
 static inline void ima_inode_post_setattr(struct dentry *dentry)
 {
 	return;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8bd7a0733e51..7bf7fcacfdbb 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -33,16 +33,6 @@ static int __init default_appraise_setup(char *str)
 
 __setup("ima_appraise=", default_appraise_setup);
 
-/*
- * is_ima_appraise_enabled - return appraise status
- *
- * Only return enabled, if not in ima_appraise="fix" or "log" modes.
- */
-bool is_ima_appraise_enabled(void)
-{
-	return ima_appraise & IMA_APPRAISE_ENFORCE;
-}
-
 /*
  * ima_must_appraise - set appraise flag
  *
-- 
2.17.1
