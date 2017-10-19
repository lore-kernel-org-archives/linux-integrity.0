Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:50210 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbdJSRGP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 13:06:15 -0400
Received: by mail-it0-f47.google.com with SMTP id 72so11005004itl.5
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 10:06:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACE9dm_ijBqhyQOPmWYXq+uzJ2Cxi1J92QDuqketrF6HKfH8BA@mail.gmail.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <CACE9dm_ijBqhyQOPmWYXq+uzJ2Cxi1J92QDuqketrF6HKfH8BA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 19 Oct 2017 10:06:13 -0700
Message-ID: <CACdnJus81i3RZJQHwcdQMy3HX3KDQTYbQCCGQXaVqNs3ADrd5Q@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 19, 2017 at 4:00 AM, Dmitry Kasatkin
<dmitry.kasatkin@gmail.com> wrote:
> On Wed, Oct 18, 2017 at 2:12 AM, Matthew Garrett <mjg59@google.com> wrote:
>> I'm interested in extending our use of IMA digital signatures to EVM
>> in order to protect security.capability (and, in the near future,
>> security.apparmor). However, right now this doesn't seem to quite work
>> in terms of allowing updates to a running system. We've discussed the
>> EVM siganture format's use of inode numbers and I think I've got that
>> sorted (I'll send a patch once I've got a last couple of things
>> working).
>>
>> However, I'm a little confused by how EVM should be working here. Once
>> EVM is initialised, all EVM attributes will be protected, making it
>> impossible to write new values to any xattrs covered by EVM unless
>> IMA_NEW_FILE is set.
>
>
> Sorry, why it is not possible to set xattrs?
> system can change xattrs and hmac will be recalculated...

Because there's no symmetric key loaded in this case.
