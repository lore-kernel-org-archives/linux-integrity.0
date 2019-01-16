Return-Path: <SRS0=sWjp=PY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6616C43387
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 02:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EBC20675
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 02:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfAPC6t (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:58:49 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59910 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbfAPC6t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 21:58:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIKLIeN_1547607464;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIKLIeN_1547607464)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jan 2019 10:57:44 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [LTP][PATCH v3 0/6] LTP IMA fix bundle
Date:   Wed, 16 Jan 2019 10:57:35 +0800
Message-Id: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changelog since V2:
- Rework patch 6. Here is a quick diff against V2:

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/int
index a1360b8..74223c2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -20,6 +20,7 @@
 # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
 
 TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
@@ -46,10 +47,12 @@ setup()
        tst_res TINFO "using log $LOG"
 }
 
-reset_printk_ratelimit()
+cleanup()
 {
        [ "$PRINTK_RATE_LIMIT" != "0" ] && \
                sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
+
+       ima_cleanup
 }
 
 open_file_read()
@@ -163,8 +166,6 @@ test3()
 
        validate $num_violations $count $search
 
-       reset_printk_ratelimit
-
        # wait for ima_mmap to exit, so we can umount
        tst_sleep 2s
 }

The latest test results are attached:

Test Start Time: Wed Jan 16 10:44:10 2019
-----------------------------------------
Testcase                                           Result     Exit Value
--------                                           ------     ----------
ima_measurements                                   PASS       0    
ima_policy                                         PASS       0    
ima_tpm                                            CONF       32   
ima_violations                                     PASS       0    

-----------------------------------------------
Total Tests: 4
Total Skipped Tests: 1
Total Failures: 0
Kernel Version: 5.0.0-rc1+
Machine Architecture: x86_64
Hostname: test-machine

Jia

