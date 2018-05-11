Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37430 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeEKTwC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 May 2018 15:52:02 -0400
Received: by mail-it0-f53.google.com with SMTP id 70-v6so3594887ity.2
        for <linux-integrity@vger.kernel.org>; Fri, 11 May 2018 12:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180509202811.29875-1-mjg59@google.com> <20180509202811.29875-2-mjg59@google.com>
 <1526013718.3414.32.camel@linux.vnet.ibm.com>
In-Reply-To: <1526013718.3414.32.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 11 May 2018 12:51:50 -0700
Message-ID: <CACdnJutj9oKqOX7UBXWbD+CpdL3Ed77=evN1gutRsZK1VWtYzQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, May 10, 2018 at 9:42 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Wed, 2018-05-09 at 13:28 -0700, Matthew Garrett wrote:
> > +     xattr->name = memdup_user_nul(buf, count);

> Up to now, the set of protected EVM xattrs was in the security domain.
> The current code permits any string in any domain.  If that is the
> intention, there needs to be an explanation of the security
> implications of this change at least in the patch description.

Restricting it to security makes sense for now - if it turns out that it
seems useful to use other attributes then we can talk about changing that
later.

> > +     if (strcmp(xattr->name, ".") == 0) {
> > +             evm_xattrs_locked = 1;
> > +             err = count;

> Please update the file mode bits of <securityfs>/evm_xattrs.

Ok.

> Should "evm_xattrs" be defined directly in the securityfs directory or
> in a subdirectory similar to ima?  It will be difficult later on to
> move "evm_xattrs" to a subdirectory once applications start
> reading/writing to it.  What would the subdirectory be called?

Yeah, that's tricky - the obvious directory would be evm, but that's
already in use. integrity makes sense, but then ima should also be under it.
