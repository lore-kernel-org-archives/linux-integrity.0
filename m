Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:41237 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdKQR4M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 12:56:12 -0500
Received: by mail-wm0-f51.google.com with SMTP id b189so8082379wmd.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Nov 2017 09:56:12 -0800 (PST)
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
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
Date: Fri, 17 Nov 2017 18:56:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171117165742.GH4276@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jason,

Thanks a lot for your feedback.

On 11/17/2017 05:57 PM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2017 at 11:07:24AM +0100, Javier Martinez Canillas wrote:
>  
>> This patch is an RFC because I'm not sure if this is the correct way to fix this
>> issue. I'm not that familiar with the TPM driver so may had missed some details.
>>
>> And example of user-space getting confused by the TPM chardev returning -EINVAL
>> when sending a not supported TPM command can be seen in this tpm2-tools issue:
>>
>> https://github.com/intel/tpm2-tools/issues/621
> 
> I think this is a user space bug, unfortunately.
>

No worries, as mentioned I posted this RFC mostly to raise awareness of the
issue and to get feedback on how it could be properly solved.
 
> We talked about this when the spaces code was first written and it
> seemed the best was to just return EINVAL to indicate that the kernel
> could not accept the request.
> 
> This result is semantically different from the TPM could not execute
> or complete the request.
>

Yes, the problem with that is user-space not having enough information about
what went wrong. Right now the TCTI layer just reports TSS2_BASE_RC_IO_ERROR
in this case and can't be blamed.

Maybe Philip can comment how this could be handled in user-space since he has
a much better understanding of the TCTI and SAPI layers.

> Regarding your specific issue, can you make the command you want to
> use validate? Would that make sense?
>

Sorry, I'm not sure to understand what you meant. Could you please elaborate?
 
Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
