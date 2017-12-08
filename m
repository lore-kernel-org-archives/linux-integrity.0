Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750908AbdLHUQz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 15:16:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8KFvOK129210
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 15:16:55 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2er0x1twkk-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 15:16:54 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 13:16:53 -0700
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
 <DB638850A6A2434A93ECADDA0BC838905F09D5D9@ORSMSX103.amr.corp.intel.com>
 <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
 <20171122201303.GT18272@ziepe.ca>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 15:16:53 -0500
MIME-Version: 1.0
In-Reply-To: <20171122201303.GT18272@ziepe.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5c695f48-77f2-b3ca-8d71-118c44161d50@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/22/2017 3:13 PM, Jason Gunthorpe wrote:
> On Wed, Nov 22, 2017 at 09:16:25AM -0800, flihp wrote:
> 
>> We can work around quirks in the kernel RM in user space if we must
>> (short term?) but I'm hesitant to do so in this case. Would feel better
>> about a short term work-around knowing it's only going to be short term.
> 
> Pedantically, the kernel is not implementing a RM as per some spec, it
> is using the TPM features to create isolation.
> 
> Both sides can be argued. In this case, I think the patch to add a TPM
> response buffer in this one case is reasonable, and does not look so
> complicated that it is dangerous in the kernel.
> 
> However the kernel will continue to return errnos in various cases,
> and a userspace that cannot handle them is kinda broken :)

First, to handle the error, the user space TSS would have to know that 
the RM is mapping what would normally (with the simulator or /dev/tpm0) 
be the usual TPM response packet.  This mapping isn't documented anywhere.

Second, if "handle" means "pass EINVAL back up to the application, which 
will not have any idea what it means", that's easy.  But sending the 
application an error code or message that would permit them to debug is 
much harder.

To me, it's like the difference between "file not found" and "disk error".
