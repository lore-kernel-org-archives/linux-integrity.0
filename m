Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33357 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750821AbdI1UMu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 16:12:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8SK9qTB160235
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 16:12:50 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d95611hy1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 28 Sep 2017 16:12:49 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 29 Sep 2017 06:12:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8SKCh0x40370340
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 06:12:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8SKCiiR026544
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 06:12:44 +1000
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Thu, 28 Sep 2017 16:12:40 -0400
In-Reply-To: <20170927221653.11219-1-mjg59@google.com>
References: <20170927221653.11219-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506629560.5691.33.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Matthew,

[Cc'ing Mikhail Kurinnoi]

On Wed, 2017-09-27 at 15:16 -0700, Matthew Garrett wrote:
> These are basically untested, but I'd like to get some feedback on the
> problem I'm trying to solve here. We'd like to be able to ship packages
> with verifiable security xattrs, but right now EVM makes this difficult
> due to its requirement that the inode number be encoded in the hmac. This
> patchset is intended to make it possible to protect a subset of metadata
> rather than all of it, and also to permit using EVM digital signatures in
> a similar way to how IMA digital signatures can be used now (ie, protecting
> the metadata using public/private crypto rather than having a local
> symmetric key and generating the HMACs locally). The expected workflow is:
> 
> 1) During package build or mirroring process, appropriate security metadata
>    is added (IMA hash, selinux label, etc)
> 2) An EVM digital signature is generated based purely on the security
>    metadata present during the build or mirroring process
> 3) IMA is extended to allow it to force EVM validation during appraisal even
>    if no symmetric EVM key has been added, which allows IMA appraisal to
>    appraise not only the IMA hash but also the additional metadata
> 4) If EVM is never enabled, binaries are purely validated using the EVM
>    digital signatures and are not transitioned to using HMACs
> 5) If EVM is desired, userland can set the set of metadata to be incorporated
>    into the EVM HMAC before enabling EVM

Earlier this year there were discussions on defining a portable EVM
signature, that could be included in software packages. 

The reason for including as much metadata as possible in the HMAC is
to limit cut & paste attacks.  For this reason, the portable data is
only used in transmission, not on disk.

A new EVM type is defined that does not convert the EVM signature to
an HMAC.

Mikhail's patches:
https://sourceforge.net/p/linux-ima/mailman/linux-ima-user/thread/2017
0113072602.4ffaa30a@totoro/

I've been negligent in reviewing and testing his patches.  Perhaps
they will meet your needs.

Mimi
