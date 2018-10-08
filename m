Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbeJHSgg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 14:36:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98BJQ1Z038892
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 07:25:19 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n031r3g08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 07:25:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 12:25:16 +0100
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Mon, 08 Oct 2018 07:25:00 -0400
In-Reply-To: <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <1538736566.3702.436.camel@linux.ibm.com>
         <CACdnJusoTGYAZgK3eTEew=HtUpuY4ra_6eQyGa4WWxjZPagXjQ@mail.gmail.com>
         <1538763521.3541.31.camel@linux.ibm.com>
         <CACdnJusqSSXhLHQUAeQz-s_fgvfKGNe_4Ws17T0GuCZGiVXPhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538997900.15382.90.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-10-05 at 12:25 -0700, Matthew Garrett wrote:
> On Fri, Oct 5, 2018 at 11:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > Right, the correct behavior should be not to trust FUSE filesystems,
> > but since we don't break userspace there is the
> > "ima_policy=fail_securely" boot command line option.
> 
> There seem to be two scenarios:
> 
> 1) You trust FUSE mounts, perhaps because you have some other policy
> in place to ensure that only trusted binaries can mount stuff. In this
> scenario you already trust that the filesystem will give you
> consistent results when you read data from it - 

In the trusted mount scenario, we trust the data should not change
between calculating the file hash and reading the file data, making it
similar to other local filesystems.  Unlike other local filesystems,
however, we can't detect when the file changes.  For this reason we
need to re-calculate the file hash to measure/appraise the file each
time.

> it seems reasonable to
> also trust it to give you back an accurate hash if you ask for one.

Going from trusting the filesystem to behave properly, to trusting the
file hash that the filesystem provides is a major leap.  We don't do
this today for any local filesystem.

> 2) You don't trust FUSE mounts, in which case you pass
> ima_policy=fail_securely. This patch doesn't change that behaviour.
> 
> I agree that using FUSE in general is incompatible with IMA's goals,
> but it's possible to configure systems where you can ensure that only
> trustworthy code is involved. In that scenario this patch improves
> performance without compromising security.

If you trust a FUSE filesystem to not only behave properly, but also
to return file hashes, what is the value of measuring/appraising the
files?  Define a custom policy that doesn't measure/appraise files on
FUSE filesystems.

Mimi
