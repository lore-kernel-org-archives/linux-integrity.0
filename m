Return-Path: <SRS0=ry+W=PP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5AC43387
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 02:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD972085A
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 02:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfAGC1K (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:27:10 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47253 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbfAGC1J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Jan 2019 21:27:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0THh8619_1546827990;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0THh8619_1546827990)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Jan 2019 10:26:31 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.vnet.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 0/6] LTP IMA fix bundle
Date:   Mon,  7 Jan 2019 10:26:23 +0800
Message-Id: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi & Petr,

This fix bundle fixes and cleans up IMA-related testcases in LTP.

My test result is attached here.

#cat LTP_RUN_ON-2019_01_07-10h_05m_16s.log 
Test Start Time: Mon Jan  7 10:05:18 2019
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
Kernel Version: 4.20.0+
Machine Architecture: x86_64
Hostname: test-machine

Note:
- The original PR is available at https://github.com/linux-test-project/ltp/pull/459
- The test2() in ima_tpm requires /sys/class/tpm/tpm0/device/pcrs but this interface
  is not available if TPM2 device used. So the test result showed above is expected.

Jia
