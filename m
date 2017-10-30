Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751374AbdJ3MOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 08:14:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9UCCsTJ133471
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 08:14:55 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dx17vgjy4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 08:14:54 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 30 Oct 2017 12:14:52 -0000
Subject: Re: [RFC] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Date: Mon, 30 Oct 2017 08:14:47 -0400
In-Reply-To: <CACdnJusZezTrdcaRG_CQEWZqk-bm+y=Qu6fD5cchYCZPdxWyXw@mail.gmail.com>
References: <20171026083144.16247-1-mjg59@google.com>
         <20171026120330.5360e427@totoro>
         <CACdnJuvQUGXJb664ZVJk6Z_YDYomgRSwX_C3vk4DRk5EVj02Gg@mail.gmail.com>
         <20171026124616.2f2ef1d2@totoro>
         <1509045773.5886.93.camel@linux.vnet.ibm.com>
         <CACdnJuv1n7LnWj4Oo=B+nOQQz--RFhEAvLTF1oMzcY_kqE-x6w@mail.gmail.com>
         <1509363371.3583.39.camel@linux.vnet.ibm.com>
         <CACdnJusZezTrdcaRG_CQEWZqk-bm+y=Qu6fD5cchYCZPdxWyXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509365687.3583.60.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-30 at 11:51 +0000, Matthew Garrett wrote:
> On Mon, Oct 30, 2017 at 11:36 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Mon, 2017-10-30 at 10:53 +0000, Matthew Garrett wrote:
> >> 2) It should be possible to write a policy that allows these files to
> >> be arbitrarily modified, including being deleted
> >
> > File deletion is not the problem, but if we allow the file metadata to
> > change, then the file verification will fail.
> 
> That seems reasonable? The policy may not be appraising all files, in
> which case having verification fail isn't a problem.
> 
> >> I'd been interpreting "immutable" in this case to mean "the kernel
> >> will never replace the signature with an hmac" rather than "the file
> >> and protected information cannot be modified". If you think the latter
> >> is necessary then I think we need two separate signature types and to
> >> handle the two separately.
> >
> > EVM, up to now, is reactive to file data and meta-data changes,
> > replacing the file signature with an HMAC.  For the new file signature
> > to be immutable it needs to prevent security.evm from changing, which
> > this patch currently does not do.
> 
> It prevents the kernel from modifying security.evm, but doesn't
> prevent userspace from doing so. But if userspace does so,
> verification will fail.

No, the current code does not prevent the signature from being
replaced with an HMAC.  Subsequent EVM verification will succeed based
on an HMAC.
