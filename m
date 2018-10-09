Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f182.google.com ([209.85.166.182]:51527 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJJEvW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 00:51:22 -0400
Received: by mail-it1-f182.google.com with SMTP id 74-v6so5032630itw.1
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 14:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
 <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
 <1538763521.3541.31.camel@linux.ibm.com> <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
 <1538997900.15382.90.camel@linux.ibm.com> <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
 <1539038432.15382.181.camel@linux.ibm.com> <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
 <1539108259.15382.221.camel@linux.ibm.com> <CACdnJus_N41kbJ9SdWSi-q3b-=Z7RRnfGSU1sXnKfdBmFL5j4A@mail.gmail.com>
 <1539118367.15382.247.camel@linux.ibm.com>
In-Reply-To: <1539118367.15382.247.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 9 Oct 2018 14:32:15 -0700
Message-ID: <CACdnJusJ83MH+e7N4qXwS9iMTFLVoQzZrW=zNBHaTwr+LLHL8g@mail.gmail.com>
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

On Tue, Oct 9, 2018 at 1:52 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> > The performance hit is more noticeable over remote filesystems, but we
> > have large binaries that take several seconds to hash even on local
> > filesystems. Would it be helpful to try to define the assumptions that
> > IMA makes in terms of whether or not it produces trustworthy results?
> > It feels like it's be easier to talk about this if we have a more
> > formal set of conditions to take into consideration.
>
> [Cc'ing Chuck Lever]
>
> Integrity of files on remote filesystems should probably be discussed
> in the context of fs-verity, not FUSE filesystems.

Hm. We /could/ fake up fs-verity style behaviour, but we're not
talking about files that are expected to be immutable so it would seem
like there might be mismatched semantics there.

> Do you want to continue the discussion here or perhaps as an LSS-EU
> BoF?

This is something that's causing us pain at the moment, so if there's
any chance we can reach a resolution over the next couple of weeks
then I'd like to continue discussing it :)
