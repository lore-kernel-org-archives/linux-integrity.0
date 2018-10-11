Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:50763 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbeJLBuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 21:50:17 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so8871336ite.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 11:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <20181004203007.217320-2-mjg59@google.com>
 <1539271337.11939.78.camel@linux.ibm.com>
In-Reply-To: <1539271337.11939.78.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 11 Oct 2018 11:21:42 -0700
Message-ID: <CACdnJuupQ1vj-H-_Ru+uaGJa-Lhev=52=2RGyTbR1ms4LN3DpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] VFS: Add a call to obtain a file's hash
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 11, 2018 at 8:22 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2018-10-04 at 13:30 -0700, Matthew Garrett wrote:
> > IMA wants to know what the hash of a file is, and currently does so by
> > reading the entire file and generating the hash. Some filesystems may
> > have the ability to store the hash in a secure manner resistant to
> > offline attacks (eg, filesystem-level file signing), and in that case
> > it's a performance win for IMA to be able to use that rather than having
> > to re-hash everything. This patch simply adds VFS-level support for
> > calling down to filesystems.
>
> This patch description starts out saying that IMA needs the file hash
> without explaining why.  Without that explanation, simply extracting
> the file hash included in the file signature might sound plausible,
> but kind of defeats the purpose of IMA.

I'm not sure how it defeats the purpose - IMA wants to know the hash
of a file so it can either log it or compare it against a signature,
and it currently obtains this hash by reading the entire file at
measurement time. If the filesystem later returns different data then
IMA won't notice, which allows a malicious filesystem to bypass the
measurements - there's no guarantee that we won't evict large parts of
the copy of an executable that IMA read, and the filesystem can give
us back a modified page when we page it back in. So IMA fundamentally
relies on the filesystem to be trustworthy, and if we rely on the
filesystem to be trustworthy then we should be able to rely on it to
accurately store and provide the hash of a file.
