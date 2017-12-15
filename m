Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:45056 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756760AbdLOWYg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Dec 2017 17:24:36 -0500
Received: by mail-io0-f178.google.com with SMTP id e204so4163857iof.12
        for <linux-integrity@vger.kernel.org>; Fri, 15 Dec 2017 14:24:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511908390.3473.30.camel@linux.vnet.ibm.com>
References: <20171026084055.25482-1-mjg59@google.com> <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com> <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
 <1511904917.3473.15.camel@linux.vnet.ibm.com> <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
 <1511908390.3473.30.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 15 Dec 2017 14:24:34 -0800
Message-ID: <CACdnJuu4cA0rAeejNd5hzgZZt+nAYF4-_v55Roib_oHexo2r8w@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] IMA: Support using new creds in appraisal policy
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hm, sorry, missed this mail.

On Tue, Nov 28, 2017 at 2:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-11-28 at 13:37 -0800, Matthew Garrett wrote:
>> security_task_getsecid(current) will give the same results as
>> security_cred_getsecid(current_creds())
>
> Unwinding security_task_getsecid(current) looks like it is using
> real_cred, while current_cred() is using cred.

Good question, and there's a current_real_cred() macro, so I should
just use that instead.
