Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51832 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932315AbdJYJ46 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 05:56:58 -0400
Date: Wed, 25 Oct 2017 11:56:44 +0200 (CEST)
From: James Morris <james.l.morris@oracle.com>
To: Matthew Garrett <mjg59@google.com>
cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Subject: Re: [PATCH V3] EVM: Add support for portable signature format
In-Reply-To: <20171025095413.25794-1-mjg59@google.com>
Message-ID: <alpine.LFD.2.20.1710251156250.28511@localhost>
References: <20171025095413.25794-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 25 Oct 2017, Matthew Garrett wrote:

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


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>
