Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750750AbeENKli (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 May 2018 06:41:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4EAdHxV104609
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 06:41:37 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hy6jdx7x8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 May 2018 06:41:37 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Mon, 14 May 2018 06:41:36 -0400
Subject: Re: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
 <becb898c-b778-d104-5781-899599f536d4@gmail.com>
 <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 16:09:41 +0530
MIME-Version: 1.0
In-Reply-To: <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4896f0b6-70b7-77ad-1b33-f13890b6fec2@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 05/10/2018 06:11 PM, Nayna Jain wrote:
>
>
> On 05/08/2018 10:04 PM, J Freyensee wrote:
>>
>>>           do {
>>> -            tpm_msleep(TPM_POLL_SLEEP);
>>> +            tpm_msleep(TPM_TIMEOUT_POLL);
>>>
>> I'm just curious why it was decided to still use tpm_msleep() here 
>> instead of usleep_range() which was used in the 2nd patch.
>
> TPM_TIMEOUT_POLL is in msec i.e. 1 msec and usleep_range() is used 
> only when timeout is needed in usecs.

Just to add bit more details:

usleep_range() is used in wait_for_tpm_stat() and get_burstcount() which 
are expected to return quickly. tpm_transmit() is a generic function 
used across all drivers and commands.
Some of the commands (eg. hash, key generation) take longer compared to 
other commands (eg. extend). The sleep time in tpm_transmit is reduced 
but kept in msecs to balance between the smaller and longer commands.

Thanks & Regards,
     - Nayna

>
>>
>> Otherwise,
>>
>> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
>
> Thanks !!
>
> Thanks & Regards,
>     - Nayna
>
>
