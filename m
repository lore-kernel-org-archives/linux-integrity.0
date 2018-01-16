Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751449AbeAPLfo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jan 2018 06:35:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0GBYmZ5009069
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jan 2018 06:35:44 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fhgjgr8xh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jan 2018 06:35:43 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 16 Jan 2018 11:35:41 -0000
Subject: Re: [PATCH] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alban Crequy <alban@kinvolk.io>,
        Alban Crequy <alban.crequy@gmail.com>
Cc: Iago =?ISO-8859-1?Q?L=F3pez?= Galeiras <iago@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Date: Tue, 16 Jan 2018 06:35:34 -0500
In-Reply-To: <CADZs7q6y_d6E3wDmAtsFLZYRfbV+v6gctpJ+a6BtX_02bPrttQ@mail.gmail.com>
References: <20180115144804.GA28856@infradead.org>
         <20180116104121.4231-1-alban@kinvolk.io>
         <CADZs7q6y_d6E3wDmAtsFLZYRfbV+v6gctpJ+a6BtX_02bPrttQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516102534.6607.103.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> >
> >         /*
> > -        * Reset the measure, appraise and audit cached flags either if
> > -        * ima_inode_setxattr was called or based on policy, forcing
> > -        * the file to be re-evaluated.
> > +        * Reset the measure, appraise and audit cached flags either if:
> > +        * - ima_inode_setxattr was called, or
> > +        * - based on policy ("force"), or
> > +        * - based on filesystem feature flag
> > +        * forcing the file to be re-evaluated.
> >          */
> 
> Now that I think about it, it's also possible to write this patch
> without basing it on Mimi's patch "ima: define a new policy option
> named force", which is not in next-integrity yet. Should I try that?

Yes, thank you.  As you're proposing a new flag, please remember to Cc
the fsdevel mailing list as well.

Mimi

> 
> >         if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
> >                 iint->flags &= ~IMA_DONE_MASK;
> > -       } else if (action & IMA_FORCE) {
> > +       } else if (action & IMA_FORCE || inode->i_sb->s_type->fs_flags & FS_NO_IMA_CACHE) {
> >                 if (action & IMA_MEASURE) {
> >                         iint->measured_pcrs = 0;
> >                         iint->flags &=
> > --
> > 2.13.6
> >
> 
