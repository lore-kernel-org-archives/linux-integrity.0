Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751124AbeAVM4z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 07:56:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MCs1ca083889
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 07:56:55 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fnc9gaaw4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 07:56:54 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 12:56:51 -0000
Subject: Re: [RFC PATCH v2] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alban Crequy <alban@kinvolk.io>
Cc: Alban Crequy <alban.crequy@gmail.com>,
        Iago =?ISO-8859-1?Q?L=F3pez?= Galeiras <iago@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Date: Mon, 22 Jan 2018 07:56:43 -0500
In-Reply-To: <CADZs7q68zORejnVBfQ38K6PtUTj_5OqkYjMvTa=Fi+UEyPp+FQ@mail.gmail.com>
References: <20180116151000.443-1-alban@kinvolk.io>
         <1516310702.3772.11.camel@linux.vnet.ibm.com>
         <CADZs7q4StoPLD4-CSXp5DkgPh29vrZWjayTAYkMAsrDychLOoQ@mail.gmail.com>
         <1516380970.3772.112.camel@linux.vnet.ibm.com>
         <CADZs7q68zORejnVBfQ38K6PtUTj_5OqkYjMvTa=Fi+UEyPp+FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516625803.3772.124.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-01-22 at 10:16 +0100, Alban Crequy wrote:
> On Fri, Jan 19, 2018 at 5:56 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Fri, 2018-01-19 at 11:35 +0100, Alban Crequy wrote:
> >> On Thu, Jan 18, 2018 at 10:25 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> >> > On Tue, 2018-01-16 at 16:10 +0100, Alban Crequy wrote:
> >> >> From: Alban Crequy <alban@kinvolk.io>
> >> >>
> >> >> This patch forces files to be re-measured, re-appraised and re-audited
> >> >> on file systems with the feature flag FS_NO_IMA_CACHE. In that way,
> >> >> cached integrity results won't be used.
> >> >>
> >> >> For now, this patch adds the new flag only FUSE filesystems. This is
> >> >> needed because the userspace FUSE process can change the underlying
> >> >> files at any time.
> >> >
> >> > Thanks, it's working nicely.
> >> >
> >> >
> >> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> >> index 511fbaabf624..2bd7e73ebc2a 100644
> >> >> --- a/include/linux/fs.h
> >> >> +++ b/include/linux/fs.h
> >> >> @@ -2075,6 +2075,7 @@ struct file_system_type {
> >> >>  #define FS_BINARY_MOUNTDATA  2
> >> >>  #define FS_HAS_SUBTYPE               4
> >> >>  #define FS_USERNS_MOUNT              8       /* Can be mounted by userns root */
> >> >> +#define FS_NO_IMA_CACHE              16      /* Force IMA to re-measure, re-appraise, re-audit files */
> >> >>  #define FS_RENAME_DOES_D_MOVE        32768   /* FS will handle d_move() during rename() internally. */
> >> >>       struct dentry *(*mount) (struct file_system_type *, int,
> >> >>                      const char *, void *);
> >> >>
> >> >
> >> > Since IMA is going to need another flag, we probably should have a
> >> > consistent prefix (eg. "FS_IMA").  Maybe rename this flag to
> >> > FS_IMA_NO_CACHE.
> >>
> >> Ok, I can rename it.
> >>
> >> Is there a discussion about the other IMA flag?
> >
> > There's not a single thread that I can point to, but more of an on
> > going discussion as to what it means for a filesystem to support IMA
> > and how that decision is made.
> >
> > - Initial measuring, verifying, auditing files
> > - Safely detecting when a file changes
> > - Not applicable/supported
> >
> > With Sascha Hauer's patch "ima: Use i_version only when filesystem
> > supports it" and this patch, the second issue is addressed, but will
> > cause files to be re-validated, perhaps unnecessarily, impacting
> > performance.
> >
> > Some filesystems should not be evaluated, such as pseudo filesystems
> > (eg. cgroups, sysfs, devpts, pstorefs, efivarfs, debugfs, selinux,
> > smack).  Instead of defining a flag indicating whether or not IMA is
> > applicable/supported, we should define a new flag, indicating whether
> > it is a pseudo filesystem.  This would eliminate a large portion of at
> > least the builtin IMA policy rules.
> 
> Thanks for the explanation. If that other flag is about whether it is
> a pseudo filesystem, it might not have "IMA" in the name though.

Agreed.  If we ever need to define another FS flag, we would most
likely define it in the negative (eg. FS_NO_IMA_XXXXX).  So the
current name is fine.

> >> > I'm also wondering if this change should be
> >> > separated from the IMA change.
> >>
> >> Do you mean one patch for adding the flag and the IMA change and
> >> another patch for using the flag in FUSE?
> >
> > The flag and FUSE usage of the flag, separately from IMA.
> 
> Ok, I will send a v3 with the 2 changes.

thanks,

Mimi
