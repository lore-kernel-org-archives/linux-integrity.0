Return-Path: <SRS0=ry+W=PP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6722C43387
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 02:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A3F2085A
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 02:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfAGC1D (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:27:03 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52759 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbfAGC1D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Jan 2019 21:27:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0THgn50s_1546827992;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0THgn50s_1546827992)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Jan 2019 10:26:33 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.vnet.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 4/6] ima: Code cleanup
Date:   Mon,  7 Jan 2019 10:26:27 +0800
Message-Id: <1546827989-43569-5-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

- Don't use the legacy policy function name in policy files.
- Use the variable IMA_POLICY instead of hard code path.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 testcases/kernel/security/integrity/ima/policy/measure.policy         | 2 +-
 testcases/kernel/security/integrity/ima/policy/measure.policy-invalid | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_policy.sh           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy b/testcases/kernel/security/integrity/ima/policy/measure.policy
index c68e722..9976ddf 100644
--- a/testcases/kernel/security/integrity/ima/policy/measure.policy
+++ b/testcases/kernel/security/integrity/ima/policy/measure.policy
@@ -13,4 +13,4 @@ dont_measure fsmagic=0x01021994
 dont_measure fsmagic=0x73636673
 measure func=FILE_MMAP mask=MAY_EXEC
 measure func=BPRM_CHECK mask=MAY_EXEC
-measure func=PATH_CHECK mask=MAY_READ uid=0
+measure func=FILE_CHECK mask=MAY_READ uid=0
diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
index e406757..04dff89 100644
--- a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
+++ b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
@@ -13,4 +13,4 @@ dont_measure fsmagic=0x01021994
 dnt_measure fsmagic=0x73636673
 measure func=FILE_MMAP mask=MAY_EXEC
 measure func=BPRM_CHECK mask=MAY_EXEC
-measure func=PATH_CHECK mask=MAY_READ uid=0
+measure func=FILE_CHECK mask=MAY_READ uid=0
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 64aa8cb..a0c7869 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -28,7 +28,7 @@ check_policy_writable()
 {
 	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
 
-	[ -f /sys/kernel/security/ima/policy ] || tst_brk TCONF "$err"
+	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
 	# CONFIG_IMA_READ_POLICY
 	echo "" 2> log > $IMA_POLICY
 	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
-- 
1.8.3.1

