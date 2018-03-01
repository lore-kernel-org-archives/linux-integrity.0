Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1034108AbeCAS5u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Mar 2018 13:57:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w21IvT3G106260
        for <linux-integrity@vger.kernel.org>; Thu, 1 Mar 2018 13:57:50 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gem51gym5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 01 Mar 2018 13:57:50 -0500
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 1 Mar 2018 13:57:48 -0500
Subject: Re: [PATCH 2/3] tpm: reduce poll sleep time between send() and recv()
 in tpm_transmit()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
 <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
 <20180301092222.GC29420@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 00:26:35 +0530
MIME-Version: 1.0
In-Reply-To: <20180301092222.GC29420@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 03/01/2018 02:52 PM, Jarkko Sakkinen wrote:
> On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
>> In tpm_transmit, after send(), the code checks for status in a loop
> Maybe cutting hairs now but please just use the actual function name
> instead of send(). Just makes the commit log more useful asset.
Sure, will do.
>
>> -		tpm_msleep(TPM_TIMEOUT);
>> +		tpm_msleep(TPM_TIMEOUT_POLL);
> What about just calling schedule()?
I'm not sure what you mean by "schedule()".  Are you suggesting instead 
of using usleep_range(),  using something with an even finer grain 
construct?

Thanks & Regards,
      - Nayna

>
> /Jarkko
>
