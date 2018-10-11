Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730301AbeJLA1T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 20:27:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGx8Rw043393
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 12:59:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n29nj32fw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 12:59:11 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 11 Oct 2018 12:58:45 -0400
Subject: Re: [PATCH v5 03/21] tpm: factor out tpm 1.x duration calculation to
 tpm1-cmd.c
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-4-tomas.winkler@intel.com>
From: Nayna Jain <nayna@linux.ibm.com>
Date: Thu, 11 Oct 2018 22:25:35 +0530
MIME-Version: 1.0
In-Reply-To: <20180928223035.14471-4-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9200c6f4-508c-a917-8462-fe50bb995971@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 09/29/2018 04:00 AM, Tomas Winkler wrote:
> +unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> +{
> +	int duration_idx = TPM_UNDEFINED;
> +	int duration = 0;
> +
> +	/*
> +	 * We only have a duration table for protected commands, where the upper
> +	 * 16 bits are 0. For the few other ordinals the fallback will be used.
> +	 */
> +	if (ordinal < TPM_MAX_ORDINAL)
> +		duration_idx = tpm1_ordinal_duration[ordinal];
> +
> +	if (duration_idx != TPM_UNDEFINED)
> +		duration = chip->duration[duration_idx];
> +	if (duration <= 0)
> +		return 2 * 60 * HZ;
> +	else
> +		return duration;
> +}
> +EXPORT_SYMBOL_GPL(tpm1_calc_ordinal_duration);
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index caa86b19c76d..5d20e98b844f 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -370,6 +370,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   	struct i2c_client *client = to_i2c_client(dev);
>   	u32 ordinal;
>   	size_t count = 0;
> +	unsigned long duration;
>   	int burst_count, bytes2write, retries, rc = -EIO;
>
>   	for (retries = 0; retries < TPM_RETRY; retries++) {
> @@ -455,12 +456,11 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   		return rc;
>   	}
>   	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> -	rc = i2c_nuvoton_wait_for_data_avail(chip,
> -					     tpm_calc_ordinal_duration(chip,
> -								       ordinal),
> -					     &priv->read_queue);
> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);

The original code in the nuvoton driver does not differentiate between 
TPM 1.2 and TPM 2.0 as it does in tpm_tis_core.c.  Before making any 
changes, I would first fix it, so that it could easily be backported. 
Only then do the refactoring

Thanks & Regards,
    - Nayna


> +	rc = i2c_nuvoton_wait_for_data_avail(chip, duration, &priv->read_queue);
>   	if (rc) {
> -		dev_err(dev, "%s() timeout command duration\n", __func__);
> +		dev_err(dev, "%s() timeout command duration %ld\n",
> +			__func__, duration);
>   		i2c_nuvoton_ready(chip);
>   		return rc;
>   	}
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index d2345d9fd7b5..14c332104de4 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -476,7 +476,7 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>   		if (chip->flags & TPM_CHIP_FLAG_TPM2)
>   			dur = tpm2_calc_ordinal_duration(chip, ordinal);
>   		else
> -			dur = tpm_calc_ordinal_duration(chip, ordinal);
> +			dur = tpm1_calc_ordinal_duration(chip, ordinal);
>
>   		if (wait_for_tpm_stat
>   		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index b150f87f38f5..77097229bf49 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -164,7 +164,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   	notify_remote_via_evtchn(priv->evtchn);
>
>   	ordinal = be32_to_cpu(((struct tpm_input_header*)buf)->ordinal);
> -	duration = tpm_calc_ordinal_duration(chip, ordinal);
> +	duration = tpm1_calc_ordinal_duration(chip, ordinal);
>
>   	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
>   			&priv->read_queue, true) < 0) {
