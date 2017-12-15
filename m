Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26706 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756353AbdLONsC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 08:48:02 -0500
Date: Fri, 15 Dec 2017 15:47:42 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: pmenzel@molgen.mpg.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm2-cmd: allow more attempts for selftest execution
Message-ID: <20171215134742.r7yqind4kynh3uay@linux.intel.com>
References: <20171211160525.10576-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171211160525.10576-1-Alexander.Steffen@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Dec 11, 2017 at 05:05:25PM +0100, Alexander Steffen wrote:
> Previously, if the last attempt to execute the selftest command failed with
> RC_TESTING, there was still a call to tpm_msleep, even though no further
> attempt would be made. This causes an unnecessary delay, therefore ensure
> that if the last attempt fails the function is left immediately.
> 
> Also, instead of ensuring that the cumulated runtime of all attempts is
> larger than the command duration for TPM2_SelfTest, ensure that there is at
> least one attempt for which the delay is larger than the expected command
> duration. This allows slow TPMs to execute all their tests in the
> background, without slowing down faster TPMs that have finished their tests
> earlier. If tests are still not finished even with this long delay, then
> something is broken and the TPM is not used.
> 
> Fixes: 125a22105410 ("tpm: React correctly to RC_TESTING from TPM 2.0 self
> tests")
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index f40d206..c17e753 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -849,28 +849,26 @@ static const struct tpm_input_header tpm2_selftest_header = {
>  static int tpm2_do_selftest(struct tpm_chip *chip)
>  {
>  	int rc;
> -	unsigned int delay_msec = 20;
> +	unsigned int delay_msec = 10;
>  	long duration;
>  	struct tpm2_cmd cmd;
>  
>  	duration = jiffies_to_msecs(
>  		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
>  
> -	while (duration > 0) {
> +	while (1) {
>  		cmd.header.in = tpm2_selftest_header;
>  		cmd.params.selftest_in.full_test = 0;
>  
>  		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
>  				      0, 0, "continue selftest");
>  
> -		if (rc != TPM2_RC_TESTING)
> +		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
>  			break;
>  
> -		tpm_msleep(delay_msec);
> -		duration -= delay_msec;
> -
> -		/* wait longer the next round */
> +		/* wait longer than before */
>  		delay_msec *= 2;
> +		tpm_msleep(delay_msec);
>  	}
>  
>  	return rc;
> -- 
> 2.7.4
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
