Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966728AbeAOQcv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 11:32:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0FGUCo8098581
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 11:32:51 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fgvs6sd97-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 11:32:50 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 15 Jan 2018 16:32:47 -0000
Subject: Re: [PATCH 0/2] turn on force option for FUSE in builtin policies
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
        Dongsu Park <dongsu@kinvolk.io>
Cc: linux-kernel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Mon, 15 Jan 2018 11:32:41 -0500
In-Reply-To: <20180115144804.GA28856@infradead.org>
References: <cover.1515682581.git.dongsu@kinvolk.io>
         <20180115144804.GA28856@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516033961.6607.18.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-01-15 at 06:48 -0800, Christoph Hellwig wrote:
> On Thu, Jan 11, 2018 at 08:51:48PM +0100, Dongsu Park wrote:
> > In case of FUSE filesystem, cached integrity results in IMA could be
> > reused, when the userspace FUSE process has changed the
> > underlying files. To be able to avoid such cases, we need to turn on
> > the force option in builtin policies, for actions of measure and
> > appraise. Then integrity values become re-measured and re-appraised.
> > In that way, cached integrity results won't be used.
> 
> The same is true for any distributed file system.  Checking for magic
> numbers is always the wrong thing.  You'll need flags for specific
> behavior in struct file_system_type instead.

For XFS, which considers fsmagic numbers private to the filesystem,
*always* using the fsmagic number is wrong.  As to whether this is
true for other filesystems is unclear.  IMA policies have been defined
in terms of fsmagic numbers for a long time.  fsmagic numbers were
moved from the filesystems to magic.h for this purpose.  Someone would
have complained earlier if it is always wrong.
 
I just posted a patch titled "ima: define new policy condition based
on the filesystem name" to allow policies to be defined in terms of
the i_sb->s_type->name.

Mimi
