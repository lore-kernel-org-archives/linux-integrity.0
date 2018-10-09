Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f182.google.com ([209.85.166.182]:54425 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJCrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 22:47:51 -0400
Received: by mail-it1-f182.google.com with SMTP id l191-v6so4481063ita.4
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 12:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
 <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
 <1538763521.3541.31.camel@linux.ibm.com> <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
 <1538997900.15382.90.camel@linux.ibm.com> <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
 <1539038432.15382.181.camel@linux.ibm.com> <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
 <1539108259.15382.221.camel@linux.ibm.com>
In-Reply-To: <1539108259.15382.221.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 9 Oct 2018 12:29:09 -0700
Message-ID: <CACdnJus_N41kbJ9SdWSi-q3b-=Z7RRnfGSU1sXnKfdBmFL5j4A@mail.gmail.com>
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 9, 2018 at 11:04 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2018-10-09 at 10:21 -0700, Matthew Garrett wrote:
> > Well, there's a performance benefit as well - reading 500MB
> > executables over the network is time consuming and otherwise mostly
> > unnecessary. Given two solutions that have the same properties in
> > terms of which components we need to trust, why not pick the one
> > that's faster?
>
> With the existing cover letter, the purpose of this patch set should
> be to address the performance of calculating the file hash on trusted
> local FUSE mounted filesystems, not remote filesystems or fs-verity
> filesystems.

The performance hit is more noticeable over remote filesystems, but we
have large binaries that take several seconds to hash even on local
filesystems. Would it be helpful to try to define the assumptions that
IMA makes in terms of whether or not it produces trustworthy results?
It feels like it's be easier to talk about this if we have a more
formal set of conditions to take into consideration.
