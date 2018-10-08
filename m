Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f180.google.com ([209.85.166.180]:51894 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeJIDcn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 23:32:43 -0400
Received: by mail-it1-f180.google.com with SMTP id 74-v6so13225118itw.1
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 13:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
 <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
 <1538763521.3541.31.camel@linux.ibm.com> <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
 <1538997900.15382.90.camel@linux.ibm.com>
In-Reply-To: <1538997900.15382.90.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 8 Oct 2018 13:19:01 -0700
Message-ID: <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 8, 2018 at 4:25 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Fri, 2018-10-05 at 12:25 -0700, Matthew Garrett wrote:
> > 1) You trust FUSE mounts, perhaps because you have some other policy
> > in place to ensure that only trusted binaries can mount stuff. In this
> > scenario you already trust that the filesystem will give you
> > consistent results when you read data from it -
>
> In the trusted mount scenario, we trust the data should not change
> between calculating the file hash and reading the file data, making it
> similar to other local filesystems.  Unlike other local filesystems,
> however, we can't detect when the file changes.  For this reason we
> need to re-calculate the file hash to measure/appraise the file each
> time.

But we don't re-measure for every read, so it's still possible for the
filesystem to give us back different results without affecting the
measurement.

> > it seems reasonable to
> > also trust it to give you back an accurate hash if you ask for one.
>
> Going from trusting the filesystem to behave properly, to trusting the
> file hash that the filesystem provides is a major leap.  We don't do
> this today for any local filesystem.

I don't think any local filesystems provide a mechanism for this - we
have FUSE filesystems that do.

> > I agree that using FUSE in general is incompatible with IMA's goals,
> > but it's possible to configure systems where you can ensure that only
> > trustworthy code is involved. In that scenario this patch improves
> > performance without compromising security.
>
> If you trust a FUSE filesystem to not only behave properly, but also
> to return file hashes, what is the value of measuring/appraising the
> files?  Define a custom policy that doesn't measure/appraise files on
> FUSE filesystems.

We trust that the filesystem will return us accurate binaries and
hashes, but we don't the binaries themselves may not be trustworthy -
we want the same level of audit trail associated with their execution
that we'd have for something run off local disk. We could certainly
rearchitect our filesystems to generate audit events themselves, but
we'd be duplicating functionality that already exists in the kernel.
