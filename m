Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936019AbdLSJCg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Dec 2017 04:02:36 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBJ8xZhw137891
        for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2017 04:02:35 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2exxt5tnrd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 19 Dec 2017 04:02:35 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 19 Dec 2017 04:02:34 -0500
Subject: Re: [RFC][PATCH 4/9] tpm_tis_core: send all data in single operation
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko.sakkinen@linux.intel.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-5-Alexander.Steffen@infineon.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 14:31:38 +0530
MIME-Version: 1.0
In-Reply-To: <20171208184658.9588-5-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <61524877-f0f4-03c5-3395-bd0ee90af55f@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 12/09/2017 12:16 AM, Alexander Steffen wrote:
> tpm_tis_send_data splits all commands sent to the TPM into at least two
> transfers, even if the commands are small enough to fit into a single
> transfer. The intention seems to be to make extra sure that the TPM has
> received all data correctly by observing the Expect flag flipping from 1 to
> 0 when writing the last byte.
>
> Unfortunately, this does not work as intended, because the Expect flag will
> change not when the last byte is written to the FIFO, but when the TPM
> processes the last byte from the FIFO. With a large FIFO and long commands
> it might well be that there are still many bytes left in the FIFO when the
> Expect flag is checked. Obviously, the flag will be 1 then, even if the
> FIFO contains more bytes than expected. Since there is no indication
> whether the FIFO is already empty or not, there is no way to implement this
> check reliably.
>
> But then again, this check is not necessary at all. The driver already
> ensures that not more data is sent to the TPM than is announced in the
> header. In addition, the TPM is required to throw away all extraneous bytes
> anyway. So if the Expect flag is 0 after all bytes have been sent to the
> TPM, the TPM has received the command correctly and is ready to execute it.
>
> Therefore, remove this intermediary check and send all data in a single
> operation. This simplifies the code and improves the performance,
> especially for short commands.
I was thinking if this can be taken care as part of burstcount patch itself.

Thanks & Regards,
     - Nayna

> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 25 ++++++-------------------
>   1 file changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 0df05b4..1359c52 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -320,7 +320,6 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>   	int rc, status, burstcnt;
>   	size_t count = 0;
> -	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
>
>   	status = tpm_tis_status(chip);
>   	if ((status & TPM_STS_COMMAND_READY) == 0) {
> @@ -333,38 +332,26 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>   		}
>   	}
>
> -	while (count < len - 1) {
> +	while (count < len) {
>   		burstcnt = get_burstcount(chip);
>   		if (burstcnt < 0) {
>   			dev_err(&chip->dev, "Unable to read burstcount\n");
>   			rc = burstcnt;
>   			goto out_err;
>   		}
> -		burstcnt = min_t(int, burstcnt, len - count - 1);
> +		burstcnt = min_t(int, burstcnt, len - count);
>   		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>   					 burstcnt, buf + count);
>   		if (rc < 0)
>   			goto out_err;
>
>   		count += burstcnt;
> -
> -		if (!itpm && wait_for_tpm_stat
> -			     (chip, TPM_STS_DATA_EXPECT | TPM_STS_VALID,
> -			      TPM_STS_DATA_EXPECT | TPM_STS_VALID,
> -			      chip->timeout_c, &priv->int_queue, false) < 0) {
> -			rc = -EIO;
> -			goto out_err;
> -		}
>   	}
>
> -	/* write last byte */
> -	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
> -	if (rc < 0)
> -		goto out_err;
> -
> -	if (!itpm && wait_for_tpm_stat
> -		     (chip, TPM_STS_DATA_EXPECT | TPM_STS_VALID, TPM_STS_VALID,
> -		      chip->timeout_c, &priv->int_queue, false) < 0) {
> +	if (!(priv->flags & TPM_TIS_ITPM_WORKAROUND) &&
> +	    wait_for_tpm_stat(chip, TPM_STS_DATA_EXPECT | TPM_STS_VALID,
> +			      TPM_STS_VALID, chip->timeout_c, &priv->int_queue,
> +			      false) < 0) {
>   		rc = -EIO;
>   		goto out_err;
>   	}
