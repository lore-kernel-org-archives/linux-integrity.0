Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751028AbeEPVXH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 May 2018 17:23:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4GLJ6Oo022426
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 17:23:07 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j0qg9nh1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 17:23:07 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 16 May 2018 22:23:05 +0100
Subject: Re: [PATCH V6] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Wed, 16 May 2018 17:23:00 -0400
In-Reply-To: <20180515173826.21114-1-mjg59@google.com>
References: <20180515173826.21114-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526505780.3254.5.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-15 at 10:38 -0700, Matthew Garrett wrote:
> Sites may wish to provide additional metadata alongside files in order
> to make more fine-grained security decisions[1]. The security of this is
> enhanced if this metadata is protected, something that EVM makes
> possible. However, the kernel cannot know about the set of extended
> attributes that local admins may wish to protect, and hardcoding this
> policy in the kernel makes it difficult to change over time and less
> convenient for distributions to enable.
> 
> This patch adds a new /sys/kernel/security/integrity/evm/evm_xattrs node,
> which can be read to obtain the current set of EVM-protected extended
> attributes or written to in order to add new entries. Extending this list
> will not change the validity of any existing signatures provided that the
> file in question does not have any of the additional extended attributes -
> missing xattrs are skipped when calculating the EVM hash.
> 
> [1] For instance, a package manager could install information about the
> package uploader in an additional extended attribute. Local LSM policy
> could then be associated with that extended attribute in order to
> restrict the privileges available to packages from less trusted
> uploaders.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Calling simple_setattr() directly here - this should be safe, since
> there'd only be a different setattr() implementation if we'd passed one
> in in the first place.

Thanks, no error messages now.

Mimi
