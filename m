Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753760AbdLGOgH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Dec 2017 09:36:07 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB7EYrHV071671
        for <linux-integrity@vger.kernel.org>; Thu, 7 Dec 2017 09:36:06 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eq57r80pt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 07 Dec 2017 09:36:05 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 14:36:04 -0000
Subject: Re: [RFC PATCH 2/4] ima: define new ima_sb_post_new_mount hook
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jeff Layton <jlayton@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 07 Dec 2017 09:35:59 -0500
In-Reply-To: <1512649584.1350.14.camel@redhat.com>
References: <1502904620-20075-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1502904620-20075-3-git-send-email-zohar@linux.vnet.ibm.com>
         <1512649584.1350.14.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512657359.3527.49.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Jeff,

[The IMA/EVM and the TPM mailing lists have been combined as a single
linux-integrity mailing list.]

On Thu, 2017-12-07 at 07:26 -0500, Jeff Layton wrote:
> Sorry for the late review. I just started dusting off my i_version
> rework, and noticed that IMA still has unaddressed problems here.

<snip>

> Personally, I'm not a huge fan of this scheme. It seems quite invasive,
> and doesn't really seem to address the stated problem well.

A cleaned up version of this patch set was meant to follow the
introduction of a new integrity_read method, but that patch set was
rejected.  At this point, I have no intentions of upstreaming a
cleaned up version this patch set either.

> The warning itself seems ok, but I don't really see what's wrong with
> performing remeasurement when the mtime changes on filesystems that
> don't have SB_I_VERSION set. Surely that's better than limiting it to an
> initial measurement?
> 
> Maybe I just don't understand what you're really trying to achieve here.

Based on discussions with Sascha Hauer, he convinced me the i_version
test is basically just a performance improvement and posted a patch
that checks the filesystem for i_version support, before relying on it
-  https://www.spinics.net/lists/linux-integrity/msg00033.html.

Mimi
