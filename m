Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753397AbeARVZN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 16:25:13 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0ILNdNh024502
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 16:25:13 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fk277349w-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 16:25:12 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 18 Jan 2018 21:25:09 -0000
Subject: Re: [RFC PATCH v2] ima,fuse: introduce new fs flag FS_NO_IMA_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Alban Crequy <alban.crequy@gmail.com>,
        Alban Crequy <alban@kinvolk.io>
Cc: iago@kinvolk.io, dongsu@kinvolk.io, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Date: Thu, 18 Jan 2018 16:25:02 -0500
In-Reply-To: <20180116151000.443-1-alban@kinvolk.io>
References: <20180116151000.443-1-alban@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516310702.3772.11.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-01-16 at 16:10 +0100, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> This patch forces files to be re-measured, re-appraised and re-audited
> on file systems with the feature flag FS_NO_IMA_CACHE. In that way,
> cached integrity results won't be used.
> 
> For now, this patch adds the new flag only FUSE filesystems. This is
> needed because the userspace FUSE process can change the underlying
> files at any time.

Thanks, it's working nicely. 


> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 511fbaabf624..2bd7e73ebc2a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2075,6 +2075,7 @@ struct file_system_type {
>  #define FS_BINARY_MOUNTDATA	2
>  #define FS_HAS_SUBTYPE		4
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> +#define FS_NO_IMA_CACHE		16	/* Force IMA to re-measure, re-appraise, re-audit files */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	struct dentry *(*mount) (struct file_system_type *, int,
>  		       const char *, void *);
> 

Since IMA is going to need another flag, we probably should have a
consistent prefix (eg. "FS_IMA").  Maybe rename this flag to
FS_IMA_NO_CACHE.  I'm also wondering if this change should be
separated from the IMA change.

Mimi
