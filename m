Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43805 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728360AbeJLAcJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 20:32:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGxH9C015374
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 13:04:02 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n289j7vbs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 13:04:02 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Thu, 11 Oct 2018 13:04:00 -0400
Subject: Re: [PATCH v5 05/21] tpm: factor out tpm_get_timeouts()
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-6-tomas.winkler@intel.com>
From: Nayna Jain <nayna@linux.ibm.com>
Date: Thu, 11 Oct 2018 22:30:52 +0530
MIME-Version: 1.0
In-Reply-To: <20180928223035.14471-6-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b6b0fb96-e955-bf86-9bac-e6acee1e33e0@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 09/29/2018 04:00 AM, Tomas Winkler wrote:
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 73511cd89bef..a97d72fcda5b 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -544,8 +544,10 @@ int tpm_startup(struct tpm_chip *chip);
>   ssize_t tpm_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>   		   const char *desc, size_t min_cap_length);
>   int tpm_get_timeouts(struct tpm_chip *);
> -int tpm1_auto_startup(struct tpm_chip *chip);
>   int tpm_do_selftest(struct tpm_chip *chip);
> +
> +int tpm1_auto_startup(struct tpm_chip *chip);

What is different in this tpm1_auto_startup(...) and the original one ?

Is this needed ?

Thanks & Regards,
    - Nayna


> +int tpm1_get_timeouts(struct tpm_chip *chip);
>   unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>   unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>   int tpm_pm_suspend(struct device *dev);
> @@ -585,6 +587,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>   	return (rc & BIT(7)) ? rc & 0xff : rc;
>   }
>
> +int tpm2_get_timeouts(struct tpm_chip *chip);
>   int tpm2_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
>   int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>   		    struct tpm2_digest *digests);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index dfbe9c60cbcf..978946748ea3 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -307,3 +307,109 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>   	else
>   		return duration;
>   }
> +
> +int tpm1_get_timeouts(struct tpm_chip *chip)
> +{
> +	cap_t cap;
> +	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
> +	ssize_t rc;
> +
> +	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
> +			sizeof(cap.timeout));
> +	if (rc == TPM_ERR_INVALID_POSTINIT) {
> +		if (tpm_startup(chip))
> +			return rc;
> +
> +		rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,
> +				"attempting to determine the timeouts",
> +				sizeof(cap.timeout));
> +	}
> +
> +	if (rc) {
> +		dev_err(&chip->dev, "A TPM error (%zd) occurred attempting to determine the timeouts\n",
> +			rc);
> +		return rc;
> +	}
> +
> +	timeout_old[0] = jiffies_to_usecs(chip->timeout_a);
> +	timeout_old[1] = jiffies_to_usecs(chip->timeout_b);
> +	timeout_old[2] = jiffies_to_usecs(chip->timeout_c);
> +	timeout_old[3] = jiffies_to_usecs(chip->timeout_d);
> +	timeout_chip[0] = be32_to_cpu(cap.timeout.a);
> +	timeout_chip[1] = be32_to_cpu(cap.timeout.b);
> +	timeout_chip[2] = be32_to_cpu(cap.timeout.c);
> +	timeout_chip[3] = be32_to_cpu(cap.timeout.d);
> +	memcpy(timeout_eff, timeout_chip, sizeof(timeout_eff));
> +
> +	/*
> +	 * Provide ability for vendor overrides of timeout values in case
> +	 * of misreporting.
> +	 */
> +	if (chip->ops->update_timeouts)
> +		chip->timeout_adjusted =
> +			chip->ops->update_timeouts(chip, timeout_eff);
> +
> +	if (!chip->timeout_adjusted) {
> +		/* Restore default if chip reported 0 */
> +		unsigned int i;
> +
> +		for (i = 0; i < ARRAY_SIZE(timeout_eff); i++) {
> +			if (timeout_eff[i])
> +				continue;
> +
> +			timeout_eff[i] = timeout_old[i];
> +			chip->timeout_adjusted = true;
> +		}
> +
> +		if (timeout_eff[0] != 0 && timeout_eff[0] < 1000) {
> +			/* timeouts in msec rather usec */
> +			for (i = 0; i != ARRAY_SIZE(timeout_eff); i++)
> +				timeout_eff[i] *= 1000;
> +			chip->timeout_adjusted = true;
> +		}
> +	}
> +
> +	/* Report adjusted timeouts */
> +	if (chip->timeout_adjusted) {
> +		dev_info(&chip->dev, HW_ERR "Adjusting reported timeouts: A %lu->%luus B %lu->%luus C %lu->%luus D %lu->%luus\n",
> +			 timeout_chip[0], timeout_eff[0],
> +			 timeout_chip[1], timeout_eff[1],
> +			 timeout_chip[2], timeout_eff[2],
> +			 timeout_chip[3], timeout_eff[3]);
> +	}
> +
> +	chip->timeout_a = usecs_to_jiffies(timeout_eff[0]);
> +	chip->timeout_b = usecs_to_jiffies(timeout_eff[1]);
> +	chip->timeout_c = usecs_to_jiffies(timeout_eff[2]);
> +	chip->timeout_d = usecs_to_jiffies(timeout_eff[3]);
> +
> +	rc = tpm_getcap(chip, TPM_CAP_PROP_TIS_DURATION, &cap,
> +			"attempting to determine the durations",
> +			sizeof(cap.duration));
> +	if (rc)
> +		return rc;
> +
> +	chip->duration[TPM_SHORT] =
> +		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_short));
> +	chip->duration[TPM_MEDIUM] =
> +		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_medium));
> +	chip->duration[TPM_LONG] =
> +		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
> +	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
> +
> +	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
> +	 * value wrong and apparently reports msecs rather than usecs. So we
> +	 * fix up the resulting too-small TPM_SHORT value to make things work.
> +	 * We also scale the TPM_MEDIUM and -_LONG values by 1000.
> +	 */
> +	if (chip->duration[TPM_SHORT] < (HZ / 100)) {
> +		chip->duration[TPM_SHORT] = HZ;
> +		chip->duration[TPM_MEDIUM] *= 1000;
> +		chip->duration[TPM_LONG] *= 1000;
> +		chip->duration_adjusted = true;
> +		dev_info(&chip->dev, "Adjusting TPM timeout parameters.");
> +	}
> +
> +	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
> +	return 0;
> +}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 5e7bf8842be0..49df54b0e210 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -40,6 +40,28 @@ static struct tpm2_hash tpm2_hash_map[] = {
>   	{HASH_ALGO_SM3_256, TPM2_ALG_SM3_256},
>   };
>
> +int tpm2_get_timeouts(struct tpm_chip *chip)
> +{
> +	/* Fixed timeouts for TPM2 */
> +	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
> +	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
> +	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
> +	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
> +
> +	/* PTP spec timeouts */
> +	chip->duration[TPM_SHORT] = msecs_to_jiffies(TPM2_DURATION_SHORT);
> +	chip->duration[TPM_MEDIUM] = msecs_to_jiffies(TPM2_DURATION_MEDIUM);
> +	chip->duration[TPM_LONG] = msecs_to_jiffies(TPM2_DURATION_LONG);
> +
> +	/* Key creation commands long timeouts */
> +	chip->duration[TPM_LONG_LONG] =
> +		msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
> +
> +	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
> +
> +	return 0;
> +}
> +
>   /**
>    * tpm2_ordinal_duration_index() - returns an index to the chip duration table
>    * @ordinal: TPM command ordinal.
