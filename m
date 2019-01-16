Return-Path: <SRS0=sWjp=PY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA241C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 02:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC09420675
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 02:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfAPC6q (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:58:46 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43168 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbfAPC6q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 21:58:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIKIfIx_1547607467;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIKIfIx_1547607467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jan 2019 10:57:47 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH v3 6/6] ima/ima_violations: Temporarily remove the printk rate limit
Date:   Wed, 16 Jan 2019 10:57:41 +0800
Message-Id: <1547607461-11233-7-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The output frequency of audit log is limited by printk_ratelimit()
in kernel if auditd not used. Thus, the test cases heavily depending
on searching certain keywords in log file may fail if the matching
patterns are exactly suppressed by printk_ratelimit().

In order to fix such a sort of failure, just temporarily remove the
printk rate limit, and restore its original setting when doing
cleanup.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 .../kernel/security/integrity/ima/tests/ima_setup.sh      |  2 +-
 .../kernel/security/integrity/ima/tests/ima_violations.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 6dfb4d2..fe60981 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -20,7 +20,7 @@
 TST_TESTFUNC="test"
 TST_SETUP_CALLER="$TST_SETUP"
 TST_SETUP="ima_setup"
-TST_CLEANUP="ima_cleanup"
+TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index f3f40d4..74223c2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -20,6 +20,7 @@
 # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
 
 TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
@@ -31,15 +32,29 @@ setup()
 	FILE="test.txt"
 	IMA_VIOLATIONS="$SECURITYFS/ima/violations"
 	LOG="/var/log/messages"
+	PRINTK_RATE_LIMIT="0"
 
 	if status_daemon auditd; then
 		LOG="/var/log/audit/audit.log"
+	else
+		tst_check_cmds sysctl
+
+		PRINTK_RATE_LIMIT=`sysctl -n kernel.printk_ratelimit`
+		sysctl -wq kernel.printk_ratelimit=0
 	fi
 	[ -f "$LOG" ] || \
 		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
 	tst_res TINFO "using log $LOG"
 }
 
+cleanup()
+{
+	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
+		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
+
+	ima_cleanup
+}
+
 open_file_read()
 {
 	exec 3< $FILE || exit 1
-- 
1.8.3.1

