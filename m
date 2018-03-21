Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41418 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751656AbeCUS0k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Mar 2018 14:26:40 -0400
Message-ID: <1521656797.6397.13.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add retry logic
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Wed, 21 Mar 2018 11:26:37 -0700
In-Reply-To: <20180319211727.GC14364@linux.intel.com>
References: <1521249754.12827.7.camel@HansenPartnership.com>
         <20180319211727.GC14364@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-19 at 23:17 +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 16, 2018 at 06:22:34PM -0700, James Bottomley wrote:
> > 
> > TPM2 can return TPM2_RC_RETRY to any command and when it does we
> > get
> > unexpected failures inside the kernel that surprise users (this is
> > mostly observed in the trusted key handling code).  The UEFI 2.6
> > spec
> > has advice on how to handle this:
> > 
> >     The firmware SHALL not return TPM2_RC_RETRY prior to the
> > completion
> >     of the call to ExitBootServices().
> > 
> >     Implementer's Note: the implementation of this function should
> > check
> >     the return value in the TPM response and, if it is
> > TPM2_RC_RETRY,
> >     resend the command. The implementation may abort if a
> > sufficient
> >     number of retries has been done.
> 
> When does TPM decide to send this code anyway? TCG specifications do
> not cover this too well, which makes the whole review process quite
> staggering.
> 
> "the TPM was not able to start the command" is essentially a
> tautology... I wonder who came up with such a bad description.
> 
> > 
> > So we follow that advice in our tpm_transmit() code using
> > TPM2_DURATION_SHORT as the initial wait duration and
> > TPM2_DURATION_LONG as the maximum wait time.  This should fix all
> > the
> > in-kernel use cases and also means that user space TSS
> > implementations
> > don't have to have their own retry handling.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > Cc: stable@vger.kernel.org
> 
> Didn't look at this before responding to your previous email. This
> should be a separate commit before the self test change I guess.
> 
> Maybe we could:
> 
> 1. Create a two patch patch set and check that it applies cleanly
>    to my tree.
> 2.

OK, I've built a two patch series on your tree with the original "tpm:
fix intermittent failure with self tests" patch removed and created a
new version of it based on the working retry logic.

I'll send it as a proper two sequence patch set.

James
