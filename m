Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33739 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdKQQ5s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 11:57:48 -0500
Received: by mail-wr0-f196.google.com with SMTP id 4so2670556wrt.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 08:57:47 -0800 (PST)
Date: Fri, 17 Nov 2017 09:57:42 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171117165742.GH4276@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117100724.19257-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 17, 2017 at 11:07:24AM +0100, Javier Martinez Canillas wrote:
 
> This patch is an RFC because I'm not sure if this is the correct way to fix this
> issue. I'm not that familiar with the TPM driver so may had missed some details.
> 
> And example of user-space getting confused by the TPM chardev returning -EINVAL
> when sending a not supported TPM command can be seen in this tpm2-tools issue:
> 
> https://github.com/intel/tpm2-tools/issues/621

I think this is a user space bug, unfortunately.

We talked about this when the spaces code was first written and it
seemed the best was to just return EINVAL to indicate that the kernel
could not accept the request.

This result is semantically different from the TPM could not execute
or complete the request.

Regarding your specific issue, can you make the command you want to
use validate? Would that make sense?

> +	/*
> +	 * If command validation fails, sent it to the TPM anyways so it can
> +	 * report a proper error to user-space. Just don't do any TPM space
> +	 * management in this case.
> +	 */
> +	cmd_validated = tpm_validate_command(chip, space, buf, bufsiz);

And sending a command that failed to validate to the TPM cannot be
done, as it violates our security model

Jason
