Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932185AbeE3Tq4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 May 2018 15:46:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4UJhhS8062013
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 15:46:56 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ja0ddxb6v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 30 May 2018 15:46:53 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Wed, 30 May 2018 15:46:52 -0400
Subject: Re: [PATCH 3/8] audit: Implement audit_log_tty()
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-4-stefanb@linux.vnet.ibm.com>
 <CAHC9VhRjYhSgd_YCmgaOU_MEKuNKbHvPCVotmxyZRzSc2E6-Wg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 15:46:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRjYhSgd_YCmgaOU_MEKuNKbHvPCVotmxyZRzSc2E6-Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <38d49beb-a5dd-29de-3e4b-3dde67fdc28d@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 05/29/2018 05:07 PM, Paul Moore wrote:
> On Thu, May 24, 2018 at 4:11 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>>
>> +void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk)
>> +{
>> +       struct tty_struct *tty = audit_get_tty(tsk);
>> +
>> +       audit_log_format(ab, " tty=%s", tty ? tty_name(tty) : "(none)");
>> +       audit_put_tty(tty);
>> +}
> Perhaps I missed it, but your IMA patches only ever call this to log
> current's tty, yes?  If so, I would prefer if we dropped the
> task_struct argument and always had audit_log_tty() use current.

Done.


>
