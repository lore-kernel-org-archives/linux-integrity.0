Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41018 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdKUMt0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 07:49:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so3137324wmd.0
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 04:49:25 -0800 (PST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
Date: Tue, 21 Nov 2017 13:49:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/21/2017 01:30 PM, Jarkko Sakkinen wrote:
> On Tue, Nov 21, 2017 at 10:07:34AM +0100, Javier Martinez Canillas wrote:
>> As mentioned, I think this should be documented. I guess most people
>> would see the in-kernel resource manager as a virtualized TPM, since
>> the "TSS TAB and Resource Manager Specification" [0] explains the RM
>> making an analogy with a virtual memory manager: 
>>
>> "The Resource Manager (RM) manages the TPM context in a manner similar
>> to a virtual memory manager. It swaps objects, sessions, and sequences
>> in and out of the limited TPM memory as needed."
> 
> A process in virtual memory has a different environment than code
> running on bare metal without page table, doesn't it?
> 
>> And even your latest LPC presentation mention that the handles in the
>> in-kernel resource manager are virtualized [1].
>>
>> And I disagree that it does not matter, since the same spec says:
>>
>> "This layer is mostly transparent to the upper layers of the TSS and is
>> not required."
>>
>> But returning -EINVAL instead of a proper TPM command response with a
>> TPM_RC_COMMAND_CODE code makes it not transparent to the upper layer.
> 
> *mostly*
>

Fair enough.
 
>> If the TPM spaces infrastructure is not compliant with the spec, then I
>> think that should also be documented.
> 
> TPM specification is not a formal specification AFAIK.
> 
>>> matters less than breaking the sandbox.
>>>
>>
>> Yes, sorry for that. It wasn't clear to me that there was a sandbox and my
>> lack of familiarity with the code was the reason why I posted as a RFC in
>> the first place.
>>
>> Do you agree with Jason's suggestion to send a synthesized TPM command in
>> the that the command isn't supported?
> 
> Nope.
>

Ok. Thanks a lot for your feedback. I already had that patch but didn't want
to post it before knowing your opinion, I'll drop it now.

Philip,

I think this means that we can now fix this in user-space then? That was in
fact my first suggestion in the filed tpm2-tools issue.
 
> /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
