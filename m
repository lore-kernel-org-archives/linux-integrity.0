Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:36234 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdJABdw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Sep 2017 21:33:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
        <20170928220215.GC15067@dastard>
        <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
        <1506643967.5691.46.camel@linux.vnet.ibm.com>
        <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
        <1506649980.5691.100.camel@linux.vnet.ibm.com>
        <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
Date: Sat, 30 Sep 2017 20:33:36 -0500
In-Reply-To: <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 28 Sep 2017 20:26:15 -0700")
Message-ID: <87mv5blki7.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been taken exclusively
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Sep 28, 2017 at 6:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>
>> The locking issue isn't with validating the file hash, but with the
>> setxattr, chmod, chown syscalls.  Each of these syscalls takes the
>> i_rwsem exclusively before IMA (or EVM) is called.
>
> Read my email again.
>
>> In setxattr, chmod, chown syscalls, IMA (and EVM) are called after the
>> i_rwsem is already taken.  So the locking would be:
>>
>> lock: i_rwsem
>> lock: iint->mutex
>
> No.
>
> Two locks. One inner, one outer. Only the actual ones that calculates
> the hash would take the outer one. Read my email.

That would require a task_work or another kind of work callback so that
the writes of the xattr are not synchronous with the vfs callback
correct?

Eric
