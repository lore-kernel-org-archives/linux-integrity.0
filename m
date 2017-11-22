Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41883 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdKVUNJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Nov 2017 15:13:09 -0500
Received: by mail-wr0-f194.google.com with SMTP id z14so15650316wrb.8
        for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2017 12:13:08 -0800 (PST)
Date: Wed, 22 Nov 2017 13:13:03 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: flihp <flihp@twobit.us>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        "Roberts, William C" <william.c.roberts@intel.com>
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
Message-ID: <20171122201303.GT18272@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
 <DB638850A6A2434A93ECADDA0BC838905F09D5D9@ORSMSX103.amr.corp.intel.com>
 <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 22, 2017 at 09:16:25AM -0800, flihp wrote:

> We can work around quirks in the kernel RM in user space if we must
> (short term?) but I'm hesitant to do so in this case. Would feel better
> about a short term work-around knowing it's only going to be short term.

Pedantically, the kernel is not implementing a RM as per some spec, it
is using the TPM features to create isolation.

Both sides can be argued. In this case, I think the patch to add a TPM
response buffer in this one case is reasonable, and does not look so
complicated that it is dangerous in the kernel.

However the kernel will continue to return errnos in various cases,
and a userspace that cannot handle them is kinda broken :)

Jason
