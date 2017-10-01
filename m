Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbdJAMIY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Oct 2017 08:08:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v91C7DaB059216
        for <linux-integrity@vger.kernel.org>; Sun, 1 Oct 2017 08:08:24 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2daehdd5nh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 01 Oct 2017 08:08:23 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 1 Oct 2017 22:08:21 +1000
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Chinner <david@fromorbit.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Date: Sun, 01 Oct 2017 08:08:11 -0400
In-Reply-To: <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
         <20170928220215.GC15067@dastard>
         <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
         <1506643967.5691.46.camel@linux.vnet.ibm.com>
         <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
         <1506649980.5691.100.camel@linux.vnet.ibm.com>
         <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
         <87mv5blki7.fsf@xmission.com>
         <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506859691.5691.211.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2017-09-30 at 18:56 -0700, Linus Torvalds wrote:
> On Sep 30, 2017 18:33, "Eric W. Biederman" <ebiederm@xmission.com> wrote:.
> 
> 
> That would require a task_work or another kind of work callback so that
> the writes of the xattr are not synchronous with the vfs callback
> correct?
> 
> 
> No, why?
> 
> You should just invalidate the IMA on xattr write or other operations that
> make the measurement invalid. You only need the inner lock.

Right, re-introducing the iint->mutex and a new i_generation field in
the iint struct with a separate set of locks should work.  It will be
reset if the file metadata changes (eg. setxattr, chown, chmod).

(We need i_generation for namespacing IMA as well.)

thanks,

Mimi
