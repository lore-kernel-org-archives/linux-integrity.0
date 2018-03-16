Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15654 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeCPOaC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 10:30:02 -0400
Date: Fri, 16 Mar 2018 16:29:58 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Should we handle TPM_RC_RETRY internally?
Message-ID: <20180316142958.GD9616@linux.intel.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1521136931.5348.76.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:02:11AM -0700, James Bottomley wrote:
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
> James

I think I agree but what worries me is that this error code is almost not
documented at all in TCG specifications.

/Jarkko
