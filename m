Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:55399 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbeEARWD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 13:22:03 -0400
Received: by mail-it0-f43.google.com with SMTP id 144-v6so14374318iti.5
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 10:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180427194155.41282-1-mjg59@google.com> <1525139784.5669.26.camel@linux.vnet.ibm.com>
In-Reply-To: <1525139784.5669.26.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 01 May 2018 17:21:51 +0000
Message-ID: <CACdnJuuXNpk+Uj6YB1KPyYiGWY+6xsb-gfT1HJZ394ui+_ZByQ@mail.gmail.com>
Subject: Re: [PATCH V2] EVM: Allow runtime modification of the set of verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Apr 30, 2018 at 6:56 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Fri, 2018-04-27 at 12:41 -0700, Matthew Garrett wrote:
> > +     for (xattrname = evm_config_default_xattrnames; *xattrname !=
NULL;
> > +          xattrname++) {
> > +             tmp = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
> > +             if (!tmp)
> > +                     return -ENOMEM;
> > +             tmp->name = kstrdup(*xattrname, GFP_KERNEL);
> > +             if (!tmp->name) {
> > +                     kfree(tmp);
> > +                     return -ENOMEM;
> > +             }
> > +             list_add_tail(&tmp->list, &evm_config_xattrnames);

> If evm_config_xattrnames[] is defined as struct xattr_list, there's no
> need for allocating memory for the xattr_list and name.  Something
> like in ima_init_policy() would work.

Hm. Do you mean evm_config_default_xattrnames?

> Could we break this patch up to simplify review?  The first patch
> would create and use the xattrname list.  The subsequent patch(es)
> would add the new functionality.

Sure, I'll do that.
