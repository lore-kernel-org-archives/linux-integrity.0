Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751696AbeDFIfK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Apr 2018 04:35:10 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w368Y2mP042784
        for <linux-integrity@vger.kernel.org>; Fri, 6 Apr 2018 04:35:09 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h60btucqf-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 06 Apr 2018 04:35:09 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 6 Apr 2018 02:35:08 -0600
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
 <20180405101210.GA21636@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 14:03:37 +0530
MIME-Version: 1.0
In-Reply-To: <20180405101210.GA21636@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <95af65a1-e618-5cdf-fb81-56434f1aa973@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 04/05/2018 03:42 PM, Jarkko Sakkinen wrote:
> On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
>> Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
>> handle the TPM2_RC_RETRY error. The loop retries the command after
>> sleeping for the specified time, which is incremented exponentially in
>> every iteration. This patch fixes the initial sleep to be the default
>> sleep time.
> I think I understand the code change but do not understand what the
> long description.

It tells that the first sleep is delay_msec * 2 and not delay_msec.

>
>> Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> ---
>>   drivers/char/tpm/tpm-interface.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index c43a9e28995e..6201aab374e6 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -587,7 +587,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>>   		 */
>>   		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>>   			break;
>> -		delay_msec *= 2;
>> +
> Extra whitespace

I left just for clarity, but if not needed then I can remove it.

Thanks & Regards,
    - Nayna

>
>>   		if (delay_msec > TPM2_DURATION_LONG) {
>>   			if (rc == TPM2_RC_RETRY)
>>   				dev_err(&chip->dev, "in retry loop\n");
>> @@ -597,6 +597,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>>   			break;
>>   		}
>>   		tpm_msleep(delay_msec);
>> +		delay_msec *= 2;
>>   		memcpy(buf, save, save_size);
>>   	}
>>   	return ret;
>> -- 
>> 2.13.6
>>
> /Jarkko
>
