Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754071AbeEaTzL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 15:55:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VJnFp0037533
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 15:55:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2janm84vp7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 15:55:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 31 May 2018 20:55:07 +0100
Subject: Re: [PATCH] evm: Don't deadlock if a crypto algorithm is unavailable
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, wangjunwen@baidu.com
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 31 May 2018 15:55:02 -0400
In-Reply-To: <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
References: <CACdnJus+5Xog03Z1VYdw_8dx64Wg2zzh1b2bL-FDt0O9+p_eGQ@mail.gmail.com>
         <20180530202804.148245-1-mjg59@google.com>
         <15252CF8C1B4384C8CE16D7D55C66479011414E83B@BC-MAIL-M04.internal.baidu.com>
         <CACdnJutzAbjwieaxH1N5Z-Vt9Q=Gwf5WamPURkO1epVZEUy_8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527796502.3427.46.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-05-31 at 12:30 -0700, Matthew Garrett wrote:
> Cool. Mimi, does this satisfy your concerns with the non-SHA1 patch?

This should be posted as a separate patch, with the appropriate
"Fixes" commit info.  It requires an ack from Herbert Xu.

thanks,

Mimi
