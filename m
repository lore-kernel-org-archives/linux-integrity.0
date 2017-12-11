Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751871AbdLKNNJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 08:13:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBBDBxdL023277
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 08:13:08 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2est05a873-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 11 Dec 2017 08:13:08 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 11 Dec 2017 13:13:04 -0000
Subject: Re: [PATCH] ima: define a new policy option named "force"
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <james.l.morris@oracle.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 11 Dec 2017 08:12:58 -0500
In-Reply-To: <alpine.LFD.2.20.1712110907080.19397@localhost>
References: <1512756740.3846.3.camel@linux.vnet.ibm.com>
         <alpine.LFD.2.20.1712110907080.19397@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512997978.3846.104.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-12-11 at 09:07 +1100, James Morris wrote:
> On Fri, 8 Dec 2017, Mimi Zohar wrote:
> 
> > There are times instead of relying on previously cached status
> > information we want to force the file to be re-measured, re-appraised,
> > and re-audited.
> 
> Can you give an example of when this would be needed?

Up to Sascha Hauer's patch "ima: Use i_version only when filesystem
supports it", which is queued to be upstreamed, the cached flags are
reset only if the i_version changed, causing the file to be re-
evaluated.  After that patch, the cached flags are also reset if
i_version is not enabled. 

That leaves the case where i_version is enabled for the filesystem,
but the local kernel is not responsible for updating it.  This patch
is mainly for filesystems, where we can't trust the filesystem
properly increments i_version.

Eric/Seth, with Sasha's patch is this patch still needed for fuse
filesystems?

Mimi
