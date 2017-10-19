Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751680AbdJSMAN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 08:00:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JBxirG037727
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 08:00:12 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dpu631smy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 08:00:12 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 13:00:10 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JC06aG21692474
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 12:00:08 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JC0ABP000863
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 23:00:11 +1100
Subject: Re: [PATCH] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Thu, 19 Oct 2017 08:00:02 -0400
In-Reply-To: <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
References: <20171018180111.13021-1-mjg59@google.com>
         <C2D7A727C393B644B70DF4B4DCFB60B921C43F0A@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508414402.4510.117.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-10-19 at 11:02 +0000, Dmitry Kasatkin wrote:
> BTW.
> 
> Just to refresh my mind. What would be the correct order for setting
> this signature from package?
> On any attr/xattr change, EVM will set HMAC.

The system is running without an EVM symmetric key, just an asymmetric
key.

> What is the value of setting signature after that unless there is a
> policy to require signature (immutable)?

> In my original patchset portable was also immutable and also
> included policy support to require EVM signatures.

In Matthew's usecase scenario, only immutable and portable signatures
exist.  The EVM verification for unsigned files will be
INTEGRITY_UNKNOWN.

Mimi
