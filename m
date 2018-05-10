Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935520AbeEJMnm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 May 2018 08:43:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ACfcrN098424
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 08:43:40 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hvkvee6q3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 10 May 2018 08:43:40 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Thu, 10 May 2018 08:43:40 -0400
Subject: Re: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
To: J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
 <becb898c-b778-d104-5781-899599f536d4@gmail.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Thu, 10 May 2018 18:11:50 +0530
MIME-Version: 1.0
In-Reply-To: <becb898c-b778-d104-5781-899599f536d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 05/08/2018 10:04 PM, J Freyensee wrote:
>
>>           do {
>> -            tpm_msleep(TPM_POLL_SLEEP);
>> +            tpm_msleep(TPM_TIMEOUT_POLL);
>>
> I'm just curious why it was decided to still use tpm_msleep() here 
> instead of usleep_range() which was used in the 2nd patch.

TPM_TIMEOUT_POLL is in msec i.e. 1 msec and usleep_range() is used only 
when timeout is needed in usecs.

>
> Otherwise,
>
> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>

Thanks !!

Thanks & Regards,
     - Nayna
