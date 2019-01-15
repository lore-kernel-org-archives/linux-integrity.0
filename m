Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD6C43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B510220659
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfAOCQm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:16:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37532 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfAOCQm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 21:16:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIFQkUy_1547518479;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIFQkUy_1547518479)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jan 2019 10:14:40 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH v2 0/6] LTP IMA fix bundle
Date:   Tue, 15 Jan 2019 10:14:30 +0800
Message-Id: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi and Petr,

Here is the v2 patch series.

Changelogs since V1: 
- Don't use the word "policy" in patch 4's commit header.
- Drop patch 6 ("ima: Use ima tcb policy files for test") because it
  bases on a faulty misjudgement.
- Add a new patch to address ima_violations failure.

The latest test result is attached.

Test Start Time: Tue Jan 15 10:09:14 2019
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

Thanks,
Jia
