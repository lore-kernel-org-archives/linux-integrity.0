Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:56629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753029AbdLGQTm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 11:19:42 -0500
Date: Thu, 7 Dec 2017 18:10:12 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] tpm: return a TPM_RC_COMMAND_CODE response if a command
 isn't implemented
Message-ID: <20171207161012.v6fgylopu64t6gik@linux.intel.com>
References: <20171126233012.24528-1-javierm@redhat.com>
 <20171207013216.vdyaxcanpmaecx6p@linux.intel.com>
 <46873f11-a18f-3ab0-c5f0-3d3c5237aa67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46873f11-a18f-3ab0-c5f0-3d3c5237aa67@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Dec 07, 2017 at 09:58:34AM +0100, Javier Martinez Canillas wrote:
> Hello Jarkko,
> 
> On 12/07/2017 02:32 AM, Jarkko Sakkinen wrote:
> > On Mon, Nov 27, 2017 at 12:30:12AM +0100, Javier Martinez Canillas wrote:
> >> According to the TPM Library Specification, a TPM device must do a command
> >> header validation before processing and return a TPM_RC_COMMAND_CODE code
> >> if the command is not implemented.
> >>
> >> So user-space will expect to handle that response as an error. But if the
> >> in-kernel resource manager is used (/dev/tpmrm?), an -EINVAL errno code is
> >> returned instead if the command isn't implemented. This confuses userspace
> >> since it doesn't expect that error value.
> >>
> >> This also isn't consistent with the behavior when not using TPM spaces and
> >> accessing the TPM directly (/dev/tpm?). In this case, the command is sent
> >> to the TPM even when not implemented and the TPM responds with an error.
> >>
> >> Instead of returning an -EINVAL errno code when the tpm_validate_command()
> >> function fails, synthesize a TPM command response so user-space can get a
> >> TPM_RC_COMMAND_CODE as expected when a chip doesn't implement the command.
> >>
> >> The TPM only sets 12 of the 32 bits in the TPM_RC response, so the TSS and
> >> TAB specifications define that higher layers in the stack should use some
> >> of the unused 20 bits to specify from which level of the stack the error
> >> is coming from.
> >>
> >> Since the TPM_RC_COMMAND_CODE response code is sent by the kernel resource
> >> manager, set the error level to the TAB/RM layer so user-space is aware of
> >> this.
> >>
> >> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >>
> >> ---
> >>
> >> Changes since RFCv2:
> >> - Set the error level to the TAB/RM layer so user-space is aware that the error
> >>   is not coming from the TPM (suggested by Philip Tricca and Jarkko Sakkinen).
> >>
> >> Changes since RFCv1:
> >> - Don't pass not validated commands to the TPM, instead return a synthesized
> >>   response with the correct TPM return code (suggested by Jason Gunthorpe).
> >>
> >> And example of user-space getting confused by the TPM chardev returning -EINVAL
> >> when sending a not supported TPM command can be seen in this tpm2-tools issue:
> >>
> >> https://github.com/intel/tpm2-tools/issues/621
> >>
> >> Best regards,
> >> Javier
> >>
> >>  drivers/char/tpm/tpm-interface.c | 28 ++++++++++++++++++++--------
> >>  drivers/char/tpm/tpm.h           |  8 ++++++++
> >>  2 files changed, 28 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> >> index ebe0a1d36d8c..9391811c5f83 100644
> >> --- a/drivers/char/tpm/tpm-interface.c
> >> +++ b/drivers/char/tpm/tpm-interface.c
> >> @@ -328,7 +328,7 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip,
> >>  }
> >>  EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
> >>  
> >> -static bool tpm_validate_command(struct tpm_chip *chip,
> >> +static int tpm_validate_command(struct tpm_chip *chip,
> >>  				 struct tpm_space *space,
> >>  				 const u8 *cmd,
> >>  				 size_t len)
> >> @@ -340,10 +340,10 @@ static bool tpm_validate_command(struct tpm_chip *chip,
> >>  	unsigned int nr_handles;
> >>  
> >>  	if (len < TPM_HEADER_SIZE)
> >> -		return false;
> >> +		return -EINVAL;
> >>  
> >>  	if (!space)
> >> -		return true;
> >> +		return 0;
> >>  
> >>  	if (chip->flags & TPM_CHIP_FLAG_TPM2 && chip->nr_commands) {
> >>  		cc = be32_to_cpu(header->ordinal);
> >> @@ -352,7 +352,7 @@ static bool tpm_validate_command(struct tpm_chip *chip,
> >>  		if (i < 0) {
> >>  			dev_dbg(&chip->dev, "0x%04X is an invalid command\n",
> >>  				cc);
> >> -			return false;
> >> +			return -EOPNOTSUPP;
> >>  		}
> >>  
> >>  		attrs = chip->cc_attrs_tbl[i];
> >> @@ -362,11 +362,11 @@ static bool tpm_validate_command(struct tpm_chip *chip,
> >>  			goto err_len;
> >>  	}
> >>  
> >> -	return true;
> >> +	return 0;
> >>  err_len:
> >>  	dev_dbg(&chip->dev,
> >>  		"%s: insufficient command length %zu", __func__, len);
> >> -	return false;
> >> +	return -EINVAL;
> >>  }
> >>  
> >>  /**
> >> @@ -391,8 +391,20 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> >>  	unsigned long stop;
> >>  	bool need_locality;
> >>  
> >> -	if (!tpm_validate_command(chip, space, buf, bufsiz))
> >> -		return -EINVAL;
> >> +	rc = tpm_validate_command(chip, space, buf, bufsiz);
> >> +	if (rc == -EINVAL)
> >> +		return rc;
> >> +	/*
> >> +	 * If the command is not implemented by the TPM, synthesize a
> >> +	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
> >> +	 */
> >> +	if (rc == -EOPNOTSUPP) {
> >> +		header->length = cpu_to_be32(sizeof(*header));
> >> +		header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> >> +		header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
> >> +						  TPM2_RESMGRTPM_ERROR_LEVEL);
> >> +		return bufsiz;
> >> +	}
> >>  
> >>  	if (bufsiz > TPM_BUFSIZE)
> >>  		bufsiz = TPM_BUFSIZE;
> >> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> >> index c1866cc02e30..b3f9108d3d1f 100644
> >> --- a/drivers/char/tpm/tpm.h
> >> +++ b/drivers/char/tpm/tpm.h
> >> @@ -94,12 +94,20 @@ enum tpm2_structures {
> >>  	TPM2_ST_SESSIONS	= 0x8002,
> >>  };
> >>  
> >> +/* Indicates from what level of the software stack the error comes from */
> >> +#define TPM2_RC_LEVEL_SHIFT	16
> >> +
> >> +#define TPM2_RESMGRTPM_ERROR_LEVEL (11 << TPM2_RC_LEVEL_SHIFT)
> >> +#define TPM2_RESMGR_ERROR_LEVEL    (12 << TPM2_RC_LEVEL_SHIFT)
> >> +#define TPM2_DRIVER_ERROR_LEVEL    (13 << TPM2_RC_LEVEL_SHIFT)
> >> +
> >>  enum tpm2_return_codes {
> >>  	TPM2_RC_SUCCESS		= 0x0000,
> >>  	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
> >>  	TPM2_RC_HANDLE		= 0x008B,
> >>  	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
> >>  	TPM2_RC_DISABLED	= 0x0120,
> >> +	TPM2_RC_COMMAND_CODE    = 0x0143,
> >>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
> >>  	TPM2_RC_REFERENCE_H0	= 0x0910,
> >>  };
> >> -- 
> >> 2.14.3
> >>
> > 
> > Please use next time --subject-prefix="PATCH v3".
> >
> 
> I did. But you are answering to my v1 patch. The v3 can be found here with the
> following subject "[PATCH v3] tpm: return a TPM_RC_COMMAND_CODE response if
> command is not implemented"
> 
> https://patchwork.kernel.org/patch/10084305/
> 
> Probably you got confused because I posted 2 RFCs before posting a proper PATCH
> and then PATCHv3 and v3.
> 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> 
> Thanks! As mentioned this is v1, but I guess it also applies to v3 since the
> only differences are the removal of the unused defines and the naming change
> we discussed.
> 
> > /Jarkko
> > 
> 
> Best regards,
> -- 
> Javier Martinez Canillas
> Software Engineer - Desktop Hardware Enablement
> Red Hat

Anyway, it is landed now.

/Jarkko
