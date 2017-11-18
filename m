Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42353 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162280AbdKRAxw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 19:53:52 -0500
Received: by mail-wr0-f169.google.com with SMTP id o14so3489253wrf.9
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 16:53:52 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jason Gunthorpe <jgg@ziepe.ca>,
        "Roberts, William C" <william.c.roberts@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
 <53b319e3-d46c-dfc7-7024-88a448be7d72@redhat.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BEC48@ORSMSX115.amr.corp.intel.com>
 <20171117235526.GX4276@ziepe.ca>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <f77f3fa3-94ed-40fe-228b-b24dd5539754@redhat.com>
Date: Sat, 18 Nov 2017 01:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171117235526.GX4276@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/18/2017 12:55 AM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2017 at 07:14:21PM +0000, Roberts, William C wrote:
> 
>> I don't know why spaces would filter by command code. But it does
>> seem to be loaded By getting the command codes from the tpm in
>> tpm2_get_tpm_pt().
> 
> Ah, I forgot. So my remark is not quite right :\
> 

Right, so it seems I didn't completely misunderstand the code after all :)

>> I don't think that it's the right fix. I don't think the in-kernel
>> RM should be filtering, but please enlighten my ignorance. Phillip
>> did the userspace RM and understand the RM issues way better than I.
> 
> It needs to prevent unauthorized stuff from being sent to the TPM, so
> if the kernel does not know how to parse the command it shouldn't send
> it. It is a matter of security..
>

What I fail to understand is why that's not a problem when the TPM spaces
infrastructure isn't used, tpm_validate_command() function just returns
true if space is NULL. So when sending command to /dev/tpm0 directly, a
rogue user-space program can send any arbitrary data to the TPM.

And also according to the TCG spec, the TPM should validate the command
header before it attempts to process the command.

> I can't remember if we synthezied responses for anything else, it
> could make sense to return the usual not supported command response
> for this specific thing. But the length error should remain EINVAL I
> think..
>
> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
