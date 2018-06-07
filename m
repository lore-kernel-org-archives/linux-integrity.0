Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:32854 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753260AbeFGUcy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jun 2018 16:32:54 -0400
Received: by mail-io0-f177.google.com with SMTP id d185-v6so13386192ioe.0
        for <linux-integrity@vger.kernel.org>; Thu, 07 Jun 2018 13:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180606215712.121747-1-mjg59@google.com> <20180606215712.121747-2-mjg59@google.com>
 <1528380154.3255.68.camel@linux.vnet.ibm.com>
In-Reply-To: <1528380154.3255.68.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 7 Jun 2018 13:32:41 -0700
Message-ID: <CACdnJutGdEmCCCdO-5FZy5gyWpcsQKu8P83PnK4eNh3+XAjOFA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] evm: Allow non-SHA1 digital signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jun 7, 2018 at 7:02 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> Hi Matthew,
>
> On Wed, 2018-06-06 at 14:57 -0700, Matthew Garrett wrote:
> > SHA1 is reasonable in HMAC constructs, but it's desirable to be able to
> > use stronger hashes in digital signatures. Modify the EVM crypto code so
> > the hash type is imported from the digital signature and passed down to
> > the hash calculation code, and return the digest size to higher layers
> > for validation.
> >
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
>
> This patch applies using "quilt push", but not with "git am".  Did you
> post the associated ima-evm-utils patch?

That's strange - I sent it with git send-email. I can resend the
userspace patch (the original one allowed non-SHA1 HMACs, but that
doesn't seem helpful, so I'll drop that part)
