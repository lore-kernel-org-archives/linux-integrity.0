Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49735 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbdKZOM1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 09:12:27 -0500
Date: Sun, 26 Nov 2017 16:12:20 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171126141220.kv6efqoxkqjq3273@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <600d6778-f155-ea51-64dc-e0041c6943d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <600d6778-f155-ea51-64dc-e0041c6943d3@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 22, 2017 at 10:26:24AM +0100, Javier Martinez Canillas wrote:
> On 11/21/2017 09:29 PM, Roberts, William C wrote:
> 
> [snip]
> 
> >>>
> >>> Do you agree with Jason's suggestion to send a synthesized TPM command
> >>> in the that the command isn't supported?
> >>
> >> Nope.
> > 
> > We should update the elf loader to make sure that ELF files don't contain
> > Incorrect instructions. We shouldn't have this type of policy in the driver
> > considering that the tpm is designed to handle it. Obviously you disagree,
> > just understand you're wrong :-P
> > 
> 
> I think the sandbox is correct and makes sense to only send well constructed
> commands to the TPM. So my RFC patch breaking the sandbox is clearly wrong.
> 
> I still do believe that both interfaces (/dev/tpm and /dev/tpmrm) should be
> consistent if possible though. In other words, I don't see the value of not
> behaving as expected by the spec if this doesn't have security implications
> as is the case with the approach suggested by Jason. And the implementation
> for sending the synthesized response is also trivial.
> 
> The other option that's fixing this in user-space will be a workaround, since
> it would either be to check for TPM_RC_SUCCESS instead of TPM_RC_COMMAND_CODE
> or make the SAPI library infer that a -EINVAL error means that a command isn't
> supported and return a TPM_RC_COMMAND_CODE to the caller.
> 
> For completeness, I'll share my patch implementing what Jason suggested, even
> when is quite likely that Jarkko won't like it since he has a strong opinion
> on this:

I apologize for long delay. I have this enormous upstreaming project on
my shoulders [1], which will temporarily cause more delay for TPM but
things will settle once it is pulled to the mainline.

I'll go through the patch within next few days.

[1] https://lkml.org/lkml/2017/11/25/123

/Jarkko

> From 145b6891a68b32ae803a4b0abd3d35679ed6b2a1 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javierm@redhat.com>
> Date: Tue, 21 Nov 2017 12:32:15 +0100
> Subject: [RFCv2 PATCH] tpm: return a TPM_RC_COMMAND_CODE response if command
>  isn't implemented
> 
> According to the TPM Library Specification, a TPM device must do a command
> header validation before processing and return a TPM_RC_COMMAND_CODE code
> if the command is not implemented.
> 
> So user-space will expect to handle the response cods as error. But if the
> in-kernel resource manager is used (/dev/tpmrm?), an -EINVAL errno code is
> returned instead if the command isn't implemented. This confuses userspace
> since it doesn't expect that error value.
> 
> This also isn't consistent with the behavior when not using TPM spaces and
> accessing the TPM directly (/dev/tpm?). In this case, the command is sent
> to the TPM even when implemented and userspace gets an error from the TPM.
> 
> Instead of returning an -EINVAL errno code when the tpm_validate_command()
> function fails, synthesize a TPM command response so userspace can get a
> TPM_RC_COMMAND_CODE as expected when a chip doesn't implement the command.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> 
> Changes since RFCv1:
> - Don't send not validated commands to the TPM, instead return a synthesized
>   response with the correct TPM return code (suggested by Jason Gunthorpe).
> 
>  drivers/char/tpm/tpm-interface.c | 28 ++++++++++++++++++++--------
>  drivers/char/tpm/tpm.h           |  1 +
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index ebe0a1d36d8c..b8d01897c0ba 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -328,7 +328,7 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip,
>  }
>  EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
>  
> -static bool tpm_validate_command(struct tpm_chip *chip,
> +static int tpm_validate_command(struct tpm_chip *chip,
>  				 struct tpm_space *space,
>  				 const u8 *cmd,
>  				 size_t len)
> @@ -340,10 +340,10 @@ static bool tpm_validate_command(struct tpm_chip *chip,
>  	unsigned int nr_handles;
>  
>  	if (len < TPM_HEADER_SIZE)
> -		return false;
> +		return -EINVAL;
>  
>  	if (!space)
> -		return true;
> +		return 0;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
>  		cc = be32_to_cpu(header->ordinal);
> @@ -352,7 +352,7 @@ static bool tpm_validate_command(struct tpm_chip *chip,
>  		if (i < 0) {
>  			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
>  				cc);
> -			return false;
> +			return -EOPNOTSUPP;
>  		}
>  
>  		attrs = chip->cc_attrs_tbl[i];
> @@ -362,11 +362,11 @@ static bool tpm_validate_command(struct tpm_chip *chip,
>  			goto err_len;
>  	}
>  
> -	return true;
> +	return 0;
>  err_len:
>  	dev_dbg(&chip->dev,
>  		"%s: insufficient command length %zu", __func__, len);
> -	return false;
> +	return -EINVAL;
>  }
>  
>  /**
> @@ -391,8 +391,20 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	unsigned long stop;
>  	bool need_locality;
>  
> -	if (!tpm_validate_command(chip, space, buf, bufsiz))
> -		return -EINVAL;
> +	rc = tpm_validate_command(chip, space, buf, bufsiz);
> +	if (rc == -EINVAL)
> +		return rc;
> +	/*
> +	 * If the command is not implemented by the TPM, synthesize a
> +	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> +	 */
> +	if (rc == -EOPNOTSUPP) {
> +		header->length = cpu_to_be32(sizeof(*header));
> +		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE);
> +
> +		return bufsiz;
> +	}
>  
>  	if (bufsiz > TPM_BUFSIZE)
>  		bufsiz = TPM_BUFSIZE;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index c1866cc02e30..40818fa59b05 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -100,6 +100,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_HANDLE		= 0x008B,
>  	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
>  	TPM2_RC_DISABLED	= 0x0120,
> +	TPM2_RC_COMMAND_CODE    = 0x0143,
>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	= 0x0910,
>  };
> -- 
> 2.14.3
