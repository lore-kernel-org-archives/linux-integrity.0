Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3BC433E0
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Mar 2021 00:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611EA64EFC
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Mar 2021 00:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCRAvC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 17 Mar 2021 20:51:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14366 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhCRAul (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 20:50:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F17gf2JZxz8ypN;
        Thu, 18 Mar 2021 08:48:46 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 08:50:29 +0800
Subject: Re: [PATCH] char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>
References: <1615971586-21039-1-git-send-email-tiantao6@hisilicon.com>
 <YFJtcUzj6SGRRgq9@kernel.org>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <32fee14a-1b53-2833-b0b8-0532fc62620e@huawei.com>
Date:   Thu, 18 Mar 2021 08:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YFJtcUzj6SGRRgq9@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


ÔÚ 2021/3/18 4:58, Jarkko Sakkinen Ð´µÀ:
> On Wed, Mar 17, 2021 at 04:59:46PM +0800, Tian Tao wrote:
>> disable_irq() after request_irq() still has a time gap in which
>> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
>> disable IRQ auto-enable because of requesting.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Is this a new feature?
yes £¬you can see cbe16f35bee6880becca6f20d2ebf6b457148552 genirq: Add 
IRQF_NO_AUTOEN for request_irq/nmi()
> What would be great is a "Link:" tag to the patch set if it is fairly
> recent (i.e. lore.kernel.org link).
>
> /Jarkko
>
>> ---
>>   drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> index ec9a65e..25299e5 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
>> @@ -705,14 +705,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
>>   
>>   	if (client->irq > 0) {
>>   		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
>> -				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
>> +				      IRQF_NO_AUTOEN,
>>   				      dev->driver->name, chip);
>>   		if (rc < 0) {
>>   			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
>>   			return rc;
>>   		}
>>   
>> -		disable_irq(client->irq);
>>   		priv->irq = client->irq;
>>   	} else {
>>   		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
>> -- 
>> 2.7.4
>>
>>
> .
>

