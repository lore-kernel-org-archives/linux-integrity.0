Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45079 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKUJHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 04:07:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so1676258wme.4
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 01:07:36 -0800 (PST)
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
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
Date: Tue, 21 Nov 2017 10:07:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jarkko,

On 11/21/2017 12:15 AM, Jarkko Sakkinen wrote:
> On Fri, Nov 17, 2017 at 11:07:24AM +0100, Javier Martinez Canillas wrote:
>> According to the TPM Library Specification, a TPM device must do a command
>> header validation before processing and return a TPM_RC_COMMAND_CODE code
>> if the command is not implemented and the TPM_RC_COMMAND_SIZE code if the
>> command buffer size is not correct.
>>
>> So user-space will expect to handle these response codes as errors, but if
>> the in-kernel resource manager is used (/dev/tpmrm?) then an -EINVAL errno
>> code is returned instead if the command isn't implemented or the buffer
>> size isn't correct. This confuses user-space since doesn't expect that.
>>
>> This is also not consistent with the behavior when not using TPM spaces
>> and accessing the TPM directly (/dev/tpm?), in this case the command is
>> is sent to the TPM anyways and user-space can get an error from the TPM.
>>
>> Instead of returning an -EINVAL errno code when the tpm_validate_command()
>> function fails, allow the command to be sent to the TPM but just don't do
>> any TPM space management. That way the TPM can report back a proper error
>> and the behavior be consistent when using either /dev/tpm? or /dev/tpmrm?.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> It is not a virtual TPM so I don't think that matters. It at least

As mentioned, I think this should be documented. I guess most people
would see the in-kernel resource manager as a virtualized TPM, since
the "TSS TAB and Resource Manager Specification" [0] explains the RM
making an analogy with a virtual memory manager: 

"The Resource Manager (RM) manages the TPM context in a manner similar
to a virtual memory manager. It swaps objects, sessions, and sequences
in and out of the limited TPM memory as needed."

And even your latest LPC presentation mention that the handles in the
in-kernel resource manager are virtualized [1].

And I disagree that it does not matter, since the same spec says:

"This layer is mostly transparent to the upper layers of the TSS and is
not required."

But returning -EINVAL instead of a proper TPM command response with a
TPM_RC_COMMAND_CODE code makes it not transparent to the upper layer.

If the TPM spaces infrastructure is not compliant with the spec, then I
think that should also be documented.

> matters less than breaking the sandbox.
>

Yes, sorry for that. It wasn't clear to me that there was a sandbox and my
lack of familiarity with the code was the reason why I posted as a RFC in
the first place.

Do you agree with Jason's suggestion to send a synthesized TPM command in
the that the command isn't supported?

> /Jarkko
>

[0]: https://www.trustedcomputinggroup.org/wp-content/uploads/TSS-TAB-and-Resource-Manager-00-91-PublicReview.pdf
[1]: http://linuxplumbersconf.com/2017/ocw//system/presentations/4818/original/TPM2-kernel-evnet-app_tricca-sakkinen.pdf

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
