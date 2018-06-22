Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932076AbeFVUpx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 16:45:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MKcVi1053001
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 16:45:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2js732aq4s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 16:45:51 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 16:45:51 -0400
Subject: Re: [PATCH v3 2/4] tpm: Implement tpm_chip_find() for other
 subsystems to find a TPM chip
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-3-stefanb@linux.vnet.ibm.com>
 <20180622204319.GE19151@ziepe.ca>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Jun 2018 16:45:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180622204319.GE19151@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6f4d9302-8399-e73a-f8d0-d493658c1980@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/22/2018 04:43 PM, Jason Gunthorpe wrote:
> On Fri, Jun 22, 2018 at 12:46:11PM -0400, Stefan Berger wrote:
>> Implement tpm_chip_find() for other subsystems to find a TPM chip and
>> get a reference to that chip.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>   drivers/char/tpm/tpm-chip.c | 27 +++++++++++++++++++++++++++
>>   include/linux/tpm.h         |  5 +++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 4e83695af068..2520555b1e17 100644
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -81,6 +81,33 @@ void tpm_put_ops(struct tpm_chip *chip)
>>   EXPORT_SYMBOL_GPL(tpm_put_ops);
>>   
>>   /**
>> + * tpm_chip_find() - find a TPM chip and get a reference to it
>> + */
>> +struct tpm_chip *tpm_chip_find(void)
> I feel like this should be called 'tpm_default_chip()'
>
>> +{
>> +	struct tpm_chip *chip, *res = NULL;
>> +	int chip_num = 0;
>> +	int chip_prev;
>> +
>> +	mutex_lock(&idr_lock);
>> +
>> +	do {
>> +		chip_prev = chip_num;
>> +		chip = idr_get_next(&dev_nums_idr, &chip_num);
>> +		if (chip) {
>> +			get_device(&chip->dev);
>> +			res = chip;
>> +			break;
>> +		}
>> +	} while (chip_prev != chip_num);
>> +
>> +	mutex_unlock(&idr_lock);
> And what was tpm_chip_find_get should just call this function..
And then after that each time tpm_get_ops() ?
>
> Jason
>
