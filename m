Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753231AbeEURxK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 May 2018 13:53:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4LHn9jc006526
        for <linux-integrity@vger.kernel.org>; Mon, 21 May 2018 13:53:10 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j41dakqn5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 21 May 2018 13:53:09 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Mon, 21 May 2018 11:53:08 -0600
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
To: Steve Grubb <sgrubb@redhat.com>
Cc: Richard Guy Briggs <rgb@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
 <efb6c164-febe-67bb-43a9-795476c4902f@linux.vnet.ibm.com>
 <2397631.78oLu0QVqb@x2>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 21 May 2018 13:53:04 -0400
MIME-Version: 1.0
In-Reply-To: <2397631.78oLu0QVqb@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <21646a72-e782-e33a-9e75-5cc98b241f36@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/21/2018 12:58 PM, Steve Grubb wrote:
> On Thursday, May 17, 2018 10:18:13 AM EDT Stefan Berger wrote:
>>> audit_log_container_info() then releasing the local context.  This
>>> version of the record has additional concerns covered here:
>>> https://github.com/linux-audit/audit-kernel/issues/52
>> Following the discussion there and the concern with breaking user space,
>> how can we split up the AUDIT_INTEGRITY_RULE that is used in
>> ima_audit_measurement() and ima_parse_rule(), without 'breaking user
>> space'?
>>
>> A message produced by ima_parse_rule() looks like this here:
>>
>> type=INTEGRITY_RULE msg=audit(1526566213.870:305): action="dont_measure"
>> fsmagic="0x9fa0" res=1
> Why is action and fsmagic being logged as untrusted strings? Untrusted
> strings are used when an unprivileged user can affect the contents of the
> field such as creating a file with space or special characters in the name.
>
> Also, subject and object information is missing. Who loaded this rule?
>
>> in contrast to that an INTEGRITY_PCR record type:
>>
>> type=INTEGRITY_PCR msg=audit(1526566235.193:334): pid=1615 uid=0 auid=0
>> ses=2 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>> op="invalid_pcr" cause="open_writers" comm="scp"
>> name="/var/log/audit/audit.log" dev="dm-0" ino=1962625 res=1
> Why is op & cause being logged as an untrusted string? This also has
> incomplete subject information.

It's calling audit_log_string() in both cases:

https://elixir.bootlin.com/linux/latest/source/security/integrity/integrity_audit.c#L48

>
>> Should some of the fields from INTEGRITY_PCR also appear in
>> INTEGRITY_RULE? If so, which ones?
> pid, uid, auid, tty, session, subj, comm, exe, res.  <- these are required to
> be searchable
>
>> We could probably refactor the current  integrity_audit_message() and have
>> ima_parse_rule() call into it to get those fields as well. I suppose adding
>> new fields to it wouldn't be considered breaking user space?
> The audit user space utilities pretty much expects those fields in that order
> for any IMA originating events. You can add things like op or cause before

We will call into audit_log_task, which will put the parameters into 
correct order:

auid uid gid ses subj pid comm exe

https://elixir.bootlin.com/linux/latest/source/kernel/auditsc.c#L2433




> that. The reason why you can do that is those additional fields are not
> required to be searchable by common criteria.
>
> -Steve
>
>
