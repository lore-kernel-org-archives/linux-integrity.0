Return-Path: <SRS0=mv0F=NY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A4C43441
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Nov 2018 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BDA22507
	for <linux-integrity@archiver.kernel.org>; Tue, 13 Nov 2018 09:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BDA22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeKMTrC (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:47:02 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731528AbeKMTrC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Nov 2018 14:47:02 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A82E8395EE769;
        Tue, 13 Nov 2018 09:49:39 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 09:49:31 +0000
Subject: Re: [PATCH] Apply on top of: tpm: dynamically allocate active_banks
 array
To:     Nayna Jain <nayna@linux.ibm.com>,
        <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        "Kenneth Goldman" <kgoldman@us.ibm.com>
References: <20181109092925.2908-1-roberto.sassu@huawei.com>
 <1d2e39fe-4bfb-4644-d216-f962c168668e@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <82565c56-d3a3-ac15-4345-7e19b90fabf1@huawei.com>
Date:   Tue, 13 Nov 2018 10:49:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1d2e39fe-4bfb-4644-d216-f962c168668e@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/2018 7:09 PM, Nayna Jain wrote:
> 
> 
> On 11/09/2018 02:59 PM, Roberto Sassu wrote:
>> This patch checks if a PCR bank is active (at least one bit in the
>> pcr_select mask is set).
>> ---
>>   drivers/char/tpm/tpm2-cmd.c | 44 +++++++++++++++++++++++++++----------
>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 533089cede07..eba8f8d00a09 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -854,15 +854,20 @@ struct tpm2_pcr_selection {
>>   static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>>   {
>> -    struct tpm2_pcr_selection pcr_selection;
>> +    struct tpm2_pcr_selection *pcr_selection;
>>       struct tpm_buf buf;
>>       void *marker;
>>       void *end;
>>       void *pcr_select_offset;
>>       u32 sizeof_pcr_selection;
>> +    u32 nr_possible_banks;
>> +    u32 nr_active_banks = 0;
> 
> The TCG Spec uses the term "allocated" and not "active".  For 
> consistency, I think we can also use the term "allocated". For example - 
> nr_allocated_banks and *allocated_banks both here and in struct tpm_chip.
> 
> Sorry, it took me sometime to be clear on this else would have mentioned 
> previously.

Thanks. Jarkko?

Roberto


> Thanks & Regards,
>      - Nayna
> 
> 
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
