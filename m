Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750990AbdJLNOj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2017 09:14:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9CDENnR017888
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2017 09:14:39 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dj79ywupe-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2017 09:14:39 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 12 Oct 2017 09:14:38 -0400
Subject: Re: [PATCH v3 4/5] tpm: reduce tpm_msleep() time in get_burstcount()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
 <20171004102924.12355-5-nayna@linux.vnet.ibm.com>
 <20171012111835.g7uulven4whnpf5d@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 18:44:13 +0530
MIME-Version: 1.0
In-Reply-To: <20171012111835.g7uulven4whnpf5d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <945e7428-62a8-27e8-beca-99f14a11d210@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 10/12/2017 04:48 PM, Jarkko Sakkinen wrote:
> On Wed, Oct 04, 2017 at 06:29:23AM -0400, Nayna Jain wrote:
>> Currently, get_burstcount() function sleeps for 5msec in a loop
>> before retrying for next query to burstcount. However, if it takes
>> lesser time for TPM to return, this 5msec delay is longer
>> than necessary.
>>
>> This patch replaces the tpm_msleep time from 5msec to 1msec.
>>
>> After this change, performance on a TPM 1.2 with an 8 byte
>> burstcount for 1000 extends improved from ~10sec to ~9sec.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 224842e06105..826a0b9c9201 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -226,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
>>   		burstcnt = (value >> 8) & 0xFFFF;
>>   		if (burstcnt)
>>   			return burstcnt;
>> -		tpm_msleep(TPM_TIMEOUT);
>> +		tpm_msleep(TPM_POLL_SLEEP);
>>   	} while (time_before(jiffies, stop));
>>   	return -EBUSY;
>>   }
>> -- 
>> 2.13.3
>>
> Would it make sense to squash this to 3/5 and merge the commit
> messages?
Yeah.. it sounds reasonable.. both are reducing the sleep delay time for 
same purpose, just in different functions.

Thanks & Regards,
     - Nayna

>
> /Jarkko
>
