Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:55639 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbdKCStw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Nov 2017 14:49:52 -0400
Received: by mail-io0-f194.google.com with SMTP id p186so8282365ioe.12
        for <linux-integrity@vger.kernel.org>; Fri, 03 Nov 2017 11:49:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509725025.3416.73.camel@linux.vnet.ibm.com>
References: <20171102221005.10190-1-mjg59@google.com> <1509725025.3416.73.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 3 Nov 2017 11:49:51 -0700
Message-ID: <CACdnJusn8c-8GMX3iY+6xsOGu6uNKQAMr_begLLTp13_p_bdPw@mail.gmail.com>
Subject: Re: [PATCH V3] EVM: Allow userland to permit modification of
 EVM-protected metadata
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Nov 3, 2017 at 9:03 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2017-11-02 at 15:10 -0700, Matthew Garrett wrote:
>> -             1: enable HMAC validation and creation
>> -             2: enable digital signature validation
>> -             3: enable HMAC and digital signature validation and HMAC
>> -                creation
>> +             Bit       Effect
>> +             0         Enable HMAC validation and creation
>
> The code and documentation do not seem to be in sync.  Dracut is
> currently using 1 to indicate the HMAC key has been loaded.

I've changed from describing the raw values to the bits they
correspond to, so bit 0 corresponds to a value of 1. I can switch back
to describing the raw values instead?

>>
>> +     /* Policy permits modification of the protected attrs */
>
> Could we indicate that there is no HMAC key loaded.

In the comment, or in kernel output?
>> +     /* Don't allow a request to freshly enable metadata writes if
>> +      * keys are loaded.
>> +      */
>> +     if ((i & EVM_ALLOW_METADATA_WRITES) &&
>> +         ((evm_initialized & EVM_KEY_MASK) != 0) &&
>> +         !(evm_initialized & EVM_ALLOW_METADATA_WRITES))
>
> Ok, not sure that the "(evm_initialized & EVM_ALLOW_METADATA_WRITES)"
> is needed, but it doesn't hurt.

Goal here was to allow:

echo 6 >evm
echo 7 >evm

to work without an error, but I guess that's not a big deal.
