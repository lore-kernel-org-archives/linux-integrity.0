Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53898 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751269AbeCTGGH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Mar 2018 02:06:07 -0400
Message-ID: <1521525966.5186.42.camel@HansenPartnership.com>
Subject: Re: Should we handle TPM_RC_RETRY internally?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrey Pronin <apronin@chromium.org>
Cc: jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Date: Mon, 19 Mar 2018 23:06:06 -0700
In-Reply-To: <CAP7wa8Kq_++HasQY6bZ9idJ_TDOyXhnRAmyUY6t1B+HZWKF8ig@mail.gmail.com>
References: <1521136931.5348.76.camel@HansenPartnership.com>
         <20180316142958.GD9616@linux.intel.com>
         <1521215304.4379.8.camel@HansenPartnership.com>
         <CAP7wa8Kq_++HasQY6bZ9idJ_TDOyXhnRAmyUY6t1B+HZWKF8ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Your original email is missing from the list because it has a html
part, which vger takes as spam.  You have to send text/plain only to
get email on the list

On Sat, 2018-03-17 at 01:21 +0000, Andrey Pronin wrote:
> On Fri, Mar 16, 2018 at 8:48 AM James Bottomley <
> James.Bottomley@hansenpartnership.com> wrote:
> > 
> > 
> > On Fri, 2018-03-16 at 16:29 +0200, Jarkko Sakkinen wrote:
> > > 
> > > On Thu, Mar 15, 2018 at 11:02:11AM -0700, James Bottomley wrote:
> > > > 
> > > > 
> > > > I was investigating an apparent bug in the trusted keys
> > > > implementation where periodically the key operation barfs and
> > > > returns an error to userspace.  It turns out this error is
> > > > because the TPM returns TPM_RC_RETRY to an operation.
> > > > 
> > > > The TPM spec is a bit unclear why the TPM would return
> > > > TPM_RC_RETRY, but it is clear that it may happen on a lot of
> > > > operations.  I checked with the microsoft reference
> > > > implementation:
> > > > 
> > > > https://github.com/Microsoft/ms-tpm-20-ref/
> > > > 
> > > > Which implies it's only set if the lockout check is invoked by
> > > > the command and the previous TPM shutdown wasn't orderly.  It
> > > > does seem to me that I've only seen it involving objects with
> > > > DA implications, which explains why it's seen in trusted keys.
> > > > 
> > > > If I read the UEFI TPM API, it does automatic retries.  This is
> > > > the note:
> > > > 
> > > >     The firmware SHALL not return TPM2_RC_RETRY prior to the
> > > > completion
> > > >     of the call to ExitBootServices().
> > > > 
> > > >     Implementer's Note: the implementation of this function
> > > > should
> > > > check
> > > >     the return value in the TPM response and, if it is
> > > > TPM2_RC_RETRY,
> > > >     resend the command. The implementation may abort if a
> > > > sufficient
> > > >     number of retries has been done.
> > > > 
> > > > I really think if UEFI does it, we should do it too (and it
> > > > will fix my trusted key bug).
> > > > 
> > > > What does everyone else think?  If it's agreed, I'll code up
> > > > the patch.
> > > > 
> > > > James
> > > 
> > > I think I agree but what worries me is that this error code is
> > > almost not documented at all in TCG specifications.
> > 
> > Yes, it's cryptic, it just says "the TPM was not able to start the
> > command", which is why I checked the reference implementation.  I
> > think the UEFI ref is the clearest because it provides
> > implementation guidance (basically to retry the command until
> > timeout) which I see no reason we can't follow in the kernel.
> > 
> > The alternative is that we handle it in the TSS and I have to patch
> > trusted keys.  However none of the core TPM routines that use
> > tpm_transmit_cmd() have any retry logic, so if we find a TPM that
> > returns it to a kernel sent command we'll get random unexplained
> > failures (based on the ref implementation I don't think this is
> > likely, but by the spec it's possible, especially for a
> > manufacturer who isn't using the reference), so we may end up
> > having to add retry logic to every place in the kernel where we use
> > tpm_transmit_cmd() ... then we'll wish we'd done it generically
> > inside that routine.
> > 
> > Based on this, I think the UEFI spec gives us the safety of knowing
> > that internal handling is correct and the advantages of doing so
> > now are that we don't get a potentially exploding problem later, so
> > it seems like a net win.  I'll code up a patch.
> > 
> > James
> > 
> 
> If the TSS starts retrying commands itself, then it's more than just
> handling TPM_RC_RETRY. There is also even more cryptic
> TPM_RC_YIELDED, which allows (suggests?) retrying,

This is only for software based TPMs, so I suppose intel PTT could do
it, but, as the note says, it's not issued by the reference
implementation at all.  I'd say ignore it until we find an actual
implementor.

>  and TPM_RC_NV_RATE, which covers one of the few legitimate and
> easily explainable reasons why a command can fail now but succeed
> later.

NV_RATE is only for commands that touch NV memory, so that updates can
be rate limited.  The docs imply it's only for NV commands, which we
don't issue in the kernel.

> And what about TPM_RC_MEMORY,

It means there are too many objects in the TPM and is not fixable by a
retry only by unloading something.

>  TPM_RC_NV_UNAVAILABLE and such?

That means the platform component reports the NV memory isn't present.
 This is only for TPMs with external NV chips, I believe and it means
there's a NV connection or provisioning problem.

> Though quite exotic, they are all warnings, and all indicate a
> possibly temporary lack of access/resources. Unlike TPM_RC_*_HANDLES,
> CONTEXT_GAP etc, they don't require RM to do anything with objects
> and handles to recover, and may succeed if simply retried after a
> delay.

No ... the only one you've cited that may be retry amenable is
RC_YIELDED ... the rest indicate other problems a retry won't fix and
as such should be exposed to the user.

> Shall these retries be also handled in tpm_transmit_cmd() or left up
> to the caller to take care of? And how are they different from
> TPM_RC_RETRY case, if the latter?
> 
> If you are interested in the actual in-kernel use of the commands
> that can face such codes, look no further than tpm2_load_context().
> The reference implementation may return TPM_RC_NV* from
> TPM2_ContextLoad since it calls NvIsAvailable().

You may be looking at a different emulator.  In the Microsoft one
it's RETURN_IF_NV_IS_NOT_AVAILABLE and it can't actually be returned by
context loading or saving.

In general I'd say we do the pragmatic not the theoretical thing, so
handle retry returns that have actually been seen and which have caused
problems.  That set is currently only RC_RETRY.

James
