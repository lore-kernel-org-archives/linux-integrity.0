Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:51728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754511AbeCSEg0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 00:36:26 -0400
Date: Sun, 18 Mar 2018 21:40:56 -0700
From: Philip Tricca <philip.b.tricca@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: Should we handle TPM_RC_RETRY internally?
Message-ID: <20180319044056.GD8769@intel.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
 <eaa8e31f-62cb-dcf0-a27f-87d993d2f3e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <eaa8e31f-62cb-dcf0-a27f-87d993d2f3e4@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Mar 16, 2018 at 11:36:28AM +0100, Javier Martinez Canillas wrote:
> [adding Philip Tricca to the cc list]
> 
> Hello James,
> 
> On 03/15/2018 07:02 PM, James Bottomley wrote:
> > I was investigating an apparent bug in the trusted keys implementation
> > where periodically the key operation barfs and returns an error to
> > userspace.  It turns out this error is because the TPM returns
> > TPM_RC_RETRY to an operation.
> > 
> > The TPM spec is a bit unclear why the TPM would return TPM_RC_RETRY,
> > but it is clear that it may happen on a lot of operations.  I checked
> > with the microsoft reference implementation:
> > 
> > https://github.com/Microsoft/ms-tpm-20-ref/
> > 
> > Which implies it's only set if the lockout check is invoked by the
> > command and the previous TPM shutdown wasn't orderly.  It does seem to
> > me that I've only seen it involving objects with DA implications, which
> > explains why it's seen in trusted keys.
> > 
> > If I read the UEFI TPM API, it does automatic retries.  This is the
> > note:
> > 
> >     The firmware SHALL not return TPM2_RC_RETRY prior to the completion
> >     of the call to ExitBootServices().
> > 
> >     Implementer's Note: the implementation of this function should check
> >     the return value in the TPM response and, if it is TPM2_RC_RETRY,
> >     resend the command. The implementation may abort if a sufficient
> >     number of retries has been done.
> > 
> > I really think if UEFI does it, we should do it too (and it will fix my
> > trusted key bug).
> > 
> > What does everyone else think?  If it's agreed, I'll code up the patch.
> > 
> 
> That's a very good question. I don't know the answer but maybe Philip does
> since he said that would ask the TCG TSS WG members for their thoughts on
> this [0].
> 
> We had the same issue in the tpm2-software project, and at the end Philip
> added a macro that retries sending commands on TPM_RC_RETRY responses [1].

We've been using this macro without indicent for some time in
applications using the tss2-sys library. If memory serves I think the
new tss2-esys library handles this internally so from the perspective of
the user space I'd written this issue off as solved.

> If the kernel handles this, then such a macro won't be needed anymore for
> user-space programs and will simplify things. So I'm in favour to handle
> at the driver level but I'm not sure if is the correct thing to do or not.

I can't say for sure but I'd imagine the implications of implementing a
retry loop in the kernel are different than user space. We retry
indefinitely but I would think having some bounded number of retries in
the kernel would be prudent.

Philip
