Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752441AbeBBQ7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 11:59:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w12Gs0to070328
        for <linux-integrity@vger.kernel.org>; Fri, 2 Feb 2018 11:59:14 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fvtexm64d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 02 Feb 2018 11:59:13 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 2 Feb 2018 16:59:12 -0000
Subject: Re: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag
 FS_IMA_NO_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
        linux-integrity@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org
Date: Fri, 02 Feb 2018 11:59:04 -0500
In-Reply-To: <CAJfpegvt5W-q0W8_VRML-MNW6+n2ZQYW+51utRXDDKSbvsqf3w@mail.gmail.com>
References: <cover.1517314847.git.dongsu@kinvolk.io>
         <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
         <1517584816.3171.61.camel@linux.vnet.ibm.com>
         <1517585624.3171.64.camel@linux.vnet.ibm.com>
         <CAJfpegvt5W-q0W8_VRML-MNW6+n2ZQYW+51utRXDDKSbvsqf3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517590744.3171.89.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-02 at 17:10 +0100, Miklos Szeredi wrote:
> On Fri, Feb 2, 2018 at 4:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Fri, 2018-02-02 at 10:20 -0500, Mimi Zohar wrote:
> >> Hi Miklos,
> >>
> >> On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
> >> > From: Alban Crequy <alban@kinvolk.io>
> >> >
> >> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
> >> > re-appraised and re-audited each time. Cached integrity results should
> >> > not be used.
> >> >
> >> > It is useful in FUSE because the userspace FUSE process can change the
> >> > underlying files at any time without notifying the kernel.
> 
> I don't really have an understanding what IMA is doing, I think the
> same thing applies to any network filesystem (i.e. ones with
> d_revalidate).
> 
> Isn't that the case?

IMA is calculating the file hash, for inclusion in the measurement
list, verifying the file signature stored in the xattr, or both.  For
the remote filesystem case, re-calculating the file hash would be
limited to inclusion in the measurement list.  For FUSE, the kernel
has access to the xattr, so re-calculating the file hash could also be
used to re-verify the file signature.

Mimi
