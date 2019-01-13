Return-Path: <SRS0=R33m=PV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042C4C43387
	for <linux-integrity@archiver.kernel.org>; Sun, 13 Jan 2019 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBDC20836
	for <linux-integrity@archiver.kernel.org>; Sun, 13 Jan 2019 12:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfAMMQU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 13 Jan 2019 07:16:20 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33891 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfAMMQU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Jan 2019 07:16:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TI9SE5X_1547381672;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TI9SE5X_1547381672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Jan 2019 20:14:33 +0800
Subject: Re: [PATCH 0/6] LTP IMA fix bundle
To:     zohar@linux.vnet.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <d2d5d3ec-8778-782e-655c-09f8a8fcefa4@linux.alibaba.com>
Date:   Sun, 13 Jan 2019 20:14:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

Could you review this patchset for LTP?

Thanks,
Jia

On 2019/1/7 上午10:26, Jia Zhang wrote:
> Hi Mimi & Petr,
> 
> This fix bundle fixes and cleans up IMA-related testcases in LTP.
> 
> My test result is attached here.
> 
> #cat LTP_RUN_ON-2019_01_07-10h_05m_16s.log 
> Test Start Time: Mon Jan  7 10:05:18 2019
> -----------------------------------------
> Testcase                                           Result     Exit Value
> --------                                           ------     ----------
> ima_measurements                                   PASS       0    
> ima_policy                                         PASS       0    
> ima_tpm                                            CONF       32   
> ima_violations                                     PASS       0    
> 
> -----------------------------------------------
> Total Tests: 4
> Total Skipped Tests: 1
> Total Failures: 0
> Kernel Version: 4.20.0+
> Machine Architecture: x86_64
> Hostname: test-machine
> 
> Note:
> - The original PR is available at https://github.com/linux-test-project/ltp/pull/459
> - The test2() in ima_tpm requires /sys/class/tpm/tpm0/device/pcrs but this interface
>   is not available if TPM2 device used. So the test result showed above is expected.
> 
> Jia
> 
