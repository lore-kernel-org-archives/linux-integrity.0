Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727714AbeJERtN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Oct 2018 13:49:13 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95AojSv033758
        for <linux-integrity@vger.kernel.org>; Fri, 5 Oct 2018 06:50:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mx5u1sspy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Oct 2018 06:50:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 5 Oct 2018 11:49:41 +0100
Subject: Re: Allow FUSE filesystems to provide out-of-band hashes to IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: dmitry.kasatkin@gmail.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Date: Fri, 05 Oct 2018 06:49:26 -0400
In-Reply-To: <20181004203007.217320-1-mjg59@google.com>
References: <20181004203007.217320-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538736566.3702.436.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

On Thu, 2018-10-04 at 13:30 -0700, Matthew Garrett wrote:
> As of d77ccdc644a59b412d8e101576134c90a0aa6797, IMA will trigger a
> rehash of any file on a FUSE filesystem for every measurement. This has
> a significant impact on performance. Individual FUSE filesystems may
> have the ability to identify whether a file needs to be rehashed, and
> some may even have the ability to obtain the file hash out of band
> without needing the kernel to do it. Longer term, this may also be
> usable for other scenarios where a filesystem can provide a trustworthy
> hash (eg, fs-verity on ext4 could provide a hash and then later abort
> any read()s that discover that the file doesn't match the measurement).

Really, a security vs. performance argument?!  I don't need to tell
you of all people, that one of the basic tenents of trusted boot is
calculating the actual file hash before use.  Limiting the file hash
re-calculation is one thing, but relying on some out of band method of
obtaining the file hash without the kernel ever calculating it is
totally different.  The only exception will be for fs-verity, which
will return not the file hash, but the file's Merkle tree root hash.

If you want to introduce support for identifying whether a FUSE file,
on a trusted mount, needs to be rehashed, that's fine.  It should not
be the default behavior.

Mimi
