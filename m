Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750733AbeAOVAc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 16:00:32 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0FKwrQO018885
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 16:00:32 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fh0a5rybx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 16:00:32 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 15 Jan 2018 21:00:30 -0000
Subject: Re: [PATCH 0/2] turn on force option for FUSE in builtin policies
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org,
        Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Mon, 15 Jan 2018 16:00:23 -0500
In-Reply-To: <20180115171825.GA28088@infradead.org>
References: <cover.1515682581.git.dongsu@kinvolk.io>
         <20180115144804.GA28856@infradead.org>
         <1516033961.6607.18.camel@linux.vnet.ibm.com>
         <20180115171825.GA28088@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516050023.6607.57.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-01-15 at 09:18 -0800, Christoph Hellwig wrote:
> On Mon, Jan 15, 2018 at 11:32:41AM -0500, Mimi Zohar wrote:
> > For XFS, which considers fsmagic numbers private to the filesystem,
> > *always* using the fsmagic number is wrong.  As to whether this is
> > true for other filesystems is unclear.  IMA policies have been defined
> > in terms of fsmagic numbers for a long time.  fsmagic numbers were
> > moved from the filesystems to magic.h for this purpose.  Someone would
> > have complained earlier if it is always wrong.
> >  
> > I just posted a patch titled "ima: define new policy condition based
> > on the filesystem name" to allow policies to be defined in terms of
> > the i_sb->s_type->name.
> 
> ima has no business looking at either the name _or_ the magic number.

There are a couple of reasons to define policies in terms of the
filesystem name or magic numbers.

One example is pseudo filesystems (eg. pseudo filesystems - sysfs,
securitys, cgroups, selinuxfs, etc).  These should never be measured
or appraised.

The current example is fuse and remote file systems.  These should
always be re-evaluated and not rely on cached file info.

If not based on IMA policy, what do you propose?  Define new SB_ flags
 to indicate IMA disabled/enabled (eg. SB_IMA) and nocaching (eg.
SB_IMA_NOCACHE)?

Mimi
