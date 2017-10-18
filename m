Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750960AbdJRSiR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 14:38:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9IIbsBC140390
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 14:38:17 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dp6x93fg0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 14:38:16 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 19:38:13 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9IIcA2M27918412
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 18:38:11 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9IIc9h8013946
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 05:38:09 +1100
Subject: Re: Writing out EVM protected xattrs while EVM is active
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 18 Oct 2017 14:38:06 -0400
In-Reply-To: <CACdnJuu-F0Rft2TdyA+qa3PGT_jceiDVy_z_nA3QRvAdrGcsjw@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
         <1508291395.4513.95.camel@linux.vnet.ibm.com>
         <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
         <1508292499.4513.99.camel@linux.vnet.ibm.com>
         <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
         <1508295225.4513.123.camel@linux.vnet.ibm.com>
         <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
         <1508349118.4510.14.camel@linux.vnet.ibm.com>
         <CACdnJutON0tX5NV_Di1PEOFHN5Hf-E-shQ=Fzv6CSYkkBk-i=Q@mail.gmail.com>
         <1508350783.4510.22.camel@linux.vnet.ibm.com>
         <CACdnJuu-F0Rft2TdyA+qa3PGT_jceiDVy_z_nA3QRvAdrGcsjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508351886.4510.34.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 11:23 -0700, Matthew Garrett wrote:
> On Wed, Oct 18, 2017 at 11:19 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > The IMA_NEW_FILE check is applicable only when there are no security
> > xattrs (INTEGRITY_NOXATTRS), which would not be the case after writing
> > the first security xattr.  The return result in that case is
> > INTEGRITY_NOLABEL, meaning no security.evm.
> 
> Ah, of course. Ok, how about going with my proposal with an intention
> to relax the restriction around it and HMAC support once we have a
> mechanism for setting multiple xattrs at once?

Sure.  We really need some way of keeping track of things needing to
be done.  And of course, putting a name with it.

[I'm still hoping someone will add the CPIO xattr support.  Any
takers?  It's really a self contained project, lots of impact.  A
really small, minor problem is reading and understanding the
undocumented state table in order to make the change.]

I assume you received, earlier today, the linux-next documentation
conflict and resolution from Mark Brown.  Hopefully, he'll be willing
to carry this change as well.

Mimi
