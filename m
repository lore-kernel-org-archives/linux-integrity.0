Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750989AbdLXF4K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 00:56:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBO5s7Hc146046
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 00:56:10 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2f252fsska-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 00:56:10 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 24 Dec 2017 05:56:07 -0000
Subject: Re: [PATCH 11/11] evm: Don't update hmacs in user ns mounts
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>,
        Dongsu Park <dongsu@kinvolk.io>
Cc: linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Alban Crequy <alban@kinvolk.io>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <james.l.morris@oracle.com>
Date: Sun, 24 Dec 2017 00:56:01 -0500
In-Reply-To: <1514092328.5221.116.camel@linux.vnet.ibm.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
         <1f2233a1a028f1eb1e9bea7d06efa6d34e69e752.1512041070.git.dongsu@kinvolk.io>
         <20171223040348.GK6837@mail.hallyn.com>
         <1514092328.5221.116.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1514094961.5221.132.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2017-12-24 at 00:12 -0500, Mimi Zohar wrote:
> Hi Serge,
> 
> On Fri, 2017-12-22 at 22:03 -0600, Serge E. Hallyn wrote:
> > On Fri, Dec 22, 2017 at 03:32:35PM +0100, Dongsu Park wrote:
> > > From: Seth Forshee <seth.forshee@canonical.com>
> > > 
> > > The kernel should not calculate new hmacs for mounts done by
> > > non-root users. Update evm_calc_hmac_or_hash() to refuse to
> > > calculate new hmacs for mounts for non-init user namespaces.
> > > 
> > > Cc: linux-integrity@vger.kernel.org
> > > Cc: linux-security-module@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: James Morris <james.l.morris@oracle.com>
> > > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > 
> > Hi Mimi,
> > 
> > does this change seem sufficient to you?
> 
> I think this is the correct behavior in the context of fuse file
> systems.  This patch, the "ima: define a new policy option named
> force" patch, and an updated IMA policy should be upstreamed together.
>  The cover letter should provide the motivation for these patches.

Ah, this patch is being upstreamed with the fuse mounts patches.  I
guess Seth is planning on posting the IMA policy changes for fuse
separately.

Mimi
