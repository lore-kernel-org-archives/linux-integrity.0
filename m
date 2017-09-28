Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:47567 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdI1VNP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 17:13:15 -0400
Received: by mail-qk0-f179.google.com with SMTP id b82so2771052qkc.4
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 14:13:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506629560.5691.33.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 28 Sep 2017 14:13:13 -0700
Message-ID: <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 28, 2017 at 1:12 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Earlier this year there were discussions on defining a portable EVM
> signature, that could be included in software packages.
>
> The reason for including as much metadata as possible in the HMAC is
> to limit cut & paste attacks.  For this reason, the portable data is
> only used in transmission, not on disk.

The concern is that two identical copies of a file may exist, but with
different security contexts, and that not protecting the inode would
allow an attacker to copy the security metadata from one file onto the
other? This presumably only has meaning if they're on separate
filesystems, since otherwise the attacker could just delete one file
and hardlink the other to the former's location? I think that for our
purposes this isn't a big deal.

> A new EVM type is defined that does not convert the EVM signature to
> an HMAC.
>
> Mikhail's patches:
> https://sourceforge.net/p/linux-ima/mailman/linux-ima-user/thread/2017
> 0113072602.4ffaa30a@totoro/

That looks broadly like what we want, but I think there's some
advantage in maintaining the flexibility of choosing which information
is embedded. One additional option would be to allow userland to place
a restriction on which options *must* be present, ie local policy
could refuse to allow any signatures that didn't include a specific
set of metadata.

One of the reasons we're interested in allowing the use of signatures
rather than HMACs is to avoid the case where a machine being
compromised would allow an attacker to obtain the symmetric key and
drop new appropriately HMACed binaries on the system that would
persist even if the kernel was updated to fix the vulnerability.
