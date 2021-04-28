Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C4C433ED
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Apr 2021 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0CB6141E
	for <linux-integrity@archiver.kernel.org>; Wed, 28 Apr 2021 08:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhD1Ion (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:44:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16164 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Iom (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 04:44:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FVXCP0v9nzmdpq;
        Wed, 28 Apr 2021 16:40:49 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Apr 2021
 16:43:46 +0800
Subject: Re: [PATCH] tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <peterhuewe@gmx.de>, <linux-integrity@vger.kernel.org>
References: <1618888245-31604-1-git-send-email-tiantao6@hisilicon.com>
 <YIih6nWshf7XfNTU@kernel.org>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <9bdc99ef-7407-5ae7-a412-18e695ca8c2d@huawei.com>
Date:   Wed, 28 Apr 2021 16:43:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YIih6nWshf7XfNTU@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


ÔÚ 2021/4/28 7:44, Jarkko Sakkinen Ð´µÀ:
> On Tue, Apr 20, 2021 at 11:10:45AM +0800, Tian Tao wrote:
>> Function returns 'void __iomem *' so use IOMEM_ERR_PTR for returning
>> an error.
> You should also tell why we want to to use IOMEM_ERR_PTR in the
> description. If it makes sense, then you should know why it makes
> sense.

thank for review the code ,I'll send a v2 to update the commit message.

This is to simplify the code, the definition of IOMEM_ERR_PTR is in 
include/linux/io.h

#define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)

I'll send it to v2 and put the above sentence in the commit messge, what 
do you think?

>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>>   drivers/char/tpm/tpm_crb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index a9dcf31..1860665 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -464,7 +464,7 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
>>   
>>   	/* Detect a 64 bit address on a 32 bit system */
>>   	if (start != new_res.start)
>> -		return (void __iomem *) ERR_PTR(-EINVAL);
>> +		return IOMEM_ERR_PTR(-EINVAL);
>>   
>>   	if (!iores)
>>   		return devm_ioremap_resource(dev, &new_res);
>> -- 
>> 2.7.4
>>
>>
> /Jarkko
> .
>

