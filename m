Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751319AbeCVQPU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 12:15:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2MG7MZg119140
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 12:15:20 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gve50p9yj-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 12:15:19 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 22 Mar 2018 10:15:18 -0600
Subject: Re: [PATCH v2 1/2] tpm: add retry logic
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <1521657747.6397.18.camel@HansenPartnership.com>
 <1521657828.6397.19.camel@HansenPartnership.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 21:43:50 +0530
MIME-Version: 1.0
In-Reply-To: <1521657828.6397.19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7236ada1-43b5-8280-ce21-3d0c095dfe9d@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



>   /**
> + * tpm_transmit - Internal kernel interface to transmit TPM commands.
> + *
> + * @chip: TPM chip to use
> + * @space: tpm space
> + * @buf: TPM command buffer
> + * @bufsiz: length of the TPM command buffer
> + * @flags: tpm transmit flags - bitmap
> + *
> + * A wrapper around tpm_try_transmit that handles TPM2_RC_RETRY
> + * returns from the TPM and retransmits the command after a delay up
> + * to a maximum wait of TPM2_DURATION_LONG.
> + *
> + * Note: TPM1 never returns TPM2_RC_RETRY so the retry logic is TPM2
> + * only
> + *
> + * Return:
> + *     the length of the return when the operation is successful.
> + *     A negative number for system errors (errno).
> + */
> +ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> +		     u8 *buf, size_t bufsiz, unsigned int flags)
> +{
> +	struct tpm_output_header *header = (struct tpm_output_header *)buf;
> +	/* space for header and handles */
> +	u8 save[TPM_HEADER_SIZE + 3*sizeof(u32)];
> +	unsigned int delay_msec = TPM2_DURATION_SHORT;
> +	u32 rc = 0;
> +	ssize_t ret;
> +	const size_t save_size = min(space ? sizeof(save) : TPM_HEADER_SIZE,
> +				     bufsiz);
> +
> +	/*
> +	 * Subtlety here: if we have a space, the handles will be
> +	 * transformed, so when we restore the header we also have to
> +	 * restore the handles.
> +	 */
> +	memcpy(save, buf, save_size);
> +
> +	for (;;) {
> +		ret = tpm_try_transmit(chip, space, buf, bufsiz, flags);
> +		if (ret < 0)
> +			break;
> +		rc = be32_to_cpu(header->return_code);
> +		if (rc != TPM2_RC_RETRY)
> +			break;
> +		delay_msec *= 2;

Was wondering if this increment could be moved after 
tpm_msleep(delay_msec) ?

Thanks & Regards,
    - Nayna

> +		if (delay_msec > TPM2_DURATION_LONG) {
> +			dev_err(&chip->dev, "TPM is in retry loop\n");
> +			break;
> +		}
> +		tpm_msleep(delay_msec);
> +		memcpy(buf, save, save_size);
> +	}
> +	return ret;
> +}
> +/**
>    * tpm_transmit_cmd - send a tpm command to the device
>    *    The function extracts tpm out header return code
>    *
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index ab3861631d27..05967c1a1f32 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -112,6 +112,7 @@ enum tpm2_return_codes {
>   	TPM2_RC_COMMAND_CODE    = 0x0143,
>   	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>   	TPM2_RC_REFERENCE_H0	= 0x0910,
> +	TPM2_RC_RETRY		= 0x0922,
>   };
>
>   enum tpm2_algorithms {
