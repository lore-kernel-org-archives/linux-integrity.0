Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031364AbeBNPgU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Feb 2018 10:36:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EFXnuX117111
        for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2018 10:36:19 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g4p10p3vf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2018 10:36:19 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 14 Feb 2018 15:36:16 -0000
Subject: Re: [RFC PATCH 2/4] ima: fail signature verification on
 unprivileged & untrusted filesystems
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
Date: Wed, 14 Feb 2018 10:36:09 -0500
In-Reply-To: <20180214151637.GA2671@mail.hallyn.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
         <20180214144903.GA1953@mail.hallyn.com>
         <1518620899.5667.10.camel@linux.vnet.ibm.com>
         <20180214151637.GA2671@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1518622569.5667.26.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-02-14 at 09:16 -0600, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > On Wed, 2018-02-14 at 08:49 -0600, Serge E. Hallyn wrote:
> > > Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > > > Files on untrusted filesystems, such as fuse, can change at any time,
> > > > making the measurement(s) and by extension signature verification
> > > > meaningless.
> > > > 
> > > > FUSE can be mounted by unprivileged users either today with fusermount
> > > > installed with setuid, or soon with the upcoming patches to allow FUSE
> > > > mounts in a non-init user namespace.
> > > > 
> > > > This patch always fails the file signature verification on unprivileged
> > > > and untrusted filesystems.  To also fail file signature verification on
> > > 
> > > Why only untrusted?  Fuse could cause the same issue if it just
> > > messes up when mounted from init userns right?
> > 
> > Right, whether it is an unprivileged mount or not, fuse can return
> > whatever it wants, whenever it wants.  IMA can calculate the file hash
> > based based on what it reads, but fuse can return whatever it wants on
> > subsequent reads.
> 
> Ok but your patch seems to let privileged fuse mounts slide?  (see below)

Unprivileged fuse mounts hasn't been upstreamed yet, so we wouldn't be
breaking existing userspace.

> 
> > Refer to the discussion with Linus - http://kernsec.org/pipermail/linu
> > x-security-module-archive/2018-February/005200.html
> > 
> > > > privileged, untrusted filesystems requires a custom policy.
> > > 
> > > (I'm not saying you shouldn't do this, but) does this mean that
> > > a container whose rootfs is fuse-mounted by the unprivileged user
> > > cannot possibly use IMA?
> > 
> > How would you suggest to differentiate between your unprivileged fuse
> > mounts from unintended, unintended malicious ones?
> 
> I wouldn't.

What happened to the requirement that systems should be "fail-safe"?
Ok, hard coding this rule probably is not a good idea.  For those
wanting to take this liability on their systems, we can make this
configurable, like for privileged fuse mounts.  Unlike for privileged
fuse mounts, the builtin policies, I think, should be fail safe and
include the "fail" rule for unprivileged fuse mounts.

> 
> > The remaining patches are policy based.
> > 
> > > Good thing we can partially work around that by intercepting real
> > > mount calls with Tycho's new patchset :)
> > 
> > Can you provide a little more details?
> 
> It would allow a container runtime to intercept mount(2) and perform
> a real mount on the user's behalf.  Assuming the runtime is privileged,
> of course, otherwise it would intercept and do a fuse mount which is
> no help here :)
> 
> https://lkml.org/lkml/2018/2/4/28

thanks!

Mimi
