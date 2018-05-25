Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030260AbeEYUbs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 May 2018 16:31:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4PKNsOC073456
        for <linux-integrity@vger.kernel.org>; Fri, 25 May 2018 16:31:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j6pg7xvat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 May 2018 16:31:48 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 25 May 2018 14:31:47 -0600
Subject: Re: [PATCH v3 2/2] usb: misc: xapea00x: perform platform
 initialization of TPM
To: linux-usb@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20180430125418.31344-1-david.bild@xaptum.com>
 <20180504130022.5231-3-david.bild@xaptum.com>
 <20180504190638.ikqhdvcqccakzdjd@ziepe.ca>
 <CAAi9uDvyzk1vnQVXkJxRCATy85g4nwMLJjqu6rr1YZn9NV_TYw@mail.gmail.com>
 <20180508105515.GB6132@linux.intel.com>
 <1525793148.3672.8.camel@HansenPartnership.com>
 <CAAi9uDvgd5+d5fNbSGEeEVvdHLzwid6SqC0BVA3BPXkFWR4ooQ@mail.gmail.com>
 <1525793785.3672.12.camel@HansenPartnership.com>
 <20180510015938.GN6190@linux.intel.com>
 <CAAi9uDtj=nFnk2=oqhJj_c8vEenDvT5eHKaFEDGSh+u-fxg9vw@mail.gmail.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 16:31:43 -0400
MIME-Version: 1.0
In-Reply-To: <CAAi9uDtj=nFnk2=oqhJj_c8vEenDvT5eHKaFEDGSh+u-fxg9vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9652912d-6a24-8af4-b835-40d653141099@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 5/10/2018 10:31 AM, David R. Bild wrote:
>>
>> Could this be implemented as a first priority to daemon. If it turns out
>> to be bad approach we can reconsider kernel. If we land it to kernel it
>> is harder to take steps back.
> 
> Is the daemon an implementation of the TCG resource manager spec?

The TCG spec does use a daemon approach, similar to tcsd for TPM 1.2.

The Linux TPM driver is currently using a different approach, a 
in-kernel (in the TPM device driver) resource manager.

The advantages I see to putting the resource manager in the device 
driver are:

1 - Kernel uses of the TPM go through the same device driver, so they 
leverage the resource manager.

2 - The TPM device driver offers a standard /dev/tpmrm0 interface,
100% compatible with /dev/tpm0.
