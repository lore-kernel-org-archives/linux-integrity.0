Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbeCNRux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 13:50:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EHoVli057963
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 13:50:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq6new78s-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 13:50:52 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 17:50:49 -0000
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Stef Bon <stefbon@gmail.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        chuck Lever <chuck.lever@oracle.com>,
        Michael Halcrow <mhalcrow@google.com>
Date: Wed, 14 Mar 2018 13:50:41 -0400
In-Reply-To: <877eqer5r6.fsf@xmission.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
         <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
         <1521032461.3547.404.camel@linux.vnet.ibm.com>
         <877eqer5r6.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521049841.3547.500.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-14 at 11:17 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > On Wed, 2018-03-14 at 08:52 +0100, Stef Bon wrote:
> >> I do not have any comments about the patches but a question.
> >> I completely agree that the files can change without the VFS knowing
> >> about it, but isn't that in general the case with filesystems with a
> >> backend shared with others (network fs's?).
> >
> > Right, the problem is not limited to fuse, but needs to be addressed
> > before unprivileged fuse mounts are upstreamed.
> >
> > Alban's response to this question:
> > https://marc.info/?l=linux-kernel&m=151784020321045&w=2
> 
> Which goes to why it is a flag that get's set.
> 
> All of this just needs a follow-up patch to update every filesystem
> that does not meet ima's requirements.

Currently files on remote filesystems are measured/appraised/audited
once.  With the new flags, our options would be to either fail the
signature verification or constantly re-measure/re-appraise files on
remote file systems.  Neither option seems like the right solution.

There's some very initial discussions on how to support file integrity
on remote filesystems.  Chuck Lever has some thoughts on piggy-backing 
on the fs-verity work being done.  From a very, very high level, IMA-
appraisal would verify the file signature, but leave the integrity
enforcement to the vfs/fs layer.  By integrating fs-verity or similar
proposal with IMA, measurements would be included in the measurement
list and keys used for file signature verification would use the same
existing IMA-appraisal infrastructure.

> Mimi I believe you said that the requirement is that all file changes
> can be detected through the final __fput of a file that calls
> ima_file_free.

Right, like for fuse, I don't believe this existing hook works for
remote filesystems.

Mimi
