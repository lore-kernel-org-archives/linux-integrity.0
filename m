Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:19748 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbdJWNnB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:43:01 -0400
Date: Mon, 23 Oct 2017 15:42:57 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] xen-tpmfront: Use common error handling code in
 vtpm_send()
Message-ID: <20171023134257.txnpbg5c5z7uaquf@linux.intel.com>
References: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
 <9cfcbfd0-75c3-4de5-f735-0ace23d2abcb@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9cfcbfd0-75c3-4de5-f735-0ace23d2abcb@users.sourceforge.net>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 22, 2017 at 01:29:33PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Oct 2017 12:56:42 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/char/tpm/xen-tpmfront.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 656e8af95d52..873a5631937a 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -90,10 +90,8 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  
>  	/* Wait for completion of any existing command or cancellation */
>  	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, chip->timeout_c,
> -			&priv->read_queue, true) < 0) {
> -		vtpm_cancel(chip);
> -		return -ETIME;
> -	}
> +			      &priv->read_queue, true) < 0)
> +		goto cancel_vtpm;
>  
>  	memcpy(offset + (u8 *)shr, buf, count);
>  	shr->length = count;
> @@ -108,11 +106,14 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>  	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
>  			&priv->read_queue, true) < 0) {
>  		/* got a signal or timeout, try to cancel */
> -		vtpm_cancel(chip);
> -		return -ETIME;
> +		goto cancel_vtpm;
>  	}
>  
>  	return count;
> +
> +cancel_vtpm:
> +	vtpm_cancel(chip);
> +	return -ETIME;
>  }
>  
>  static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> -- 
> 2.14.2
> 

NAK

/Jarkko
