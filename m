Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755393AbeCSL5x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 07:57:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2JBmsXu100224
        for <linux-integrity@vger.kernel.org>; Mon, 19 Mar 2018 07:57:52 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gta3dpt2u-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Mar 2018 07:57:52 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 19 Mar 2018 11:57:49 -0000
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 19 Mar 2018 07:57:43 -0400
In-Reply-To: <87a7vbydn9.fsf@xmission.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
         <87a7vbydn9.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521460663.3503.127.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Miklos,

On Tue, 2018-03-13 at 14:32 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > Files on FUSE can change at any point in time without IMA being able
> > to detect it.  The file data read for the file signature verification
> > could be totally different from what is subsequently read, making the
> > signature verification useless.
> >
> > FUSE can be mounted by unprivileged users either today with fusermount
> > installed with setuid, or soon with the upcoming patches to allow FUSE
> > mounts in a non-init user namespace.
> >
> > This patch sets the SB_I_IMA_UNVERIFIABLE_SIGNATURE flag and when
> > appropriate sets the SB_I_UNTRUSTED_MOUNTER flag.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

There's been a number of changes since the original version of this
patch set.  I would appreciate your Ack for this version?

Thanks,

Mimi


> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Dongsu Park <dongsu@kinvolk.io>
> > Cc: Alban Crequy <alban@kinvolk.io>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > ---
> >  fs/fuse/inode.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 624f18bbfd2b..ef309958e060 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1080,6 +1080,9 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
> >  	sb->s_maxbytes = MAX_LFS_FILESIZE;
> >  	sb->s_time_gran = 1;
> >  	sb->s_export_op = &fuse_export_operations;
> > +	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
> > +	if (sb->s_user_ns != &init_user_ns)
> > +		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
> >  
> >  	file = fget(d.fd);
> >  	err = -EINVAL;
> 
