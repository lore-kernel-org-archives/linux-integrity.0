Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751023AbdLXFMS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 00:12:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBO58e6n184475
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 00:12:17 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2f24y7h5b1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 24 Dec 2017 00:12:17 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 24 Dec 2017 05:12:15 -0000
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
Date: Sun, 24 Dec 2017 00:12:08 -0500
In-Reply-To: <20171223040348.GK6837@mail.hallyn.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
         <1f2233a1a028f1eb1e9bea7d06efa6d34e69e752.1512041070.git.dongsu@kinvolk.io>
         <20171223040348.GK6837@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1514092328.5221.116.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Serge,

On Fri, 2017-12-22 at 22:03 -0600, Serge E. Hallyn wrote:
> On Fri, Dec 22, 2017 at 03:32:35PM +0100, Dongsu Park wrote:
> > From: Seth Forshee <seth.forshee@canonical.com>
> > 
> > The kernel should not calculate new hmacs for mounts done by
> > non-root users. Update evm_calc_hmac_or_hash() to refuse to
> > calculate new hmacs for mounts for non-init user namespaces.
> > 
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: James Morris <james.l.morris@oracle.com>
> > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Hi Mimi,
> 
> does this change seem sufficient to you?

I think this is the correct behavior in the context of fuse file
systems.  This patch, the "ima: define a new policy option named
force" patch, and an updated IMA policy should be upstreamed together.
 The cover letter should provide the motivation for these patches.

Mimi

> 
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> > Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
> > ---
> >  security/integrity/evm/evm_crypto.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index bcd64baf..729f4545 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -190,7 +190,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
> >  	int error;
> >  	int size;
> >  
> > -	if (!(inode->i_opflags & IOP_XATTR))
> > +	if (!(inode->i_opflags & IOP_XATTR) ||
> > +	    inode->i_sb->s_user_ns != &init_user_ns)
> >  		return -EOPNOTSUPP;
> >  
> >  	desc = init_desc(type);
> > -- 
> > 2.13.6
> 
