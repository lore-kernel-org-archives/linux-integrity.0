Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755753AbdKGS3w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Nov 2017 13:29:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA7ITqF8054689
        for <linux-integrity@vger.kernel.org>; Tue, 7 Nov 2017 13:29:52 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e3fyjem8t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 07 Nov 2017 13:29:50 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 11:29:49 -0700
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
 performance
To: Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
 <20171017203232.2262-3-nayna@linux.vnet.ibm.com>
 <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
Date: Tue, 7 Nov 2017 23:59:10 +0530
MIME-Version: 1.0
In-Reply-To: <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 10/20/2017 08:12 PM, Alexander.Steffen@infineon.com wrote:
>> The TPM burstcount status indicates the number of bytes that can
>> be sent to the TPM without causing bus wait states.  Effectively,
>> it is the number of empty bytes in the command FIFO.
>>
>> This patch optimizes the tpm_tis_send_data() function by checking
>> the burstcount only once. And if the burstcount is valid, it writes
>> all the bytes at once, permitting wait state.
>>
>> After this change, performance on a TPM 1.2 with an 8 byte
>> burstcount for 1000 extends improved from ~41sec to ~14sec.
>>
>> Suggested-by: Ken Goldman<kgold@linux.vnet.ibm.com>  in
>> conjunction with the TPM Device Driver work group.
>> Signed-off-by: Nayna Jain<nayna@linux.vnet.ibm.com>
>> Acked-by: Mimi Zohar<zohar@linux.vnet.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 42 +++++++++++++++----------------------
>> ----
>>   1 file changed, 15 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c
>> b/drivers/char/tpm/tpm_tis_core.c
>> index b33126a35694..993328ae988c 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -316,7 +316,6 @@ static int tpm_tis_send_data(struct tpm_chip *chip,
>> u8 *buf, size_t len)
>>   {
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>   	int rc, status, burstcnt;
>> -	size_t count = 0;
>>   	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
>>
>>   	status = tpm_tis_status(chip);
>> @@ -330,35 +329,24 @@ static int tpm_tis_send_data(struct tpm_chip *chip,
>> u8 *buf, size_t len)
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
>> -		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv-
>>> locality),
>> -					 burstcnt, buf + count);
>> -		if (rc < 0)
>> -			goto out_err;
>> -
>> -		count += burstcnt;
>> -
>> -		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip-
>>> timeout_c,
>> -					&priv->int_queue, false) < 0) {
>> -			rc = -ETIME;
>> -			goto out_err;
>> -		}
>> -		status = tpm_tis_status(chip);
>> -		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>> -			rc = -EIO;
>> -			goto out_err;
>> -		}
>> +	/*
>> +	 * Get the initial burstcount to ensure TPM is ready to
>> +	 * accept data.
>> +	 */
>> +	burstcnt = get_burstcount(chip);
>> +	if (burstcnt < 0) {
>> +		dev_err(&chip->dev, "Unable to read burstcount\n");
>> +		rc = burstcnt;
>> +		goto out_err;
>>   	}
>>
>> +	rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>> +			len - 1, buf);
>> +	if (rc < 0)
>> +		goto out_err;
>> +
>>   	/* write last byte */
>> -	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality),
>> buf[count]);
>> +	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[len-
>> 1]);
>>   	if (rc < 0)
>>   		goto out_err;
>>
>> --
>> 2.13.3
> This seems to fail reliably with my SPI TPM 2.0. I get EIO when trying to send large amounts of data, e.g. with TPM2_Hash, and subsequent tests seem to take an unusual amount of time. More analysis probably has to wait until November, since I am going to be in Prague next week.

Thanks Alex for testing these.. Did you get the chance to do any further 
analysis ?

Thanks & Regards,
        - Nayna

> Alexander
>
