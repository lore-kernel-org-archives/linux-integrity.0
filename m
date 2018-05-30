Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932240AbeE3ViY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 17:38:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ULYYdU077339
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 17:38:24 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ja22wn3jh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 17:38:23 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 30 May 2018 17:38:23 -0400
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit"
 actions
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com>
 <20180530124920.g5agxm75x4i6pw6n@madcap2.tricolour.ca>
 <35894dae-c9c6-aa65-da99-c0283d459878@linux.vnet.ibm.com>
 <CAHC9VhSnubpfY6=RF9ZHQS0js18xor2nF=REfd=ZKTxV-wabiA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 17:38:18 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSnubpfY6=RF9ZHQS0js18xor2nF=REfd=ZKTxV-wabiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <85a2ad4d-6406-ad64-f440-7ab8289ceb2e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/30/2018 05:22 PM, Paul Moore wrote:
> On Wed, May 30, 2018 at 9:08 AM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 05/30/2018 08:49 AM, Richard Guy Briggs wrote:
>>> On 2018-05-24 16:11, Stefan Berger wrote:
>>>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>>>> the IMA "audit" policy action.  This patch defines
>>>> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>>>>
>>>> With this change we now call integrity_audit_msg_common() to get
>>>> common integrity auditing fields. This now produces the following
>>>> record when parsing an IMA policy rule:
>>>>
>>>> type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure \
>>>>     fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
>>>>     subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>     op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
>>>>     tty=tty2 res=1
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>> ---
>>>>    include/uapi/linux/audit.h          | 3 ++-
>>>>    security/integrity/ima/ima_policy.c | 5 +++--
>>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>>>> index 4e61a9e05132..776e0abd35cf 100644
>>>> --- a/include/uapi/linux/audit.h
>>>> +++ b/include/uapi/linux/audit.h
>>>> @@ -146,7 +146,8 @@
>>>>    #define AUDIT_INTEGRITY_STATUS            1802 /* Integrity enable
>>>> status */
>>>>    #define AUDIT_INTEGRITY_HASH      1803 /* Integrity HASH type */
>>>>    #define AUDIT_INTEGRITY_PCR       1804 /* PCR invalidation msgs */
>>>> -#define AUDIT_INTEGRITY_RULE       1805 /* policy rule */
>>>> +#define AUDIT_INTEGRITY_RULE       1805 /* IMA "audit" action policy
>>>> msgs  */
>>>> +#define AUDIT_INTEGRITY_POLICY_RULE 1806 /* IMA policy rules */
>>>>      #define AUDIT_KERNEL                2000    /* Asynchronous audit
>>>> record. NOT A REQUEST. */
>>>>    diff --git a/security/integrity/ima/ima_policy.c
>>>> b/security/integrity/ima/ima_policy.c
>>>> index 3aed25a7178a..a8ae47a386b4 100644
>>>> --- a/security/integrity/ima/ima_policy.c
>>>> +++ b/security/integrity/ima/ima_policy.c
>>>> @@ -634,7 +634,7 @@ static int ima_parse_rule(char *rule, struct
>>>> ima_rule_entry *entry)
>>>>          int result = 0;
>>>>          ab = integrity_audit_log_start(NULL, GFP_KERNEL,
>>>> -                                      AUDIT_INTEGRITY_RULE);
>>>> +                                      AUDIT_INTEGRITY_POLICY_RULE);
>>> Is it possible to connect this record to a syscall by replacing the
>>> first parameter (NULL) by current->context?
> We're likely going to need to "associate" this record (audit speak for
> making the first parameter non-NULL) with others for the audit
> container ID work.  If you do it now, Richard's patches will likely
> get a few lines smaller and that will surely make him a bit happier :)

Richard is also introducing a local context that we can then create and 
use instead of the NULL. Can we not use that then?

Steven seems to say: "We don't want to add syscall records to 
everything. That messes up schemas and existing code. The integrity 
events are 1 record in size and should stay that way. This saves disk 
space and improves readability."


>
>> We would have to fix current->context in this case since it is NULL. We get
>> to this location by root cat'ing a policy or writing a policy filename into
>> /sys/kernel/security/ima/policy.
> Perhaps I'm missing something, but current in this case should point
> to the process which is writing to the policy file, yes?
>
Yes, but current->context is NULL for some reason.
