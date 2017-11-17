Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34563 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbdKQSei (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 13:34:38 -0500
Received: by mail-wm0-f48.google.com with SMTP id y82so4341598wmg.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 10:34:37 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
Date: Fri, 17 Nov 2017 19:34:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171117181734.GM4276@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/17/2017 07:17 PM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2017 at 07:10:09PM +0100, Javier Martinez Canillas wrote:
> 
>> Right, that's what I understood indeed but wanted to be sure. The problem with
>> that approach is that would not scale.
>>
>> Since this particular TPM2 doesn't have support for the TPM2_EncryptDecrypt2
>> command, but some chips may not support others commands.
> 
> No, tpm_validate is not supposed to be sensitive to what commands the
> TPM supports. It is only supposed to check if the command passed is
> fully understood by the kernel and is properly formed.
> 
> This is to prevent rouge user space from sending garbage or privileged
> commands to the TPM.
> 
> If it is refusing TPM2_EncryptDecrypt2, and that command is safe to
> use in the spaces system, then tpm_validate must learn how to handle
> it, or userspace can never use it.
>

I see, misunderstood what the check was about then. If that's the case, then
Making tpm_validate to learn how to check that command makes sense indeed
and so does the -EINVAL error code.

Since it doesn't mean that the TPM doesn't support the command but just that
the TPM spaces doesn't know how to handle it.

Need to look at the code in more detail, thanks a lot for the clarification.

> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
