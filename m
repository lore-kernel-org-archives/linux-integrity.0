Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44994 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJPCdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Oct 2018 22:33:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so19925827otf.11
        for <linux-integrity@vger.kernel.org>; Mon, 15 Oct 2018 11:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <20181004203007.217320-3-mjg59@google.com>
 <1539271386.11939.79.camel@linux.ibm.com> <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
 <1539298987.11939.136.camel@linux.ibm.com> <CACdnJuvrATdx2giEvddU38SMKp2oj1XjHqEbs88fuUOekHyDLw@mail.gmail.com>
 <1539567497.11939.198.camel@linux.ibm.com>
In-Reply-To: <1539567497.11939.198.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 15 Oct 2018 11:46:25 -0700
Message-ID: <CACdnJuvWaVXcRcDBPtZCWrJsWX8-rXRbc3bWjtrx=8-4m0uetQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 14, 2018 at 6:38 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Fri, 2018-10-12 at 11:31 -0700, Matthew Garrett wrote:
> > There's a couple of ways. We could extend the filesystem type matching
> > logic to also check the subtype - you'd then need to enforce that at
> > the LSM level in order to protect against untrusted filesystems
> > spoofing the filesystem type. Alternatively, we could add an
> > additional policy match type for mount point and iterate through
> > s_mounts on the superblock - if any match, we could define the policy
> > there?
>
> The first method differentiates between different subtypes of FUSE
> filesystems, while the second method allows differentiating between
> the same type and subtype on different mount points.  Both criteria
> are needed, but instead of the second method based on a mount point,
> perhaps based instead on a mount flag?

Patch 3 already requires that the allow_gethash option be passed for
this to work - I can restrict that to CAP_SYS_ADMIN?

> Trusted mount of permitted filesystem type and subtype, that is
> mounted with the defined mount flag.

Ok, I'll write up a patch that allows policy matching of filesystem
subtype as well as type and try to get that posted this week so we can
discuss it in Edinburgh?
