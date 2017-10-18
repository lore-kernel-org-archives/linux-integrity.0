Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:45201 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdJRSI6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Oct 2017 14:08:58 -0400
Received: by mail-io0-f182.google.com with SMTP id i38so7183299iod.2
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 11:08:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508349118.4510.14.camel@linux.vnet.ibm.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com> <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
 <1508292499.4513.99.camel@linux.vnet.ibm.com> <CACdnJuscweoJFresHzoQ_va9-eokz12VMz_T2kpJb-iJeSbGzg@mail.gmail.com>
 <1508295225.4513.123.camel@linux.vnet.ibm.com> <CACdnJuspob9PMrZHQb9Bff1tpa9D6RVBit931FkHLNE-GC35yg@mail.gmail.com>
 <1508349118.4510.14.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 18 Oct 2017 11:08:57 -0700
Message-ID: <CACdnJutON0tX5NV_Di1PEOFHN5Hf-E-shQ=Fzv6CSYkkBk-i=Q@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 18, 2017 at 10:51 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> Ok. I'm not sure this is easily fixable to handle my use-case without
>> breaking assumptions made in yours, so I'm wondering if a different
>> approach would be better here. For us, there's no problem with
>> updating any of the EVM-protected xattrs at runtime as long as doing
>> so invalidates the iint cache entry (hmm, does setting an xattr bump
>> the iversion? If so, we already get this behaviour). How would you
>> feel about a runtime controllable flag that enabled this, possibly
>> tied into the /sys/kernel/security/evm write? We'd end up with:
>>
>> 1: Enable HMAC
>> 2: Enable RSA
>> 4: Permit extended attribute writes
>>
>> Existing behaviour would be preserved since 1 would lock down the
>> interface, and we could reject cases where 1 and 4 are set
>> simultaneously.
>
> Here's an alternative, though admittedly one that is more difficult to
> implement and dependent on having a portable EVM signature type.
>
> Define the equivalent of listxattr that allows writing multiple
> xattrs.  Change option 4 above to "Permit writing a group of extended
> attributes, including an EVM signature, when none currently exist."

This would require adding a new syscall (including glibc support), and
I think that's probably a hard sell for a single usecase. Looking at
the code a bit more, are you sure about this? I thought IMA_NEW_FILE
would only be cleared once the last writer closes the fd, so it ought
to be possible to do multiple fsetxattr()s with the same file
descriptor until the last writer closes it?
