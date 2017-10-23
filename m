Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:49057 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbdJWNmH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:42:07 -0400
Date: Mon, 23 Oct 2017 15:42:02 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Use common error handling code in
 tpm_tis_send_data()
Message-ID: <20171023134202.d6td6vvhd7pfv5ue@linux.intel.com>
References: <fb0a6fbb-db2f-ce3f-f1c2-02f934accc4e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb0a6fbb-db2f-ce3f-f1c2-02f934accc4e@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 22, 2017 at 12:16:19PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Oct 2017 11:41:09 +0200
> 
> Add a jump target so that a specific error code assignment for timeout
> conditions will be in the implementation only at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdde971bc810..3681f7a74d1b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -262,12 +262,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	status = tpm_tis_status(chip);
>  	if ((status & TPM_STS_COMMAND_READY) == 0) {
>  		tpm_tis_ready(chip);
> -		if (wait_for_tpm_stat
> -		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> -		     &priv->int_queue, false) < 0) {
> -			rc = -ETIME;
> -			goto out_err;
> -		}
> +		if (wait_for_tpm_stat(chip, TPM_STS_COMMAND_READY,
> +				      chip->timeout_b, &priv->int_queue, false)
> +		    < 0)
> +			goto report_timeout;
>  	}
>  
>  	while (count < len - 1) {
> @@ -286,10 +284,9 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		count += burstcnt;
>  
>  		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -					&priv->int_queue, false) < 0) {
> -			rc = -ETIME;
> -			goto out_err;
> -		}
> +				      &priv->int_queue, false) < 0)
> +			goto report_timeout;
> +
>  		status = tpm_tis_status(chip);
>  		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
>  			rc = -EIO;
> @@ -303,10 +300,9 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  		goto out_err;
>  
>  	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -				&priv->int_queue, false) < 0) {
> -		rc = -ETIME;
> -		goto out_err;
> -	}
> +			      &priv->int_queue, false) < 0)
> +		goto report_timeout;
> +
>  	status = tpm_tis_status(chip);
>  	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
>  		rc = -EIO;
> @@ -315,6 +311,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  
>  	return 0;
>  
> +report_timeout:
> +	rc = -ETIME;
>  out_err:
>  	tpm_tis_ready(chip);
>  	return rc;
> -- 
> 2.14.2
> 

NAK. wait_for_tpm_stat() should give that error code.

/Jarkko
