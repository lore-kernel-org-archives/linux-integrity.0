Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CEDC43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FC620659
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfAOCQW (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:16:22 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58534 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbfAOCQW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 21:16:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIFSdAu_1547518482;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIFSdAu_1547518482)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jan 2019 10:14:43 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 6/6] ima/ima_violations: Temporarily remove the printk rate limit
Date:   Tue, 15 Jan 2019 10:14:36 +0800
Message-Id: <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The output frequency of audit log is limited by printk_ratelimit()
in kernel if auditd not used. Thus, the test heavily depending on
searching keywords in log file may fail if the matching patterns
are exactly suppressed by printk_ratelimit().

In order to fix such a sort of failure, just temporarily remove
the limit, and recover its setting at the end of test.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index f3f40d4..a1360b8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -31,15 +31,27 @@ setup()
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
 
+reset_printk_ratelimit()
+{
+	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
+		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
+}
+
 open_file_read()
 {
 	exec 3< $FILE || exit 1
@@ -151,6 +163,8 @@ test3()
 
 	validate $num_violations $count $search
 
+	reset_printk_ratelimit
+
 	# wait for ima_mmap to exit, so we can umount
 	tst_sleep 2s
 }
-- 
1.8.3.1

