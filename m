Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45864 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdJ3K5M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 06:57:12 -0400
Received: by mail-io0-f196.google.com with SMTP id i38so26141264iod.2
        for <linux-integrity@vger.kernel.org>; Mon, 30 Oct 2017 03:57:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509027658.25604.4.camel@tycho.nsa.gov>
References: <20171026084055.25482-1-mjg59@google.com> <1509027658.25604.4.camel@tycho.nsa.gov>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 30 Oct 2017 10:57:11 +0000
Message-ID: <CACdnJuu8fvVoD+G50dWtauUUa3H1tUAbBgzusc_CKNBugrVmwQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] security: Add a cred_getsecid hook
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 26, 2017 at 3:20 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett via Selinux wrote:
>> +static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
>> +{
>> +     rcu_read_lock();
>> +     *secid = cred_sid(c);
>> +     rcu_read_unlock();
>
> Is rcu_read_lock() necessary here? Seems like we use cred_sid() in many
> places without it.

Ah, I thought it was based on task_sid(), but I guess that's actually
protecting the __task_cred()?
