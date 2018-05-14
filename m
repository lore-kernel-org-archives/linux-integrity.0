Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752383AbeENVCU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 17:02:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EKxFt8051427
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 17:02:20 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hye888umd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 17:02:19 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 14 May 2018 22:02:17 +0100
Subject: Re: [PATCH V5 3/3] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Mon, 14 May 2018 17:02:14 -0400
In-Reply-To: <CACdnJuvffE30wET24+KJ3KnBfM_mf88=DKU96wHmV+2BL+A2Hg@mail.gmail.com>
References: <20180511231236.5501-1-mjg59@google.com>
         <20180511231236.5501-3-mjg59@google.com>
         <1526229700.3898.26.camel@linux.vnet.ibm.com>
         <CACdnJuuve3OrJPvBYeRoTfaan022hi9p0dDbDbZJuKHCU4t3xA@mail.gmail.com>
         <1526318354.3898.159.camel@linux.vnet.ibm.com>
         <1526319342.3368.2.camel@linux.vnet.ibm.com>
         <CACdnJusuhYBsOY_tg681hcE2fnHAfTvmEyFnE-ALO_BNBCKAzA@mail.gmail.com>
         <CACdnJuvffE30wET24+KJ3KnBfM_mf88=DKU96wHmV+2BL+A2Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526331734.3937.3.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-05-14 at 11:50 -0700, Matthew Garrett wrote:
> On Mon, May 14, 2018 at 10:36 AM Matthew Garrett <mjg59@google.com> wrote:
> 
> > On Mon, May 14, 2018 at 10:35 AM Mimi Zohar <zohar@linux.vnet.ibm.com>
> > wrote:
> > > > # echo . > /sys/kernel/security/integrity/evm/evm_xattrs
> > > > bash: echo: write error: Operation not permitted
> 
> > > I'm still seeing this message.
> 
> > Looking into it.
> 
> I can't reproduce this - the only way you should be getting EPERM is if the
> list is already locked or if you don't have CAP_SYS_ADMIN.

The call to notify_change() calls security_inode_setattr(), which is
failing, because there is no security.evm xattr.  It's failing with
-EPERM.

Mimi
