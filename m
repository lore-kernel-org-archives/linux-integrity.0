Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:48141 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdJRVBE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 17:01:04 -0400
Received: by mail-io0-f176.google.com with SMTP id j17so7703632iod.5
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 14:01:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f438abf6-de2a-847d-40fa-0b139135b97f@schaufler-ca.com>
References: <20171016203709.11199-1-mjg59@google.com> <f438abf6-de2a-847d-40fa-0b139135b97f@schaufler-ca.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 18 Oct 2017 14:01:02 -0700
Message-ID: <CACdnJuvjcYNVvLGkxcHzkZ719-rfN8yCvkzO0kdg1xiYKVAT9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] security: Add a cred_getsecid hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Oct 16, 2017 at 2:58 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/16/2017 1:37 PM, Matthew Garrett wrote:
>> For IMA purposes, we want to be able to obtain the prepared secid in the
>> bprm structure before the credentials are committed. Add a cred_getsecid
>> hook that makes this possible.
>
> Why do you want the secid? What are you planning to do with it?

See the following patch - IMA policy allows the admin to restrict
appraisal to executables running in specific security contexts.
However, right now the check at application execution time ends up
using the current task creds before the new creds are committed.
