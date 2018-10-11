Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:54790 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJLD7H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 23:59:07 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so15546969ita.4
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 13:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181004203007.217320-1-mjg59@google.com> <20181004203007.217320-3-mjg59@google.com>
 <1539271386.11939.79.camel@linux.ibm.com>
In-Reply-To: <1539271386.11939.79.camel@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 11 Oct 2018 13:30:01 -0700
Message-ID: <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
To: zohar@linux.ibm.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 11, 2018 at 8:23 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2018-10-04 at 13:30 -0700, Matthew Garrett wrote:
> > Some filesystems may be able to provide hashes in an out of band manner,
> > and allowing them to do so is a performance win. This is especially true
> > of FUSE-based filesystems where otherwise we recalculate the hash on
> > every measurement. Make use of this by default, but provide a parameter
> > to force recalculation rather than trusting the filesystem.
> >
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
>
> Support for not calculating the file hash would need to be finer
> grained than this, probably on a per mount basis.  The default should
> be for IMA to always calculate the file hash, unless explicitly told
> not to.

Ok, should this just be part of the IMA policy?

> IMA should never skip the file hash calculation if the filesystem is
> an untrusted mount (eg. SB_I_UNTRUSTED_MOUNTER).

Ok.
