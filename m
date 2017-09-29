Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59363 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751113AbdI2BxM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 21:53:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8T1mdd9017794
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 21:53:11 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d9c0na89x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 21:53:11 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 11:53:08 +1000
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 28 Sep 2017 21:53:00 -0400
In-Reply-To: <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
         <20170928220215.GC15067@dastard>
         <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
         <1506643967.5691.46.camel@linux.vnet.ibm.com>
         <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506649980.5691.100.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-09-28 at 17:33 -0700, Linus Torvalds wrote:
> On Thu, Sep 28, 2017 at 5:12 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > Originally IMA did define it's own lock, prior to IMA-appraisal.  IMA-
> > appraisal introduced writing the file hash as an xattr, which required
> > taking the i_mutex.  process_measurement() and ima_file_free() took
> > the iint->mutex first and then the i_mutex, while setxattr, chmod and
> > chown took the locks in reverse order.  To resolve the potential
> > deadlock, the iint->mutex was eliminated.
> 
> Umm. You already have an explicit invalidation model, where you
> invalidate after a write has occurred.

Invalidating after each write would be horrible performance.  Only
after all the changes are made, after the file close, is the file
integrity status invalidated and the file hash re-calculated and
written out.

At some point, we might want to go back and look at having finer grain
file integrity invalidation.

> But the locking of the generation count (or "invalidation status" or
> whatever) can - and should be - entirely independent of the locking of
> the actual appraisal.

The locking issue isn't with validating the file hash, but with the
setxattr, chmod, chown syscalls.  Each of these syscalls takes the
i_rwsem exclusively before IMA (or EVM) is called.

In ima_file_free(), the locking would be:

lock: iint->mutex
lock: i_rwsem
	write hash as xattr
unlock: i_rwsem
unlock iint->mutex


In setxattr, chmod, chown syscalls, IMA (and EVM) are called after the
i_rwsem is already taken.  So the locking would be:

lock: i_rwsem
lock: iint->mutex

unlock: iint->mutex
unlock: i_rwsem

Perhaps now the problem is clearer?

Mimi
 

> So make the appraisal itself use a semaphore ("only one appraisal at a time").
> 
> But use a separate lock for the generation count.
> So then appraisal is:
> 
>  - get appraisal semaphore
>       - get generation count lock
>             read generation count
>       - drop generation count lock
>       - do the actual appraisal
>  - drop appraisal semaphore
> 
> Note that you now have a tuple of "generation count, appraisal" that
> you have *not* saved off yet, but it's your stable thing.
> 
> Now you can write the xattr:
> 
>   - get exclusive inode lock (for xattr)
>       - get generation count lock
>           - if the appraisal generation does not match, do NOT write
> the appraisal you just calculated, since it's pointless: it's already
> stale.
>           - otherwise write the appraisal and generation count to the xattr
>       - drop generation count lock
>   - release exclusive inode lock
> 
> and then for anything that does setxattr or chmod or whatever, just
> use that generation count lock to invalidate the appraisal. You don't
> need to actual appraisal lock for that.
> 
> So now the appraisal lock is always the outermost one, and the
> generation count lock is always the innermost.
> 
> Anyway, I haven't looked at the details of what IMA does, but
> something like the above really sounds like it should work and seems
> pretty straightforward.
> 
> No?
> 
>                Linus
> 
