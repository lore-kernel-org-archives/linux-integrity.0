Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:52275 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933213AbdJRCCJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 22:02:09 -0400
Received: by mail-it0-f54.google.com with SMTP id j140so4625825itj.1
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 19:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508291395.4513.95.camel@linux.vnet.ibm.com>
References: <CACdnJutQ1NBxfAO1NBJqrrF0en9hc_C=Jy8XxNb5pEiBVwAa0g@mail.gmail.com>
 <1508291395.4513.95.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 17 Oct 2017 19:02:07 -0700
Message-ID: <CACdnJuvYoKRdtF7+BZK4yp8JmC_pfaXyZhhwHzPC739OR6mhOg@mail.gmail.com>
Subject: Re: Writing out EVM protected xattrs while EVM is active
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 17, 2017 at 6:49 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-10-17 at 16:12 -0700, Matthew Garrett wrote:
>> I'm interested in extending our use of IMA digital signatures to EVM
>> in order to protect security.capability (and, in the near future,
>> security.apparmor).
>
> security.capability is already included in the EVM HMAC/signature.
> Your security.apparmor patch is now queued in my #next branch.

Ah, sorry, by "our" I meant "my specific use case", not upstream :)

>> But as far as I can tell, IMA_NEW_FILE will only
>> be set if there's an IMA action that covers the file in question. This
>> means it's possible to write out security.evm and friends on newly
>> created files that would be appraised, but not on any other files. Am
>> I missing something?
>
> Only files in the IMA policy that pass integrity verification can be
> accessed.  The IMA_NEW_FILE flag overides this restriction, allowing
> IMA to access new files, even if the security.ima xattr does not yet
> exist.

Is this accurate? If there's no IMA policy that covers the file in
question (eg, appraise is limited to a specific security context or
owner), will IMA_NEW ever be set? It looks like that codepath will
only be entered if there's a rule that matches. The EVM xattr
protections appear to be called regardless, which means that there's
then no way to write out attributes on them at runtime.
