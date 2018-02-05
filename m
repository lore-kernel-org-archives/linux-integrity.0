Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753197AbeBEQht (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Feb 2018 11:37:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w15GbKs6114026
        for <linux-integrity@vger.kernel.org>; Mon, 5 Feb 2018 11:37:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fxqtv9kpy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Feb 2018 11:37:48 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 5 Feb 2018 16:37:46 -0000
Subject: Re: [RFC PATCH] ima: force the re-evaluation of files on untrusted
 file systems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        Alban Crequy <alban@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date: Mon, 05 Feb 2018 11:37:40 -0500
In-Reply-To: <CAJfpegvjZj-F-8kJaa7PkdykJn997AG383CcW7tiSGUYcq+BEA@mail.gmail.com>
References: <1517838054.3736.49.camel@linux.vnet.ibm.com>
         <1517845858.3050.13.camel@HansenPartnership.com>
         <CAJfpegtDqsW1PQ3-jkGbLykL_u1WgsTcKYG4N1Hp__K__H3Pqg@mail.gmail.com>
         <1517847712.3736.96.camel@linux.vnet.ibm.com>
         <CAJfpegvjZj-F-8kJaa7PkdykJn997AG383CcW7tiSGUYcq+BEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517848660.3736.101.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-02-05 at 17:30 +0100, Miklos Szeredi wrote:
> On Mon, Feb 5, 2018 at 5:21 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Mon, 2018-02-05 at 17:12 +0100, Miklos Szeredi wrote:
> >> On Mon, Feb 5, 2018 at 4:50 PM, James Bottomley
> >> <James.Bottomley@hansenpartnership.com> wrote:
> >> > On Mon, 2018-02-05 at 08:40 -0500, Mimi Zohar wrote:
> >> >> On filesystems, such as fuse or remote filesystems, that we can not
> >> >> detect or rely on the filesystem to tell us when a file has changed,
> >> >> always re-measure, re-appraise, and/or re-audit the file.
> >> >
> >> > Using the presence or absence of d_revalidate isn't definitive for
> >> > uncacheable appraisals: all stacked filesystems have to implement
> >> > d_revalidate just in case the underlying has it, but it doesn't mean
> >> > their appraisals can't be cached if they're fully built on top of
> >> > traditional filesystems (like they are in the Docker/OCI use case).  I
> >> > think the original flag approach is better.  The only thing stackable
> >> > filesystems argues for is that for them it should probably be a
> >> > superblock flag so it can be per-mount point (depending on overlay
> >> > composition).
> >> >
> >> > d_revalidate() also strikes me as wrong from the semantic point of
> >> > view: it's about whether the path name to inode cache needs re-
> >> > evaluating not whether the underlying inode could change arbitrarily.
> >> >  These are definitely related but not necessarily equivalent concepts.
> >>
> >> True.  A more precise indication is whether cache pages have been
> >> invalidated for a certain inode.   Can we used that?  I.e.
> >> invalidate_inode_pages*() calls down into IMA or sets a flags or
> >> whatever to indicate that the file contents might have changed.
> >
> > I don't think that works for the FUSE use case.
> 
> Okay, it's true that cache invalidation is just a hint about file
> contents changing.  The file contents could change without cache
> invalidation if userspace filesystem is buggy or malicious.

Right, the untrusted, malicious userspace filesystem is the reason for
Alban's patches.  Can you review/ack those patches?

thanks,

Mimi
