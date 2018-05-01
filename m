Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35255 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeEAWcX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 18:32:23 -0400
Received: by mail-it0-f66.google.com with SMTP id 186-v6so14783738itu.0
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 15:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
 <26787.1519902415@warthog.procyon.org.uk> <8106.1525201247@warthog.procyon.org.uk>
 <1525205707.5669.91.camel@linux.vnet.ibm.com> <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
 <1525211403.5669.141.camel@linux.vnet.ibm.com> <CACdnJut41527gX5xh8em8i2sZhEwYno3hN37mhNqhk7Jmtb-9g@mail.gmail.com>
 <1525213285.5669.152.camel@linux.vnet.ibm.com>
In-Reply-To: <1525213285.5669.152.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 01 May 2018 22:32:11 +0000
Message-ID: <CACdnJuu11tPS+hpsri4tkgrWn-EEgLWgXT-Bb1m=s4Dx3478JQ@mail.gmail.com>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>, nayna@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 1, 2018 at 3:21 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Tue, 2018-05-01 at 21:59 +0000, Matthew Garrett wrote:
> > Oh, is kexec verified off the _module keyring? We still end up with the
> > problem that distributions don't have a mechanism to ship IMA signatures
> > yet, but that avoids the user modification problem. I've just posted a
> > patchset to debian-dpkg, we'll see how that goes.

> I'm not aware of a _module keyring.  With IMA-appraisal, the signature
> verification of the kernel image (kexec_file_load) uses the trusted
> IMA keyring.  Nayna Jain posted a patch that defines a new platform
> keyring[1], which would only be used to validate the kernel image and
> initramfs signatures.

INTEGRITY_KEYRING_MODULE is defined, but doesn't appear to be used
anywhere. Odd. Anyway, distributions are unlikely to ship with
CONFIG_INTEGRITY_TRUSTED_KEYRING since it makes it impossible for users to
determine which set of IMA or EVM signatures they want to trust. So if
validation is against the IMA keyring rather than builtin_trusted_keys,
it's going to be possible for users to extend the set of trusted keys. If
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG is set then the kernel seems to do the
right thing here, but it's not clear to me how that's supposed to interact
with IMA?
