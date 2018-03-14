Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752158AbeCNUUr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 16:20:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EKJrIO018794
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 16:20:47 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gq67xkpj8-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 16:20:47 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 16:20:45 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
Date: Wed, 14 Mar 2018 17:20:19 -0300
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
Message-Id: <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

Replace nested ifs in the EVM xattr verification logic with a switch
statement, making the code easier to understand.

Also, add comments to the if statements in the out section and constify the
cause variable.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 0c5f94b7b9c3..dd10ecbdce45 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -215,7 +215,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     int xattr_len, int opened)
 {
 	static const char op[] = "appraise_data";
-	char *cause = "unknown";
+	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
@@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) &&
-	    (status != INTEGRITY_PASS_IMMUTABLE) &&
-	    (status != INTEGRITY_UNKNOWN)) {
-		if ((status == INTEGRITY_NOLABEL)
-		    || (status == INTEGRITY_NOXATTRS))
-			cause = "missing-HMAC";
-		else if (status == INTEGRITY_FAIL)
-			cause = "invalid-HMAC";
+	switch (status) {
+	case INTEGRITY_PASS:
+	case INTEGRITY_PASS_IMMUTABLE:
+	case INTEGRITY_UNKNOWN:
+		break;
+	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
+	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
+		cause = "missing-HMAC";
+		goto out;
+	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
+		cause = "invalid-HMAC";
 		goto out;
 	}
+
 	switch (xattr_value->type) {
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
@@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
+		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
-		} else if ((inode->i_size == 0) &&
-			   (iint->flags & IMA_NEW_FILE) &&
-			   (xattr_value &&
-			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
+		}
+
+		/* Permit new files with file signatures, but without data. */
+		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
+		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
 			status = INTEGRITY_PASS;
 		}
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else {
