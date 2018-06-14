Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964820AbeFNUlc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jun 2018 16:41:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5EKd9ko124169
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jun 2018 16:41:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jkv270msw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jun 2018 16:41:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 14 Jun 2018 21:41:29 +0100
Subject: Re: [USER] [PATCH 2/2] Add security.apparmor to the set of extended
 attributes used by EVM
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 14 Jun 2018 16:41:24 -0400
In-Reply-To: <CACdnJuvyY3qQms+xxvWoLpcXC8aE0efnKJo37fWDWtyG3fUhhQ@mail.gmail.com>
References: <20180417225601.6965-1-mjg59@google.com>
         <20180417225601.6965-2-mjg59@google.com>
         <1528846954.3874.16.camel@linux.vnet.ibm.com>
         <CACdnJuvyY3qQms+xxvWoLpcXC8aE0efnKJo37fWDWtyG3fUhhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1529008884.3740.61.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-06-14 at 12:43 -0700, Matthew Garrett wrote:
> On Tue, Jun 12, 2018 at 4:42 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > On Tue, 2018-04-17 at 15:56 -0700, Matthew Garrett wrote:
> > > The kernel is taking security.apparmor into account when validating EVM,
> > > so evmctl should be doing the same.
> > >
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> >
> > The XATTR_NAME_APPARMOR is dependent on the version of
> > "/usr/include/linux/xattr.h".  Without it defined, evmctl fails to
> > build.
> 
> Hmm, true. Is it reasonable to just hardcode it rather than using the define?

I'm not sure how difficult it would be to tie the package name/version
to a specific kernel release.  Commit 096b85464832 ("EVM: Include
security.apparmor in EVM measurements") was upstreamed in linux-4.15.

Mimi
