Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034054AbeCASqN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Mar 2018 13:46:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w21Iimj2015243
        for <linux-integrity@vger.kernel.org>; Thu, 1 Mar 2018 13:46:12 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2genaw4qdr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 01 Mar 2018 13:46:11 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 1 Mar 2018 13:46:10 -0500
Subject: Re: [PATCH 1/3] tpm: move TPM_POLL_SLEEP from tpm_tis_core.c to tpm.h
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
 <20180301083740.GB29420@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 00:14:57 +0530
MIME-Version: 1.0
In-Reply-To: <20180301083740.GB29420@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <409652f8-74db-2af5-3faa-137c71a27a59@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 03/01/2018 02:07 PM, Jarkko Sakkinen wrote:
> Hi
>
> On Wed, Feb 28, 2018 at 02:18:26PM -0500, Nayna Jain wrote:
>> This patch moves TPM_POLL_SLEEP from tpm_tis_core.c to tpm.h, renaming
>> it to TPM_TIMEOUT_POLL, to follow the existing enum naming
>> conventions.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> The cover letter is missing. Are this meant to be a patch set or
> individual patches? I'll check these anyway.

These patches continue to improve TPM performance.
The first patch exports and renames the timeout enum for polling, that 
is subsequently used in the second patch.
The third patch is posted as an RFC  for further performance improvement 
by improving granularity.
>
>> ---
>>   drivers/char/tpm/tpm.h          |  3 ++-
>>   drivers/char/tpm/tpm_tis_core.c | 10 ++--------
>>   2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index f895fba4e20d..7e797377e1eb 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -53,7 +53,8 @@ enum tpm_const {
>>   enum tpm_timeout {
>>   	TPM_TIMEOUT = 5,	/* msecs */
>>   	TPM_TIMEOUT_RETRY = 100, /* msecs */
>> -	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
>> +	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
> What is happening here?
Addition of comma to add next enum value.

Thanks & Regards,
     - Nayna

>
>> +	TPM_TIMEOUT_POLL = 1	/* msecs */
>>   };
>>   
>>   /* TPM addresses */
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 183a5f54d875..dc474e7244a6 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -31,12 +31,6 @@
>>   #include "tpm.h"
>>   #include "tpm_tis_core.h"
>>   
>> -/* This is a polling delay to check for status and burstcount.
>> - * As per ddwg input, expectation is that status check and burstcount
>> - * check should return within few usecs.
>> - */
>> -#define TPM_POLL_SLEEP	1  /* msec */
>> -
>>   static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>>   
>>   static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>> @@ -90,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>>   		}
>>   	} else {
>>   		do {
>> -			tpm_msleep(TPM_POLL_SLEEP);
>> +			tpm_msleep(TPM_TIMEOUT_POLL);
>>   			status = chip->ops->status(chip);
>>   			if ((status & mask) == mask)
>>   				return 0;
>> @@ -232,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
>>   		burstcnt = (value >> 8) & 0xFFFF;
>>   		if (burstcnt)
>>   			return burstcnt;
>> -		tpm_msleep(TPM_POLL_SLEEP);
>> +		tpm_msleep(TPM_TIMEOUT_POLL);
>>   	} while (time_before(jiffies, stop));
>>   	return -EBUSY;
>>   }
>> -- 
>> 2.13.3
>>
> Otherwise, looks fine.
> /Jarkko
>
