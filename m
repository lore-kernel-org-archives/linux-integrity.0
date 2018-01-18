Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18515 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbeARS1C (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 13:27:02 -0500
Date: Thu, 18 Jan 2018 20:26:57 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: nayna@linux.vnet.ibm.com, kgold@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC][PATCH 6/9] tpm_tis_spi: fix sending wrong data during wait
 state handling
Message-ID: <20180118182657.knnxk25bc2v5cefw@linux.intel.com>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-7-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208184658.9588-7-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 07:46:55PM +0100, Alexander Steffen wrote:
> When the TPM signals wait states, the driver has to repeat the last byte
> until the TPM stops signaling wait states and accepts that byte. It should
> not send a dummy byte, even though that might work with some TPM
> implementations.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm_tis_spi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index c4f511b..2758b41 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -88,9 +88,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  
>  		if ((phy->iobuf[3] & 0x01) == 0) {
>  			// handle SPI wait states
> -			phy->iobuf[0] = 0;
> -
>  			for (i = 0; i < TPM_RETRY; i++) {
> +				phy->iobuf[0] = addr;

Why it has to be moved inside the loop?

/Jarkko
