Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:39783 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbdKGKpZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 05:45:25 -0500
From: Roberto Sassu <roberto.sassu@huawei.com>
To: <linux-integrity@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 12/15] ima: do not update security.ima if appraisal status is not INTEGRITY_PASS
Date: Tue, 7 Nov 2017 11:37:07 +0100
Message-ID: <20171107103710.10883-13-roberto.sassu@huawei.com>
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Commit b65a9cfc2c38 ("Untangling ima mess, part 2: deal with counters")
moved the call of ima_file_check() from may_open() to do_filp_open() at a
point where the file descriptor is already opened.

This breaks the assumption made by IMA that file descriptors being closed
belong to files whose access was granted by ima_file_check(). The
consequence is that security.ima and security.evm are updated with good
values, regardless of the current appraisal status.

For example, if a file does not have security.ima, IMA will create it after
opening the file for writing, even if access is denied. Access to the file
will be allowed afterwards.

Avoid this issue by checking the appraisal status before updating
security.ima.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_appraise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 285a53452fb5..1b2236e637ff 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -320,6 +320,9 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	if (iint->flags & IMA_DIGSIG)
 		return;
 
+	if (iint->ima_file_status != INTEGRITY_PASS)
+		return;
+
 	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
 	if (rc < 0)
 		return;
-- 
2.11.0
