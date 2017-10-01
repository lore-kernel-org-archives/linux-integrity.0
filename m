Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:37643 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdJASlu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Oct 2017 14:41:50 -0400
MIME-Version: 1.0
In-Reply-To: <1506859691.5691.211.camel@linux.vnet.ibm.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
 <20170928220215.GC15067@dastard> <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
 <1506643967.5691.46.camel@linux.vnet.ibm.com> <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
 <1506649980.5691.100.camel@linux.vnet.ibm.com> <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
 <87mv5blki7.fsf@xmission.com> <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
 <1506859691.5691.211.camel@linux.vnet.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Oct 2017 11:41:48 -0700
Message-ID: <CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Chinner <david@fromorbit.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 1, 2017 at 5:08 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> Right, re-introducing the iint->mutex and a new i_generation field in
> the iint struct with a separate set of locks should work.  It will be
> reset if the file metadata changes (eg. setxattr, chown, chmod).

Note that the "inner lock" could possibly be omitted if the
invalidation can be just a single atomic instruction.

So particularly if invalidation could be just an atomic_inc() on the
generation count, there might not need to be any inner lock at all.

You'd have to serialize the actual measurement with the "read
generation count", but that should be as simple as just doing a
smp_rmb() between the "read generation count" and "do measurement on
file contents".

Of course, if you do something more complex in invalidation, you may
end up needing a real lock.

                 Linus
