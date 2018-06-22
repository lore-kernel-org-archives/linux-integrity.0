Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751291AbeFVLkm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jun 2018 07:40:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MBduiL071291
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 07:40:42 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jryp09x50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jun 2018 07:40:41 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 07:40:40 -0400
Subject: Re: [PATCH v2 3/4] ima: Use tpm_chip_find() and access TPM functions
 using it
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-4-stefanb@linux.vnet.ibm.com>
 <1529614425.23843.20.camel@linux.vnet.ibm.com>
 <f4af7347-a9dd-1683-5c2c-faeb45750e2e@linux.vnet.ibm.com>
 <20180622032536.GB19151@ziepe.ca>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Jun 2018 07:40:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180622032536.GB19151@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <495fdcf7-b5b9-0341-796b-66fdf537811b@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 06/21/2018 11:25 PM, Jason Gunthorpe wrote:
> On Thu, Jun 21, 2018 at 04:59:55PM -0400, Stefan Berger wrote:
>> On 06/21/2018 04:53 PM, Mimi Zohar wrote:
>>> On Wed, 2018-06-20 at 16:42 -0400, Stefan Berger wrote:
>>>> Rather than accessing the TPM functions using a NULL pointer, which
>>>> causes a lookup for a suitable chip every time, get a hold of a tpm_chip
>>>> and access the TPM functions using this chip. We call the tpm_chip
>>>> ima_tpm_chip and protect it, once initialization is done, using a
>>>> rw_semaphore called ima_tpm_chip_lock.
>>>>
>>>> Use ima_shutdown to release the tpm_chip.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>   security/integrity/ima/ima.h        |  3 +++
>>>>   security/integrity/ima/ima_crypto.c | 12 ++++++++++--
>>>>   security/integrity/ima/ima_init.c   | 19 ++++++++++++-------
>>>>   security/integrity/ima/ima_queue.c  |  7 +++++--
>>>>   4 files changed, 30 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>>>> index 354bb5716ce3..53a88d578ca5 100644
>>>> +++ b/security/integrity/ima/ima.h
>>>> @@ -24,6 +24,7 @@
>>>>   #include <linux/hash.h>
>>>>   #include <linux/tpm.h>
>>>>   #include <linux/audit.h>
>>>> +#include <linux/rwsem.h>
>>>>   #include <crypto/hash_info.h>
>>>>
>>>>   #include "../integrity.h"
>>>> @@ -56,6 +57,8 @@ extern int ima_policy_flag;
>>>>   extern int ima_used_chip;
>>>>   extern int ima_hash_algo;
>>>>   extern int ima_appraise;
>>>> +extern struct rw_semaphore ima_tpm_chip_lock;
>>>> +extern struct tpm_chip *ima_tpm_chip;
>>> ima_add_templatE_entry() synchronizes appending a measurement to the
>>> measurement list and extending the TPM by taking a lock.  Do we really
>>> need to introduce another lock?
>> This lock protects the ima_tpm_chip from going from != NULL to NULL in the
>> ima_shutdown function. Basically, a global pointer accessed by concurrent
>> threads should be protected if its value can change. However, in this case
>> ima_shutdown would be called so late that there shouldn't be concurrency
>> anymore. Though, I found it better to protect it. Maybe someone else has an
>> opinion?
> Why have a shutdown block? There is no harm in holding a kref if the
> machine is shutting down.

Looking around at other drivers' usage of the reboot notifier, I find 
other drivers as well that use spinlocks or mutexes during the shutdown. 
Besides that, we do have the shutdown block already when device_shutdown 
calls tpm_class_shutdown() and we get the ops_sem.

     Stefan
>
> Jason
>
