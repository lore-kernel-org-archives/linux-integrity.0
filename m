Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750882AbeERGdF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 02:33:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4I6TbuK058256
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 02:33:04 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j1kkebyu4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 02:33:04 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 18 May 2018 00:33:03 -0600
Subject: Re: [PATCH v4 2/4] tpm: migrate tpm2_probe() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-3-jarkko.sakkinen@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 12:01:07 +0530
MIME-Version: 1.0
In-Reply-To: <20180326121406.14548-3-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8c7f20fd-4b4f-0f25-35a4-eb1a615f1615@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>

Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>


Thanks & Regards,
     - Nayna

> ---
>   drivers/char/tpm/tpm2-cmd.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7665661d9230..7bffd0fd1dca 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -844,30 +844,35 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>
>   /**
>    * tpm2_probe() - probe TPM 2.0
> - * @chip: TPM chip to use
> + * @chip: a TPM chip to probe
>    *
> - * Return: < 0 error and 0 on success.
> + * Return: 0 on success,
> + *         -errno otherwise
>    *
> - * Send idempotent TPM 2.0 command and see whether TPM 2.0 chip replied based on
> - * the reply tag.
> + * Send an idempotent TPM 2.0 command and see whether there is TPM2 chip in the
> + * other end based on the response tag. The flag TPM_CHIP_FLAG_TPM2 is set if
> + * this is the case.
>    */
>   int tpm2_probe(struct tpm_chip *chip)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm_output_header *out;
> +	struct tpm_buf buf;
>   	int rc;
>
> -	cmd.header.in = tpm2_get_tpm_pt_header;
> -	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
> -	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
> -	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
> -	if (rc <  0)
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	if (rc)
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> -		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> +	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
> +	tpm_buf_append_u32(&buf, 1);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	/* We ignore TPM return codes on purpose. */
> +	if (rc >=  0) {
> +		out = (struct tpm_output_header *)buf.data;
> +		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
> +			chip->flags |= TPM_CHIP_FLAG_TPM2;
> +	}
> +	tpm_buf_destroy(&buf);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tpm2_probe);
