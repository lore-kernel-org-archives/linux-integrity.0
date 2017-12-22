Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755906AbdLVQBJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 11:01:09 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBMFx15O139118
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 11:01:08 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2f10vn6ane-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 11:01:07 -0500
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 22 Dec 2017 08:56:06 -0700
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vBMFu4AW13238744
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 08:56:04 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4868878047
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 08:56:04 -0700 (MST)
Received: from [9.2.202.150] (unknown [9.2.202.150])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP id 1DCA97803F
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 08:56:04 -0700 (MST)
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: linux-integrity@vger.kernel.org
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
 <bca7c2af-def4-17cd-7b91-c1122877d3d4@huawei.com>
 <0813ba81-d06d-318d-4947-28ba7ad38e0e@linux.vnet.ibm.com>
 <3a7b696d-5fb2-a97d-d4f1-65e0f8df9515@huawei.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 10:56:09 -0500
MIME-Version: 1.0
In-Reply-To: <3a7b696d-5fb2-a97d-d4f1-65e0f8df9515@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b718cb20-830f-815f-545a-bc6e2ceb6591@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/11/2017 3:26 AM, Roberto Sassu wrote:
> 
> I meant that when a Verifier attests unknown Requestors, likely delta
> reports cannot be used. 

Is there a real use case for "unknown requesters"?  Unless the verifier 
knows the requester's public key, it can't verify the quote.

I conclude that a requester is always known - by its unique public key.

>> 3 - All implementations I know of use some database for the verifier. 
>> It already has to hold public keys, error reports, etc.  Adding one 
>> more integer - the number of events in the last report - isn't hard.
>>
>> I have open source sample code that does all this already.
> 
> With OpenAttestation 1.7 (which supports IMA), I noticed some delays.
> But, as you said, performance can be improved.

I can't speak for that code.  But my sample code supports incremental
event logs.  The implementation was not trivial, but it wasn't overly 
complex.

The real gain is not the event log transmission time.  That's 
unmeasurably small.  It's mostly validating the IMA signatures, and 
partly reconstructing PCR 10.

We've already seen logs with 60K events (events, not bytes).  You don't 
want to walk that log every time, especially when one verifier starts 
supporting 1000's of requestors.
