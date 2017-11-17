Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45364 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdKQSKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 13:10:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so8091791wme.4
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 10:10:11 -0800 (PST)
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
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
Date: Fri, 17 Nov 2017 19:10:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171117175834.GK4276@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


On 11/17/2017 06:58 PM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2017 at 06:56:09PM +0100, Javier Martinez Canillas wrote:
> 
>> Yes, the problem with that is user-space not having enough information about
>> what went wrong. Right now the TCTI layer just reports TSS2_BASE_RC_IO_ERROR
>> in this case and can't be blamed.
> 
> Well, if you care about the differnce between a transport failure and
> a kernel rejection due to validation, then it needs to report a
> different code :)
> 

Fair enough, the hard part I guess would be to decide which errno codes to use
that could better map to the actual TPM_RC_COMMAND_{CODE,SIZE} response codes.

I'll give some thought to this and also discuss with the tpm2 tools/tss folks.

>>> Regarding your specific issue, can you make the command you want to
>>> use validate? Would that make sense?
>>
>> Sorry, I'm not sure to understand what you meant. Could you please elaborate?
> 
> Make it so tpm_validate will accept the command being sent.
>

Right, that's what I understood indeed but wanted to be sure. The problem with
that approach is that would not scale.

Since this particular TPM2 doesn't have support for the TPM2_EncryptDecrypt2
command, but some chips may not support others commands. So I rather prefer to
have a consistent way for the kernel to report when a command is found to not
be supported and user-space to understand it.

> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
