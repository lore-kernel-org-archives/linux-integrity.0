Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A07C43444
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E0720645
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfAOQwT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:52:19 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36793 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730791AbfAOQok (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TIJ3G8k_1547570533;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIJ3G8k_1547570533)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jan 2019 00:42:14 +0800
Subject: Re: [PATCH 6/6] ima/ima_violations: Temporarily remove the printk
 rate limit
To:     Petr Vorel <pvorel@suse.cz>, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
 <20190115150759.GA2954@dell5510>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
Date:   Wed, 16 Jan 2019 00:42:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190115150759.GA2954@dell5510>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2019/1/15 下午11:07, Petr Vorel wrote:
> Hi Jia, Mimi,
> 
> ...
>> +reset_printk_ratelimit()
>> +{
>> +	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
>> +		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
>> +}
> ...
>> @@ -151,6 +163,8 @@ test3()
> 
>>  	validate $num_violations $count $search
> 
>> +	reset_printk_ratelimit
> This should be called in cleanup function.
> Actually as it's called only once I'd put it into cleanup function.

I recognized that ima_setup.sh already defines a cleanup() so I cannot
define another cleanup function in ima_violations.sh. Do you mean moving
reset_printk_ratelimit into cleanup() defined in ima_setup.sh?

Thanks,
Jia

> No need to resent the patchset, if it's the only change, I change it before
> merge.
> 
> @Mimi: do you agree with this change?
> I've seen some issues on some distros when not using auditd daemon,
> but now cannot reproduce them any more.
> 
> Kind regards,
> Petr
> 
