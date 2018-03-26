Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752179AbeCZOM2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Mar 2018 10:12:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2QEBvhX120525
        for <linux-integrity@vger.kernel.org>; Mon, 26 Mar 2018 10:12:27 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gy04gxb7t-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 26 Mar 2018 10:12:27 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 26 Mar 2018 08:12:25 -0600
Subject: Re: [PATCH v2 1/2] tpm: add retry logic
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <1521657747.6397.18.camel@HansenPartnership.com>
 <1521657828.6397.19.camel@HansenPartnership.com>
 <7236ada1-43b5-8280-ce21-3d0c095dfe9d@linux.vnet.ibm.com>
 <1521736298.7197.4.camel@HansenPartnership.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 19:41:02 +0530
MIME-Version: 1.0
In-Reply-To: <1521736298.7197.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3733a124-1746-d5d9-4fda-838c9ffdaa81@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 03/22/2018 10:01 PM, James Bottomley wrote:
> On Thu, 2018-03-22 at 21:43 +0530, Nayna Jain wrote:
>>>    /**
>>> + * tpm_transmit - Internal kernel interface to transmit TPM
>>> commands.
>>> + *
>>> + * @chip: TPM chip to use
>>> + * @space: tpm space
>>> + * @buf: TPM command buffer
>>> + * @bufsiz: length of the TPM command buffer
>>> + * @flags: tpm transmit flags - bitmap
>>> + *
>>> + * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
>>> + * returns from the TPM and retransmits the command after a delay
>>> up
>>> + * to a maximum wait of TPM2_DURATION_LONG.
>>> + *
>>> + * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is
>>> TPM2
>>> + * only
>>> + *
>>> + * Return:
>>> + *     the length of the return when the operation is successful.
>>> + *     A negative number for system errors (errno).
>>> + */
>>> +ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space
>>> *space,
>>> +		     u8 *buf, size_t bufsiz, unsigned int flags)
>>> +{
>>> +	struct tpm_output_header *header = (struct
>>> tpm_output_header *)buf;
>>> +	/* space for header and handles */
>>> +	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
>>> +	unsigned int delay_msec = TPM2_DURATION_SHORT;
>>> +	u32 rc = 0;
>>> +	ssize_t ret;
>>> +	const size_t save_size = min(space ? sizeof(save) :
>>> TPM_HEADER_SIZE,
>>> +				     bufsiz);
>>> +
>>> +	/*
>>> +	 * Subtlety here: if we have a space, the handles will be
>>> +	 * transformed, so when we restore the header we also have
>>> to
>>> +	 * restore the handles.
>>> +	 */
>>> +	memcpy(save, buf, save_size);
>>> +
>>> +	for (;;) {
>>> +		ret = tpm_try_transmit(chip, space, buf, bufsiz,
>>> flags);
>>> +		if (ret < 0)
>>> +			break;
>>> +		rc = be32_to_cpu(header->return_code);
>>> +		if (rc != TPM2_RC_RETRY)
>>> +			break;
>>> +		delay_msec *= 2;
>> Was wondering if this increment could be moved after
>> tpm_msleep(delay_msec) ?
> I thought about that when I saw the logic in the original but what it
> would do is double the maximum delay (which is already nearly double
> TPM2_DURATION_LONG).  I figured doubling the initial timeout was fine
> rather than trying to do complex logic to get the delay exact (and then
> having to litter the file with comments explaining why).

Sorry James, I didn't understand exactly about what complex logic is 
involved. Can you please explain it more ?
My point was to just move "delay_msec *= 2"  after tpm_msleep() as shown 
below:

if (delay_msec > TPM2_DURATION_LONG) {
     dev_err(&chip->dev, "TPM is in retry loop\n");
     break;
}
tpm_msleep(delay_msec)
delay_msec *= 2;

And the first time sleep will use the already initialized value of 
delay_msec as:
unsigned int delay_msec = TPM2_DURATION_SHORT;

Thanks & Regards,
    - Nayna


>
> James
>
