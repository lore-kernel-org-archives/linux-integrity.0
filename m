Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:45870 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754148AbeEHWvm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 18:51:42 -0400
Received: by mail-io0-f176.google.com with SMTP id c9-v6so34117515iob.12
        for <linux-integrity@vger.kernel.org>; Tue, 08 May 2018 15:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180501175124.192587-1-mjg59@google.com> <20180501175124.192587-2-mjg59@google.com>
 <1525317430.3238.58.camel@linux.vnet.ibm.com> <CACdnJuvUze0GSmQcnyFi_3vGEPoEgavrF9WhFoDpmHSni3FwEA@mail.gmail.com>
 <1525815782.3551.86.camel@linux.vnet.ibm.com>
In-Reply-To: <1525815782.3551.86.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 08 May 2018 22:51:31 +0000
Message-ID: <CACdnJusHQvBk3rO1DqOr=XyeKZkmFqq+HM9HUO7whvUVG9yxYw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 8, 2018 at 2:43 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Tue, 2018-05-08 at 21:30 +0000, Matthew Garrett wrote:
> > As far as I can tell the VFS doesn't do that, and I wouldn't put it past
> > someone to use UTF-8 at some point...

> The audit subsystem uses audit_log_untrustedstrings() to check for
> control characters.  I'm not sure what should be included, but not
> checking userspace strings doesn't sound right.

As far as I can tell it's legitimate for xattr names to include control
characters. I can't think of /why/ someone would do that, but...

> > I think a config option would make sense here. Locking doesn't seem
> > unreasonable, but I'm not sure what the threat model would really be -
> > adding new xattrs would only result in additional signatures validating
if
> > they were signed with a trusted key in the first place.

> Remember adding additional EVM xattrs isn't limited to just EVM
> signatures, but for the original EVM HMAC as well.  Did you want to
> limit it to the EVM portable & immutable signatures?

If you add entries and then signatures are created you'll end up with
signatures that won't validate on next boot until the same attributes are
added. That feels at worst like root being able to trigger a DoS, which
they'd be able to do by tampering with the signatures via the raw device
node anyway.
