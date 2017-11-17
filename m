Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34837 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdKQSRj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 13:17:39 -0500
Received: by mail-wr0-f174.google.com with SMTP id w95so2856212wrc.2
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 10:17:39 -0800 (PST)
Date: Fri, 17 Nov 2017 11:17:34 -0700
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
Message-ID: <20171117181734.GM4276@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 17, 2017 at 07:10:09PM +0100, Javier Martinez Canillas wrote:

> Right, that's what I understood indeed but wanted to be sure. The problem with
> that approach is that would not scale.
> 
> Since this particular TPM2 doesn't have support for the TPM2_EncryptDecrypt2
> command, but some chips may not support others commands.

No, tpm_validate is not supposed to be sensitive to what commands the
TPM supports. It is only supposed to check if the command passed is
fully understood by the kernel and is properly formed.

This is to prevent rouge user space from sending garbage or privileged
commands to the TPM.

If it is refusing TPM2_EncryptDecrypt2, and that command is safe to
use in the spaces system, then tpm_validate must learn how to handle
it, or userspace can never use it.

Jason
