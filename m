Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:45620 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdJKSps (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2017 14:45:48 -0400
Received: by mail-io0-f173.google.com with SMTP id i38so2835711iod.2
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2017 11:45:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507730526.3426.22.camel@linux.vnet.ibm.com>
References: <20171010222609.5185-1-mjg59@google.com> <1507730526.3426.22.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 11 Oct 2017 11:45:46 -0700
Message-ID: <CACdnJut4CAynhqhuvCKiMrr2tCu-G5fRxAMJndPy2Lsd9CZRwQ@mail.gmail.com>
Subject: Re: [PATCH] EVM: Allow userspace to signal an RSA key has been loaded
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Oct 11, 2017 at 7:02 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2017-10-10 at 15:26 -0700, Matthew Garrett wrote:
>> EVM will only perform validation once a key has been loaded. This key
>> may either be a symmetric trusted key (for HMAC validation and creation)
>> or the public half of an asymmetric key (for digital signature
>> validation). The /sys/kernel/security/evm interface allows userland to
>> signal that a symmetric key has been loaded, but does not allow userland
>> to signal that an asymmetric public key has been loaded.
>>
>> This patch extends the interface to permit userspace to pass a bitmask
>> of loaded key types. It is a write-once interface in order to avoid a
>> compromised system from being able to load an additional key type later.
>
> Let's be a bit more precise.  It only prevents loading the EVM
> symmetric key.  I'm a bit concerned about this restriction, not that
> there is a restriction, but that it is automatic.

Hm, true, EVM_INIT_X509 is never actually checked before we try
verification - that's probably not ideal.

> Let's take a hypothetical scenario, where the asymmetric key is
> available early, but the symmetric key is available later due to
> hardware.  In this scenario, we would want to load and start
> appraising early, with the ability of loading the EVM symmetric later.
>
> With CONFIG_EVM_LOAD_X509, the initial asymmetric is loaded and the
> subsequent symmetric key can still be loaded, as EVM_SETUP is not
> enabled.
>
> I think preventing userspace from loading an EVM symmetric key, is
> fine, but it shouldn't be done automatically on their behalf.

Ok, how about I add another bit that supports locking it, and
automatically set that if a symmetric key is loaded (to maintain
parity with the existing implementation)?
