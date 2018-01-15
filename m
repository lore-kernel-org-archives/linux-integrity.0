Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966312AbeAOQkS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 11:40:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0FGddMv089868
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 11:40:18 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fh00rg0xq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2018 11:40:17 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 15 Jan 2018 16:40:14 -0000
Subject: Re: [PATCH] ima: define new policy condition based on the
 filesystem name
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>
Date: Mon, 15 Jan 2018 11:40:07 -0500
In-Reply-To: <20180115162726.GB15686@infradead.org>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
         <20180115162726.GB15686@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516034407.6607.26.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-01-15 at 08:27 -0800, Christoph Hellwig wrote:
> On Mon, Jan 15, 2018 at 11:20:36AM -0500, Mimi Zohar wrote:
> > Some filesystems do not export the filesystem's magic number, as it is
> > considered internal, private data.  In other cases, the policy rule
> > needs to identify a specifically mounted filesystem (eg. rootfs).
> 
> No, it doesn't.  Policies based on a file system type are complete and
> utterly bogus.   rootfs should not be treated any different from other
> file systems.

rootfs IS different than other filesystems, as other filesystems
uniquely identify the underlying filesystem type.  rootfs can be a
ramfs or tmpfs filesystem.  Only tmpfs supports xattrs.

Mimi
