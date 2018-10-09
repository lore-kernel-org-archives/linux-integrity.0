Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f181.google.com ([209.85.166.181]:38401 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJAjj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 20:39:39 -0400
Received: by mail-it1-f181.google.com with SMTP id i76-v6so3879977ita.3
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 10:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
 <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
 <1538763521.3541.31.camel@linux.ibm.com> <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
 <1538997900.15382.90.camel@linux.ibm.com> <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
 <1539038432.15382.181.camel@linux.ibm.com>
In-Reply-To: <1539038432.15382.181.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 9 Oct 2018 10:21:27 -0700
Message-ID: <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 8, 2018 at 3:40 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2018-10-08 at 13:19 -0700, Matthew Garrett wrote:
> > We trust that the filesystem will return us accurate binaries and
> > hashes, but we don't the binaries themselves may not be trustworthy -
> > we want the same level of audit trail associated with their execution
> > that we'd have for something run off local disk. We could certainly
> > rearchitect our filesystems to generate audit events themselves, but
> > we'd be duplicating functionality that already exists in the kernel.
>
> I'm really not comfortable with the FUSE filesystem calculating the
> file hash being used by IMA.  Adding FUSE i_version support would have
> been better, instead of returning the actual file hash.  Based on a
> mount option and the i_version, the kernel could then decide whether
> or not to limit re-calculating the file hash.

Well, there's a performance benefit as well - reading 500MB
executables over the network is time consuming and otherwise mostly
unnecessary. Given two solutions that have the same properties in
terms of which components we need to trust, why not pick the one
that's faster?
