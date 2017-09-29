Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751046AbdI2AM5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 20:12:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8T09LSx107089
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 20:12:57 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d96s05eb6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 20:12:57 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 10:12:54 +1000
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Cc: LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 28 Sep 2017 20:12:47 -0400
In-Reply-To: <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
         <20170928220215.GC15067@dastard>
         <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506643967.5691.46.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-09-28 at 16:39 -0700, Linus Torvalds wrote:
> On Thu, Sep 28, 2017 at 3:02 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, Sep 28, 2017 at 08:39:33AM -0400, Mimi Zohar wrote:
> >> Don't attempt to take the i_rwsem, if it has already been taken
> >> exclusively.
> >>
> >> Signed-off-by:  Mimi Zohar <zohar@linux.vnet.ibm.com>
> >
> > That's bloody awful.
> >
> > The locking in filesystem IO paths is already complex enough without
> > adding a new IO path semantic that says "caller has already locked
> > the i_rwsem in some order and some dependencies that we have no idea
> > about".
> 
> I do have to admit that I never got a satisfactory answer on why IMA
> doesn't just use its own private per-inode lock for this all.
> 
> It isn't using the i_rwsem for file consistency reasons anyway, so it
> seems to be purely about serializing the actual signature generation
> with the xattr writing, but since IMA does those both, why isn't IMA
> just using its own lock (not the filesystem lock) to do that?

Originally IMA did define it's own lock, prior to IMA-appraisal.  IMA-
appraisal introduced writing the file hash as an xattr, which required
taking the i_mutex.  process_measurement() and ima_file_free() took
the iint->mutex first and then the i_mutex, while setxattr, chmod and
chown took the locks in reverse order.  To resolve the potential
deadlock, the iint->mutex was eliminated.

Mimi
