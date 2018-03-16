Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53690 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeCPKgc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 06:36:32 -0400
Received: by mail-wm0-f53.google.com with SMTP id e194so2117787wmd.3
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 03:36:31 -0700 (PDT)
Subject: Re: Should we handle TPM_RC_RETRY internally?
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <eaa8e31f-62cb-dcf0-a27f-87d993d2f3e4@redhat.com>
Date: Fri, 16 Mar 2018 11:36:28 +0100
MIME-Version: 1.0
In-Reply-To: <1521136931.5348.76.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[adding Philip Tricca to the cc list]

Hello James,

On 03/15/2018 07:02 PM, James Bottomley wrote:
> I was investigating an apparent bug in the trusted keys implementation
> where periodically the key operation barfs and returns an error to
> userspace.  It turns out this error is because the TPM returns
> TPM_RC_RETRY to an operation.
> 
> The TPM spec is a bit unclear why the TPM would return TPM_RC_RETRY,
> but it is clear that it may happen on a lot of operations.  I checked
> with the microsoft reference implementation:
> 
> https://github.com/Microsoft/ms-tpm-20-ref/
> 
> Which implies it's only set if the lockout check is invoked by the
> command and the previous TPM shutdown wasn't orderly.  It does seem to
> me that I've only seen it involving objects with DA implications, which
> explains why it's seen in trusted keys.
> 
> If I read the UEFI TPM API, it does automatic retries.  This is the
> note:
> 
>     The firmware SHALL not return TPM2_RC_RETRY prior to the completion
>     of the call to ExitBootServices().
> 
>     Implementer's Note: the implementation of this function should check
>     the return value in the TPM response and, if it is TPM2_RC_RETRY,
>     resend the command. The implementation may abort if a sufficient
>     number of retries has been done.
> 
> I really think if UEFI does it, we should do it too (and it will fix my
> trusted key bug).
> 
> What does everyone else think?  If it's agreed, I'll code up the patch.
> 

That's a very good question. I don't know the answer but maybe Philip does
since he said that would ask the TCG TSS WG members for their thoughts on
this [0].

We had the same issue in the tpm2-software project, and at the end Philip
added a macro that retries sending commands on TPM_RC_RETRY responses [1].

If the kernel handles this, then such a macro won't be needed anymore for
user-space programs and will simplify things. So I'm in favour to handle
at the driver level but I'm not sure if is the correct thing to do or not.

> James
> 

[0]: https://github.com/tpm2-software/tpm2-tools/issues/469#issuecomment-340501128
[1]: https://github.com/tpm2-software/tpm2-tools/pull/585/commits/9b0f3e59bab0810cf3721bf6765bd083f23f811f

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
