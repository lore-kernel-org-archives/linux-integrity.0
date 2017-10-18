Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750724AbdJRRwH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 13:52:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9IHoesP143647
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 13:52:07 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dp6x912av-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 13:52:06 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 18 Oct 2017 18:52:04 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9IHq1KI24510480
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 17:52:03 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9IHq2tq032528
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 04:52:02 +1100
Subject: Re: Writing out EVM protected xattrs while EVM is active
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Wed, 18 Oct 2017 13:51:58 -0400
In-Reply-To: <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
         <1508291395.4513.95.camel@linux.vnet.ibm.com>
         <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
         <1508292499.4513.99.camel@linux.vnet.ibm.com>
         <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
         <1508295225.4513.123.camel@linux.vnet.ibm.com>
         <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508349118.4510.14.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> >> I may be misdiagnosing this, but as far as I can tell IMA_NEW_FILE is
> >> only set in ima_appraise_measurement() if action is set to something,
> >> and if ima_match_rules() doesn't match then this will never be the
> >> case?
> >
> > True, but having IMA_NEW_FILE set would only help with writing the
> > first xattr, not subsequent ones.
> 
> Ok. I'm not sure this is easily fixable to handle my use-case without
> breaking assumptions made in yours, so I'm wondering if a different
> approach would be better here. For us, there's no problem with
> updating any of the EVM-protected xattrs at runtime as long as doing
> so invalidates the iint cache entry (hmm, does setting an xattr bump
> the iversion? If so, we already get this behaviour). How would you
> feel about a runtime controllable flag that enabled this, possibly
> tied into the /sys/kernel/security/evm write? We'd end up with:
> 
> 1: Enable HMAC
> 2: Enable RSA
> 4: Permit extended attribute writes
> 
> Existing behaviour would be preserved since 1 would lock down the
> interface, and we could reject cases where 1 and 4 are set
> simultaneously.

Here's an alternative, though admittedly one that is more difficult to
implement and dependent on having a portable EVM signature type.

Define the equivalent of listxattr that allows writing multiple
xattrs.  Change option 4 above to "Permit writing a group of extended
attributes, including an EVM signature, when none currently exist."

Then option 1 and 4 won't need to be mutually exclusive.

Mimi
