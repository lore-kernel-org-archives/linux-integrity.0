Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:46050 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbdJRCN3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 22:13:29 -0400
Received: by mail-it0-f51.google.com with SMTP id n195so4896055itg.0
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 19:13:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508292499.4513.99.camel@linux.vnet.ibm.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 17 Oct 2017 19:13:28 -0700
Message-ID: <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 17, 2017 at 7:08 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-10-17 at 19:02 -0700, Matthew Garrett wrote:
>
>> Is this accurate? If there's no IMA policy that covers the file in
>> question (eg, appraise is limited to a specific security context or
>> owner), will IMA_NEW ever be set? It looks like that codepath will
>> only be entered if there's a rule that matches. The EVM xattr
>> protections appear to be called regardless, which means that there's
>> then no way to write out attributes on them at runtime.
>
> Updating/writing security.evm is triggered by writing or updating ANY
> file metadata included in the HMAC calculation.  There is no
> requirement for security.ima to exist.

In this case there's no symmetric key loaded, so security.evm won't be
updated. Here's what's happening:

1) Configure an IMA policy that only appraises a subset of files
2) Create a new file that does not match the appraisal rule.
IMA_NEW_FILE isn't set because no rule matched.
3) Attempt to write security.ima, security.capability and security.evm
on the new file. EVM blocks this because IMA_NEW_FILE isn't set.

I may be misdiagnosing this, but as far as I can tell IMA_NEW_FILE is
only set in ima_appraise_measurement() if action is set to something,
and if ima_match_rules() doesn't match then this will never be the
case?
