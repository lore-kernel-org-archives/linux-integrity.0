Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbeJJELm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 00:11:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w99KngZm043934
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 16:52:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n11vamk4c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 16:52:55 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 9 Oct 2018 21:52:52 +0100
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 09 Oct 2018 16:52:47 -0400
In-Reply-To: <CACdnJus_N41kbJ9SdWSi-q3b-=Z7RRnfGSU1sXnKfdBmFL5j4A@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
         <1538997900.15382.90.camel@linux.ibm.com>
         <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
         <1539038432.15382.181.camel@linux.ibm.com>
         <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
         <1539108259.15382.221.camel@linux.ibm.com>
         <CACdnJus_N41kbJ9SdWSi-q3b-=Z7RRnfGSU1sXnKfdBmFL5j4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539118367.15382.247.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-10-09 at 12:29 -0700, Matthew Garrett wrote:
> On Tue, Oct 9, 2018 at 11:04 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2018-10-09 at 10:21 -0700, Matthew Garrett wrote:
> > > Well, there's a performance benefit as well - reading 500MB
> > > executables over the network is time consuming and otherwise mostly
> > > unnecessary. Given two solutions that have the same properties in
> > > terms of which components we need to trust, why not pick the one
> > > that's faster?
> >
> > With the existing cover letter, the purpose of this patch set should
> > be to address the performance of calculating the file hash on trusted
> > local FUSE mounted filesystems, not remote filesystems or fs-verity
> > filesystems.
> 
> The performance hit is more noticeable over remote filesystems, but we
> have large binaries that take several seconds to hash even on local
> filesystems. Would it be helpful to try to define the assumptions that
> IMA makes in terms of whether or not it produces trustworthy results?
> It feels like it's be easier to talk about this if we have a more
> formal set of conditions to take into consideration.

[Cc'ing Chuck Lever]

Integrity of files on remote filesystems should probably be discussed
in the context of fs-verity, not FUSE filesystems.

Do you want to continue the discussion here or perhaps as an LSS-EU
BoF?

Mimi
