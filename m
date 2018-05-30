Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932431AbeE3Vtl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 17:49:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4ULn0vd014943
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 17:49:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ja131qq32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 17:49:40 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 30 May 2018 17:49:39 -0400
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit"
 actions
To: Paul Moore <paul@paul-moore.com>
Cc: Steve Grubb <sgrubb@redhat.com>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <15281606.YptaXzsEVL@x2>
 <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
 <3607733.4k8ofLVAdP@x2>
 <1160afb4-4184-b30c-5f67-c21536b5f7d3@linux.vnet.ibm.com>
 <CAHC9VhQZeBS3EzgsWogeuCPtGxSFVDm1jUOLV7Jk4JRC4CVLyQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 17:49:35 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQZeBS3EzgsWogeuCPtGxSFVDm1jUOLV7Jk4JRC4CVLyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <85d2a40a-884c-c63d-50f6-024f7bbea4a8@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/30/2018 05:24 PM, Paul Moore wrote:
> On Wed, May 30, 2018 at 3:54 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 05/30/2018 12:27 PM, Steve Grubb wrote:
>>> On Wednesday, May 30, 2018 11:25:05 AM EDT Stefan Berger wrote:
>>>> On 05/30/2018 11:15 AM, Steve Grubb wrote:
>>>>> On Wednesday, May 30, 2018 9:54:00 AM EDT Stefan Berger wrote:
>>>>>> On 05/29/2018 05:30 PM, Steve Grubb wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Thursday, May 24, 2018 4:11:05 PM EDT Stefan Berger wrote:
>>>>>>>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>>>>>>>> the IMA "audit" policy action.  This patch defines
>>>>>>>> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>>>>>>>>
>>>>>>>> With this change we now call integrity_audit_msg_common() to get
>>>>>>>> common integrity auditing fields. This now produces the following
>>>>>>>> record when parsing an IMA policy rule:
>>>>>>>>
>>>>>>>> type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure
>>>>>>>> \
>>>>>>>>
>>>>>>>> fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
>>>>>>>> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>>>>> op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
>>>>>>>> tty=tty2 res=1
>>>>>>> Since this is a new event, do you mind moving the tty field to be
>>>>>>> between
>>>>>>> auid= and ses=  ?   That is the more natural place for it.
>>>>>> 6/8 refactors the code so that the integrity audit records produced by
>>>>>> IMA follow one format in terms of ordering of the fields, with fields
>>>>>> like inode optional, though, and AUDIT_INTEGRITY_RULE in the end being
>>>>>> the only one with a different format. Do we really want to change that
>>>>>> order just for 1806?
>>>>>>
>>>>>> 5/8 now produces the following:
>>>>>>
>>>>>> type=INTEGRITY_PCR msg=audit(1527685075.941:502): pid=2431 \
>>>>>> uid=0 auid=1000 ses=5 \
>>>>>> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>>> op=invalid_pcr cause=open_writers comm="grep" \
>>>>>> name="/var/log/audit/audit.log" dev="dm-0" ino=1962494 \
>>>>>> exe="/usr/bin/grep" tty=pts0 res=1
>>>>>>
>>>>>> Comparing the two:
>>>>>>
>>>>>> 1806:          action, fsmagic, pid, uid, auid, ses, subj, op, cause,
>>>>>> comm,    exe, tty, res
>>>>>> INTEGRITY_PCR:                  pid, uid, auid, ses, subj, op, cause,
>>>>>> comm, name, dev, ino, exe, tty, res
>>>>> OK. I guess go with it as is. It passes testing.
>>>> What about the position of 'res' field relative to the two new fields
>>>> 'exe' and 'tty'?
>>> res (results) is always the last field for every event. We have no events
>>> where it is not the last field. I'd prefer to go with it as is. The events
>>> pass my testing the way they are.
>>>
>>>> Do we want to keep them as shown or strictly append the
>>>> two new fields 'exe' and 'tty'?
>>> I'd prefer the first option to keep things as expected.
>>>
>>>> Paul seems to request that they appear after 'res'.
>>> I'd rather see them dropped, as useful as they could be, than to malform
>>> the
>>> events.
>>
>> Paul NACK'ed them since he wanted to have them added to the end. You seem to
>> say it's ok to add them before 'res'. Not sure whether to drop them now
>> since we are 'at it.'
> I talked about this in the other patch's thread, but the "new fields
> at the end of existing records" policy applies here too.

I am not sure what to post in v2. It looks like if I append it to the 
end after 'res' I could get the NACK'ed by Steve?!

So the other choice is to only keep patches 1,2, 6, and 7, so leave most 
of the integrity audit messages untouched. Then only create a different 
format for the new AUDIT_INTEGRITY_POLICY_RULE (current 8/8) that shares 
(for consistency reasons) the same format with the existing integrity 
audit messages but also misses tty= and exe= ?


>
> Also note Richard's earlier comment about "associating" the IMA
> records with all of the related audit records.
>
