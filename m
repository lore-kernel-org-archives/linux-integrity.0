Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:38346 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdJTPnj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2017 11:43:39 -0400
From: Roberto Sassu <roberto.sassu@huawei.com>
To: <linux-integrity@vger.kernel.org>
CC: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/2] ima: don't measure files in the TCB if Biba strict policy is enforced
Date: Fri, 20 Oct 2017 17:41:38 +0200
Message-ID: <20171020154138.23635-3-roberto.sassu@huawei.com>
In-Reply-To: <20171020154138.23635-1-roberto.sassu@huawei.com>
References: <20171020154138.23635-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The Biba strict policy prevents processes outside the TCB from modifying
appraised files. Then, since the integrity of those files is preserved,
because only processes in the TCB can write appraised files, it is not
necessary to measure them each time they are accessed by the TCB.

This solves one of the main problems of binary attestation: when a
modified file is accessed by the TCB, it was necessary to measure it
because verifiers cannot determine from the measurement list if the
writer belong or not to the TCB. Verifiers find an unknown digest
and have to consider the whole system as compromised.

If the Biba strict policy has been selected, and appraisal is in enforce
mode, IMA measures files at first access, if they have a digital signature.
Then, for subsequent accesses, files are not measured again, unless the
appraisal status changes.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6e85ea8e2373..16c2da0e32d9 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -200,10 +200,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 			goto out;
 	}
 
-	if (ima_integrity_policy)
+	if (ima_integrity_policy) {
 		policy_violation = ima_appraise_biba_check(file, iint,
 						must_appraise, &pathbuf,
 						&pathname, filename);
+		/* do not measure mutable files, if they are appraised */
+		if (ima_integrity_policy == BIBA_STRICT &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+			if (iint && (iint->flags & IMA_APPRAISED))
+				action &= ~IMA_MEASURE;
+	}
 	if (violation_check)
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname);
@@ -246,9 +252,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK))
+	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
+		if (!rc && ima_integrity_policy == BIBA_STRICT &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			iint->flags &= ~IMA_MEASURE;
+			if (!(iint->flags & IMA_DIGSIG))
+				action &= ~IMA_MEASURE;
+		}
+	}
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
-- 
2.11.0
