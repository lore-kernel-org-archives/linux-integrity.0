Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:52616 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdJRR1P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 13:27:15 -0400
Received: by mail-it0-f53.google.com with SMTP id j140so6842542itj.1
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 10:27:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508295225.4513.123.camel@linux.vnet.ibm.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com> <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
 <1508295225.4513.123.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 18 Oct 2017 10:27:13 -0700
Message-ID: <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 17, 2017 at 7:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-10-17 at 19:13 -0700, Matthew Garrett wrote:
>> On Tue, Oct 17, 2017 at 7:08 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> In this case there's no symmetric key loaded, so security.evm won't be
>> updated. Here's what's happening:
>>
>> 1) Configure an IMA policy that only appraises a subset of files
>> 2) Create a new file that does not match the appraisal rule.
>> IMA_NEW_FILE isn't set because no rule matched.
>> 3) Attempt to write security.ima, security.capability and security.evm
>> on the new file. EVM blocks this because IMA_NEW_FILE isn't set.
>
> Are you writing these xattrs before or after you closed the file?
>  Once the file is closed, even if the IMA_NEW_FILE flag had been set,
> it would be removed.

Yes, I've fixed up my implementation to make the calls while the file
is still open.

>> I may be misdiagnosing this, but as far as I can tell IMA_NEW_FILE is
>> only set in ima_appraise_measurement() if action is set to something,
>> and if ima_match_rules() doesn't match then this will never be the
>> case?
>
> True, but having IMA_NEW_FILE set would only help with writing the
> first xattr, not subsequent ones.

Ok. I'm not sure this is easily fixable to handle my use-case without
breaking assumptions made in yours, so I'm wondering if a different
approach would be better here. For us, there's no problem with
updating any of the EVM-protected xattrs at runtime as long as doing
so invalidates the iint cache entry (hmm, does setting an xattr bump
the iversion? If so, we already get this behaviour). How would you
feel about a runtime controllable flag that enabled this, possibly
tied into the /sys/kernel/security/evm write? We'd end up with:

1: Enable HMAC
2: Enable RSA
4: Permit extended attribute writes

Existing behaviour would be preserved since 1 would lock down the
interface, and we could reject cases where 1 and 4 are set
simultaneously.
