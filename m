Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031649AbeBNPvz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Feb 2018 10:51:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1EFpoNw135760
        for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2018 10:51:55 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g4mgptffv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2018 10:51:51 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 14 Feb 2018 15:49:52 -0000
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
Date: Wed, 14 Feb 2018 10:49:46 -0500
In-Reply-To: <20180214154255.GA3087@mail.hallyn.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
         <20180214144903.GA1953@mail.hallyn.com>
         <1518620899.5667.10.camel@linux.vnet.ibm.com>
         <20180214151637.GA2671@mail.hallyn.com>
         <1518622569.5667.26.camel@linux.vnet.ibm.com>
         <20180214154255.GA3087@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1518623386.5667.30.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-02-14 at 09:42 -0600, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > On Wed, 2018-02-14 at 09:16 -0600, Serge E. Hallyn wrote:
> > > Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > > > On Wed, 2018-02-14 at 08:49 -0600, Serge E. Hallyn wrote:
> > > > > Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > > > > > Files on untrusted filesystems, such as fuse, can change at any time,
> > > > > > making the measurement(s) and by extension signature verification
> > > > > > meaningless.
> > > > > > 
> > > > > > FUSE can be mounted by unprivileged users either today with fusermount
> > > > > > installed with setuid, or soon with the upcoming patches to allow FUSE
> > > > > > mounts in a non-init user namespace.
> > > > > > 
> > > > > > This patch always fails the file signature verification on unprivileged
> > > > > > and untrusted filesystems.  To also fail file signature verification on
> > > > > 
> > > > > Why only untrusted?  Fuse could cause the same issue if it just
> > > > > messes up when mounted from init userns right?
> > > > 
> > > > Right, whether it is an unprivileged mount or not, fuse can return
> > > > whatever it wants, whenever it wants.  IMA can calculate the file hash
> > > > based based on what it reads, but fuse can return whatever it wants on
> > > > subsequent reads.
> > > 
> > > Ok but your patch seems to let privileged fuse mounts slide?  (see below)
> > 
> > Unprivileged fuse mounts hasn't been upstreamed yet, so we wouldn't be
> > breaking existing userspace.
> 
> I don't think I'm being clear.
> 
> In your patch it looks like you mark unprivileged FUSE mounts as
> INTEGRITY_FAIL.  I agree you should do that.  But you skip the
> FS_UNTRUSTED check for privileged FUSE mounts.  I'm asking why
> that's ok.
> 
> > > > Refer to the discussion with Linus - http://kernsec.org/pipermail/linu
> > > > x-security-module-archive/2018-February/005200.html
> > > > 
> > > > > > privileged, untrusted filesystems requires a custom policy.
> > > > > 
> > > > > (I'm not saying you shouldn't do this, but) does this mean that
> > > > > a container whose rootfs is fuse-mounted by the unprivileged user
> > > > > cannot possibly use IMA?
> > > > 
> > > > How would you suggest to differentiate between your unprivileged fuse
> > > > mounts from unintended, unintended malicious ones?
> > > 
> > > I wouldn't.
> > 
> > What happened to the requirement that systems should be "fail-safe"?
> 
> My point was - I was asking whether there was any way to have IMA be
> meaningful with such containers, not saying I had any ideas, and
> certainly not saying that just because you can't detect it means you
> should allow it in all cases.  It's too bad that it has this effect,
> but I agree with your patch.
> 
> I only didn't ack it because you're skipping the check for privileged
> mounts which seems wrong.

Oh!  That is based on Linus' "request" not to break userspace.

Mimi
