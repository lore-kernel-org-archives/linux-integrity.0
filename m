Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728138AbeJLRGG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 13:06:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9C9YVMi107857
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 05:34:32 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n2pugdhww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 05:34:32 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Fri, 12 Oct 2018 05:34:32 -0400
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
From: Nayna Jain <nayna@linux.ibm.com>
Date: Fri, 12 Oct 2018 15:01:24 +0530
MIME-Version: 1.0
In-Reply-To: <20180928223035.14471-7-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <24b611f6-8080-3f99-56e5-818bd16ef4f8@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 09/29/2018 04:00 AM, Tomas Winkler wrote:
> Move tpm1_pcr_extend to tpm1-cmd.c and remove
> unused pcrextend_header structure and
> EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
> defines.
>
> Fixes warning:
> drivers/char/tpm/tpm-interface.c:609:38: warning: 'pcrextend_header' defined but not used [-Wunused-const-variable=]
>   static const struct tpm_input_header pcrextend_header = {
>                                        ^~~~~~~~~~~~~~~~
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>
> V2-V3: Rebase
> V4: Remove defines.
> V5: Resend.
>
>   drivers/char/tpm/tpm-interface.c | 28 ----------------------------
>   drivers/char/tpm/tpm.h           |  2 ++
>   drivers/char/tpm/tpm1-cmd.c      | 21 +++++++++++++++++++++
>   3 files changed, 23 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1fa0300f3829..ac73e6ac3d83 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -614,34 +614,6 @@ int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>   }
>   EXPORT_SYMBOL_GPL(tpm_pcr_read);
>
> -#define TPM_ORD_PCR_EXTEND 20
> -#define EXTEND_PCR_RESULT_SIZE 34
> -#define EXTEND_PCR_RESULT_BODY_SIZE 20
> -static const struct tpm_input_header pcrextend_header = {
> -	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> -	.length = cpu_to_be32(34),
> -	.ordinal = cpu_to_be32(TPM_ORD_PCR_EXTEND)
> -};
> -
> -static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> -			   char *log_msg)
> -{
> -	struct tpm_buf buf;
> -	int rc;
> -
> -	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
> -	if (rc)
> -		return rc;
> -
> -	tpm_buf_append_u32(&buf, pcr_idx);
> -	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, buf.data, EXTEND_PCR_RESULT_SIZE,
> -			      EXTEND_PCR_RESULT_BODY_SIZE, 0, log_msg);
> -	tpm_buf_destroy(&buf);
> -	return rc;
> -}
> -
>   /**
>    * tpm_pcr_extend - extend a PCR value in SHA1 bank.
>    * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a97d72fcda5b..3fb268f43955 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -549,6 +549,8 @@ int tpm_do_selftest(struct tpm_chip *chip);
>   int tpm1_auto_startup(struct tpm_chip *chip);
>   int tpm1_get_timeouts(struct tpm_chip *chip);
>   unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> +int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> +		    const char *log_msg);
>   unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>   int tpm_pm_suspend(struct device *dev);
>   int tpm_pm_resume(struct device *dev);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 978946748ea3..ec242397e6dc 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -413,3 +413,24 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
>   	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
>   	return 0;
>   }
> +
> +#define TPM_ORD_PCR_EXTEND 20
> +int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> +		    const char *log_msg)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_append_u32(&buf, pcr_idx);
> +	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
> +
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
> +			      TPM_DIGEST_SIZE, 0, log_msg);
> +
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}


Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>

Sorry for bit delay in testing.

Thanks & Regards,
    - Nayna
