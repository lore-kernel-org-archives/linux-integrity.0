Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752074AbdJKL37 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 07:29:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BBThWx068846
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 07:29:58 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dhhkgurab-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 07:29:58 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 05:29:57 -0600
Subject: Re: [PATCH v3 2/5] tpm: ignore burstcount to improve tpm_tis send()
 performance
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
 <20171004102924.12355-3-nayna@linux.vnet.ibm.com>
 <20171010150433.vxwxg4wzc3lgqckf@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 16:59:30 +0530
MIME-Version: 1.0
In-Reply-To: <20171010150433.vxwxg4wzc3lgqckf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d979746f-e875-52ab-b3d9-864bc7902dd8@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 10/10/2017 08:34 PM, Jarkko Sakkinen wrote:
> On Wed, Oct 04, 2017 at 06:29:21AM -0400, Nayna Jain wrote:
>> The TPM burstcount status indicates the number of bytes that can
>> be sent to the TPM without causing bus wait states.  Effectively,
>> it is the number of empty bytes in the command FIFO. Further,
>> some TPMs have a static burstcount, when the value remains zero
>> until the entire FIFO is empty.
>>
>> This patch optimizes the tpm_tis_send_data() function by checking
>> the burstcount only once. And if the burstcount is valid, it writes
>> all the bytes at once, permitting wait states. The performance of a
>> 34 byte extend on a TPM 1.2 with an 8 byte burstcount improved from
>> 41msec to 14msec.
>>
>> After this change, performance on a TPM 1.2 with an 8 byte
>> burstcount for 1000 extends improved from ~41sec to ~14sec.
>>
>> Suggested-by: Ken Goldman <kgold@linux.vnet.ibm.com> in
>> conjunction with the TPM Device Driver work group.
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 42 ++++++++++++++++-------------------------
>>   1 file changed, 16 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index b33126a35694..8da425e1783f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -316,7 +316,6 @@ static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)
>>   {
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>   	int rc, status, burstcnt;
>> -	size_t count = 0;
>>   	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
>>   
>>   	status = tpm_tis_status(chip);
>> @@ -330,35 +329,26 @@ static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)
>>   		}
>>   	}
>>   
>> -	while (count < len - 1) {
>> -		burstcnt = get_burstcount(chip);
>> -		if (burstcnt < 0) {
>> -			dev_err(&chip->dev, "Unable to read burstcount\n");
>> -			rc = burstcnt;
>> -			goto out_err;
>> -		}
>> -		burstcnt = min_t(int, burstcnt, len - count - 1);
>> -		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>> -					 burstcnt, buf + count);
>> -		if (rc < 0)
>> -			goto out_err;
>> +	/*
>> +	 * Get the initial burstcount to ensure TPM is ready to
>> +	 * accept data.
>> +	 */
>> +	burstcnt = get_burstcount(chip);
>> +	if (burstcnt < 0) {
>> +		dev_err(&chip->dev, "Unable to read burstcount\n");
>> +		rc = burstcnt;
>> +		goto out_err;
>> +	}
>>   
>> -		count += burstcnt;
>> +	burstcnt = len - 1;
>>   
>> -		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
>> -					&priv->int_queue, false) < 0) {
>> -			rc = -ETIME;
>> -			goto out_err;
>> -		}
>> -		status = tpm_tis_status(chip);
>> -		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>> -			rc = -EIO;
>> -			goto out_err;
>> -		}
>> -	}
>> +	rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>> +			burstcnt, buf);
> Otherwise, this looks good but I don't understand why you assign 'len -
> 1' to 'brustcnt' and pass it to tpm_tis_write_bytes() instead of just
> passing 'len - 1'. I mean no relation to burst count, right?
Yeah, I can just send 'len - 1'. Will do this change.

Thanks & Regards,
      - Nayna
>
> /Jarkko
>
