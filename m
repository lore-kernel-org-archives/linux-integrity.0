Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23728 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754917AbeCVPOG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 11:14:06 -0400
Message-ID: <a220d693c2fc2de660223de76e2279ef2080192b.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] tpm: add retry logic
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Thu, 22 Mar 2018 17:14:02 +0200
In-Reply-To: <1521657828.6397.19.camel@HansenPartnership.com>
References: <1521657747.6397.18.camel@HansenPartnership.com>
         <1521657828.6397.19.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-21 at 11:43 -0700, James Bottomley wrote:
> TPM2 can return TPM2_RC_RETRY to any command and when it does we get
> unexpected failures inside the kernel that surprise users (this is
> mostly observed in the trusted key handling code).  The UEFI 2.6 spec
> has advice on how to handle this:
> 
>     The firmware SHALL not return TPM2_RC_RETRY prior to the completion
>     of the call to ExitBootServices().
> 
>     Implementer's Note: the implementation of this function should check
>     the return value in the TPM response and, if it is TPM2_RC_RETRY,
>     resend the command. The implementation may abort if a sufficient
>     number of retries has been done.
> 
> So we follow that advice in our tpm_transmit() code using
> TPM2_DURATION_SHORT as the initial wait duration and
> TPM2_DURATION_LONG as the maximum wait time.  This should fix all the
> in-kernel use cases and also means that user space TSS implementations
> don't have to have their own retry handling.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
