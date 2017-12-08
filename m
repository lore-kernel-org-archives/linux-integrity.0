Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752217AbdLHT61 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 14:58:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8JucRl109293
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 14:58:26 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eqyqg6pc5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 14:58:26 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 12:58:18 -0700
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 14:58:19 -0500
MIME-Version: 1.0
In-Reply-To: <20171117165742.GH4276@ziepe.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0afdb1e8-c5e0-0ce6-ff7f-27f9c6ada211@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/17/2017 11:57 AM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2017 at 11:07:24AM +0100, Javier Martinez Canillas wrote:
> 
>> This patch is an RFC because I'm not sure if this is the correct way to fix this
>> issue. I'm not that familiar with the TPM driver so may had missed some details.
>>
>> And example of user-space getting confused by the TPM chardev returning -EINVAL
>> when sending a not supported TPM command can be seen in this tpm2-tools issue:
>>
>> https://github.com/intel/tpm2-tools/issues/621
> 
> I think this is a user space bug, unfortunately.
> 
> We talked about this when the spaces code was first written and it
> seemed the best was to just return EINVAL to indicate that the kernel
> could not accept the request.
> 
> This result is semantically different from the TPM could not execute
> or complete the request.

I think there is a difference between:

- The kernel could __not__ accept the request, and
- The kernel could accept the request, but there's code in the kernel to 
reject it.

My preference is for the kernel to send the command when possible, and 
let the TPM decide whether it can be executed.

Otherwise, the kernel device driver has to be updated every time the TPM 
implements something new that the kernel previously thought was an error.
