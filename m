Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751772AbdJYL4t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 07:56:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9PBu8K5069748
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 07:56:48 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dtshvhycf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2017 07:56:48 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 25 Oct 2017 12:56:45 +0100
Subject: Re: [PATCH V3] EVM: Add support for portable signature format
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Wed, 25 Oct 2017 07:56:40 -0400
In-Reply-To: <20171025095413.25794-1-mjg59@google.com>
References: <20171025095413.25794-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508932600.7367.13.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-25 at 02:54 -0700, Matthew Garrett wrote:
> The EVM signature includes the inode number and (optionally) the
> filesystem UUID, making it impractical to ship EVM signatures in
> packages. This patch adds a new portable format intended to allow
> distributions to include EVM signatures. It is identical to the existing
> format but hardcodes the inode and generation numbers to 0 and does not
> include the filesystem UUID even if the kernel is configured to do so.
> 
> Removing the inode means that the metadata and signature from one file
> could be copied to another file without invalidating it. This is avoided
> by ensuring that an IMA xattr is present during EVM validation.
> 
> Based on earlier work by Dmitry Kasatkin and Mikhail Kurinnoi.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
> ---
> V3: include feedback from Mimi.

Some checks are still missing to prevent the portable/immutable
signature from being replaced with an HMAC (eg. setattr, removexattr,
etc).

Mimi
