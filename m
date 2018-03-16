Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48768 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965129AbeCPPs1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 11:48:27 -0400
Message-ID: <1521215304.4379.8.camel@HansenPartnership.com>
Subject: Re: Should we handle TPM_RC_RETRY internally?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date: Fri, 16 Mar 2018 08:48:24 -0700
In-Reply-To: <20180316142958.GD9616@linux.intel.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
         <20180316142958.GD9616@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-16 at 16:29 +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 15, 2018 at 11:02:11AM -0700, James Bottomley wrote:
> > 
> > I was investigating an apparent bug in the trusted keys
> > implementation where periodically the key operation barfs and
> > returns an error to userspace.  It turns out this error is because
> > the TPM returns TPM_RC_RETRY to an operation.
> > 
> > The TPM spec is a bit unclear why the TPM would return
> > TPM_RC_RETRY, but it is clear that it may happen on a lot of
> > operations.  I checked with the microsoft reference implementation:
> > 
> > https://github.com/Microsoft/ms-tpm-20-ref/
> > 
> > Which implies it's only set if the lockout check is invoked by the
> > command and the previous TPM shutdown wasn't orderly.  It does seem
> > to me that I've only seen it involving objects with DA
> > implications, which explains why it's seen in trusted keys.
> > 
> > If I read the UEFI TPM API, it does automatic retries.  This is the
> > note:
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
> > 
> > I really think if UEFI does it, we should do it too (and it will
> > fix my trusted key bug).
> > 
> > What does everyone else think?  If it's agreed, I'll code up the
> > patch.
> > 
> > James
> 
> I think I agree but what worries me is that this error code is almost
> not documented at all in TCG specifications.

Yes, it's cryptic, it just says "the TPM was not able to start the
command", which is why I checked the reference implementation.  I think
the UEFI ref is the clearest because it provides implementation
guidance (basically to retry the command until timeout) which I see no
reason we can't follow in the kernel.

The alternative is that we handle it in the TSS and I have to patch
trusted keys.  However none of the core TPM routines that use
tpm_transmit_cmd() have any retry logic, so if we find a TPM that
returns it to a kernel sent command we'll get random unexplained
failures (based on the ref implementation I don't think this is likely,
but by the spec it's possible, especially for a manufacturer who isn't
using the reference), so we may end up having to add retry logic to
every place in the kernel where we use tpm_transmit_cmd() ... then
we'll wish we'd done it generically inside that routine.

Based on this, I think the UEFI spec gives us the safety of knowing
that internal handling is correct and the advantages of doing so now
are that we don't get a potentially exploding problem later, so it
seems like a net win.  I'll code up a patch.

James
