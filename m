Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750772AbdKUPzV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 10:55:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vALFrUXx136442
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 10:55:21 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ecn9efcdy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 10:55:18 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 21 Nov 2017 15:53:45 -0000
Subject: Re: IMA appraisal master plan?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        Patrick Ohly <patrick.ohly@intel.com>,
        James Morris <james.l.morris@oracle.com>
Cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <silviu.vlasceanu@huawei.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 21 Nov 2017 10:53:33 -0500
In-Reply-To: <e84b74a4-be06-8c15-5bbe-c4e7ee8abe42@huawei.com>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
         <1510770065.5979.21.camel@intel.com>
         <alpine.LFD.2.20.1711161101360.27132@localhost>
         <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
         <1510798382.3711.389.camel@linux.vnet.ibm.com>
         <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
         <1510837595.3711.420.camel@linux.vnet.ibm.com>
         <a88aff89-1e75-9019-4394-640f5fb318da@huawei.com>
         <alpine.LFD.2.20.1711200746120.25470@localhost>
         <1511173252.5979.45.camel@intel.com>
         <fd3f5cd3-a6a8-a540-f634-4ac489a171e8@huawei.com>
         <1511273148.4729.206.camel@linux.vnet.ibm.com>
         <e84b74a4-be06-8c15-5bbe-c4e7ee8abe42@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511279613.4729.219.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2017-11-21 at 16:25 +0100, Roberto Sassu wrote:

> In the next version of the patch set 'ima: preserve integrity of dynamic
> data', I will introduce the policy low watermark for objects. Instead of
> denying writing of mutable files by processes outside the TCB, IMA will
> allow the operation and demote those files (remove the HMAC).

There has been no consensus for the existing patch set you've posted.
In fact, everyone who has responded said to make it a separate LSM.
Extending the patch set makes no sense.

Mimi
