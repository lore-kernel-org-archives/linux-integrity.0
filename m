Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932953AbeFTVNG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jun 2018 17:13:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKs0Ww138313
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 17:13:06 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqw9rjvxd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 20 Jun 2018 17:13:06 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 17:13:04 -0400
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180620205004.GG27445@ziepe.ca>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 20 Jun 2018 17:13:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180620205004.GG27445@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5acee904-ede6-d33f-33b7-3ad94fce9850@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/20/2018 04:50 PM, Jason Gunthorpe wrote:
> On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
>> Implement tpm_chip_find() for other subsystems to find a TPM chip and
>> get a reference to that chip. Once done with using the chip, the reference
>> is released using tpm_chip_put().
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>   drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
>>   include/linux/tpm.h         |  9 +++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 0a62c19937b6..eaaf41ce73d8 100644
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -81,6 +81,43 @@ void tpm_put_ops(struct tpm_chip *chip)
>>   EXPORT_SYMBOL_GPL(tpm_put_ops);
>>   
>>   /**
>> + * tpm_chip_put() - Release a ref to the tpm_chip
>> + * @chip: Chip to put
>> + */
>> +void tpm_chip_put(struct tpm_chip *chip)
>> +{
>> +	if (chip)
>> +		put_device(&chip->dev);
> Rarely like to see those if's inside a put function.. Does it actually
> help anything?
Following put_device() 'pattern' here which also checks using 'if (dev)'.

     Stefan
