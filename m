Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751591AbeE3PZK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 11:25:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UFOIZj049975
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 11:25:10 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9vngef4h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 11:25:10 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 30 May 2018 09:25:09 -0600
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit"
 actions
To: Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <1569841.KfYyxMilWs@x2>
 <2d5baf73-755b-dc82-a778-25a3cd22989a@linux.vnet.ibm.com>
 <15281606.YptaXzsEVL@x2>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 11:25:05 -0400
MIME-Version: 1.0
In-Reply-To: <15281606.YptaXzsEVL@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/30/2018 11:15 AM, Steve Grubb wrote:
> On Wednesday, May 30, 2018 9:54:00 AM EDT Stefan Berger wrote:
>> On 05/29/2018 05:30 PM, Steve Grubb wrote:
>>> Hello,
>>>
>>> On Thursday, May 24, 2018 4:11:05 PM EDT Stefan Berger wrote:
>>>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>>>> the IMA "audit" policy action.  This patch defines
>>>> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>>>>
>>>> With this change we now call integrity_audit_msg_common() to get
>>>> common integrity auditing fields. This now produces the following
>>>> record when parsing an IMA policy rule:
>>>>
>>>> type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure \
>>>>
>>>>     fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
>>>>     subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>     op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
>>>>     tty=tty2 res=1
>>> Since this is a new event, do you mind moving the tty field to be between
>>> auid= and ses=  ?   That is the more natural place for it.
>> 6/8 refactors the code so that the integrity audit records produced by
>> IMA follow one format in terms of ordering of the fields, with fields
>> like inode optional, though, and AUDIT_INTEGRITY_RULE in the end being
>> the only one with a different format. Do we really want to change that
>> order just for 1806?
>>
>> 5/8 now produces the following:
>>
>> type=INTEGRITY_PCR msg=audit(1527685075.941:502): pid=2431 \
>>     uid=0 auid=1000 ses=5 \
>>     subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>     op=invalid_pcr cause=open_writers comm="grep" \
>>     name="/var/log/audit/audit.log" dev="dm-0" ino=1962494 \
>>     exe="/usr/bin/grep" tty=pts0 res=1
>>
>> Comparing the two:
>>
>> 1806:          action, fsmagic, pid, uid, auid, ses, subj, op, cause,
>> comm,    exe, tty, res
>> INTEGRITY_PCR:                  pid, uid, auid, ses, subj, op, cause,
>> comm, name, dev, ino, exe, tty, res
> OK. I guess go with it as is. It passes testing.

What about the position of 'res' field relative to the two new fields 
'exe' and 'tty'? Do we want to keep them as shown or strictly append the 
two new fields 'exe' and 'tty'? Paul seems to request that they appear 
after 'res'.

     Stefan

>
> -Steve
>
>>> Also, it might be more natural for the op= and cause= fields to be before
>>> the pid= portion. This doesn't matter as much to me because those are
>>> not searchable fields and they are skipped right over. But moving the
>>> tty field is the main comment from me.
>> With the refactoring in 6/8 we at least have consistency among the
>> INTEGRITY_* records, with the only exception being AUDIT_INTEGRITY_RULE
>> that has its own format:
>>
>> https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_a
>> pi.c#L324
>>
>> The other ones currently all format using integrity_audit_msg().
>>
>>> Thanks,
>>> -Steve
>>>
>>>> Signed-off-by: Stefan Berger<stefanb@linux.vnet.ibm.com>
>>>> ---
>>>>
>>>>    include/uapi/linux/audit.h          | 3 ++-
>>>>    security/integrity/ima/ima_policy.c | 5 +++--
>>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>>>> index 4e61a9e05132..776e0abd35cf 100644
>>>> --- a/include/uapi/linux/audit.h
>>>> +++ b/include/uapi/linux/audit.h
>>>> @@ -146,7 +146,8 @@
>>>>
>>>>    #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
>>>>    #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
>>>>    #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
>>>>
>>>> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>>>> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs
>>>> */ +#define AUDIT_INTEGRITY_POLICY_RULE 1806 /* IMA policy rules */
>>>>
>>>>    #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A
>>> REQUEST. */
>>>
>>>> diff --git a/security/integrity/ima/ima_policy.c
>>>> b/security/integrity/ima/ima_policy.c index 3aed25a7178a..a8ae47a386b4
>>>> 100644
>>>> --- a/security/integrity/ima/ima_policy.c
>>>> +++ b/security/integrity/ima/ima_policy.c
>>>> @@ -634,7 +634,7 @@ static int ima_parse_rule(char *rule, struct
>>>> ima_rule_entry *entry) int result = 0;
>>>>
>>>>    	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
>>>>
>>>> -				       AUDIT_INTEGRITY_RULE);
>>>> +				       AUDIT_INTEGRITY_POLICY_RULE);
>>>>
>>>>    	entry->uid = INVALID_UID;
>>>>    	entry->fowner = INVALID_UID;
>>>>
>>>> @@ -926,7 +926,8 @@ static int ima_parse_rule(char *rule, struct
>>>> ima_rule_entry *entry) temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
>>>>
>>>>    	else if (entry->func == POLICY_CHECK)
>>>>    	
>>>>    		temp_ima_appraise |= IMA_APPRAISE_POLICY;
>>>>
>>>> -	audit_log_format(ab, "res=%d", !result);
>>>> +	integrity_audit_msg_common(ab, NULL, NULL,
>>>> +				   "policy_update", "parse_rule", result);
>>>>
>>>>    	audit_log_end(ab);
>>>>    	return result;
>>>>    
>>>>    }
>
>
>
