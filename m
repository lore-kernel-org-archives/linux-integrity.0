Return-Path: <SRS0=sWjp=PY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5EDC43387
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1DF20859
	for <linux-integrity@archiver.kernel.org>; Wed, 16 Jan 2019 02:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfAPCzk (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:55:40 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52123 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727883AbfAPCzk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 21:55:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TIKMQ6E_1547607199;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIKMQ6E_1547607199)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jan 2019 10:53:20 +0800
Subject: Re: [PATCH 6/6] ima/ima_violations: Temporarily remove the printk
 rate limit
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
 <20190115150759.GA2954@dell5510>
 <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
 <20190115172401.GC2954@dell5510>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <a4c87b61-33a4-cc8b-489e-023c74bfcc48@linux.alibaba.com>
Date:   Wed, 16 Jan 2019 10:53:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190115172401.GC2954@dell5510>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2019/1/16 上午1:24, Petr Vorel wrote:
> Hi Jia,
> 
>>>> +	reset_printk_ratelimit
>>> This should be called in cleanup function.
>>> Actually as it's called only once I'd put it into cleanup function.
> 
>> I recognized that ima_setup.sh already defines a cleanup() so I cannot
>> define another cleanup function in ima_violations.sh. Do you mean moving
>> reset_printk_ratelimit into cleanup() defined in ima_setup.sh?
> No. You can define redefine local cleanup function in ima_violations.sh after
> loading ima_setup.sh and call ima_cleanup() in it.
> 
> + you can change setup in ima_setup.sh:
> TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> (see testcases/network/stress/ipsec/ipsec_lib.sh and testcases/network/stress/ipsec/ipsec_lib.sh and it's usage).
> 
> Cleanup of something defined in setup should be always in cleanup function and
> not in any tests as it's called always after tst_brk() calls (some tests might
> get skipped, so cleanup cannot be in them).

Thanks for the comments. I will send V3 to address this.

Jia

> 
> Kind regards,
> Petr
> 
