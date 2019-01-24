Return-Path: <SRS0=wNEK=QA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171DC282C3
	for <linux-integrity@archiver.kernel.org>; Thu, 24 Jan 2019 05:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B7321872
	for <linux-integrity@archiver.kernel.org>; Thu, 24 Jan 2019 05:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfAXFLu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:11:50 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46735 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbfAXFLt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Jan 2019 00:11:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TItmM.9_1548306706;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TItmM.9_1548306706)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jan 2019 13:11:47 +0800
Subject: Re: [PATCH v3 5/6] ima: Rename the folder name for policy files to
 datafiles
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-6-git-send-email-zhang.jia@linux.alibaba.com>
 <20190123170409.GA11731@dell5510>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <49244744-3546-c477-f443-a70ced4a4ed4@linux.alibaba.com>
Date:   Thu, 24 Jan 2019 13:11:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190123170409.GA11731@dell5510>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2019/1/24 上午1:04, Petr Vorel wrote:
> Hi Mimi, Jia,
> 
>> If we choose to run ima_policy.sh locally without installation,
>> a failure message is reported as following:
> 
>> ima_policy 1 TCONF: missing <path>/ltp/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> 
>> TST_DATAROOT would be extended to datafiles but the policy files
>> are actually placed under policy.
> 
>> In order to make it easier, just rename the folder name to datafiles.
> 
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> ---
> 
> I wasn't sure about this one as make install isn't that hard to do even during
> debugging and policy is more descriptive. But other tests use datafiles as well,
> therefore taken as well.

Actually, this patch resolves the issue if we just follow this step to
run IMA-only test:

$ git clone https://github.com/linux-test-project/ltp.git
$ cd ltp
$ export LTP_ROOT="$PWD"
$ make autotools
$ ./configure
$ cd testcases/lib
$ make
$ cd ../kernel/security/integrity/ima
$ make
$ sudo PATH=$LTP_ROOT/testcases/lib:tests:$PATH ./tests/ima_policy.sh

A full LTP installation doesn't have this issue.

Jia

> 
> Whole patchset merged, thank you both for your work.
> 
> Kind regards,
> Petr
> 
