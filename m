Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752224AbdLVTcc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Dec 2017 14:32:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBMJTHqs038085
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 14:32:32 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2f15bsqt5m-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 14:32:31 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 22 Dec 2017 14:32:30 -0500
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id vBMJWSDP49938454
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 19:32:28 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86FB0AE03B
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 14:33:32 -0500 (EST)
Received: from [9.2.202.150] (unknown [9.2.202.150])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 76575AE034
        for <linux-integrity@vger.kernel.org>; Fri, 22 Dec 2017 14:33:32 -0500 (EST)
Subject: Re: TPM driver breaks S3 suspend
To: linux-integrity@vger.kernel.org
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 14:32:34 -0500
MIME-Version: 1.0
In-Reply-To: <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <279113e4-ebd6-33a5-7988-cbb58609fbef@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 12/21/2017 5:19 AM, Alexander.Steffen@infineon.com wrote:

>> 
>> The error code 38 in definition is TPM_ERR_INVALID_POSTINIT. I 
>> found some explanations which said this error code means that this 
>> command was received in the wrong sequence relative to a
>> TPM_Startup command. Don't really know what happens here and how
>> should I deal with this? Any suggestions? Please let me know what
>> else information should I provide. Thanks
>> 
>> Chris
> 
> In addition, from the error code we can tell that it is not actually
> a selftest failure. INVALID_POSTINIT for a command other than
> TPM_Startup means that no TPM_Startup has been executed for that
> power cycle yet, so the TPM has to reject all other commands.
> Usually, the platform sends the TPM_Startup command, but not in your
> case apparently.

I offer another possibility, based on this:

1 - There are two ways to get TPM_ERR_INVALID_POSTINIT. One is what 
Alexander said.  The other is a second TPM_Startup without a TPM_Init 
(reboot).

2 - Chris said that he gets this when doing an S3 suspend.  S3 does
not do a reboot, and thus there should __not__ be a TPM_Startup.

Could it be that the device driver is issuing a TPM_Startup when
resuming from S3?

However, Chris indicated that the TPM_ERR_INVALID_POSTINIT is returned 
from 'savestate'.  This could only happen if the TPM never got a
TPM_Startup at its first boot, which seems unlikely.
