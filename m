Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730693AbeGWAh0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Jul 2018 20:37:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6MNb9Zl045597
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jul 2018 19:38:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kcj3u93dq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jul 2018 19:38:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 23 Jul 2018 00:38:57 +0100
Subject: Re: [PATCH -next] EVM: fix return value check in evm_write_xattrs()
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Sun, 22 Jul 2018 19:38:41 -0400
In-Reply-To: <20180711151510.GA23645@mail.hallyn.com>
References: <1531315720-4191-1-git-send-email-weiyongjun1@huawei.com>
         <20180711151510.GA23645@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1532302721.6206.24.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-07-11 at 10:15 -0500, Serge E. Hallyn wrote:
> Quoting Wei Yongjun (weiyongjun1@huawei.com):
> > In case of error, the function audit_log_start() returns NULL pointer
> > not ERR_PTR(). The IS_ERR() test in the return value check should be
> > replaced with NULL test.
> > 
> > Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Thanks, this patch is now queued in the next-integrity branch of the
linux-integrity tree.

Mimi
