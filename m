Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:43313 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeJMCFn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 22:05:43 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so9903417ioa.10
        for <linux-integrity@vger.kernel.org>; Fri, 12 Oct 2018 11:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <20181004203007.217320-3-mjg59@google.com>
 <1539271386.11939.79.camel@linux.ibm.com> <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
 <1539298987.11939.136.camel@linux.ibm.com>
In-Reply-To: <1539298987.11939.136.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 12 Oct 2018 11:31:42 -0700
Message-ID: <CACdnJuvrATdx2giEvddU38SMKp2oj1XjHqEbs88fuUOekHyDLw@mail.gmail.com>
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 11, 2018 at 4:03 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2018-10-11 at 13:30 -0700, Matthew Garrett wrote:

> > Ok, should this just be part of the IMA policy?
>
> How would you be able to differentiate between different FUSE
> filesystems for example?

There's a couple of ways. We could extend the filesystem type matching
logic to also check the subtype - you'd then need to enforce that at
the LSM level in order to protect against untrusted filesystems
spoofing the filesystem type. Alternatively, we could add an
additional policy match type for mount point and iterate through
s_mounts on the superblock - if any match, we could define the policy
there?
