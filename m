Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:43323 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeEAVDH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 17:03:07 -0400
Received: by mail-io0-f179.google.com with SMTP id t23-v6so15049005ioc.10
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
 <26787.1519902415@warthog.procyon.org.uk> <8106.1525201247@warthog.procyon.org.uk>
 <1525205707.5669.91.camel@linux.vnet.ibm.com>
In-Reply-To: <1525205707.5669.91.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 01 May 2018 21:02:55 +0000
Message-ID: <CACdnJuuqYiSsaB9dhP9jYFx--y0VgnAWobswgViHamyMN5ijTg@mail.gmail.com>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, May 1, 2018 at 1:15 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> a) Requiring two signatures was addressed by a patch titled "lockdown:
> fix coordination of kernel module signature verification" [1]

Ah, I'd missed that - thanks!

> There's been further discussions as to what should remain in the
> "lockdown" patch set.  Based on the discussion here [2], it seems like
>   "[PATCH 06/24] kexec_load: Disable at runtime if the kernel is locked
> down" will be removed.

> Instead of preventing the loading of a kernel image (kexec_load
>   syscall) being dependent on the lockdown flag, it could be dependent
> on the kernel_read_file_id READING_KEXEC_IMAGE.  A version of these
> patches was posted [3].

Hm. My concern is that distributions are going to ship IMA in a
configuration that allows users to add their own keys at boot time (it's
difficult to use it in a generic way otherwise), and that's going to allow
kexecing of arbitrary images without requiring physical access. I think
kexec_file_load() needs to be relying on non-IMA signatures.
