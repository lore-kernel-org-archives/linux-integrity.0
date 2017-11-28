Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:44681 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbdK1Vhy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Nov 2017 16:37:54 -0500
Received: by mail-it0-f51.google.com with SMTP id b5so1554862itc.3
        for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2017 13:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511904917.3473.15.camel@linux.vnet.ibm.com>
References: <20171026084055.25482-1-mjg59@google.com> <20171026084055.25482-2-mjg59@google.com>
 <1511902135.3473.5.camel@linux.vnet.ibm.com> <CACdnJus2Wha_CjL-8g2BdY=evfNjFqHwKQorsxhUQa8Na_0kCg@mail.gmail.com>
 <1511904917.3473.15.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 28 Nov 2017 13:37:52 -0800
Message-ID: <CACdnJuvN6NxHLG=hS4iDRHBGWWdzFeUMfkF3ETRjXCbwiXpgnQ@mail.gmail.com>
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

On Tue, Nov 28, 2017 at 1:35 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-11-28 at 13:22 -0800, Matthew Garrett wrote:
>> We need to check against the appropriate credentials structure, and
>> since we're doing this before commit_creds() has been called we can't
>> just do it against the one in the task structure.  For BPRM_CHECK
>> that'll be current_cred(), which means there's no change in
>> functionality, whereas for CREDS_CHECK it'll be the new credentials
>> structure.
>
> The existing code calls security_task_getsecid() with "current" not
> "current_cred".  Will replacing security_task_getsecid() with
> security_cred_getsecid() return the same info for the original
> BRPM_CHECK?

security_task_getsecid(current) will give the same results as
security_cred_getsecid(current_creds())
