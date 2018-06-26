Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754889AbeFZSgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jun 2018 14:36:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QIXsus134795
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 14:36:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jusqwtnuy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Jun 2018 14:36:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 14:36:17 -0400
Subject: Re: [PATCH v6 3/5] tpm: Convert tpm_find_get_ops() to use
 tpm_default_chip()
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
 <20180626172331.2505541-4-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 26 Jun 2018 14:36:13 -0400
MIME-Version: 1.0
In-Reply-To: <20180626172331.2505541-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <17ca4660-150b-b536-bbda-01629aac11f6@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/26/2018 01:23 PM, Stefan Berger wrote:
> Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
> is passed in.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-chip.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index f551061262c9..b01d34983766 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -124,29 +124,23 @@ EXPORT_SYMBOL_GPL(tpm_default_chip);
>    */
>   struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
>   {
> -	struct tpm_chip *res = NULL;
> -	int chip_num = 0;
> -	int chip_prev;
> -
> -	mutex_lock(&idr_lock);
> +	int rc;
>
> -	if (!chip) {
> -		do {
> -			chip_prev = chip_num;
> -			chip = idr_get_next(&dev_nums_idr, &chip_num);
> -			if (chip && !tpm_try_get_ops(chip)) {
> -				res = chip;
> -				break;
> -			}
> -		} while (chip_prev != chip_num);
> -	} else {
> +	if (chip) {
>   		if (!tpm_try_get_ops(chip))
> -			res = chip;
> +			return chip;
> +		return NULL;
>   	}
>
> -	mutex_unlock(&idr_lock);
> -
> -	return res;
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return NULL;
> +	rc = tpm_try_get_ops(chip);
> +	/* release additional reference we got from tpm_default_chip() */
> +	put_device(&chip->dev);
> +	if (!rc)
This should say 'if (rc)'.
> +		return NULL;
> +	return chip;
>   }
>
>   /**
