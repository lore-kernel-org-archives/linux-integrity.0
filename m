Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751605AbeFALVZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jun 2018 07:21:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w51BJt9N057555
        for <linux-integrity@vger.kernel.org>; Fri, 1 Jun 2018 07:21:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jb43ejxkk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jun 2018 07:21:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 1 Jun 2018 12:21:22 +0100
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: wangjunwen@baidu.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 01 Jun 2018 07:21:07 -0400
In-Reply-To: <CACdnJuvRoZ=McstC_f9uaqZ+zWWDu9L=yQCBXDF6xQMtmTsfcQ@mail.gmail.com>
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
         <20180530202804.148245-1-mjg59@google.com>
         <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
         <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
         <1527796502.3427.46.camel@linux.vnet.ibm.com>
         <CACdnJutU3fcYK3TVicBXUvCDo_9DaWuqTRDcz_GGGZOLegg3Ww@mail.gmail.com>
         <1527798728.3427.58.camel@linux.vnet.ibm.com>
         <CACdnJuvRoZ=McstC_f9uaqZ+zWWDu9L=yQCBXDF6xQMtmTsfcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527852067.3427.81.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-05-31 at 14:06 -0700, Matthew Garrett wrote:
> On Thu, May 31, 2018 at 1:32 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > On Thu, 2018-05-31 at 13:07 -0700, Matthew Garrett wrote:
> > > On Thu, May 31, 2018 at 12:55 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > > >
> > > > On Thu, 2018-05-31 at 12:30 -0700, Matthew Garrett wrote:
> > > > > Cool. Mimi, does this satisfy your concerns with the non-SHA1 patch?
> > > >
> > > > This should be posted as a separate patch, with the appropriate
> > > > "Fixes" commit info.  It requires an ack from Herbert Xu.
> > >
> > > The non-sha1 patch doesn't seem to be in -next at the moment - should
> > > I wait for you to merge that so I can add the fixes tag?
> >
> > The problem exists prior to the non-sha1 patch, but could have been
> > resolved differently for only sha1 (eg. Kconfig requiring sha1).  The
> > non-sha1 patch requires a different solution.
> 
> EVM looks like it SELECTs CONFIG_SHA1, so I /think/ it should be ok
> before that patch?

According to Junwen, with CONFIG_TRUSTED_KEYS enabled the HMAC and
SHA1 are allocated at __init.  The locking problem occurs when
CONFIG_TRUSTED_KEYS is not enabled.  His solution would have been to
move the crypto_alloc_shash() in EVM to an __init function.

Mimi
