Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbdLHWEc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 17:04:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8M4K0m121779
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 17:04:31 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2er35j88ht-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 17:04:29 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 14:59:26 -0700
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
 <bca7c2af-def4-17cd-7b91-c1122877d3d4@huawei.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 16:59:26 -0500
MIME-Version: 1.0
In-Reply-To: <bca7c2af-def4-17cd-7b91-c1122877d3d4@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0813ba81-d06d-318d-4947-28ba7ad38e0e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/6/2017 4:13 AM, Roberto Sassu wrote:

> I think this is not suitable for scenarios where unknown Requestors are
> attested.

Could you explain.  The relying party can either accept the unknown 
requester or reject it.  What's the issue?

> 
> https://trustedcomputinggroup.org/wp-content/uploads/IWG_Architecture_v1_0_r1.pdf 
> (Section 4)
> 
> 
>> - if it's the first quote after a reboot, send the entire log, else
>> - if PCRs haven't changed, don't send anything, else
>> - send a delta since the last attestation.
>>
>> Even without this obvious optimization, the transmit time is 
>> negligible compared to the quote signature generation time.
> Having large measurement lists introduces additional issues:
> 
> 1) overhead to generate/parse the TCG Integrity Report
>     (Requestor/Verifier)

1 - When I profiled my code, the TPM quote signing was nearly all the 
time.  For the first quote, verifying the IMA signatures at the relying 
party was also measurable.

Everything else - parsing at the requester and relying party, transmit 
time, even reconstructing the PCRs from the event log, was insignificant.

General principle:  Whenever there's an asymmetric key operation, it's 
likely that nothing else affects performance.

> 2) storage requirement (Verifier)
> 3) overhead to build the complete Integrity Report from base + delta if
>     the verification tool is not stateful (Verifier)

2 - I assume that the verifier will have a disk.  With our logs running 
1-10 mbytes, a generic 2017 disk can handle 100,000's of requesters.

3 - All implementations I know of use some database for the verifier. 
It already has to hold public keys, error reports, etc.  Adding one more 
integer - the number of events in the last report - isn't hard.

I have open source sample code that does all this already.
