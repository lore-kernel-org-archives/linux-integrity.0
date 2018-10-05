Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f171.google.com ([209.85.166.171]:36483 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJFCZd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 22:25:33 -0400
Received: by mail-it1-f171.google.com with SMTP id c85-v6so4285822itd.1
        for <linux-integrity@vger.kernel.org>; Fri, 05 Oct 2018 12:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <1538736566.3702.436.camel@linux.ibm.com>
 <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com> <1538763521.3541.31.camel@linux.ibm.com>
In-Reply-To: <1538763521.3541.31.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 5 Oct 2018 12:25:13 -0700
Message-ID: <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Oct 5, 2018 at 11:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Right, the correct behavior should be not to trust FUSE filesystems,
> but since we don't break userspace there is the
> "ima_policy=fail_securely" boot command line option.

There seem to be two scenarios:

1) You trust FUSE mounts, perhaps because you have some other policy
in place to ensure that only trusted binaries can mount stuff. In this
scenario you already trust that the filesystem will give you
consistent results when you read data from it - it seems reasonable to
also trust it to give you back an accurate hash if you ask for one.
2) You don't trust FUSE mounts, in which case you pass
ima_policy=fail_securely. This patch doesn't change that behaviour.

I agree that using FUSE in general is incompatible with IMA's goals,
but it's possible to configure systems where you can ensure that only
trustworthy code is involved. In that scenario this patch improves
performance without compromising security.
