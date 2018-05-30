Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753529AbeE3MR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 08:17:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UCBiKJ000561
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 08:17:56 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j9s35fg6k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 08:17:55 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 30 May 2018 08:17:54 -0400
Subject: Re: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity
 audits
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com>
 <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 08:17:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQTFPwz5tpL133DQuXDbZR4P7zy4m3hb4nwm9OSf4RNgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0c9616fe-b404-eeed-1cba-c920c31694fd@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/29/2018 05:19 PM, Paul Moore wrote:
> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Use the new public audit functions to add the exe= and tty=
>> parts to the integrity audit records. We place them before
>> res=.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Suggested-by: Steve Grubb <sgrubb@redhat.com>
>> ---
>>   security/integrity/integrity_audit.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
>> index db30763d5525..8d25d3c4dcca 100644
>> --- a/security/integrity/integrity_audit.c
>> +++ b/security/integrity/integrity_audit.c
>> @@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>>                  audit_log_untrustedstring(ab, inode->i_sb->s_id);
>>                  audit_log_format(ab, " ino=%lu", inode->i_ino);
>>          }
>> +       audit_log_d_path_exe(ab, current->mm);
>> +       audit_log_tty(ab, current);
> NACK
>
> Please add the new fields to the end of the audit record, thank you.

I put it there since Steve said '"res" is traditionally the last field 
in any event' (https://lkml.org/lkml/2018/5/22/539). I don't mind 
breaking with this tradition...

>
>>          audit_log_format(ab, " res=%d", !result);
>>          audit_log_end(ab);
>>   }
