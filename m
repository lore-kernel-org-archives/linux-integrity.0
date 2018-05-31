Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754160AbeEaUcR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 16:32:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VKSrT5139639
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 16:32:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jap70vs9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 16:32:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 31 May 2018 21:32:14 +0100
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: wangjunwen@baidu.com,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 31 May 2018 16:32:08 -0400
In-Reply-To: <CACdnJutU3fcYK3TVicBXUvCDo_9DaWuqTRDcz_GGGZOLegg3Ww@mail.gmail.com>
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
         <20180530202804.148245-1-mjg59@google.com>
         <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
         <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
         <1527796502.3427.46.camel@linux.vnet.ibm.com>
         <CACdnJutU3fcYK3TVicBXUvCDo_9DaWuqTRDcz_GGGZOLegg3Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527798728.3427.58.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-05-31 at 13:07 -0700, Matthew Garrett wrote:
> On Thu, May 31, 2018 at 12:55 PM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >
> > On Thu, 2018-05-31 at 12:30 -0700, Matthew Garrett wrote:
> > > Cool. Mimi, does this satisfy your concerns with the non-SHA1 patch?
> >
> > This should be posted as a separate patch, with the appropriate
> > "Fixes" commit info.  It requires an ack from Herbert Xu.
> 
> The non-sha1 patch doesn't seem to be in -next at the moment - should
> I wait for you to merge that so I can add the fixes tag?

The problem exists prior to the non-sha1 patch, but could have been
resolved differently for only sha1 (eg. Kconfig requiring sha1).  The
non-sha1 patch requires a different solution.

Junwen, is this a regression?  Did a particular patch introduce this
problem?

Mimi
