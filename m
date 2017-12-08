Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750980AbdLHUEk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 15:04:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8K4beL109328
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 15:04:40 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2er1cd0cym-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 15:04:34 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 13:03:34 -0700
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171117165742.GH4276@ziepe.ca>
 <0e88aaa8-7d17-9cf7-c208-e31604a0e764@redhat.com>
 <20171117175834.GK4276@ziepe.ca>
 <7f4e7c86-ef04-ea41-892f-1183a1d44a7b@redhat.com>
 <20171117181734.GM4276@ziepe.ca>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 15:03:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171117181734.GM4276@ziepe.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <44ff3d81-809c-b8ea-ae27-42725ee0a9fc@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/17/2017 1:17 PM, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2017 at 07:10:09PM +0100, Javier Martinez Canillas wrote:
> 
>> Right, that's what I understood indeed but wanted to be sure. The problem with
>> that approach is that would not scale.
>>
>> Since this particular TPM2 doesn't have support for the TPM2_EncryptDecrypt2
>> command, but some chips may not support others commands.
> 
> No, tpm_validate is not supposed to be sensitive to what commands the
> TPM supports. It is only supposed to check if the command passed is
> fully understood by the kernel and is properly formed.
> 
> This is to prevent rouge user space from sending garbage or privileged
> commands to the TPM.
> 
> If it is refusing TPM2_EncryptDecrypt2, and that command is safe to
> use in the spaces system, then tpm_validate must learn how to handle
> it, or userspace can never use it.

Do you really want to build in an every expanding list of commands that 
the kernel has to screen for?  I don't think so.

Remember that there are new commands, optional commands, and vendor 
proprietary commands.  What's the rationale for only looking at the 
command code and not rest of the parameters?

To me, the simplest solution, and the easiest for the application 
developer to debug, is to pass through any command possible.
