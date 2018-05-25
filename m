Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967879AbeEYUXJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 May 2018 16:23:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4PKEBiU051519
        for <linux-integrity@vger.kernel.org>; Fri, 25 May 2018 16:23:09 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j6mgh3wn4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 May 2018 16:23:08 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 25 May 2018 14:23:06 -0600
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "David R. Bild" <david.bild@xaptum.com>
Cc: linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com>
 <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com>
 <1525793785.3672.12.camel@HansenPartnership.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 16:23:00 -0400
MIME-Version: 1.0
In-Reply-To: <1525793785.3672.12.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <89b5ac56-3d59-e264-c4a6-469b83ef8dea@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 5/8/2018 11:36 AM, James Bottomley wrote:
> On Tue, 2018-05-08 at 10:29 -0500, David R. Bild wrote:
>> On Tue, May 8, 2018 at 10:25 AM, James Bottomley

>>>
>>> I don't see any reason to set an unreachable password for the
>>> platform
>>> hierarchy if the UEFI didn't.  If the desire is to disable the
>>> platform
>>> hierarchy, then it should be disabled, not have a random password
>>> set.
>>
>> "Set random password and throw away the key" was my way of disabling
>> the platform hierarchy.  Is there a better way of doing that?
> 
> Well, yes, use TPM2_HierarchyControl to set phEnable to CLEAR.

There is a huge difference between the two.

"Set a random password" is the recommended approach.  This just
prohibits using the platform authorization - a good idea.

phEnable CLEAR disables the hierarchy, preventing it from being used
at all.  A basic problem would be that the EK certificates could not be
read.

There are likely to be other issues, like not being able to do a field 
upgrade post-OS,
