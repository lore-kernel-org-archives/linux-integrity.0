Return-Path: <SRS0=wNEK=QA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD4CC282C0
	for <linux-integrity@archiver.kernel.org>; Thu, 24 Jan 2019 02:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A3921872
	for <linux-integrity@archiver.kernel.org>; Thu, 24 Jan 2019 02:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAXCTo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:19:44 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:49672 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfAXCTo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jan 2019 21:19:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TIss7ud_1548296379;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIss7ud_1548296379)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jan 2019 10:19:40 +0800
Subject: Re: [LTP][PATCH v3 0/6] LTP IMA fix bundle
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <20190116072004.GA10601@dell5510>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <6857d8c9-c35c-7967-895f-7c4452365bc9@linux.alibaba.com>
Date:   Thu, 24 Jan 2019 10:19:39 +0800
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

Hi Petr,

Is it good enough to merge this patch series?

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
