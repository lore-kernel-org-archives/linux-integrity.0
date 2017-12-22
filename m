Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755863AbdLVRi2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 12:38:28 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBMHYs9o009130
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 12:38:28 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2f13r09gcv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 12:38:27 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 22 Dec 2017 10:38:26 -0700
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vBMHcOgW6816146
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 10:38:24 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8057803F
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 10:38:24 -0700 (MST)
Received: from [9.2.202.150] (unknown [9.2.202.150])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP id 751CA78038
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 10:38:24 -0700 (MST)
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
 <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
 <425a45d4-7d44-333e-0d7f-21a931c9d81d@redhat.com>
 <20171217164738.agn3bfcc2huv3mdb@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 12:38:30 -0500
MIME-Version: 1.0
In-Reply-To: <20171217164738.agn3bfcc2huv3mdb@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <139ac7ad-5903-0582-fe63-d1b429c347e3@linux.vnet.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/17/2017 11:47 AM, Jarkko Sakkinen wrote:

> I did not really get the Ken's comment about incompatibility with 
> different RM's. I guess all TPM user spaces should be able to handle 
> TPM_RC_COMMAND_CODE and top bits are part of the TCG standard 
> (TSS2_RESMGR_TPM_RC_LAYER):

I think (?) my comment was around the suggestion that the SAPI TSS could
map -EINVAL to TPM_RC_COMMAND_CODE.  I.e, that all the user space TSS'es
(not different RMs) would have to follow this tread and fix their 
implementations.

I wrote:

> Remember also that SAPI is just one TSS design.  There are currently
> three others.  And SAPI is targeted more as a building block than an
> end user library.
> 
> Every TSS implementation would have to do this mapping.  How would
> they even know to do it if they didn't notice this thread?  It
> wouldn't be documented anywhere other than deep in kernel code.
