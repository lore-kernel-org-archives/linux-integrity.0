Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbeJLGcv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Oct 2018 02:32:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BMxlAv012990
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 19:03:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n2d9k5d2x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 19:03:23 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 12 Oct 2018 00:03:22 +0100
Subject: Re: [PATCH 2/3] IMA: Make use of filesystem-provided hashes
From: Mimi Zohar <zohar@linux.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date: Thu, 11 Oct 2018 19:03:07 -0400
In-Reply-To: <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
References: <20181004203007.217320-1-mjg59@google.com>
         <20181004203007.217320-3-mjg59@google.com>
         <1539271386.11939.79.camel@linux.ibm.com>
         <CACdnJuvGp_3hs16kL1Vg9eXL4i=T=bXw9i5_7KTT0F+J4p9y4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1539298987.11939.136.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-10-11 at 13:30 -0700, Matthew Garrett wrote:
> On Thu, Oct 11, 2018 at 8:23 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2018-10-04 at 13:30 -0700, Matthew Garrett wrote:
> > > Some filesystems may be able to provide hashes in an out of band manner,
> > > and allowing them to do so is a performance win. This is especially true
> > > of FUSE-based filesystems where otherwise we recalculate the hash on
> > > every measurement. Make use of this by default, but provide a parameter
> > > to force recalculation rather than trusting the filesystem.
> > >
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> >
> > Support for not calculating the file hash would need to be finer
> > grained than this, probably on a per mount basis.  The default should
> > be for IMA to always calculate the file hash, unless explicitly told
> > not to.
> 
> Ok, should this just be part of the IMA policy?

How would you be able to differentiate between different FUSE
filesystems for example?

> 
> > IMA should never skip the file hash calculation if the filesystem is
> > an untrusted mount (eg. SB_I_UNTRUSTED_MOUNTER).
> 
> Ok.
> 
