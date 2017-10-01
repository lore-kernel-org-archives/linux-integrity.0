Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33265 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdJAXPI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Oct 2017 19:15:08 -0400
MIME-Version: 1.0
In-Reply-To: <20171001223402.GG15067@dastard>
References: <20170928220215.GC15067@dastard> <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
 <1506643967.5691.46.camel@linux.vnet.ibm.com> <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
 <1506649980.5691.100.camel@linux.vnet.ibm.com> <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
 <87mv5blki7.fsf@xmission.com> <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
 <1506859691.5691.211.camel@linux.vnet.ibm.com> <CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
 <20171001223402.GG15067@dastard>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Oct 2017 16:15:07 -0700
Message-ID: <CA+55aFwV=mO4NjJ2nqOsme7Pg_Lno7hPO6o+ahf-qSpunm9scA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
To: Dave Chinner <david@fromorbit.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 1, 2017 at 3:34 PM, Dave Chinner <david@fromorbit.com> wrote:
>
> We already have a change counter on the inode, which is modified on
> any data or metadata write (i_version) under filesystem locks.  The
> i_version counter has well defined semantics - it's required by
> NFSv4 to increment on any metadata or data change - so we should be
> able to rely on it's behaviour to implement IMA as well.

I actually think i_version has exactly the wrong semantics.

Afaik, it doesn't actually version the file _data_ at all, it only
versions "inode itself changed".

But I might have missed something obvious. The updates are hidden in
some odd places sometimes.

              Linus
