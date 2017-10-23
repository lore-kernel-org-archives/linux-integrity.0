Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751268AbdJWLBu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 07:01:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NAwvue029118
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 07:01:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsbswsavj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 07:01:49 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 12:01:47 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9NB1gSP12583020
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 11:01:44 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9NB1hhw028847
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 22:01:43 +1100
Subject: Re: [RFC][PATCH 0/2] ima: preserve integrity of dynamic data
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Date: Mon, 23 Oct 2017 07:01:39 -0400
In-Reply-To: <20171020154138.23635-1-roberto.sassu@huawei.com>
References: <20171020154138.23635-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508756499.3639.53.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-20 at 17:41 +0200, Roberto Sassu wrote:
> One of the most challenging tasks for remote attestation is how to
> handle the measurement of dynamic data (mutable files). When the default
> policy is selected, IMA measures files accessed by root processes (TCB).

Agreed.  The original ima_policy="appraise_tcb" (formerly known as
"ima_appraise_tcb") is a builtin policy, which can be and normally is
replaced by a custom policy.  This builtin IMA policy starts
immediately and is normally replaced after the LSMs have been
initialized, allowing for a finer grain policy.

> However, if a file was previously modified by another process, the digest
> included in the new measurement list is unknown, and verifiers must assume,
> during a remote attestation, that the system was compromised, because they
> don't know if that file was written by a process in the TCB or not.
> 
> The goal of this patch set is to enforce an integrity policy on appraised
> files, to avoid reporting measurements of dynamic data after they have been
> modified. Only the initial state should be reported (e.g. the file
> signature, or a digest list).
> 
> In order to properly enforce an integrity policy, it is necessary to
> specify in the IMA policy process credentials rather than file attributes.
> 
> For example, the rule:
> 
> appraise fowner=0
> 
> could be replaced with:
> 
> appraise uid=0
> appraise euid=0

The difference between these two policies is the ability to know which
files must be hashed/signed apriori.  In the first case, only those
files owned by root must be hashed/signed, while in the latter case
all files on the file system must be hashed/signed.

When making changes, please keep in mind the bigger picture of who is
doing what and how the integrity subsystem is currently being used.
 Adding new functionality or extending the existing subsystem is all
good, but these changes cannot break existing systems or change its
meaning.

Mimi
