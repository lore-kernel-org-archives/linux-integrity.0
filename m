Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751291AbdJBMZW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 08:25:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v92COooi111280
        for <linux-integrity@vger.kernel.org>; Mon, 2 Oct 2017 08:25:21 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dbeytbfh5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Oct 2017 08:25:21 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Oct 2017 22:25:18 +1000
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 02 Oct 2017 08:25:09 -0400
In-Reply-To: <87zi9ai63l.fsf@xmission.com>
References: <20170928220215.GC15067@dastard>
         <CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
         <1506643967.5691.46.camel@linux.vnet.ibm.com>
         <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
         <1506649980.5691.100.camel@linux.vnet.ibm.com>
         <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
         <87mv5blki7.fsf@xmission.com>
         <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
         <1506859691.5691.211.camel@linux.vnet.ibm.com>
         <CA+55aFwG65-1DZGLkxWzXiPHECjVvY+WHa0ihRq6MbJ4yrX-Sg@mail.gmail.com>
         <20171001223402.GG15067@dastard>
         <1506901362.5691.247.camel@linux.vnet.ibm.com>
         <87zi9ai63l.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506947109.5691.282.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2017-10-01 at 22:25 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> > There should be no open writers in ima_check_last_writer(), so the
> > file shouldn't be changing.
> 
> This is slightly tangential but I think important to consider.
> What do you do about distributed filesystems fuse, nfs, etc that
> can change the data behind the kernels back.

Exactly!

> Do you not support such systems or do you have a sufficient way to
> detect changes?

Currently, only the initial file access in policy is measured,
verified, audited.  Even if there was a way of detecting the change,
since we can't trust these file systems, the performance would be
awful, but we should probably not be caching the
measurement/verification results.

Mimi
