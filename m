Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbeIYWgr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Sep 2018 18:36:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PGQ7fX073256
        for <linux-integrity@vger.kernel.org>; Tue, 25 Sep 2018 12:28:30 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqq4pmttd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Sep 2018 12:28:29 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 25 Sep 2018 10:28:29 -0600
Subject: Re: [PATCH v3 06/20] tpm: move tpm1_pcr_extend to tpm1-cmd.c
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180918093459.19165-1-tomas.winkler@intel.com>
 <20180918093459.19165-7-tomas.winkler@intel.com>
 <20180919140634.GA27854@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 25 Sep 2018 21:55:27 +0530
MIME-Version: 1.0
In-Reply-To: <20180919140634.GA27854@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7af3302c-3c46-ebc7-bf9b-704c8eaaa6b7@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 09/19/2018 07:36 PM, Jarkko Sakkinen wrote:
> On Tue, Sep 18, 2018 at 12:34:45PM +0300, Tomas Winkler wrote:
>> Move tpm1_pcr_extend to tpm1-cmd.c and remove
>> unused pcrextend_header structure.
>>
>> Fixes warning:
>> drivers/char/tpm/tpm-interface.c:609:38: warning: 'pcrextend_header' defined but not used [-Wunused-const-variable=]
>>   static const struct tpm_input_header pcrextend_header = {
>>                                        ^~~~~~~~~~~~~~~~
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Can someone with a working IMA environment to test it? Don't have one
> right now (should probably setup).

I think I can try testing this patch sometime next week. I will test the 
updated version.

Thanks & Regards,
     - Nayna

>
> /Jarkko
>
