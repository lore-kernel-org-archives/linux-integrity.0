Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:50240 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeDPScv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Apr 2018 14:32:51 -0400
Received: by mail-it0-f50.google.com with SMTP id r19-v6so12697721itc.0
        for <linux-integrity@vger.kernel.org>; Mon, 16 Apr 2018 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180413225220.20130-1-mjg59@google.com> <1523801140.3272.187.camel@linux.vnet.ibm.com>
In-Reply-To: <1523801140.3272.187.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 16 Apr 2018 18:32:39 +0000
Message-ID: <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com>
Subject: Re: [PATCH] EVM: Allow runtime modification of the set of verified xattrs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Apr 15, 2018 at 7:05 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Fri, 2018-04-13 at 15:52 -0700, Matthew Garrett wrote:
> > Sites may wish to provide additional metadata alongside files in order
> > to make more fine-grained security decisions[1]. The security of this is
> > enhanced if this metadata is protected, something that EVM makes
> > possible. However, the kernel cannot know about the set of extended
> > attributes that local admins may wish to protect, and hardcoding this
> > policy in the kernel makes it difficult to change over time and less
> > convenient for distributions to enable.
> >
> > This patch adds a new /sys/kernel/security/evm_xattrs node, which can be
> > read to obtain the current set of EVM-protected extended attributes or
> > written to in order to add new entries. Once EVM is enabled (by writing
> > to /sys/kernel/security/evm), further writes are blocked. This should
> > make no difference to security considerations around EVM - even if an
> > attacker is able to get additional extended attributes added to this
> > list, it will simply result in existing signatures failing to validate.

> Up to now, the security.evm HMAC was calculated based on the existing
> set of protected xattrs, but did not require all of the xattrs to
> exist.  Here, after adding a new xattr to the set of protected xattrs,
> the HMAC/signature verification of existing security.evm xattrs should
> continue to validate, just as it currently does with non-existent
> xattrs.  Writing an existing, currently non-existent or new xattrs
> would cause the signature/HMAC to be re-calculate and written out as
> an HMAC.  Only the new EVM portable and immutable signatures would
> result in signature verification failures.

Yes, you're right - this is a misleading statement in the description, and
this behaviour isn't actually changed by the patch.

> Although evm_config_xattrnames is not currently defined as a const, it
> should have been.  Including additional xattrs via a securityfs file,
> limits how the memory for the entire list of xattrs and the pointer to
> that list can be protected.

Right, I did wonder about that.

> Does this extra list of xattrs need to be run time or build time
> configurable?  If it's build time configurable you'd be able to use
> __ro_after_init.  For run time configurable, perhaps the proposed
> "post-init read-only memory" (https://lwn.net/Articles/750215/) could
> be used.

Runtime. I'll look into the post-init stuff, but given that this doesn't
change the current security position do you think it's a blocker?
