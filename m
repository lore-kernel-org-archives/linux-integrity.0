Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751948AbdJKM2N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 08:28:13 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9BCNtIi107254
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 08:28:12 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dhhqe72ww-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 08:28:12 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 11 Oct 2017 13:28:10 +0100
Subject: Re: [PATCH] vfs: fix mounting a filesystem with i_version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Date: Wed, 11 Oct 2017 08:28:01 -0400
In-Reply-To: <alpine.LRH.2.21.1710090924410.3670@namei.org>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1710090924410.3670@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507724881.3428.19.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Al,

This patch fixes a regression.  Without it, you can't mount a file
system with i_version.  This obviously affects IMA.  Could you pick up
this patch and forward it to Linus please?

Commit dd924ea17c0c "vfs: fix mounting a filesystem with i_version"
can be found in my git repo.

thanks,

Mimi


On Mon, 2017-10-09 at 09:24 +1100, James Morris wrote:
> cc: Al Viro.
> 
> 
> On Sun, 8 Oct 2017, Mimi Zohar wrote:
> 
> > The mount i_version flag is not enabled in the new sb_flags.  This patch
> > adds the missing SB_I_VERSION flag.
> > 
> > Fixes: e462ec5 "VFS: Differentiate mount flags (MS_*) from internal
> >        superblock flags"
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  fs/namespace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 3b601f115b6c..d18deb4c410b 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2825,7 +2825,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
> >  			    SB_MANDLOCK |
> >  			    SB_DIRSYNC |
> >  			    SB_SILENT |
> > -			    SB_POSIXACL);
> > +			    SB_POSIXACL |
> > +			    SB_I_VERSION);
> >  
> >  	if (flags & MS_REMOUNT)
> >  		retval = do_remount(&path, flags, sb_flags, mnt_flags,
> > 
> 
