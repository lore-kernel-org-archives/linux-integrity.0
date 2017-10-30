Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:47067 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdJ3KyX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 06:54:23 -0400
Received: by mail-io0-f179.google.com with SMTP id 101so26132103ioj.3
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 03:54:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ac81cfb4-5cd3-64e5-5a08-4f167696a84d@schaufler-ca.com>
References: <20171026084055.25482-1-mjg59@google.com> <ac81cfb4-5cd3-64e5-5a08-4f167696a84d@schaufler-ca.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 10:54:22 +0000
Message-ID: <CACdnJus0bb=LcbRjHVMMjHpi+NG3YV_DwF4UBT4uSoY=tHqyTQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] security: Add a cred_getsecid hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 26, 2017 at 2:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/26/2017 1:40 AM, Matthew Garrett wrote:
>>  V3: Fix smack_cred_getsecid()
>
> Much better. Have you tried this with Smack?

I'm afraid not - I have zero expertise with Smack and no easy way to
set it up. I can do so later in the week if you like?
