Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io1-f45.google.com ([209.85.166.45]:33274 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFA0p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 20:26:45 -0400
Received: by mail-io1-f45.google.com with SMTP id l25-v6so11273784ioj.0
        for <linux-integrity@vger.kernel.org>; Fri, 05 Oct 2018 10:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
In-Reply-To: <1538736566.3702.436.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 5 Oct 2018 10:26:51 -0700
Message-ID: <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Oct 5, 2018 at 3:49 AM Mimi Zohar <zohar@linux.ibm.com> wrote:

> Really, a security vs. performance argument?!  I don't need to tell
> you of all people, that one of the basic tenents of trusted boot is
> calculating the actual file hash before use.  Limiting the file hash
> re-calculation is one thing, but relying on some out of band method of
> obtaining the file hash without the kernel ever calculating it is
> totally different.  The only exception will be for fs-verity, which
> will return not the file hash, but the file's Merkle tree root hash.

Using FUSE means you're inherently accepting the risk of TOCTOU.
Having the kernel read everything once and hash it is no guarantee
that the filesystem will return the same value on further reads, so if
you're going to use FUSE in an environment where you're using IMA then
you already need to assert that your filesystems are trustworthy.
