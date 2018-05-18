Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbeERGbB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 May 2018 02:31:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4I6TZdN121333
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 02:31:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j1qk7c1uu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 18 May 2018 02:31:00 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 18 May 2018 00:31:00 -0600
Subject: Re: [PATCH v4 1/4] tpm: migrate tpm2_shutdown() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 11:59:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180326121406.14548-2-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ec8f1102-e096-e39e-b6a7-4d335401c088@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> prints an error message.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>

> ---
>   drivers/char/tpm/tpm2-cmd.c | 44 ++++++++++++--------------------------------
>   1 file changed, 12 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 96c77c8e7f40..7665661d9230 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -27,10 +27,6 @@ enum tpm2_session_attributes {
>   	TPM2_SA_CONTINUE_SESSION	= BIT(0),
>   };
>
> -struct tpm2_startup_in {
> -	__be16	startup_type;
> -} __packed;
> -
>   struct tpm2_get_tpm_pt_in {
>   	__be32	cap_id;
>   	__be32	property_id;
> @@ -55,7 +51,6 @@ struct tpm2_get_random_out {
>   } __packed;
>
>   union tpm2_cmd_params {
> -	struct	tpm2_startup_in		startup_in;
>   	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
>   	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
>   	struct	tpm2_get_random_in	getrandom_in;
> @@ -412,11 +407,8 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
>   	int rc;
>
>   	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
> -	if (rc) {
> -		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
> -			 handle);
> +	if (rc)
>   		return;
> -	}
>
>   	tpm_buf_append_u32(&buf, handle);
>
> @@ -762,40 +754,28 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>   }
>   EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>
> -#define TPM2_SHUTDOWN_IN_SIZE \
> -	(sizeof(struct tpm_input_header) + \
> -	 sizeof(struct tpm2_startup_in))
> -
> -static const struct tpm_input_header tpm2_shutdown_header = {
> -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> -	.length = cpu_to_be32(TPM2_SHUTDOWN_IN_SIZE),
> -	.ordinal = cpu_to_be32(TPM2_CC_SHUTDOWN)
> -};
> -
>   /**
>    * tpm2_shutdown() - send shutdown command to the TPM chip
>    *
> + * In places where shutdown command is sent there's no much we can do except
> + * print the error code on a system failure.
> + *
>    * @chip:		TPM chip to use.
>    * @shutdown_type:	shutdown type. The value is either
>    *			TPM_SU_CLEAR or TPM_SU_STATE.
>    */
>   void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm_buf buf;
>   	int rc;
>
> -	cmd.header.in = tpm2_shutdown_header;
> -	cmd.params.startup_in.startup_type = cpu_to_be16(shutdown_type);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0,
> -			      "stopping the TPM");
> -
> -	/* In places where shutdown command is sent there's no much we can do
> -	 * except print the error code on a system failure.
> -	 */
> -	if (rc < 0 && rc != -EPIPE)
> -		dev_warn(&chip->dev, "transmit returned %d while stopping the TPM",
> -			 rc);
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
> +	if (rc)
> +		return;
> +	tpm_buf_append_u16(&buf, shutdown_type);
> +	tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0,
> +			 "stopping the TPM");
> +	tpm_buf_destroy(&buf);
>   }
>
>   /*
