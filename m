Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56210 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdKTXPc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 18:15:32 -0500
Date: Tue, 21 Nov 2017 01:15:12 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117100724.19257-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 17, 2017 at 11:07:24AM +0100, Javier Martinez Canillas wrote:
> According to the TPM Library Specification, a TPM device must do a command
> header validation before processing and return a TPM_RC_COMMAND_CODE code
> if the command is not implemented and the TPM_RC_COMMAND_SIZE code if the
> command buffer size is not correct.
> 
> So user-space will expect to handle these response codes as errors, but if
> the in-kernel resource manager is used (/dev/tpmrm?) then an -EINVAL errno
> code is returned instead if the command isn't implemented or the buffer
> size isn't correct. This confuses user-space since doesn't expect that.
> 
> This is also not consistent with the behavior when not using TPM spaces
> and accessing the TPM directly (/dev/tpm?), in this case the command is
> is sent to the TPM anyways and user-space can get an error from the TPM.
> 
> Instead of returning an -EINVAL errno code when the tpm_validate_command()
> function fails, allow the command to be sent to the TPM but just don't do
> any TPM space management. That way the TPM can report back a proper error
> and the behavior be consistent when using either /dev/tpm? or /dev/tpmrm?.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

It is not a virtual TPM so I don't think that matters. It at least
matters less than breaking the sandbox.

/Jarkko
