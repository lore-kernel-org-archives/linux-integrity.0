Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbeJJBWj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Oct 2018 21:22:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w99I4HIC189779
        for <linux-integrity@vger.kernel.org>; Tue, 9 Oct 2018 14:04:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n0xcvg5ky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 14:04:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 9 Oct 2018 19:04:25 +0100
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Tue, 09 Oct 2018 14:04:19 -0400
In-Reply-To: <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
         <1538997900.15382.90.camel@linux.ibm.com>
         <CACdnJutwqyKwimcxAY4XNKv2fcyyg7aTJkoKY+XT-XnWLeU4aA@mail.gmail.com>
         <1539038432.15382.181.camel@linux.ibm.com>
         <CACdnJuszN9KRujTpGLWH2XCbotxMrLf+5nrr4P5K3yO7BBxWJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539108259.15382.221.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-10-09 at 10:21 -0700, Matthew Garrett wrote:
> On Mon, Oct 8, 2018 at 3:40 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Mon, 2018-10-08 at 13:19 -0700, Matthew Garrett wrote:
> > > We trust that the filesystem will return us accurate binaries and
> > > hashes, but we don't the binaries themselves may not be trustworthy -
> > > we want the same level of audit trail associated with their execution
> > > that we'd have for something run off local disk. We could certainly
> > > rearchitect our filesystems to generate audit events themselves, but
> > > we'd be duplicating functionality that already exists in the kernel.
> >
> > I'm really not comfortable with the FUSE filesystem calculating the
> > file hash being used by IMA.  Adding FUSE i_version support would have
> > been better, instead of returning the actual file hash.  Based on a
> > mount option and the i_version, the kernel could then decide whether
> > or not to limit re-calculating the file hash.
> 
> Well, there's a performance benefit as well - reading 500MB
> executables over the network is time consuming and otherwise mostly
> unnecessary. Given two solutions that have the same properties in
> terms of which components we need to trust, why not pick the one
> that's faster?

With the existing cover letter, the purpose of this patch set should
be to address the performance of calculating the file hash on trusted
local FUSE mounted filesystems, not remote filesystems or fs-verity
filesystems.

Mimi
