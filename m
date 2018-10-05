Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbeJFBSm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 21:18:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95IB1Ca055037
        for <linux-integrity@vger.kernel.org>; Fri, 5 Oct 2018 14:18:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxd050f0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Oct 2018 14:18:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 5 Oct 2018 19:18:47 +0100
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Fri, 05 Oct 2018 14:18:41 -0400
In-Reply-To: <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538763521.3541.31.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-05 at 10:26 -0700, Matthew Garrett wrote:
> On Fri, Oct 5, 2018 at 3:49 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > Really, a security vs. performance argument?!  I don't need to tell
> > you of all people, that one of the basic tenents of trusted boot is
> > calculating the actual file hash before use.  Limiting the file hash
> > re-calculation is one thing, but relying on some out of band method of
> > obtaining the file hash without the kernel ever calculating it is
> > totally different.  The only exception will be for fs-verity, which
> > will return not the file hash, but the file's Merkle tree root hash.
> 
> Using FUSE means you're inherently accepting the risk of TOCTOU.
> Having the kernel read everything once and hash it is no guarantee
> that the filesystem will return the same value on further reads, so if
> you're going to use FUSE in an environment where you're using IMA then
> you already need to assert that your filesystems are trustworthy.

Right, the correct behavior should be not to trust FUSE filesystems,
but since we don't break userspace there is the
"ima_policy=fail_securely" boot command line option.

Mimi
