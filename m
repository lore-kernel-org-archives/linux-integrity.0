Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754234AbeBPIeK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 03:34:10 -0500
Date: Fri, 16 Feb 2018 10:34:06 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: fix selftest failure regression
Message-ID: <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
References: <1518122886.21828.20.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518122886.21828.20.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi

See the comments below and please include this as a prequel patch for
the next version:

https://patchwork.kernel.org/patch/10208965/

On Thu, Feb 08, 2018 at 12:48:06PM -0800, James Bottomley wrote:
> From 8f147e6a9a8e08433d6c1836afbf030598d26e9e Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Thu, 8 Feb 2018 12:33:47 -0800
> Subject: [PATCH] tpm: fix intermittent failure with self tests
> 
> Ever since
> 
> commit 2482b1bba5122b1d5516c909832bdd282015b8e9
> Author: Alexander Steffen <Alexander.Steffen@infineon.com>
> Date:   Thu Aug 31 19:18:56 2017 +0200
> 
>     tpm: Trigger only missing TPM 2.0 self tests
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to
> work (necessitating a reboot). The problem seems to be that the TPM
> gets into a state where the partial self-test doesn't return
> TPM_RC_SUCCESS (meaning all tests have run to completion), but instead
> returns TPM_RC_TESTING (meaning some tests are still running in the
> background).  There are various theories that resending the self-test
> command actually causes the tests to restart and thus triggers more
> TPM_RC_TESTING returns until the timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down
> the boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that
> have passed and if it gets a failure return TPM_RC_FAILURE to every
> subsequent command.  So the fix is to kick off self tests once and if
> they return TPM_RC_TESTING log that as a backgrounded self test and
> continue on.  In order to prevent userspace from seeing any
> TPM_RC_TESTING returns (which it might if userspace sends a command
> that needs a TPM subsystem which is still under test), we loop in
> tpm_transmit_cmd until either a timeout or we don't get a
> TPM_RC_TESTING return.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: 2482b1bba5122b1d5516c909832bdd282015b8e9
> ---
>  drivers/char/tpm/tpm-interface.c | 28 ++++++++++++++++++++++++----
>  drivers/char/tpm/tpm.h           |  1 +
>  drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++--------------------
>  3 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 3cec403a80b3..c3e6d0248af8 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -521,12 +521,32 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>  	const struct tpm_output_header *header = buf;
>  	int err;
>  	ssize_t len;
> +	unsigned int delay_msec = 20;
>  
> -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> -	if (len <  0)
> -		return len;
> +	/*
> +	 * on first probe we kick off a TPM self test in the
> +	 * background This means the TPM may return RC_TESTING to any
> +	 * command that tries to use a subsystem under test, so do an
> +	 * exponential backoff wait if that happens
> +	 */
> +	for (;;) {
> +		len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> +		if (len <  0)
> +			return len;
> +
> +		err = be32_to_cpu(header->return_code);
> +		if (err != TPM2_RC_TESTING ||
> +		    (flags & TPM_TRANSMIT_NOWAIT))
> +			break;
> +
> +		delay_msec *= 2;
> +		if (delay_msec > TPM2_DURATION_LONG) {
> +			dev_err(&chip->dev,"TPM: still running self tests, giving up waiting\n");
> +			break;
> +		}
> +		tpm_msleep(delay_msec);
> +	}

Please have a helper function for this.

>  
> -	err = be32_to_cpu(header->return_code);
>  	if (err != 0 && desc)
>  		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
>  			desc);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 528cffbd49d3..47c5a5206325 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -495,6 +495,7 @@ extern struct idr dev_nums_idr;
>  enum tpm_transmit_flags {
>  	TPM_TRANSMIT_UNLOCKED	= BIT(0),
>  	TPM_TRANSMIT_RAW	= BIT(1),
> +	TPM_TRANSMIT_NOWAIT	= BIT(2),

Note to myself: TPM_TRANSMIT_RAW is a retarded name that does not mean
anything. That should be renamed simply as TPM_TRANSMIT_IGNORE_LOCALITY.

It is really hard to interpret what TPM_TRANSMIT_NOWAIT means. Please
just name it as TPM_TRANSMIT_IGNORE_TESTING or propose something
better. I think that name makes it obvious what the flag means.

>  };
>  
>  ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index f6be08483ae6..169232179182 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -853,28 +853,24 @@ static const struct tpm_input_header tpm2_selftest_header = {
>  static int tpm2_do_selftest(struct tpm_chip *chip)
>  {
>  	int rc;
> -	unsigned int delay_msec = 20;
> -	long duration;
>  	struct tpm2_cmd cmd;
>  
> -	duration = jiffies_to_msecs(
> -		tpm2_calc_ordinal_duration(chip, TPM2_CC_SELF_TEST));
> -
> -	while (duration > 0) {
> -		cmd.header.in = tpm2_selftest_header;
> -		cmd.params.selftest_in.full_test = 0;
> -
> -		rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
> -				      0, 0, "continue selftest");
> -
> -		if (rc != TPM2_RC_TESTING)
> -			break;
> -
> -		tpm_msleep(delay_msec);
> -		duration -= delay_msec;
> -
> -		/* wait longer the next round */
> -		delay_msec *= 2;
> +	cmd.header.in = tpm2_selftest_header;
> +	cmd.params.selftest_in.full_test = 0;
> +
> +	rc = tpm_transmit_cmd(chip, NULL, &cmd, TPM2_SELF_TEST_IN_SIZE,
> +			      0, TPM_TRANSMIT_NOWAIT, "continue selftest");
> +
> +	if (rc == TPM2_RC_TESTING) {
> +		/*
> +		 * A return of RC_TESTING means the TPM is still
> +		 * running self tests.  If one fails it will go into
> +		 * failure mode and return RC_FAILED to every command,
> +		 * so treat a still in testing return as a success
> +		 * rather than causing a driver detach.
> +		 */
> +		dev_info(&chip->dev,"TPM: Running self test in background\n");
> +		rc = TPM2_RC_SUCCESS;
>  	}
>  
>  	return rc;

I'm not sure how tpm_write() call path is handled.

/Jarkko
