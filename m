Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbeJPVHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Oct 2018 17:07:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GDEIxT144689
        for <linux-integrity@vger.kernel.org>; Tue, 16 Oct 2018 09:16:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n5fvpk0mg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Oct 2018 09:16:54 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 16 Oct 2018 14:16:52 +0100
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Tue, 16 Oct 2018 09:16:36 -0400
In-Reply-To: <CACdnJuvWaVXcRcDBPtZCWrJsWX8-rXRbc3bWjtrx=8-4m0uetQ@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <20181004203007.217320-3-mjg59@google.com>
         <1539271386.11939.79.camel@linux.ibm.com>
         <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
         <1539298987.11939.136.camel@linux.ibm.com>
         <CACdnJuvrATdx2giEvddU38SMKp2oj1XjHqEbs88fuUOekHyDLw@mail.gmail.com>
         <1539567497.11939.198.camel@linux.ibm.com>
         <CACdnJuvWaVXcRcDBPtZCWrJsWX8-rXRbc3bWjtrx=8-4m0uetQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539695796.11939.273.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-10-15 at 11:46 -0700, Matthew Garrett wrote:
> On Sun, Oct 14, 2018 at 6:38 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Fri, 2018-10-12 at 11:31 -0700, Matthew Garrett wrote:
> > > There's a couple of ways. We could extend the filesystem type matching
> > > logic to also check the subtype - you'd then need to enforce that at
> > > the LSM level in order to protect against untrusted filesystems
> > > spoofing the filesystem type. Alternatively, we could add an
> > > additional policy match type for mount point and iterate through
> > > s_mounts on the superblock - if any match, we could define the policy
> > > there?
> >
> > The first method differentiates between different subtypes of FUSE
> > filesystems, while the second method allows differentiating between
> > the same type and subtype on different mount points.  Both criteria
> > are needed, but instead of the second method based on a mount point,
> > perhaps based instead on a mount flag?
> 
> Patch 3 already requires that the allow_gethash option be passed for
> this to work - I can restrict that to CAP_SYS_ADMIN?

In the case of FUSE filesystems, using "gethash" should be limited to
trusted mounts, not fileystems mounted with SB_I_UNTRUSTED_MOUNTER.
 So requiring CAP_SYS_ADMIN seems unnecessary.  The difference in the
approaches is that root has CAP_SYS_ADMIN, while providing a mount
flag requires intention.

> 
> > Trusted mount of permitted filesystem type and subtype, that is
> > mounted with the defined mount flag.
> 
> Ok, I'll write up a patch that allows policy matching of filesystem
> subtype as well as type and try to get that posted this week so we can
> discuss it in Edinburgh?

Sounds good.  Hopefully I'll have time to review it before Edinburgh.

Mimi
