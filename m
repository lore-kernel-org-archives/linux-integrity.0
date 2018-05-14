Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35668 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeENRBf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 13:01:35 -0400
Received: by mail-it0-f67.google.com with SMTP id q72-v6so12671636itc.0
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180511231236.5501-1-mjg59@google.com> <20180511231236.5501-3-mjg59@google.com>
 <1526229700.3898.26.camel@linux.vnet.ibm.com>
In-Reply-To: <1526229700.3898.26.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 14 May 2018 10:01:07 -0700
Message-ID: <CACdnJuuve3OrJPvBYeRoTfaan022hi9p0dDbDbZJuKHCU4t3xA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] EVM: Allow runtime modification of the set of
 verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, May 13, 2018 at 9:41 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Fri, 2018-05-11 at 16:12 -0700, Matthew Garrett wrote:
  > +
> > +     if (strcmp(xattr->name, ".") == 0) {
> > +             evm_xattrs_locked = 1;
> > +             inode = evm_xattrs->d_inode;
> > +             inode_lock(inode);
> > +             newattrs.ia_mode = S_IFREG | 0440;
> > +             newattrs.ia_valid = ATTR_MODE;
> > +             err = notify_change(evm_xattrs, &newattrs, NULL);
> > +             inode_unlock(inode);
> > +             audit_log_format(ab, "locked");
> > +             if (!err)
> > +                     err = count;
> > +             goto out;
> > +     }
> > +
> > +     audit_log_format(ab, "xattr=");
> > +     audit_log_untrustedstring(ab, xattr->name);
> > +
> > +     if (strncmp(xattr->name, XATTR_SECURITY_PREFIX,
> > +                 XATTR_SECURITY_PREFIX_LEN) != 0) {
> > +             err = -EINVAL;
> > +             goto out;
> > +     }

> This test now prevents locking the xattr names list.  Making this an
> else clause will fix it.

Are you sure? The check for "." happens before this, and jumps over the
rest of the function.
