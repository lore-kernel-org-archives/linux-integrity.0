Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753227AbdI1Odp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 10:33:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8SEXWcs073824
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 10:33:44 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d8yxs40tr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 10:33:43 -0400
Received: from localhost
        by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 00:33:31 +1000
Subject: Re: [RFC PATCH 1/3] fs: define new read_iter rwf flag
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Date: Thu, 28 Sep 2017 10:33:23 -0400
In-Reply-To: <20170928135416.GA30859@bombadil.infradead.org>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com>
         <20170928135416.GA30859@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506609203.5022.1.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-09-28 at 06:54 -0700, Matthew Wilcox wrote:
> On Thu, Sep 28, 2017 at 08:39:31AM -0400, Mimi Zohar wrote:
> > Writing extended attributes requires exclusively taking the i_rwsem
> > lock.  To synchronize the file hash calculation and writing the file
> > hash as security.ima xattr, IMA-appraisal takes the i_rwsem lock
> > exclusively before calculating the file hash.  (Once the file hash
> > is calculated, the result is cached.  Taking the lock exclusively
> > prevents calculating the file hash multiple times.)
> > 
> > Some filesystems have recently replaced their filesystem dependent
> > lock with the global i_rwsem to read a file.  As a result, when IMA
> > attempts to calculate the file hash, reading the file attempts to
> > take the i_rwsem again.
> > 
> > To resolve this problem, this patch defines a new read_iter flag
> > named "rwf" to indicate that the i_rwsem has already been taken
> > exclusively.  Subsequent patches will set or test the "rwf" flag.
> 
> I don't like adding a bool parameter everywhere.

Me either!

> Why not add a flag
> to the kiocb ki_flags?
> 
> #define IOCB_RWSEM_HELD		(1 << 8)

Thank you for the suggestion.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
