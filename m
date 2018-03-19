Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:23764 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031318AbeCSVRb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 17:17:31 -0400
Date: Mon, 19 Mar 2018 23:17:27 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm: add retry logic
Message-ID: <20180319211727.GC14364@linux.intel.com>
References: <1521249754.12827.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1521249754.12827.7.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Mar 16, 2018 at 06:22:34PM -0700, James Bottomley wrote:
> TPM2 can return TPM2_RC_RETRY to any command and when it does we get
> unexpected failures inside the kernel that surprise users (this is
> mostly observed in the trusted key handling code).  The UEFI 2.6 spec
> has advice on how to handle this:
> 
>     The firmware SHALL not return TPM2_RC_RETRY prior to the completion
>     of the call to ExitBootServices().
> 
>     Implementer's Note: the implementation of this function should check
>     the return value in the TPM response and, if it is TPM2_RC_RETRY,
>     resend the command. The implementation may abort if a sufficient
>     number of retries has been done.

When does TPM decide to send this code anyway? TCG specifications do
not cover this too well, which makes the whole review process quite
staggering.

"the TPM was not able to start the command" is essentially a
tautology... I wonder who came up with such a bad description.

> So we follow that advice in our tpm_transmit() code using
> TPM2_DURATION_SHORT as the initial wait duration and
> TPM2_DURATION_LONG as the maximum wait time.  This should fix all the
> in-kernel use cases and also means that user space TSS implementations
> don't have to have their own retry handling.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: stable@vger.kernel.org

Didn't look at this before responding to your previous email. This
should be a separate commit before the self test change I guess.

Maybe we could:

1. Create a two patch patch set and check that it applies cleanly
   to my tree.
2.

> ---
>  drivers/char/tpm/tpm-interface.c | 75 ++++++++++++++++++++++++++++++++--------
>  drivers/char/tpm/tpm.h           |  1 +
>  2 files changed, 61 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 7c3380201960..1d25d1dca2f0 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -398,21 +398,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
>  	chip->locality = -1;
>  }
>  
> -/**
> - * tpm_transmit - Internal kernel interface to transmit TPM commands.
> - *
> - * @chip: TPM chip to use
> - * @space: tpm space
> - * @buf: TPM command buffer
> - * @bufsiz: length of the TPM command buffer
> - * @flags: tpm transmit flags - bitmap
> - *
> - * Return:
> - *     0 when the operation is successful.
> - *     A negative number for system errors (errno).
> - */
> -ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> -		     u8 *buf, size_t bufsiz, unsigned int flags)
> +static ssize_t tpm_transmit_internal(struct tpm_chip *chip,
> +				     struct tpm_space *space,
> +				     u8 *buf, size_t bufsiz,
> +				     unsigned int flags)

I would name this as tpm_try_transmit() because that is what it
exactly is given the existence of TPM_RC_RETRY. It is more exact and
less abstract naming than tpm_transmit_internal() therefore a better
naming.

/Jarkko
