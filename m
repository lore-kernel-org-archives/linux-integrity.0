Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932326AbdJZTXA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2017 15:23:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9QJMrwr104173
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2017 15:23:00 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dujhr9awq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 26 Oct 2017 15:22:59 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 26 Oct 2017 20:22:57 +0100
Subject: Re: [RFC] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Mikhail Kurinnoi <viewizard@viewizard.com>,
        Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Date: Thu, 26 Oct 2017 15:22:53 -0400
In-Reply-To: <20171026124616.2f2ef1d2@totoro>
References: <20171026083144.16247-1-mjg59@google.com>
         <20171026120330.5360e427@totoro>
         <CACdnJuvQUGXJb664ZVJk6Z_YDYomgRSwX_C3vk4DRk5EVj02Gg@mail.gmail.com>
         <20171026124616.2f2ef1d2@totoro>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509045773.5886.93.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-10-26 at 12:46 +0300, Mikhail Kurinnoi wrote:
> ? Thu, 26 Oct 2017 02:08:25 -0700
> Matthew Garrett <mjg59@google.com> ?????:
> 
> > On Thu, Oct 26, 2017 at 2:03 AM, Mikhail Kurinnoi
> > <viewizard@viewizard.com> wrote:
> > > ? Thu, 26 Oct 2017 01:31:44 -0700
> > > Matthew Garrett <mjg59@google.com> ?????:
> > >  
> > >> @@ -317,7 +319,7 @@ void ima_update_xattr(struct
> > >> integrity_iint_cache *iint, struct file *file) int rc = 0;
> > >>
> > >>       /* do not collect and update hash for digital signatures */
> > >> -     if (iint->flags & IMA_DIGSIG)
> > >> +     if (iint->flags & IMA_DIGSIG || iint->flags &
> > >> EVM_IMMUTABLE_DIGSIG) return;
> > >>  
> > >
> > > Isn't this mean, we already changed files data, and we just don't
> > > allow IMA xattr update? This file will not pass integrity
> > > verification next time.  
> > 
> > That's fine - policy may not care. It's easier to sign all files and
> > then leave enforcement up to the local policy than it is to determine
> > in advance which files will need protection.

You're both correct.  Signing the file data will prevent security.ima
from changing, assuming the file is in policy and there is a
FILE_CHECK rule.  We're requiring the signed file-metadata include
security.ima, but it currently doesn't require it to contain a file
signature.  Only having a single file signature, was one of Matthew's
requirements.

IMA accessing the EVM flags crosses the boundary between EVM/IMA. Just
as the LSMs protect their own xattr label, EVM should protect
security.evm, preventing it from changing.  There's no need for the
test here in IMA.

An additional patch could prevent IMA from allowing files with the
portable/immutable signatures from changing, just as it currently
prevents signed file data from changing.  Refer to the
IMA_XATTR_DIGEST case statement in ima_appraise_measurement().  It
should be based on the result returned from evm_verifyxattr(), as
Mikhail suggested.

> > > I thought, the idea was prevent data changes, and in this way
> > > prevent IMA xattr update.  
> > 
> > No, the goal is to be able to detect when files have been modified and
> > (optionally) restrict access as a result. Otherwise the packaging
> > system has to be able to identify all files that may be legitimately
> > modified, which is something that may differ depending on the client.
> > It's much easier to permit the data modification and have the local
> > policy block reading or execution if it's actually a sensitive file.
> 
> Hmm...
> http://www.spinics.net/lists/linux-integrity/msg00151.html
> 
> probably, we should decide first, what exactly immutable EVM mean.
> It's hard to propose something or test patch if we still have
> misunderstanding in concept of immutable EVM.

Agreed.  I think EVM should prevent any changes to the file metadata
that would cause the portable/immutable EVM signature to be invalid.
 For example, the change in evm_inode_setattr() permits the file
metadata to change.  The same is true for removing files or writing
security xattrs.

Mimi
