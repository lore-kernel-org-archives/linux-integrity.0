Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36838 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeEAV7Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 17:59:25 -0400
Received: by mail-it0-f67.google.com with SMTP id e20-v6so14718823itc.1
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 14:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
 <26787.1519902415@warthog.procyon.org.uk> <8106.1525201247@warthog.procyon.org.uk>
 <1525205707.5669.91.camel@linux.vnet.ibm.com> <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
 <1525211403.5669.141.camel@linux.vnet.ibm.com>
In-Reply-To: <1525211403.5669.141.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 01 May 2018 21:59:13 +0000
Message-ID: <CACdnJut41527gX5xh8em8i2sZhEwYno3hN37mhNqhk7Jmtb-9g@mail.gmail.com>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 1, 2018 at 2:50 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> On Tue, 2018-05-01 at 21:02 +0000, Matthew Garrett wrote:
> > Hm. My concern is that distributions are going to ship IMA in a
> > configuration that allows users to add their own keys at boot time (it's
> > difficult to use it in a generic way otherwise), and that's going to
allow
> > kexecing of arbitrary images without requiring physical access. I think
> > kexec_file_load() needs to be relying on non-IMA signatures.

> I don't see how.  Unless the kernel was built with extra room for a
> local CA public key (CONFIG_SYSTEM_EXTRA_CERTIFICATE), which would be
> loaded onto the builtin keyring, there is no way of adding keys to the
> IMA keyring.  Adding the extra public key would require the kernel to
> be resigned.

Oh, is kexec verified off the _module keyring? We still end up with the
problem that distributions don't have a mechanism to ship IMA signatures
yet, but that avoids the user modification problem. I've just posted a
patchset to debian-dpkg, we'll see how that goes.
