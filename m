Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:47383 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdI1XjY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 19:39:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170928220215.GC15067@dastard>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com> <20170928220215.GC15067@dastard>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Sep 2017 16:39:23 -0700
Message-ID: <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
To: Dave Chinner <david@fromorbit.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 28, 2017 at 3:02 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Thu, Sep 28, 2017 at 08:39:33AM -0400, Mimi Zohar wrote:
>> Don't attempt to take the i_rwsem, if it has already been taken
>> exclusively.
>>
>> Signed-off-by:  Mimi Zohar <zohar@linux.vnet.ibm.com>
>
> That's bloody awful.
>
> The locking in filesystem IO paths is already complex enough without
> adding a new IO path semantic that says "caller has already locked
> the i_rwsem in some order and some dependencies that we have no idea
> about".

I do have to admit that I never got a satisfactory answer on why IMA
doesn't just use its own private per-inode lock for this all.

It isn't using the i_rwsem for file consistency reasons anyway, so it
seems to be purely about serializing the actual signature generation
with the xattr writing, but since IMA does those both, why isn't IMA
just using its own lock (not the filesystem lock) to do that?

                 Linus
