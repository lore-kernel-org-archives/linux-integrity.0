Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbeJBQNZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Oct 2018 12:13:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w929OZ9V042640
        for <linux-integrity@vger.kernel.org>; Tue, 2 Oct 2018 05:31:04 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv10httd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 02 Oct 2018 05:31:04 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 03:31:03 -0600
Subject: Re: [PATCH v5 06/21] tpm: move tpm1_pcr_extend to tpm1-cmd.c
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-7-tomas.winkler@intel.com>
 <20181002004248.GC23753@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Tue, 2 Oct 2018 14:58:00 +0530
MIME-Version: 1.0
In-Reply-To: <20181002004248.GC23753@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7e42b9c4-2299-a62d-ac79-0e147cb60573@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



On 10/02/2018 06:12 AM, Jarkko Sakkinen wrote:
> On Sat, Sep 29, 2018 at 01:30:20AM +0300, Tomas Winkler wrote:
>> Move tpm1_pcr_extend to tpm1-cmd.c and remove
>> unused pcrextend_header structure and
>> EXTEND_PCR_RESULT_SIZE and EXTEND_PCR_RESULT_BODY_SIZE
>> defines.
>>
>> Fixes warning:
>> drivers/char/tpm/tpm-interface.c:609:38: warning: 'pcrextend_header' defined but not used [-Wunused-const-variable=]
>>   static const struct tpm_input_header pcrextend_header = {
>>                                        ^~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Would need help with this from someone with a working IMA setup
> on testing.


My test system is down for now.. I think it will be up later in this 
week. I can test it then.

Thanks & Regards,
     - Nayna


>
> /Jarkko
>
