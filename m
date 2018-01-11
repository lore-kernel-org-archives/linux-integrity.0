Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935624AbeAKTrF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jan 2018 14:47:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0BJhnF5034203
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2018 14:47:04 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fec2s6mk5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2018 14:47:04 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 11 Jan 2018 19:47:02 -0000
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state
 retries
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        kgold@linux.vnet.ibm.com, linux-integrity@vger.kernel.org
Date: Thu, 11 Jan 2018 14:46:58 -0500
In-Reply-To: <20171208184658.9588-9-Alexander.Steffen@infineon.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
         <20171208184658.9588-9-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515700018.3420.13.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Alexander,

On Fri, 2017-12-08 at 19:46 +0100, Alexander Steffen wrote:
> There do not seem to be any real limits one the amount/duration of wait
> states that the TPM is allowed to generate. So at least give the TPM some
> time to clean up the situation that caused the wait states instead of
> retrying the transfers as fast as possible.

Without this patch, the TPM performance on the pi is amazing!  A
thousand extends takes ~6.5 seconds.  Unfortunately, the same thousand
extends with this patch takes > 2+ minutes.  TPM_TIMEOUT (5 msecs) is
a really long time.  Why so long?

Mimi
  

> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_spi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index 2cc6aa9..e53c9c3 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -88,7 +88,7 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> 
>  		if ((phy->iobuf[3] & 0x01) == 0) {
>  			// handle SPI wait states
> -			for (i = 0; i < TPM_RETRY; i++) {
> +			for (i = 1; i <= TPM_RETRY; i++) {
>  				phy->iobuf[0] = addr;
>  				spi_xfer.len = 1;
>  				spi_message_init(&m);
> @@ -98,9 +98,10 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  					goto exit;
>  				if (phy->iobuf[0] & 0x01)
>  					break;
> +				tpm_msleep(i * TPM_TIMEOUT);
>  			}
> 
> -			if (i == TPM_RETRY) {
> +			if (i > TPM_RETRY) {
>  				spi_xfer.tx_buf = NULL;
>  				spi_xfer.rx_buf = NULL;
>  				spi_xfer.len = 0;
