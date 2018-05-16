Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751096AbeEPU3A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 May 2018 16:29:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4GKO8v4147166
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 16:28:59 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j0qg9kjqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 16:28:59 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 16 May 2018 14:28:59 -0600
Subject: Re: [RFC PATCH v4 3/5] ima: differentiate auditing policy rules from
 "audit" actions
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        ebiederm@xmission.com, john.johansen@canonical.com
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
 <20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
 <1526391655.3937.151.camel@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 16:28:43 -0400
MIME-Version: 1.0
In-Reply-To: <1526391655.3937.151.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2496f165-67f7-304d-08a0-ea8eedd3c3d4@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/15/2018 09:40 AM, Mimi Zohar wrote:
> Hi Stefan,
>
> On Fri, 2018-05-11 at 10:42 -0400, Stefan Berger wrote:
>> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>>
>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>> the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
>> to reflect the IMA policy rules.
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> We do need to separate out auditing the IMA policy rules from the
> "IMA-audit" messages.  Based on the IMA policy rule aspect of the
> discussions [1],  I would really appreciate if you could work with
> Richard and Steve on the new IMA policy rule audit format.
Is your patch below still valid for splitting it up into 'two distinct 
audit record types' ?

>
> This change can be upstreamed independently of either the IMA
> namespacing or the audit containerid patch sets.  The sooner we make
> this change and upstream it, the better.
>
> [1] https://www.redhat.com/archives/linux-audit/2018-March/msg00092.html
>
> thanks,
>
> Mimi
>
>> ---
>>   include/uapi/linux/audit.h          | 3 ++-
>>   security/integrity/ima/ima_policy.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 4e61a9e05132..8966e7ff1c4c 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -146,7 +146,8 @@
>>   #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
>>   #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
>>   #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
>> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
>> +#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
>>
>>   #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 915f5572c6ff..3a1412db02a3 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -619,7 +619,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>   	bool uid_token;
>>   	int result = 0;
>>
>> -	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
>> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
>>
>>   	entry->uid = INVALID_UID;
>>   	entry->fowner = INVALID_UID;
