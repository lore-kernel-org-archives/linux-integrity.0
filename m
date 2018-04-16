Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751159AbeDPUQs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Apr 2018 16:16:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3GKFnVj029372
        for <linux-integrity@vger.kernel.org>; Mon, 16 Apr 2018 16:16:48 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hd0wrcnds-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 16 Apr 2018 16:16:48 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 16 Apr 2018 21:16:46 +0100
Subject: Re: [PATCH] EVM: Allow runtime modification of the set of verified
 xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Mon, 16 Apr 2018 16:16:42 -0400
In-Reply-To: <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com>
References: <20180413225220.20130-1-mjg59@google.com>
         <1523801140.3272.187.camel@linux.vnet.ibm.com>
         <CACdnJutNLdkqaz0UfveSq_vYBZ37Qx8DkfGWKR3_=bcLpj5MwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523909802.3272.238.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-04-16 at 18:32 +0000, Matthew Garrett wrote:
> On Sun, Apr 15, 2018 at 7:05 AM Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> > Although evm_config_xattrnames is not currently defined as a const, it
> > should have been.  Including additional xattrs via a securityfs file,
> > limits how the memory for the entire list of xattrs and the pointer to
> > that list can be protected.
> 
> Right, I did wonder about that.
> 
> > Does this extra list of xattrs need to be run time or build time
> > configurable?  If it's build time configurable you'd be able to use
> > __ro_after_init.  For run time configurable, perhaps the proposed
> > "post-init read-only memory" (https://lwn.net/Articles/750215/) could
> > be used.
> 
> Runtime. I'll look into the post-init stuff, but given that this doesn't
> change the current security position do you think it's a blocker?

I would probably make the existing evm_config_xattrnames a const and
create a link list.  As new xattrs are defined, append them to the
tail.

Is there a reason for adding one additional xattrs one at a time, as
opposed to parsing a string?

Is it better to define a securityfs file, rather than a boot command
line argument?  With a boot command line argument, the list of xattrs
could be defined as __ro_after_init.

Mimi
