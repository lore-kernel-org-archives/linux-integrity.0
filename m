Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752292AbeBAShC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 13:37:02 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w11Ia6Na110237
        for <linux-integrity@vger.kernel.org>; Thu, 1 Feb 2018 13:37:02 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fv7nc9v9h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 01 Feb 2018 13:37:02 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 1 Feb 2018 18:36:59 -0000
Subject: Re: [RFC PATCH v4 0/2] ima,fuse: introduce new fs flag
 FS_IMA_NO_CACHE
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>
Date: Thu, 01 Feb 2018 13:36:53 -0500
In-Reply-To: <cover.1517314847.git.dongsu@kinvolk.io>
References: <cover.1517314847.git.dongsu@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517510213.6675.12.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
> This patchset v4 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
> FUSE. This forces files to be re-measured, re-appraised and re-audited
> on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
> cached integrity results won't be used.

Thanks!

Mimi
