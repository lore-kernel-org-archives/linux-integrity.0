Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:41289 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755905AbeEHVav (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 May 2018 17:30:51 -0400
Received: by mail-io0-f177.google.com with SMTP id e12-v6so40277631iob.8
        for <linux-integrity@vger.kernel.org>; Tue, 08 May 2018 14:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180501175124.192587-1-mjg59@google.com> <20180501175124.192587-2-mjg59@google.com>
 <1525317430.3238.58.camel@linux.vnet.ibm.com>
In-Reply-To: <1525317430.3238.58.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 08 May 2018 21:30:39 +0000
Message-ID: <CACdnJuvUze0GSmQcnyFi_3vGEPoEgavrF9WhFoDpmHSni3FwEA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, May 2, 2018 at 8:17 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-05-01 at 10:51 -0700, Matthew Garrett wrote:
> > +             Shows the set of extended attributes used to calculate or
> > +             validate the EVM signature, and allows additional
attributes
> > +             to be added at runtime. Adding additional extended
attributes
> > +             will result in any existing signatures generated without
the
> > +             additional attributes becoming invalid, and any signatures
> > +             generated after additional attributes are added will only
be
> > +             valid if the same additional attributes are configured on
> > +             system boot.

> This needs to be updated ...

Yup.

> > +     if (*ppos != 0)
> > +             return -EINVAL;

> Is there a maximum xattr name size?  Should there be?

There is - I'll add a check.

> > +     /* Remove any trailing newline */
> > +     len = strlen(xattr->name);
> > +     if (xattr->name[len-1] == '\n')
> > +             xattr->name[len-1] = '\0';

> Shouldn't we somehow sanity check userspace provided strings, before
> adding them to the list of xattrs?  Perhaps limit the string to the
> upper and lower case letters?

As far as I can tell the VFS doesn't do that, and I wouldn't put it past
someone to use UTF-8 at some point...

  > +     evm_xattrs = securityfs_create_file("evm_xattrs", 0440, NULL, NULL,
> > +                                         &evm_xattr_ops);
> > +     if (!evm_xattrs || IS_ERR(evm_xattrs)) {
> > +             securityfs_remove(evm_init_tpm);
> > +             return -EFAULT;
> > +     }
> > +

> Do we really want this feature unconditionally enabled?  How often do
> you expect to add xattrs?  Is there ever a point where you would want
> to lock the list of xattrs from changing?

I think a config option would make sense here. Locking doesn't seem
unreasonable, but I'm not sure what the threat model would really be -
adding new xattrs would only result in additional signatures validating if
they were signed with a trusted key in the first place.
