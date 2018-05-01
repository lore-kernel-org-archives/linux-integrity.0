Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36720 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeEAXqk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 19:46:40 -0400
Received: by mail-io0-f172.google.com with SMTP id d73-v6so15436249iog.3
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 16:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
 <26787.1519902415@warthog.procyon.org.uk> <8106.1525201247@warthog.procyon.org.uk>
 <1525205707.5669.91.camel@linux.vnet.ibm.com> <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
 <1525211403.5669.141.camel@linux.vnet.ibm.com> <CACdnJut41527gX5xh8em8i2sZhEwYno3hN37mhNqhk7Jmtb-9g@mail.gmail.com>
 <1525213285.5669.152.camel@linux.vnet.ibm.com> <CACdnJuu11tPS+hpsri4tkgrWn-EEgLWgXT-Bb1m=s4Dx3478JQ@mail.gmail.com>
 <1525218220.5669.164.camel@linux.vnet.ibm.com>
In-Reply-To: <1525218220.5669.164.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 01 May 2018 23:46:28 +0000
Message-ID: <CACdnJuvSjpUS-fvURrrYOnLLPpasYgr6kJkncbfvMuOCYEL1EQ@mail.gmail.com>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>, nayna@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 1, 2018 at 4:43 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Tue, 2018-05-01 at 22:32 +0000, Matthew Garrett wrote:
> > INTEGRITY_KEYRING_MODULE is defined, but doesn't appear to be used
> > anywhere. Odd. Anyway, distributions are unlikely to ship with
> > CONFIG_INTEGRITY_TRUSTED_KEYRING since it makes it impossible for users
to
> > determine which set of IMA or EVM signatures they want to trust. So if
> > validation is against the IMA keyring rather than builtin_trusted_keys,
> > it's going to be possible for users to extend the set of trusted keys.
If
> > CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is set then the kernel seems to do the
> > right thing here, but it's not clear to me how that's supposed to
interact
> > with IMA?

>  From your description, whatever keys the distros are loading onto the
> builtin_trusted_keys keyring for verifying the kexec kernel image,
> could just as easily be added to the IMA trusted keyring
> (CONFIG_INTEGRITY_TRUSTED_KEYRING).  I don't see the difference.

If CONFIG_INTEGRITY_TRUSTED_KEYRING isn't set then you can load new (and
unsigned) IMA keys from userspace. So if IMA is the lockdown control
mechanism for kexec, distros must either set
CONFIG_INTEGRITY_TRUSTED_KEYRING (which I don't think is practical) or IMA
should test kexec against the builtin_trusted_keys keyring rather than the
IMA keyring. Or have I misunderstood how this works?
