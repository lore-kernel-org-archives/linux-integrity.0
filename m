Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726691AbeJQOAE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Oct 2018 10:00:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9H64m3h014525
        for <linux-integrity@vger.kernel.org>; Wed, 17 Oct 2018 02:06:03 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n5sshd5jv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 17 Oct 2018 02:06:02 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 17 Oct 2018 02:06:02 -0400
Subject: Re: [PATCH v5 20/21] tpm1: reimplement tpm1_continue_selftest() using
 tpm_buf
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-21-tomas.winkler@intel.com>
From: Nayna Jain <nayna@linux.ibm.com>
Date: Wed, 17 Oct 2018 11:32:52 +0530
MIME-Version: 1.0
In-Reply-To: <20180928223035.14471-21-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <068d310f-566c-b6d5-5ab8-2bc9a5d36fd1@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 09/29/2018 04:00 AM, Tomas Winkler wrote:
> Reimplement tpm1_continue_selftest() using tpm_buf structure.
> This is the last command using the old tpm_cmd_t structure
> and now the structure can be removed.
>
> Cc: Nayna Jain <nayna@linux.vnet.ibm.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>
> V3: New in the series.
> V4: Resend.
> V5: Fix &buf.data -> buf.data in tpm1_continue_selftest()
>
>   drivers/char/tpm/tpm.h      |  9 ---------
>   drivers/char/tpm/tpm1-cmd.c | 21 ++++++++++-----------
>   2 files changed, 10 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2f06740f993d..7ada00f067f1 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -377,15 +377,6 @@ enum tpm_sub_capabilities {
>   	TPM_CAP_PROP_TIS_DURATION = 0x120,
>   };
>
> -typedef union {
> -	struct	tpm_input_header in;
> -	struct	tpm_output_header out;
> -} tpm_cmd_header;
> -
> -struct tpm_cmd_t {
> -	tpm_cmd_header	header;
> -} __packed;
> -
>
>   /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
>    * bytes, but 128 is still a relatively large number of random bytes and
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index d418a27a75e0..6b04648f8184 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -602,15 +602,8 @@ int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
>   }
>
>   #define TPM_ORD_CONTINUE_SELFTEST 83
> -#define CONTINUE_SELFTEST_RESULT_SIZE 10
> -static const struct tpm_input_header continue_selftest_header = {
> -	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> -	.length = cpu_to_be32(10),
> -	.ordinal = cpu_to_be32(TPM_ORD_CONTINUE_SELFTEST),
> -};
> -
>   /**
> - * tpm_continue_selftest -- run TPM's selftest
> + * tpm_continue_selftest() - run TPM's selftest
>    * @chip: TPM chip to use
>    *
>    * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
> @@ -618,12 +611,18 @@ static const struct tpm_input_header continue_selftest_header = {
>    */
>   static int tpm1_continue_selftest(struct tpm_chip *chip)
>   {
> +	struct tpm_buf buf;
>   	int rc;
> -	struct tpm_cmd_t cmd;
>
> -	cmd.header.in = continue_selftest_header;
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, CONTINUE_SELFTEST_RESULT_SIZE,
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
> +	if (rc)
> +		return rc;
> +
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE,
>   			      0, 0, "continue selftest");
> +
> +	tpm_buf_destroy(&buf);
> +
>   	return rc;
>   }
>


Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>


Thanks & Regards,
     - Nayna
