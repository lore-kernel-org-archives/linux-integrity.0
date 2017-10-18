Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750800AbdJRST4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 14:19:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9IIJluq036868
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 14:19:56 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dpc4702mg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 14:19:55 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 19:19:50 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9IIJlbE28770486
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 18:19:48 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9IIJkM7022164
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 05:19:46 +1100
Subject: Re: Writing out EVM protected xattrs while EVM is active
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 18 Oct 2017 14:19:43 -0400
In-Reply-To: <CACdnJutON0tX5NV_Di1PEOFHN5Hf-E-shQ=Fzv6CSYkkBk-i=Q@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
         <1508291395.4513.95.camel@linux.vnet.ibm.com>
         <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
         <1508292499.4513.99.camel@linux.vnet.ibm.com>
         <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
         <1508295225.4513.123.camel@linux.vnet.ibm.com>
         <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
         <1508349118.4510.14.camel@linux.vnet.ibm.com>
         <CACdnJutON0tX5NV_Di1PEOFHN5Hf-E-shQ=Fzv6CSYkkBk-i=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508350783.4510.22.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 11:08 -0700, Matthew Garrett wrote:
> On Wed, Oct 18, 2017 at 10:51 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >> Ok. I'm not sure this is easily fixable to handle my use-case without
> >> breaking assumptions made in yours, so I'm wondering if a different
> >> approach would be better here. For us, there's no problem with
> >> updating any of the EVM-protected xattrs at runtime as long as doing
> >> so invalidates the iint cache entry (hmm, does setting an xattr bump
> >> the iversion? If so, we already get this behaviour). How would you
> >> feel about a runtime controllable flag that enabled this, possibly
> >> tied into the /sys/kernel/security/evm write? We'd end up with:
> >>
> >> 1: Enable HMAC
> >> 2: Enable RSA
> >> 4: Permit extended attribute writes
> >>
> >> Existing behaviour would be preserved since 1 would lock down the
> >> interface, and we could reject cases where 1 and 4 are set
> >> simultaneously.
> >
> > Here's an alternative, though admittedly one that is more difficult to
> > implement and dependent on having a portable EVM signature type.
> >
> > Define the equivalent of listxattr that allows writing multiple
> > xattrs.  Change option 4 above to "Permit writing a group of extended
> > attributes, including an EVM signature, when none currently exist."
> 
> This would require adding a new syscall (including glibc support), and
> I think that's probably a hard sell for a single usecase. Looking at
> the code a bit more, are you sure about this? I thought IMA_NEW_FILE
> would only be cleared once the last writer closes the fd, so it ought
> to be possible to do multiple fsetxattr()s with the same file
> descriptor until the last writer closes it?

The IMA_NEW_FILE check is applicable only when there are no security
xattrs (INTEGRITY_NOXATTRS), which would not be the case after writing
the first security xattr.  The return result in that case is
INTEGRITY_NOLABEL, meaning no security.evm.
 
Mimi
