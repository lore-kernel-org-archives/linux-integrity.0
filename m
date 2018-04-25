Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:37293 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbeDYQzG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Apr 2018 12:55:06 -0400
Received: by mail-io0-f177.google.com with SMTP id y128-v6so27613686iod.4
        for <linux-integrity@vger.kernel.org>; Wed, 25 Apr 2018 09:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180413225220.20130-1-mjg59@google.com> <1523801140.3272.187.camel@linux.vnet.ibm.com>
 <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com>
 <1523909802.3272.238.camel@linux.vnet.ibm.com> <CACdnJusXUkwmxsJiwysMniYj4AvmJjBjH0XXzMiTXwsR9+T+Fw@mail.gmail.com>
 <CACdnJusixeW6LUhFzTEdLgQwRfxf9SXup3CwCAL+gXfA0PPO8g@mail.gmail.com> <1524667892.3371.67.camel@linux.vnet.ibm.com>
In-Reply-To: <1524667892.3371.67.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 25 Apr 2018 16:54:54 +0000
Message-ID: <CACdnJutUWcs9=50uv648Er3H3ehh4zAZb=ngWTx56K1dBQ18wg@mail.gmail.com>
Subject: Re: [PATCH] EVM: Allow runtime modification of the set of verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        igor.stoppa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Apr 25, 2018 at 7:51 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> [CC'ing Igor]

> On Tue, 2018-04-24 at 20:03 +0000, Matthew Garrett wrote:
> > Thinking about this some more - I think being able to do this at
runtime is
> > actually important. If we add an additional xattr to the signatures
then we
> > want to be able to update machine policy without forcing a reboot first,
> > otherwise we have a chicken and egg problem where we have to gate any
new
> > package update against having a machine rebooted with an updated command
> > line (otherwise the signature validation will fail for packages that
> > contain new signatures)

> If the list of xattr names is append only, there is no reason for re-
> allocating the entire xattr name list each time.  As long as the xattr
> name list pointer is defined as __ro_after_init, we can work with Igor
> on using "protectable memory" once it is upstreamed.

Ok, I'll refactor this into a list.
