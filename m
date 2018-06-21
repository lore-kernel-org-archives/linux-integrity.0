Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932856AbeFURpI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 13:45:08 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LHZiJQ127050
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jun 2018 13:45:08 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jregvwtrs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 21 Jun 2018 13:45:08 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 21 Jun 2018 13:45:07 -0400
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 13:45:03 -0400
MIME-Version: 1.0
In-Reply-To: <20180621171518.GI11859@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
> On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
>> Implement tpm_chip_find() for other subsystems to find a TPM chip and
>> get a reference to that chip. Once done with using the chip, the reference
>> is released using tpm_chip_put().
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> You should sort this out in a way that we don't end up with duplicate
> functions.

Do you want me to create a function *like* tpm_chip_find_get() that 
takes an additional parameter whether to get the ops semaphore and have 
that function called by the existing tpm_chip_find_get() and the new 
tpm_chip_find(). The latter would then not get the ops semphore. I 
didn't want to do this since one time the function returns with a lock 
held and the other time not.

   Stefan

>
> /Jarkko
>
