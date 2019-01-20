Return-Path: <SRS0=Jbst=P4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B439C636A2
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4867F20861
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 14:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfATO7X (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 20 Jan 2019 09:59:23 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47781 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730579AbfATO7W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Jan 2019 09:59:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01406;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TIdTHIt_1547996355;
Received: from 192.168.78.200(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIdTHIt_1547996355)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 20 Jan 2019 22:59:16 +0800
Subject: Re: [LTP][PATCH v3 0/6] LTP IMA fix bundle
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <20190116072004.GA10601@dell5510>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <8ef3d1f2-7dbc-2dd5-051b-7f5074682c07@linux.alibaba.com>
Date:   Sun, 20 Jan 2019 22:59:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190116072004.GA10601@dell5510>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mini,

Could you help to take a look at this V3 patch series?

Thanks,
Jia

On 2019/1/16 下午3:20, Petr Vorel wrote:
> Hi Jia, Mimi,
> 
>> Changelog since V2:
>> - Rework patch 6. Here is a quick diff against V2:
> 
> LGTM, just waiting if Mimi reviews 1st and 6th commit.
> 
> Kind regards,
> Petr
> 
