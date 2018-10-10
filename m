Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f176.google.com ([209.85.166.176]:36861 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXmz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 19:42:55 -0400
Received: by mail-it1-f176.google.com with SMTP id c85-v6so8852294itd.1
        for <linux-integrity@vger.kernel.org>; Wed, 10 Oct 2018 09:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
 <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
 <1538763521.3541.31.camel@linux.ibm.com> <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
 <1538997900.15382.90.camel@linux.ibm.com> <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
 <1539038432.15382.181.camel@linux.ibm.com> <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
 <1539108259.15382.221.camel@linux.ibm.com> <CACdnJus_N41kbJ9SdWSi-q3b-=Z7RRnfGSU1sXnKfdBmFL5j4A@mail.gmail.com>
 <1539118367.15382.247.camel@linux.ibm.com> <CACdnJusJ83MH+e7N4qXwS9iMTFLVoQzZrW=zNBHaTwr+LLHL8g@mail.gmail.com>
 <1539169755.15382.274.camel@linux.ibm.com>
In-Reply-To: <1539169755.15382.274.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 10 Oct 2018 09:19:50 -0700
Message-ID: <CACdnJusGj9MNY7KRcyR2YgR1XeawxwZmfe0ximzXTay6Sf2P9g@mail.gmail.com>
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 10, 2018 at 4:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Tue, 2018-10-09 at 14:32 -0700, Matthew Garrett wrote:
> > Hm. We /could/ fake up fs-verity style behaviour, but we're not
> > talking about files that are expected to be immutable so it would seem
> > like there might be mismatched semantics there.
>
> If these aren't immutable files, then the file hash needs to be
> calculated and re-calculated on file change.  Trust between the kernel
> and FUSE isn't bi-directional.  IMA already supports hardware crypto
> acceleration.  (Refer to the "ima.ahash_minsize" and
> "ima.ahash_bufsize" boot command line options.)  Why is it better that
> FUSE calculates the file hash than the kernel?

The trust /has/ to be bi-directional - if FUSE isn't trustworthy then
it can return false data after the measurement, since we're not
performing measurements at every read. FUSE can recalculate the hash
once a write occurs (it has all the rest of the data already), whereas
having the kernel redo it requires it to read the entire data back
from FUSE. This patch still leaves FUSE measurements as uncached, so
the filesystem will be queried for a new hash every time we want a new
measurement. For cases where there's no benefit in having the
filesystem do the hashing, the filesystem can simply not provide the
feature and the kernel will continue using the existing code.
