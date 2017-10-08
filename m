Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751027AbdJHMy1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Oct 2017 08:54:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v98Crrj2006615
        for <linux-integrity@vger.kernel.org>; Sun, 8 Oct 2017 08:54:26 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2devm1rt4s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Oct 2017 08:54:26 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 8 Oct 2017 13:54:24 +0100
Subject: Re: [PATCH] vfs: fix mounting a filesystem with i_version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date: Sun, 08 Oct 2017 08:54:16 -0400
In-Reply-To: <20171008085840.GA6825@infradead.org>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
         <20171008085840.GA6825@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507467256.5841.64.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2017-10-08 at 01:58 -0700, Christoph Hellwig wrote:
> On Sun, Oct 08, 2017 at 12:28:21AM -0400, Mimi Zohar wrote:
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
> 
> The problem is that the whole masking there is a piece of crap.
> 
> It assumes that MS_* and SB_* flags have the same numeric values,
> which is bound to create a major problem rather sooner than later.

According to the original commit, separating them is just the first
step.  This patch fixes that first step so that filesystems can be
mounted with i_version.

Mimi

> What we need is a separate __bitwise type for SB_*, translated them
> here and treat them as a separate namespaces.
> 
