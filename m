Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:9381 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751274AbdLKI1B (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 03:27:01 -0500
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Ken Goldman <kgold@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <5060980f-2b70-6b77-89f2-5ef66ff4cace@linux.vnet.ibm.com>
 <bca7c2af-def4-17cd-7b91-c1122877d3d4@huawei.com>
 <0813ba81-d06d-318d-4947-28ba7ad38e0e@linux.vnet.ibm.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
CC: Silviu Vlasceanu <silviu.vlasceanu@huawei.com>
Message-ID: <3a7b696d-5fb2-a97d-d4f1-65e0f8df9515@huawei.com>
Date: Mon, 11 Dec 2017 09:26:40 +0100
MIME-Version: 1.0
In-Reply-To: <0813ba81-d06d-318d-4947-28ba7ad38e0e@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/8/2017 10:59 PM, Ken Goldman wrote:
> On 12/6/2017 4:13 AM, Roberto Sassu wrote:
> 
>> I think this is not suitable for scenarios where unknown Requestors are
>> attested.
> 
> Could you explain.  The relying party can either accept the unknown 
> requester or reject it.  What's the issue?

I meant that when a Verifier attests unknown Requestors, likely delta
reports cannot be used. The Verifier would have to store the base report
also for Requestors that are attested only once.


>> https://trustedcomputinggroup.org/wp-content/uploads/IWG_Architecture_v1_0_r1.pdf 
>> (Section 4)
>>
>>
>>> - if it's the first quote after a reboot, send the entire log, else
>>> - if PCRs haven't changed, don't send anything, else
>>> - send a delta since the last attestation.
>>>
>>> Even without this obvious optimization, the transmit time is 
>>> negligible compared to the quote signature generation time.
>> Having large measurement lists introduces additional issues:
>>
>> 1) overhead to generate/parse the TCG Integrity Report
>>     (Requestor/Verifier)
> 
> 1 - When I profiled my code, the TPM quote signing was nearly all the 
> time.  For the first quote, verifying the IMA signatures at the relying 
> party was also measurable.
> 
> Everything else - parsing at the requester and relying party, transmit 
> time, even reconstructing the PCRs from the event log, was insignificant.
> 
> General principle:  Whenever there's an asymmetric key operation, it's 
> likely that nothing else affects performance.
> 
>> 2) storage requirement (Verifier)
>> 3) overhead to build the complete Integrity Report from base + delta if
>>     the verification tool is not stateful (Verifier)
> 
> 2 - I assume that the verifier will have a disk.  With our logs running 
> 1-10 mbytes, a generic 2017 disk can handle 100,000's of requesters.
> 
> 3 - All implementations I know of use some database for the verifier. It 
> already has to hold public keys, error reports, etc.  Adding one more 
> integer - the number of events in the last report - isn't hard.
> 
> I have open source sample code that does all this already.

With OpenAttestation 1.7 (which supports IMA), I noticed some delays.
But, as you said, performance can be improved.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
