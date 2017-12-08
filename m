Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:46162 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdLHUUt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 15:20:49 -0500
Received: by mail-wr0-f179.google.com with SMTP id x49so11848530wrb.13
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 12:20:49 -0800 (PST)
Date: Fri, 8 Dec 2017 13:20:45 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ken Goldman <kgold@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
Message-ID: <20171208202045.GA19705@ziepe.ca>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
 <DB638850A6A2434A93ECADDA0BC838905F09D5D9@ORSMSX103.amr.corp.intel.com>
 <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
 <20171122201303.GT18272@ziepe.ca>
 <5c695f48-77f2-b3ca-8d71-118c44161d50@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c695f48-77f2-b3ca-8d71-118c44161d50@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 03:16:53PM -0500, Ken Goldman wrote:

> First, to handle the error, the user space TSS would have to know that the
> RM is mapping what would normally (with the simulator or /dev/tpm0) be the
> usual TPM response packet.  This mapping isn't documented anywhere.

There are lots of failure cases that have nothing to do with the TPM,
and I really don't want to see complex code mapping traditional POSIX
errors into TPM packets in the kernel.

If you need that, do it in userspace??

Jason
