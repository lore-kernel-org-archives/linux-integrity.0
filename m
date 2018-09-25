Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727281AbeIYQdv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Sep 2018 12:33:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PAOA17023032
        for <linux-integrity@vger.kernel.org>; Tue, 25 Sep 2018 06:26:57 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqgj1ysyj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Sep 2018 06:26:57 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 04:26:56 -0600
Subject: Re: [PATCH v4 20/21] tpm1: reimplement tpm1_continue_selftest() using
 tpm_buf
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921135820.20549-1-tomas.winkler@intel.com>
 <20180921135820.20549-21-tomas.winkler@intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 25 Sep 2018 15:53:59 +0530
MIME-Version: 1.0
In-Reply-To: <20180921135820.20549-21-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5f142a3b-15b8-368b-19e5-5926b20addfd@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 09/21/2018 07:28 PM, Tomas Winkler wrote:
> Reimplement tpm1_continue_selftest() using tpm_buf structure.
> This is the last command using the old tpm_cmd_t structure
> and now the structure can be removed.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V3: New in the series.
> V4: Resend.
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
> index cde9a01ad31f..6d7d70b0d130 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -604,15 +604,8 @@ int tpm1_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf)
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
> @@ -620,12 +613,18 @@ static const struct tpm_input_header continue_selftest_header = {
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
> +	rc = tpm_transmit_cmd(chip, NULL, &buf.data, PAGE_SIZE,
I think this needs to buf.data instead of &buf.data

Thanks & Regards,
      - Nayna

>   			      0, 0, "continue selftest");
> +
> +	tpm_buf_destroy(&buf);
> +
>   	return rc;
>   }
>
